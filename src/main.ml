(*
  # 1e350;;
  - : float = infinity
  # -3e400;;
  - : float = neg_infinity
  2.0 /. 0.;;
  - : float = infinity
  0. /. 0.;;
  - : float = nan
  # sqrt (-1.);;
  - : float = nan
  # infinity +. neg_infinity;;
  - : float = nan
  # "Hello, " ^ "OCaml!";;
  - : string = "Hello, OCaml!"
  # "Hello, OCaml!".[4];;
  - : char = 'o'
*)

let () =
  Printf.printf "Hello, OCaml!\n"
