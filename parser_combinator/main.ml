type ast = Str of string | Seq of ast list

type result = Success of (ast * string * int) | Failure

type parser = string -> int -> result

let substr str start len =
  let str_len = String.length str in
    if str_len >= start + len
      then Some (String.sub str start len)
      else None

let token str =
  fun target position ->
    let len = String.length target in
      match substr target position len with
          Some cut -> if cut = str
            then Success (Str str, target, position + len)
            else Failure
        | None -> Failure
