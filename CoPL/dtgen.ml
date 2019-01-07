type nat = Z | S of nat

type judgement = Plus of nat * nat * nat

type derivation_tree = { rule: string; conclusion : judgement; premise : derivation_tree list }
