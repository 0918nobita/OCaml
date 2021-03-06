type term
  = Var of int
  | Abs of term
  | App of term * term

let rec string_of_nameless ctx = function
  | Var n ->
      if ctx >= n
        then string_of_int n
        else "`" ^ string_of_int n
  | Abs term ->
      "(λ. " ^ string_of_nameless (1 + ctx) term ^ ")"
  | App (lhs, rhs) ->
      "(" ^ string_of_nameless ctx lhs ^ " " ^ string_of_nameless ctx rhs ^ ")"

let shift d =
  let rec walk c = function
    | Var k ->
        if k >= c then Var (k + d) else Var k
    | Abs term ->
        Abs (walk (c + 1) term)
    | App (t1, t2) ->
        App (walk c t1, walk c t2)
  in
    walk 0

let rec subst j s = function
  | Var k when k = j -> s
  | (Var _) as var -> var
  | Abs term ->
      Abs (subst (j + 1) (shift 1 s) term)
  | App (t1, t2) ->
      App (subst j s t1, subst j s t2)

let rec eval = function
  | App (Abs t, (Abs _ as v)) ->
      shift (-1) @@ subst 0 (shift 1 v) t
  | App (Abs _ as v, t) ->
      App (eval v, t)
  | Abs _ as term -> term
  | _ -> failwith "No rule applies"

(* succ = λ. λ. λ. 1 (2 1 0) *)
let succ = Abs (Abs (Abs (App (Var 1, App (App (Var 2, Var 1), Var 0)))))

let rec church_of_nat n =
  if n > 0
    then eval @@ App (succ, church_of_nat (n - 1))
    else Abs (Abs (Var 0))
