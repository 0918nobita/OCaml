type ast = Str of string | Char of char

type result = Success of (ast list * string * int) | Failure

type parser = string -> int -> result

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
