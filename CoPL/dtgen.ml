type nat = Z | S of nat

type judgement = Plus of nat * nat * nat

type derivation_tree = { rule: string; conclusion : judgement; premise : derivation_tree list }

let rec string_of_nat = function
    Z -> "Z"
  | S (n') -> "S(" ^ (string_of_nat n') ^ ")"

let string_of_judgement judgement =
  let Plus (n1, n2, n3) = judgement in
    (string_of_nat n1) ^ " plus " ^ (string_of_nat n2) ^ " is " ^ (string_of_nat n3)
