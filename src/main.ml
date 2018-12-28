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

(* 練習問題 3.1 *)

(* (1) US ドル (実数) を受け取って円 (整数) に換算する関数 (四捨五入) *)
let conv dollar = int_of_float (Float.round (dollar *. 114.32));;

(* (2) 円 (整数) を受け取って、US ドル (セント以下を小数にした実数) に換算する関数 *)
(* 1 セント以下は四捨五入 *)
let conv2 yen = Float.round ((float_of_int yen) /. 114.32)

(* (3) US ドル (実数) を受け取って "[ドル] dollars are [円] yen." という文字列を返す関数 *)
let conv3 dollar =
  (string_of_float dollar) ^ " dollars are " ^ (string_of_int (conv dollar)) ^ " yen."

(* (4) 文字を受け取って、アルファベットの小文字なら大文字に、その他の文字はそのまま帰す関数 *)
let capitalize c =
  if 'a' <= c && c <= 'z'
    then (char_of_int ((int_of_char c) - 32))
    else c

(* 練習問題 3.2 *)
let andx b1 b2 = if b1 then b2 else false
let orx b1 b2 = if b1 then true else b2

(* 練習問題 3.3 *)
let andx2 b1 b2 = not ((not b1) || (not b2))
let orx2 b1 b2 = not ((not b1) && (not b2))

let () =
  Printf.printf "Hello, OCaml!\n"
