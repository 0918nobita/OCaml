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

let () =
  print_endline @@ unwrap @@ sub_utf8 "あいうえお" 1 3
