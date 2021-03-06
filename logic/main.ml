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

type sequent = Sequent of expr_list * expr_list

let string_of_sequent = function
    Sequent (premise, result) -> enclose @@ string_of_expr_list premise ^ " ---> " ^ enclose @@ string_of_expr_list result

type inference_rule = InferenceRule of sequent list * sequent

let string_of_inference_rule = function
    InferenceRule (sequent_list, sequent) ->
        enclose @@ String.concat "  " (List.map string_of_sequent sequent_list) ^ "  ⊢  " ^ string_of_sequent sequent

let () =
  let
    sequent1 = Sequent (AbstractExprList "Γ", Concat (AbstractExprList "Δ", Cons (Var "A", Empty))) and
    sequent2 = Sequent (Cons (Var "A", AbstractExprList "Π"), AbstractExprList "Σ") and
    sequent3 = Sequent (
        Concat (AbstractExprList "Γ", AbstractExprList "Π"),
        Concat (AbstractExprList "Δ", AbstractExprList "Σ"))
  in
    print_endline @@ string_of_inference_rule @@ InferenceRule ([sequent1; sequent2], sequent3)
