open Yojson.Basic

exception InvalidConfig of string

let validate = function
  | `Assoc tuples ->
      tuples
      |> List.iter (fun tuple ->
        print_endline @@ fst tuple ^ ": " ^ show @@ snd tuple)
  | _ ->
      raise @@ InvalidConfig "オブジェクト形式で記述してください"

let () =
  let json = from_file "psyconfig.json" in
  print_endline @@ show json;
  validate json
