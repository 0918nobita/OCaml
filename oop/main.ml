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

type location = { line : int; chr : int }

let string_of_location loc = string_of_int loc.line ^ ":" ^ string_of_int loc.chr

let bof = { line = 0; chr = 0 }

class ['a] ast_class ?(location = bof) (desc : 'a) =
  object
    val mutable desc = desc
    val mutable loc = location
    method get_desc = desc
    method get_loc = loc
    method update_loc diff =
      loc <- {
        line = loc.line + diff.line;
        chr = if diff.line >= 1 then diff.chr else loc.chr + diff.chr
      }
  end

let int_literal = new ast_class 7

let () =
  int_literal#update_loc { line = 2; chr = 1 };
  print_endline @@ string_of_location int_literal#get_loc; (* => "2:1" *)
  print_endline @@ string_of_int int_literal#get_desc (* => 7 *)
