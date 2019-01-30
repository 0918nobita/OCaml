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

let many parse target position =
  let rec many_inner parse target position ast_list =
    match parse target position with
        Success (ast, str, p) -> many_inner parse str p @@ ast_list @ ast
      | Failure -> Success (ast_list, target, position) in
  many_inner parse target position []
