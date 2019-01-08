open List

type nat = Z | S of nat

type judgement = Plus of int * int * int | Times of int * int * int

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
    nat_string n = string_of_nat @@ nat_of_int n
  in
    match judgement with
        Plus (n1, n2, n3) -> (nat_string n1) ^ " plus " ^ (nat_string n2) ^ " is " ^ (nat_string n3)
      | Times (n1, n2, n3) -> (nat_string n1) ^ " times " ^ (nat_string n2) ^ " is " ^ (nat_string n3)

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
  | Times (0, n, 0) ->
      if n >= 0
        then { rule = "T-Zero"; conclusion = judgement; premise = [] }
        else raise Wrong_judgement
  | Times (sn1, n2, n4) ->
      let n1 = sn1 - 1 in let n3 = n1 * n2 in
        { rule = "T-Succ"; conclusion = judgement; premise = [ (generate_dt @@ Times (n1, n2, n3)); (generate_dt @@ Plus (n2, n3, n4)) ] }

exception No_such_rule

let () =
  let
    sample_judgement = match Sys.argv.(1) with
        "plus" -> Plus (int_of_string Sys.argv.(2), int_of_string Sys.argv.(3), int_of_string Sys.argv.(4))
      | "times" -> Times (int_of_string Sys.argv.(2), int_of_string Sys.argv.(3), int_of_string Sys.argv.(4))
      | _ -> raise No_such_rule
  in
    print_string @@ string_of_dt @@ generate_dt sample_judgement
