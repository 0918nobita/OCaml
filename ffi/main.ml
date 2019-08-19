external hello : unit -> unit = "hello"

let () =
  print_endline "Start";
  hello ();
  print_endline "Finish"
