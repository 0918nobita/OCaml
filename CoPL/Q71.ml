|- let f = fun x -> match x with [] -> 0 | a :: b -> a in f (4::[]) + f [] + f (1 :: 2 :: 3 :: []) evalto 5 by E-Let {
  |- fun x -> match x with [] -> 0 | a :: b -> a evalto ()[fun x -> match x with [] -> 0 | a :: b -> a] by E-Fun {};
  f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- f (4::[]) + f [] + f (1 :: 2 :: 3 :: []) evalto 5 by E-Plus {
    f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- f (4::[]) + f [] evalto 4 by E-Plus {
      f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- f (4::[]) evalto 4 by E-App {
        f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- f evalto ()[fun x -> match x with [] -> 0 | a :: b -> a] by E-Var {};
        f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- 4::[] evalto 4::[] by E-Cons {
          f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- 4 evalto 4 by E-Int {};
          f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- [] evalto [] by E-Nil {};
        };
        x = 4::[] |- match x with [] -> 0 | a :: b -> a evalto 4 by E-MatchCons {
          x = 4::[] |- x evalto 4::[] by E-Var {};
          x = 4::[], a = 4, b = [] |- a evalto 4 by E-Var {}
        }
      };
      f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- f [] evalto 0 by E-App {
        f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- f evalto ()[fun x -> match x with [] -> 0 | a :: b -> a] by E-Var {};
        f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- [] evalto [] by E-Nil {};
        x = [] |- match x with [] -> 0 | a :: b -> a evalto 0 by E-MatchNil {
          x = [] |- x evalto [] by E-Var {};
          x = [] |- 0 evalto 0 by E-Int {}
        }
      };
      4 plus 0 is 4 by B-Plus {}
    };
    f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- f (1 :: 2 :: 3 :: []) evalto 1 by E-App {
      f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- f evalto ()[fun x -> match x with [] -> 0 | a :: b -> a] by E-Var {};
      f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- 1 :: 2 :: 3 :: [] evalto 1 :: 2 :: 3 :: [] by E-Cons {
        f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- 1 evalto 1 by E-Int {};
        f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- 2 :: 3 :: [] evalto 2 :: 3 :: [] by E-Cons {
          f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- 2 evalto 2 by E-Int {};
          f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- 3 :: [] evalto 3 :: [] by E-Cons {
            f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- 3 evalto 3 by E-Int {};
            f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- [] evalto [] by E-Nil {}
          }
        }
      };
      x = 1 :: 2 :: 3 :: [] |- match x with [] -> 0 | a :: b -> a evalto 1 by E-MatchCons {
        x = 1 :: 2 :: 3 :: [] |- x evalto 1 :: 2 :: 3 :: [] by E-Var {};
        x = 1 :: 2 :: 3 :: [], a = 1, b = 2 :: 3 :: [] |- a evalto 1 by E-Var {}
      }
    };
    4 plus 1 is 5 by B-Plus {}
  }
}
