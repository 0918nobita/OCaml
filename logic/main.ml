type logical_expr =
    True
  | False
  | And of logical_expr * logical_expr
  | Or of logical_expr * logical_expr
  | Not of logical_expr
  | Imp of logical_expr * logical_expr
  | Var of string

let enclose str = "(" ^ str ^ ")"

let rec string_of_expr = function
    True -> "t"
  | False -> "f"
  | And (lhs, rhs) -> enclose @@ string_of_expr lhs ^ " ∧ " ^ string_of_expr rhs
  | Or (lhs, rhs) -> enclose @@ string_of_expr lhs ^ " ∨ " ^ string_of_expr rhs
  | Not (expr) -> "¬" ^ enclose @@ string_of_expr expr
  | Imp (lhs, rhs) -> enclose @@ string_of_expr lhs ^ " ⇒ " ^ string_of_expr rhs
  | Var (name) -> name

type expr_list =
    Empty
  | AbstractExprList of string
  | Cons of logical_expr * expr_list
  | Concat of expr_list * expr_list

let rec string_of_expr_list = function
    Empty -> ""
  | AbstractExprList name -> name
  | Cons (head, Empty) -> string_of_expr head
  | Cons (head, tail) -> string_of_expr head ^ ", " ^ string_of_expr_list tail
  | Concat (list1, list2) -> string_of_expr_list list1 ^ ", " ^ string_of_expr_list list2
