let f = fun x -> (x, x) in (f 1, f true, f 2.0);;

(fun x -> ((let f = fun y -> (x, y) in f 4), x + 1)) 6;; (* ((6, 4), 7) *)
