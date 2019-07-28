open Yojson.Basic

let () =
  print_endline
  @@ show
  @@ from_string "{ typecheck: true }"
