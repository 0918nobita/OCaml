open List

type nat = Z | S of nat

type judgement = Plus of nat * nat * nat

type derivation_tree = { rule: string; conclusion : judgement; premise : derivation_tree list }

let rec string_of_nat = function
    Z -> "Z"
  | S (n') -> "S(" ^ (string_of_nat n') ^ ")"

let string_of_judgement judgement =
  let Plus (n1, n2, n3) = judgement in
    (string_of_nat n1) ^ " plus " ^ (string_of_nat n2) ^ " is " ^ (string_of_nat n3)

let rec int_of_nat = function
    Z -> 0
  | S (n') -> 1 + (int_of_nat n')

exception Cannot_convert_negative_number_to_nat

let rec nat_of_int num =
  if num >= 0
    then (if num = 0 then Z else S (nat_of_int (num - 1)))
    else raise Cannot_convert_negative_number_to_nat

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
  conclusion = Plus (S Z, Z, S Z);
  premise = [
    { rule = "P-Zero"; conclusion = Plus (Z, Z, Z); premise = [] }
  ]
}

let () = print_string @@ string_of_dt sample_dt
