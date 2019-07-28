open Yojson.Basic

let () =
  print_endline
  @@ show
  @@ from_file "psyconfig.json"
