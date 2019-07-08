type expression =
  | Num of int
  | Add of expression * expression
  | Multiply of expression * expression
  | Boolean of bool
  | LessThan of expression * expression
  | And of expression * expression
  | Or of expression * expression
  | If of expression * expression * expression
  | Error

let show exp =
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
    | Error -> "error"
  in
    "<< " ^ show_exp exp ^ " >>"

let is_reducible = function
  | Num _ | Boolean _ | Error -> false
  | _ -> true

let rec reduce = function
  | Num _ as num -> num
  | Boolean _ as bool -> bool
  | Add (x, y) ->
      begin match (x, y) with
        | (Num a, Num b) -> Num (a + b)
        | (Error, _) | (_, Error) | (Boolean _, _) | (_, Boolean _) -> Error
        | (a, b) when is_reducible a -> Add (reduce a, b)
        | (a, b) -> Add (a, reduce b)
      end
  | Multiply (x, y) ->
      begin match (x, y) with
        | (Num a, Num b) -> Num (a * b)
        | (Error, _) | (_, Error) | (Boolean _, _) | (_, Boolean _) -> Error
        | (a, b) when is_reducible a -> Multiply (reduce a, b)
        | (a, b) -> Multiply (a, reduce b)
      end
  | LessThan (x, y) ->
      begin match (x, y) with
        | (Num a, Num b) -> Boolean (a < b)
        | (Error, _) | (_, Error) | (Boolean _, _) | (_, Boolean _) -> Error
        | (a, b) when is_reducible a -> Multiply (reduce a, b)
        | (a, b) -> Multiply (a, reduce b)
      end
  | And (x, y) ->
      begin match (x, y) with
        | (Boolean p1, Boolean p2) -> Boolean (p1 && p2)
        | (Error, _) | (_, Error) | (Num _, _) | (_, Num _) -> Error
        | (p1, p2) when is_reducible p1 -> And (reduce p1, p2)
        | (p1, p2) -> And (p1, reduce p2)
      end
  | Or (x, y) ->
      begin match (x, y) with
        | (Boolean p1, Boolean p2) -> Boolean (p1 || p2)
        | (Error, _) | (_, Error) | (Num _, _) | (_, Num _) -> Error
        | (p1, p2) when is_reducible p1 -> Or (reduce p1, p2)
        | (p1, p2) -> Or (p1, reduce p2)
      end
  | If (cond, t, f) ->
      begin match cond with
        | Boolean p -> if p then t else f
        | Error | Num _ -> Error
        | p -> If (reduce p, t, f)
      end
  | Error -> Error

let rec run exp =
  print_endline @@ show exp;
  if is_reducible exp
    then run (reduce exp)
    else exp
