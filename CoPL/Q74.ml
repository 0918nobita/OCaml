|- let rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y in length ((1 :: 2 :: []) :: (3 :: 4 :: 5 :: []) :: []) evalto 2 by E-LetRec {
  length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- length ((1 :: 2 :: []) :: (3 :: 4 :: 5 :: []) :: []) evalto 2 by E-AppRec {
    length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- length evalto ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] by E-Var {};
    length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- (1 :: 2 :: []) :: (3 :: 4 :: 5 :: []) :: [] evalto (1 :: 2 :: []) :: (3 :: 4 :: 5 :: []) :: [] by E-Cons {
      length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 1 :: 2 :: [] evalto 1 :: 2 :: [] by E-Cons {
        length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 1 evalto 1 by E-Int {};
        length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 2 :: [] evalto 2 :: [] by E-Cons {
          length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 2 evalto 2 by E-Int {};
          length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- [] evalto [] by E-Nil {}
        }
      };
      length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- (3 :: 4 :: 5 :: []) :: [] evalto (3 :: 4 :: 5 :: []) :: [] by E-Cons {
        length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 3 :: 4 :: 5 :: [] evalto 3 :: 4 :: 5 :: [] by E-Cons {
          length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 3 evalto 3 by E-Int {};
          length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 4 :: 5 :: [] evalto 4 :: 5 :: [] by E-Cons {
            length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 4 evalto 4 by E-Int {};
            length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 5 :: [] evalto 5 :: [] by E-Cons {
              length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 5 evalto 5 by E-Int {};
              length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- [] evalto [] by E-Nil {}
            }
          }
        };
        length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- [] evalto [] by E-Nil {}
      }
    };
    length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = (1 :: 2 :: []) :: (3 :: 4 :: 5 :: []) :: [] |- match l with [] -> 0 | x :: y -> 1 + length y evalto 2 by E-MatchCons {
      length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = (1 :: 2 :: []) :: (3 :: 4 :: 5 :: []) :: [] |- l evalto (1 :: 2 :: []) :: (3 :: 4 :: 5 :: []) :: [] by E-Var {};
      length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = (1 :: 2 :: []) :: (3 :: 4 :: 5 :: []) :: [], x = 1 :: 2 :: [], y = (3 :: 4 :: 5 :: []) :: [] |- 1 + length y evalto 2 by E-Plus {
        length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = (1 :: 2 :: []) :: (3 :: 4 :: 5 :: []) :: [], x = 1 :: 2 :: [], y = (3 :: 4 :: 5 :: []) :: [] |- 1 evalto 1 by E-Int {};
        length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = (1 :: 2 :: []) :: (3 :: 4 :: 5 :: []) :: [], x = 1 :: 2 :: [], y = (3 :: 4 :: 5 :: []) :: [] |- length y evalto 1 by E-AppRec {
          length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = (1 :: 2 :: []) :: (3 :: 4 :: 5 :: []) :: [], x = 1 :: 2 :: [], y = (3 :: 4 :: 5 :: []) :: [] |- length evalto ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] by E-Var {};
          length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = (1 :: 2 :: []) :: (3 :: 4 :: 5 :: []) :: [], x = 1 :: 2 :: [], y = (3 :: 4 :: 5 :: []) :: [] |- y evalto (3 :: 4 :: 5 :: []) :: [] by E-Var {};
          length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = (3 :: 4 :: 5 :: []) :: [] |- match l with [] -> 0 | x :: y -> 1 + length y evalto 1 by E-MatchCons {
            length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = (3 :: 4 :: 5 :: []) :: [] |- l evalto (3 :: 4 :: 5 :: []) :: [] by E-Var {};
            length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = (3 :: 4 :: 5 :: []) :: [], x = 3 :: 4 :: 5 :: [], y = [] |- 1 + length y evalto 1 by E-Plus {
              length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = (3 :: 4 :: 5 :: []) :: [], x = 3 :: 4 :: 5 :: [], y = [] |- 1 evalto 1 by E-Int {};
              length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = (3 :: 4 :: 5 :: []) :: [], x = 3 :: 4 :: 5 :: [], y = [] |- length y evalto 0 by E-AppRec {
                length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = (3 :: 4 :: 5 :: []) :: [], x = 3 :: 4 :: 5 :: [], y = [] |- length evalto ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] by E-Var {};
                length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = (3 :: 4 :: 5 :: []) :: [], x = 3 :: 4 :: 5 :: [], y = [] |- y evalto [] by E-Var {};
                length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = [] |- match l with [] -> 0 | x :: y -> 1 + length y evalto 0 by E-MatchNil {
                  length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = [] |- l evalto [] by E-Var {};
                  length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = [] |- 0 evalto 0 by E-Int {}
                }
              };
              1 plus 0 is 1 by B-Plus {}
            }
          }
        };
        1 plus 1 is 2 by B-Plus {}
      }
    }
  }
}
