|- let rec sum = fun f -> fun n -> if n < 1 then 0 else f n + sum f (n - 1) in
  sum (fun x -> x * x) 2
evalto 5 by E-LetRec {
  sum = ()[rec sum = fun f -> fun n -> if n < 1 then 0 else f n + sum f (n - 1)] |- sum (fun x -> x * x) 2 evalto 5 by E-AppRec {
    sum = ()[rec sum = fun f -> fun n -> if n < 1 then 0 else f n + sum f (n - 1)] |- sum (fun x -> x * x) evalto ??? by {
      sum = ()[rec sum = fun f -> fun n -> if n < 1 then 0 else f n + sum f (n - 1)] |- sum evalto ()[rec sum = fun f -> fun n -> if n < 1 then 0 else f n + sum f (n - 1)] by E-Var1 {};
      sum = ()[rec sum = fun f -> fun n -> if n < 1 then 0 else f n + sum f (n - 1)] |- fun x -> x * x evalto (sum = ()[rec sum = fun f -> fun n -> if n < 1 then 0 else f n + sum f (n - 1)])[fun x -> x * x] by E-Fun {};
      sum = ()[rec sum = fun f -> fun n -> if n < 1 then 0 else f n + sum f (n - 1)], f = (sum = ()[rec sum = fun f -> fun n -> if n < 1 then 0 else f n + sum f (n - 1)])[fun x -> x * x] |- fun n -> if n < 1 then 0 else f n + sum f (n - 1) evalto (sum = ()[rec sum = fun f -> fun n -> if n < 1 then 0 else f n + sum f (n - 1)], f = (sum = ()[rec sum = fun f -> fun n -> if n < 1 then 0 else f n + sum f (n - 1)])[fun x -> x * x])[fun n -> if n < 1 then 0 else f n + sum f (n - 1)] by E-Fun {}
    };
    sum = ()[rec sum = fun f -> fun n -> if n < 1 then 0 else f n + sum f (n - 1)] |- 2 evalto 2 by E-Int {};
  }
}
