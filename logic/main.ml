type logical_expr =
    True
  | False
  | And of logical_expr * logical_expr
  | Or of logical_expr * logical_expr
  | Not of logical_expr
  | Imp of logical_expr * logical_expr
  | Var of string
