open UCoreLib

exception Unwrap_failure

let unwrap = function
  | Some v -> v
  | None -> raise Unwrap_failure

let sub_utf8 str start len =
  let text = Text.of_string_exn str in
  let str_len = Text.length text in
  if str_len >= start + len
    then Some (Text.string_of @@ Text.sub text start len)
    else None

let sei = UChar.int_of @@ Text.get_exn (Text.of_string_exn "生") 0

let shi = UChar.int_of @@ Text.get_exn (Text.of_string_exn "死") 0

let () =
  print_endline
  @@ Text.string_of (Text.of_uchar (UChar.of_int_exn (sei land shi)))
