let ref_bool = ref false

let ref_string = ref "default"

let spec_list =
  [ ("--set-string", Arg.Set_string ref_string, "Set the ref to the argument")
  ; ("--set-true", Arg.Set ref_bool, "Set the reference to true")
  ]

let files = ref []

let f_anon s =
  begin
    if not @@ Sys.file_exists s then raise @@ Arg.Bad (s ^ ": No such file");
    files := !files @ [s]
  end

let () =
  begin
    Arg.parse spec_list f_anon "Usage";
    print_string "ref_bool: ";
    print_endline (string_of_bool !ref_bool);
    print_string "ref_string: ";
    print_endline !ref_string;
    print_endline "files:";
    List.iter (fun file -> print_endline @@ "  " ^ file) (!files)
  end
