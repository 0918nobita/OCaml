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

let plus_loc base diff =
  {
    line = base.line + diff.line;
    chr = if diff.line >= 1 then diff.chr else base.chr + diff.chr
  }

class virtual ['a] ast_class ?(location = bof) () =
  object
    method virtual get_desc : 'a

    val mutable loc = location
    method get_loc = loc
    method virtual update_loc : location -> unit
  end

class int_literal (desc : int) =
  object
    inherit [int] ast_class ()
    method get_desc = desc
    method update_loc diff = loc <- plus_loc loc diff
  end

class ['a, 'b] add (lhs, rhs : 'a ast_class * 'b ast_class) =
  object
    inherit ['a ast_class * 'b ast_class] ast_class ()
    method get_desc = (lhs, rhs);
    method update_loc diff =
      begin
        lhs#update_loc diff;
        rhs#update_loc diff;
        loc <- plus_loc loc diff
      end
  end

let literal1 = new int_literal 3
let literal2 = new int_literal 4
let add_expr = new add (literal1, literal2)
