type ast = Str of string | Seq of ast list

type result = Success of (ast * string * int) | Failure

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
          then Success (Str str, target, position + str_len)
          else Failure
      | None -> Failure
