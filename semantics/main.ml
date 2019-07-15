type expression =
  | Num of int
  | Add of expression * expression
  | Multiply of expression * expression
  | Boolean of bool
  | LessThan of expression * expression
  | And of expression * expression
  | Or of expression * expression
  | If of expression * expression * expression
  | Var of string
  | Let of string * expression * expression
  | Error

let show (env, exp) =
  let rec show_exp = function
    | Num a ->
        string_of_int a
    | Add (x, y) ->
        "(" ^ show_exp x ^ " + " ^ show_exp y ^ ")"
    | Multiply (x, y) ->
        "(" ^ show_exp x ^ " * " ^ show_exp y ^ ")"
    | Boolean p ->
        string_of_bool p
    | LessThan (x, y) ->
        "(" ^ show_exp x ^ " < " ^ show_exp y ^ ")"
    | And (p1, p2) ->
        "(" ^ show_exp p1 ^ " && " ^ show_exp p2 ^ ")"
    | Or (p1, p2) ->
        "(" ^ show_exp p1 ^ " || " ^ show_exp p2 ^ ")"
    | If (cond, t, f) ->
        "if " ^ show_exp cond ^ " then " ^ show_exp t ^ " else " ^ show_exp f
    | Var ident -> ident
    | Let (ident, bound_expr, expr) ->
        "let " ^ ident ^ " = " ^ show_exp bound_expr ^ " in " ^ show_exp expr
    | Error -> "error"
  in
  let show_var_pair pair =
    "(" ^ fst pair ^ ":" ^ show_exp (snd pair) ^ ")"
  in
    print_endline @@ "env = [" ^ String.concat " " (List.map show_var_pair env) ^ "]";
    print_endline @@ "exp = " ^ show_exp exp

let is_reducible = function
  | Num _ | Boolean _ | Error -> false
  | _ -> true

let rec reduce (env, exp) = match exp with
  | Num _ as num -> (env, num)
  | Boolean _ as bool -> (env, bool)
  | Add (x, y) ->
      begin match (x, y) with
        | (Num a, Num b) -> (env, Num (a + b))
        | (Error, _) | (_, Error) | (Boolean _, _) | (_, Boolean _) -> (env, Error)
        | (a, b) when is_reducible a -> (env, Add (snd @@ reduce (env, a), b))
        | (a, b) -> (env, Add (a, snd @@ reduce (env, b)))
      end
  | Multiply (x, y) ->
      begin match (x, y) with
        | (Num a, Num b) -> (env, Num (a * b))
        | (Error, _) | (_, Error) | (Boolean _, _) | (_, Boolean _) -> (env, Error)
        | (a, b) when is_reducible a -> (env, Multiply (snd @@ reduce (env, a), b))
        | (a, b) -> (env, Multiply (a, snd @@ reduce (env, b)))
      end
  | LessThan (x, y) ->
      begin match (x, y) with
        | (Num a, Num b) -> (env, Boolean (a < b))
        | (Error, _) | (_, Error) | (Boolean _, _) | (_, Boolean _) -> (env, Error)
        | (a, b) when is_reducible a -> (env, LessThan (snd @@ reduce (env, a), b))
        | (a, b) -> (env, LessThan (a, snd @@ reduce (env, b)))
      end
  | And (x, y) ->
      begin match (x, y) with
        | (Boolean p1, Boolean p2) -> (env, Boolean (p1 && p2))
        | (Error, _) | (_, Error) | (Num _, _) | (_, Num _) -> (env, Error)
        | (p1, p2) when is_reducible p1 -> (env, And (snd @@ reduce (env, p1), p2))
        | (p1, p2) -> (env, And (p1, snd @@ reduce (env, p2)))
      end
  | Or (x, y) ->
      begin match (x, y) with
        | (Boolean p1, Boolean p2) -> (env, Boolean (p1 || p2))
        | (Error, _) | (_, Error) | (Num _, _) | (_, Num _) -> (env, Error)
        | (p1, p2) when is_reducible p1 -> (env, Or (snd @@ reduce (env, p1), p2))
        | (p1, p2) -> (env, Or (p1, snd @@ reduce (env, p2)))
      end
  | If (cond, t, f) ->
      begin match cond with
        | Boolean p -> (env, if p then t else f)
        | Error | Num _ -> (env, Error)
        | p -> (env, If (snd @@ reduce (env, p), t, f))
      end
  | Var name -> (env, List.assoc name env)
  | Let (ident, bound_expr, expr) ->
      begin match bound_expr with
        | Error -> (env, Error)
        | v when is_reducible v ->
            (env, Let (ident, snd (reduce (env, bound_expr)), expr))
        | value -> ((ident, value) :: env, expr)
      end
  | Error -> (env, Error)

let run exp = 
  let rec _run (env, exp) = 
    show (env, exp);
    if is_reducible exp 
      then _run (reduce (env, exp))
      else (env, exp)
  in
    _run ([], exp)
