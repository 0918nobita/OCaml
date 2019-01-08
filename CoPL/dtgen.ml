open List

type nat = Z | S of nat

type judgement = Plus of int * int * int

type derivation_tree = { rule: string; conclusion : judgement; premise : derivation_tree list }

let rec string_of_nat = function
    Z -> "Z"
  | S (n') -> "S(" ^ (string_of_nat n') ^ ")"

exception Cannot_convert_negative_number_to_nat

let rec nat_of_int num =
  if num >= 0
    then (if num = 0 then Z else S (nat_of_int (num - 1)))
    else raise Cannot_convert_negative_number_to_nat

let string_of_judgement judgement =
  let
    Plus (n1, n2, n3) = judgement and
    nat_string n = string_of_nat @@ nat_of_int n
  in
    (nat_string n1) ^ " plus " ^ (nat_string n2) ^ " is " ^ (nat_string n3)

let rec string_of_dt dt =
  let
    conclusion = string_of_judgement dt.conclusion and
    premise = if length dt.premise <> 0
      then (fold_left (^) " " (map (fun dt -> (string_of_dt dt) ^ "; ") dt.premise))
      else ""
  in
    conclusion ^ " by " ^ dt.rule ^ " {" ^ premise ^ "}"

let sample_dt = {
  rule = "P-Succ";
  conclusion = Plus (1, 0, 1);
  premise = [
    { rule = "P-Zero"; conclusion = Plus (0, 0, 0); premise = [] }
  ]
}

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

let () =
  let
    sample_judgement = Plus (int_of_string Sys.argv.(1), int_of_string Sys.argv.(2), int_of_string Sys.argv.(3))
  in
    print_string @@ string_of_dt @@ generate_dt sample_judgement
