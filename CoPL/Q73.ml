|- let rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y in length (1 :: 2 :: 3 :: []) evalto 3 by E-LetRec {
  length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- length (1 :: 2:: 3 :: []) evalto 3 by E-AppRec {
    length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- length evalto ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] by E-Var {};
    length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 1 :: 2 :: 3 :: [] evalto 1 :: 2 :: 3 :: [] by E-Cons {
      length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 1 evalto 1 by E-Int {};
      length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 2 :: 3 :: [] evalto 2 :: 3 :: [] by E-Cons {
        length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 2 evalto 2 by E-Int {};
        length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 3 :: [] evalto 3 :: [] by E-Cons {
          length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 3 evalto 3 by E-Int {};
          length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- [] evalto [] by E-Nil {}
        }
      }
    };
    length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 1 :: 2 :: 3 :: [] |- match l with [] -> 0 | x :: y -> 1 + length y evalto 3 by E-MatchCons {
      length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 1 :: 2 :: 3 :: [] |- l evalto 1 :: 2 :: 3 :: [] by E-Var {};
      length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 1 :: 2 :: 3 :: [], x = 1, y = 2 :: 3 :: [] |- 1 + length y evalto 3 by E-Plus {
        length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 1 :: 2 :: 3 :: [], x = 1, y = 2 :: 3 :: [] |- 1 evalto 1 by E-Int {};
        length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 1 :: 2 :: 3 :: [], x = 1, y = 2 :: 3 :: [] |- length y evalto 2 by E-AppRec {
          length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 1 :: 2 :: 3 :: [], x = 1, y = 2 :: 3 :: [] |- length evalto ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] by E-Var {};
          length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 1 :: 2 :: 3 :: [], x = 1, y = 2 :: 3 :: [] |- y evalto 2 :: 3 :: [] by E-Var {};
          length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 2 :: 3 :: [] |- match l with [] -> 0 | x :: y -> 1 + length y evalto 2 by E-MatchCons {
            length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 2 :: 3 :: [] |- l evalto 2 :: 3 :: [] by E-Var {};
            length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 2 :: 3 :: [], x = 2, y = 3 :: [] |- 1 + length y evalto 2 by E-Plus {
              length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 2 :: 3 :: [], x = 2, y = 3 :: [] |- 1 evalto 1 by E-Int {};
              length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 2 :: 3 :: [], x = 2, y = 3 :: [] |- length y evalto 1 by E-AppRec {
                length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 2 :: 3 :: [], x = 2, y = 3 :: [] |- length evalto ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] by E-Var {};
                length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 2 :: 3 :: [], x = 2, y = 3 :: [] |- y evalto 3 :: [] by E-Var {};
                length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 3 :: [] |- match l with [] -> 0 | x :: y -> 1 + length y evalto 1 by E-MatchCons {
                  length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 3 :: [] |- l evalto 3 :: [] by E-Var {};
                  length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 3 :: [], x = 3, y = [] |- 1 + length y evalto 1 by E-Plus {
                    length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 3 :: [], x = 3, y = [] |- 1 evalto 1 by E-Int {};
                    length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 3 :: [], x = 3, y = [] |- length y evalto 0 by E-AppRec {
                      length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 3 :: [], x = 3, y = [] |- length evalto ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] by E-Var {};
                      length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 3 :: [], x = 3, y = [] |- y evalto [] by E-Var {};
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
        };
        1 plus 2 is 3 by B-Plus {}
      }
    }
  }
}
