type ast =
    Str of string
  | Char of char
  | Int of int
  | Add of (ast * ast)
  | Sub of (ast * ast)
  | Mul of (ast * ast)
  | Div of (ast * ast)

let rec show_ast = function
    Str str -> "Str(" ^ str ^ " )"
  | Char c -> "Char(" ^ (Char.escaped c) ^ ")"
  | Int i -> "Int(" ^ (string_of_int i) ^ ")"
  | Add (left, right) -> "Add(" ^ (show_ast left) ^ ", " ^ (show_ast right) ^ ")"
  | Sub (left, right) -> "Sub(" ^ (show_ast left) ^ ", " ^ (show_ast right) ^ ")"
  | Mul (left, right) -> "Mul(" ^ (show_ast left) ^ ", " ^ (show_ast right) ^ ")"
  | Div (left, right) -> "Div(" ^ (show_ast left) ^ ", " ^ (show_ast right) ^ ")"

let show_ast_list l = "[" ^ List.fold_left (fun acc next -> acc ^ show_ast next ^ "; ") "" l ^ "]"

type result = Success of (ast list * string * int) | Failure

let substr str start len =
  let str_len = String.length str in
    if str_len >= start + len
      then Some (String.sub str start len)
      else None

let rec explode = function
    "" -> []
  | str -> String.sub str 0 1 :: explode (String.sub str 1 (String.length str - 1))

let char str target position =
  let list = explode str in
    match substr target position 1 with
        Some cut -> if List.mem cut list
          then Success ([Char (String.get cut 0)], target, position + 1)
          else Failure
      | None -> Failure

let token str target position =
  let str_len = String.length str in
    match substr target position str_len with
        Some cut -> if cut = str
          then Success ([Str str], target, position + str_len)
          else Failure
      | None -> Failure

let many parser target position =
  let rec many_inner parser target position ast_list =
    match parser target position with
        Success (ast, str, p) -> many_inner parser str p @@ ast_list @ ast
      | Failure -> Success (ast_list, target, position) in
  many_inner parser target position []

let rec choice parser_list target position =
  match parser_list with
      parser :: rest -> let result = parser target position in
        if result = Failure then choice rest target position else result
    | [] -> Failure

let sequence parser_list target position =
  let rec sequence_inner parser_list target position ast_list =
    match parser_list with
        parser :: rest -> (match parser target position with
          Success (ast, str, p) -> sequence_inner rest str p @@ ast_list @ ast
        | Failure -> Failure) 
      | [] -> Success (ast_list, target, position) in
  sequence_inner parser_list target position []

let option parser target position =
  let result = parser target position in
    if result = Failure then Success ([], target, position) else result

let lazy_parser callback target position =
  let parser = callback () in parser target position

let non_zero_digit = char "123456789"

let digit = choice [non_zero_digit; char "0"]

exception Parse_error

let chars_to_int chars =
  let rec chars_to_str chars =
    match chars with
        (Char head) :: tail -> Char.escaped head ^ chars_to_str tail
      | [] -> ""
      | _ -> raise Parse_error in
  int_of_string @@ chars_to_str chars

let integer target position =
  match sequence [option (char "+-"); non_zero_digit; option (many digit)] target position with
      Failure -> Failure
    | Success (ast, _, p) -> Success ([Int (chars_to_int ast)], target, p)

type 'a stream = Nil | Cons of ('a * 'a stream lazy_t)

let rec intgen low high =
  if low > high then Nil else Cons (low, lazy (intgen (low + 1) high))

exception Empty_stream

let rec stream_ref s n =
  match s with
      Nil -> raise Empty_stream
    | Cons (x, _) when n = 0 -> x;
    | Cons (_, lazy tail) -> stream_ref tail (n - 1)

let rec reverse_ast ast = match ast with
    Add (a, Add (b, c)) ->
      Add (Add (reverse_ast a, reverse_ast b), reverse_ast c)
  | Sub (a, Sub (b, c)) ->
      Sub (Sub (reverse_ast a, reverse_ast b), reverse_ast c)
  | Mul (a, Mul (b, c)) ->
      Mul (Mul (reverse_ast a, reverse_ast b), reverse_ast c)
  | Div (a, Div (b, c)) ->
      Div (Div (reverse_ast a, reverse_ast b), reverse_ast c)
  | _ -> ast

let factor = integer

let term target position =
  let rec prioritize = function
      lhs :: Char '*' :: rhs :: [] -> Mul (lhs, rhs)
    | lhs :: Char '/' :: rhs :: [] -> Div (lhs, rhs)
    | lhs :: Char '*' :: rest -> Mul (lhs, prioritize rest)
    | lhs :: Char '/' :: rest -> Div (lhs, prioritize rest)
    | factor :: [] -> factor
    | _ -> raise Parse_error in
  match sequence [factor; option (many (sequence [char "*/"; factor]))] target position with
      Failure -> Failure
    | Success (ast, _, p) -> Success([reverse_ast @@ prioritize ast], target, p)

let expr target position =
  let rec prioritize = function
      lhs :: Char '+' :: rhs :: [] -> Add (lhs, rhs)
    | lhs :: Char '-' :: rhs :: [] -> Sub (lhs, rhs)
    | lhs :: Char '+' :: rest -> Add (lhs, prioritize rest)
    | lhs :: Char '-' :: rest -> Sub (lhs, prioritize rest)
    | term :: [] -> term
    | _ -> raise Parse_error in
  match sequence [term; option (many (sequence [char "+-"; term]))] target position with
      Failure -> Failure
    | Success (ast, _, p) -> Success([reverse_ast @@ prioritize ast], target, p)
