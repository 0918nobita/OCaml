class point =
  object
    val mutable x = 0
    method get_x = x
    method move d = x <- x + d
  end

let p = new point

let () =
  p#move 3;
  p#move 4;
  print_endline @@ string_of_int @@ p#get_x (* => 7 *)
