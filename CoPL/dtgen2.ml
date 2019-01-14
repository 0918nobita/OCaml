(* ocamlopt str.cmxa dtgen2.ml -o dtgen2 *)

type exp = Int of int
        | Bool of bool
        | PlusExp of (exp * exp)
        | MinusExp of (exp * exp)
        | TimesExp of (exp * exp)
        | LtExp of (exp * exp)
        | IfExp of (exp * exp * exp)

type judgement = Plus of int * int * int
              | Minus of int * int * int
              | Times of int * int * int
              | Lt of int * int
              | EvalTo of (exp * int)

let rec string_of_exp = function
    Int n -> string_of_int n
  | Bool b -> string_of_bool b
  | PlusExp (exp1, exp2) -> (string_of_exp exp1) ^ " + " ^ (string_of_exp exp2)
  | MinusExp (exp1, exp2) -> (string_of_exp exp1) ^ " - " ^ (string_of_exp exp2)
  | TimesExp (exp1, exp2) -> (string_of_exp exp1) ^ " * " ^ (string_of_exp exp2)
  | Lt (exp1, exp2) -> (string_of_exp exp1) ^ " < " ^ (string_of_exp exp2)

let rec eval_exp = function
    
