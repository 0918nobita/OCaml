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
