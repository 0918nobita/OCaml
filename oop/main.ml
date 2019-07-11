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

let combine_loc base diff =
  {
    line = base.line + diff.line;
    chr = if diff.line >= 1 then diff.chr else base.chr + diff.chr
  }

type ast_type = IntLiteral of int | Add | Mul

class virtual ['a] ast (location : location) (children : 'a ast list) =
  object
    method virtual get_type : 'a
    val mutable loc = location
    method get_loc = loc
    method get_children = children
    method update_loc diff =
      begin
        List.iter (fun child -> child#update_loc diff) children;
        loc <- combine_loc loc diff
      end
  end

class expr_ast ?(location = bof) (ast_type : ast_type) (children : expr_ast list) =
  object
    inherit [ast_type] ast location children
    method get_type = ast_type
  end

let literal1 = new expr_ast (IntLiteral 3) []
let literal2 = new expr_ast (IntLiteral 4) []

let add_expr = new expr_ast (Add) [literal1; literal2]
let mul_expr = new expr_ast (Mul) [add_expr; literal1]

type instruction =
  | I32Const of int
  | I32Add
  | I32Mul

let rec insts_of_expr_ast (ast : expr_ast) =
  match ast#get_type with
    | IntLiteral n -> [I32Const n]
    | Add ->
        (insts_of_expr_ast @@ List.nth ast#get_children 0) @
        (insts_of_expr_ast @@ List.nth ast#get_children 1) @
        [I32Add]
    | Mul ->
        (insts_of_expr_ast @@ List.nth ast#get_children 0) @
        (insts_of_expr_ast @@ List.nth ast#get_children 1) @
        [I32Mul]
