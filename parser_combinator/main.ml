type ast = Str of string

type result = Success of (ast list * string * int) | Failure

type parser = string -> int -> result

let substr str start len =
  let str_len = String.length str in
    if str_len >= start + len
      then Some (String.sub str start len)
      else None

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
