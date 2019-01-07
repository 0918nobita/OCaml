type nat = Z | S of nat

type judgement = Plus of nat * nat * nat

type derivation_tree = { rule: string; conclusion : judgement; premise : derivation_tree list }

let rec string_of_nat = function
    Z -> "Z"
  | S (n') -> "S(" ^ (string_of_nat n') ^ ")"
