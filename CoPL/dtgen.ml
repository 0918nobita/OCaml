open List

type nat = Z | S of nat

type judgement = Plus of int * int * int | Times of int * int * int | Lt1 of int * int | Lt2 of int * int

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
      | Lt1 (n1, n2) -> (nat_string n1) ^ " is less than " ^ (nat_string n2)
      | Lt2 (n1, n2) -> (nat_string n1) ^ " is less than " ^ (nat_string n2)

let rec string_of_dt dt =
  let
    conclusion = string_of_judgement dt.conclusion and
    premise = if length dt.premise <> 0
      then (fold_left (^) " " (map (fun dt -> (string_of_dt dt) ^ "; ") dt.premise))
      else ""
  in
    conclusion ^ " by " ^ dt.rule ^ " {" ^ premise ^ "}"

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

exception No_such_rule

let () =
  let
    sample_judgement = match Sys.argv.(1) with
        "plus" -> Plus (int_of_string Sys.argv.(2), int_of_string Sys.argv.(3), int_of_string Sys.argv.(4))
      | "times" -> Times (int_of_string Sys.argv.(2), int_of_string Sys.argv.(3), int_of_string Sys.argv.(4))
      | "lt1" -> Lt1 (int_of_string Sys.argv.(2), int_of_string Sys.argv.(3))
      | "lt2" -> Lt2 (int_of_string Sys.argv.(2), int_of_string Sys.argv.(3))
      | _ -> raise No_such_rule
  in
    print_string @@ string_of_dt @@ generate_dt sample_judgement
