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

let call_get_count instance = instance#get_count

let () =
  counter2#increase 3;
  print_endline @@ string_of_int @@ call_get_count counter2 (* => 5 *)
