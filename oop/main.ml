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

let c = ref 0

class counter_class =
  object
    val mutable count = incr c; !c
    method get_count = count
    method increase diff = count <- count + diff
  end

let counter1 = new counter_class
let counter2 = new counter_class

let () =
  print_endline @@ string_of_int @@ counter1#get_count; (* => 1 *)
  print_endline @@ string_of_int @@ counter2#get_count (* => 2 *)
