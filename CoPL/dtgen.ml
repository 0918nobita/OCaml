(* ocamlopt str.cmxa dtgen.ml -o dtgen *)

open List

type nat = Z | S of nat

let rec string_of_nat = function
    Z -> "Z"
  | S (n') -> "S(" ^ (string_of_nat n') ^ ")"

exception Cannot_convert_negative_number_to_nat

let rec nat_of_int num =
  if num >= 0
    then (if num = 0 then Z else S (nat_of_int (num - 1)))
    else raise Cannot_convert_negative_number_to_nat

type exp = Value of int | PlusExp of (exp * exp) | TimesExp of (exp * exp)

let nat_string n = string_of_nat @@ nat_of_int n

let rec string_of_exp = function
    Value n -> nat_string n
  | PlusExp (exp1, exp2) -> (string_of_exp exp1) ^ " + " ^ (string_of_exp exp2)
  | TimesExp (exp1, exp2) -> (string_of_exp exp1) ^ " * " ^ (string_of_exp exp2)

type judgement = Plus of int * int * int
              | Times of int * int * int
              | Lt1 of int * int
              | Lt2 of int * int
              | Lt3 of int * int
              | EvalTo of exp * int

let string_of_judgement judgement =
  match judgement with
      Plus (n1, n2, n3) -> (nat_string n1) ^ " plus " ^ (nat_string n2) ^ " is " ^ (nat_string n3)
    | Times (n1, n2, n3) -> (nat_string n1) ^ " times " ^ (nat_string n2) ^ " is " ^ (nat_string n3)
    | Lt1 (n1, n2) -> (nat_string n1) ^ " is less than " ^ (nat_string n2)
    | Lt2 (n1, n2) -> (nat_string n1) ^ " is less than " ^ (nat_string n2)
    | Lt3 (n1, n2) -> (nat_string n1) ^ " is less than " ^ (nat_string n2)
    | EvalTo (exp, n) -> (string_of_exp exp) ^ " evalto " ^ (nat_string n)

type derivation_tree = { rule: string; conclusion : judgement; premise : derivation_tree list }

let rec string_of_dt dt nests =
  let rec spaces n = if n > 0 then " " ^ spaces (n - 1) else "" in
  let premise_exists = length dt.premise <> 0 in
  let
    conclusion = string_of_judgement dt.conclusion and
    indent_b = spaces nests and
    indent_e = if premise_exists then spaces nests else "" and
    premise = if premise_exists
      then (fold_left (^) "\n" (map (fun dt -> (string_of_dt dt (nests + 2)) ^ ";\n") dt.premise))
      else ""
  in
    indent_b ^ conclusion ^ " by " ^ dt.rule ^ " {" ^ premise ^ indent_e ^ "}"

exception Wrong_judgement

let rec generate_dt judgement = match judgement with
    Plus (0, n1, n2) ->
      if n2 >= 0 && n1 = n2
        then { rule = "P-Zero"; conclusion = judgement; premise = [] }
        else raise Wrong_judgement
  | Plus (n1, n2, n) ->
      if n >= 0
        then { rule = "P-Succ"; conclusion = judgement; premise = [ generate_dt @@ Plus (n1 - 1, n2, n - 1) ] }
        else raise Wrong_judgement
  | Times (0, n, 0) ->
      if n >= 0
        then { rule = "T-Zero"; conclusion = judgement; premise = [] }
        else raise Wrong_judgement
  | Times (sn1, n2, n4) ->
      let n1 = sn1 - 1 in let n3 = n1 * n2 in
        { rule = "T-Succ"; conclusion = judgement; premise = [ (generate_dt @@ Times (n1, n2, n3)); (generate_dt @@ Plus (n2, n3, n4)) ] }
  | Lt1 (n1, n3) ->
      if n1 >= 0 && n3 >= 0 && n1 < n3
        then (if n3 = n1 + 1
          then { rule = "L-Succ"; conclusion = judgement; premise = [] }
          else { rule = "L-Trans"; conclusion = judgement; premise = [ (generate_dt @@ Lt1 (n1, n1 + 1)); (generate_dt @@ Lt1 (n1 + 1, n3)) ] })
        else raise Wrong_judgement
  | Lt2 (sn1, sn2) ->
      if sn1 >= 0 && sn2 >= 0
        then (if sn1 = 0 && sn2 > 0
          then { rule = "L-Zero"; conclusion = judgement; premise = [] }
          else { rule = "L-SuccSucc"; conclusion = judgement; premise = [ generate_dt @@ Lt2 (sn1 - 1, sn2 - 1) ] })
      else raise Wrong_judgement
  | Lt3 (n1, sn2) ->
      if n1 >= 0 && sn2 >= 0 && n1 < sn2
        then (if sn2 = n1 + 1
          then { rule = "L-Succ"; conclusion = judgement; premise = [] }
          else { rule = "L-SuccR"; conclusion = judgement; premise = [ generate_dt @@ Lt3 (n1, sn2 - 1) ] })
        else raise Wrong_judgement

exception Wrong_argument
exception No_such_rule

let () = let op = if Array.length Sys.argv >= 2 then Sys.argv.(1) else raise Wrong_argument in
  let
    sample_judgement = match op with
        "plus" | "times" -> (let (n1, n2, n3) = (int_of_string Sys.argv.(2), int_of_string Sys.argv.(3), int_of_string Sys.argv.(4)) in
          match op with
              "plus" -> Plus (n1, n2, n3)
            | "times" -> Times (n1, n2, n3)
            | _ -> raise No_such_rule)
      | "lt1" | "lt2" | "lt3" -> (let (n1, n2) = (int_of_string Sys.argv.(2), int_of_string Sys.argv.(3)) in
          match op with
              "lt1" -> Lt1 (n1, n2)
            | "lt2" -> Lt2 (n1, n2)
            | "lt3" -> Lt3 (n1, n2)
            | _ -> raise No_such_rule)
      | _ -> raise No_such_rule
  in
    print_string @@ string_of_dt (generate_dt sample_judgement) 0

(*
 * 算術式 e := int | e "+" e | e "*" e
 * 判断 EvalTo := e "evalto" int
 *)

type word = Int of int | EvalToOp | PlusOp | TimesOp

exception SyntaxError

let lex str = let is_integer str = Str.string_match (Str.regexp "^[1-9][0-9]*$") str 0 in
  let
    lex_word str = if is_integer str then Int (int_of_string str) else (
      match str with
          "evalto" -> EvalToOp
        | "+" -> PlusOp
        | "*" -> TimesOp
        | _ -> raise SyntaxError) and
    words = if str <> "" then String.split_on_char ' ' str else []
  in
    map lex_word words

let parse_int = function
    Int n :: r -> (Value n, r)
  | _ -> raise SyntaxError
