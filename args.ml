let ref_bool = ref false

let ref_string = ref "default"

let spec_list =
  [ ("--set-string", Arg.Set_string ref_string, "Set the ref to the argument")
  ; ("--set-true", Arg.Set ref_bool, "Set the reference to true")
  ]

let f_anon s =
  begin
    print_string "> f_anon";
    print_endline s
  end

let () =
  begin
    Arg.parse spec_list f_anon "Usage";
    print_endline "----------";
    print_string "ref_bool: ";
    print_endline (string_of_bool !ref_bool);
    print_string "ref_string: ";
    print_endline !ref_string
  end
