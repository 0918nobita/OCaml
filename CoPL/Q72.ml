|- let rec f = fun x -> if x < 1 then [] else x :: f (x - 1) in f 3 evalto 3 :: 2 :: 1 :: [] by E-LetRec {
  f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)] |- f 3 evalto 3 :: 2 :: 1 :: [] by E-AppRec {
    f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)] |- f evalto ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)] by E-Var {};
    f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)] |- 3 evalto 3 by E-Int {};
    f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 3 |- if x < 1 then [] else x :: f (x - 1) evalto 3 :: 2 :: 1 :: [] by E-IfF {
      f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 3 |- x < 1 evalto false by E-Lt {
        f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 3 |- x evalto 3 by E-Var {};
        f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 3 |- 1 evalto 1 by E-Int {};
        3 less than 1 is false by B-Lt {}
      };
      f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 3 |- x :: f (x - 1) evalto 3 :: 2 :: 1 :: [] by E-Cons {
        f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 3 |- x evalto 3 by E-Var {};
        f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 3 |- f (x - 1) evalto 2 :: 1 :: [] by E-AppRec {
          f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 3 |- f evalto ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)] by E-Var {};
          f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 3 |- x - 1 evalto 2 by E-Minus {
            f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 3 |- x evalto 3 by E-Var {};
            f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 3 |- 1 evalto 1 by E-Int {};
            3 minus 1 is 2 by B-Minus {}
          };
          f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 2 |- if x < 1 then [] else x :: f (x - 1) evalto 2 :: 1 :: [] by E-IfF {
            f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 2 |- x < 1 evalto false by E-Lt {
              f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 2 |- x evalto 2 by E-Var {};
              f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 2 |- 1 evalto 1 by E-Int {};
              2 less than 1 is false by B-Lt {}
            };
            f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 2 |- x :: f (x - 1) evalto 2 :: 1 :: [] by E-Cons {
              f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 2 |- x evalto 2 by E-Var {};
              f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 2 |- f (x - 1) evalto 1 :: [] by E-AppRec {
                f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 2 |- f evalto ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)] by E-Var {};
                f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 2 |- x - 1 evalto 1 by E-Minus {
                  f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 2 |- x evalto 2 by E-Var {};
                  f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 2 |- 1 evalto 1 by E-Int {};
                  2 minus 1 is 1 by B-Minus {}
                };
                f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 1 |- if x < 1 then [] else x :: f (x - 1) evalto 1 :: [] by E-IfF {
                  f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 1 |- x < 1 evalto false by E-Lt {
                    f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 1 |- x evalto 1 by E-Var {};
                    f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 1 |- 1 evalto 1 by E-Int {};
                    1 less than 1 is false by B-Lt {}
                  };
                  f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 1 |- x :: f (x - 1) evalto 1 :: [] by E-Cons {
                    f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 1 |- x evalto 1 by E-Var {};
                    f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 1 |- f (x - 1) evalto [] by E-AppRec {
                      f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 1 |- f evalto ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)] by E-Var {};
                      f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 1 |- x - 1 evalto 0 by E-Minus {
                        f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 1 |- x evalto 1 by E-Var {};
                        f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 1 |- 1 evalto 1 by E-Int {};
                        1 minus 1 is 0 by B-Minus {}
                      };
                      f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 0 |- if x < 1 then [] else x :: f (x - 1) evalto [] by E-IfT {
                        f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 0 |- x < 1 evalto true by E-Lt {
                          f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 0 |- x evalto 0 by E-Var {};
                          f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 0 |- 1 evalto 1 by E-Int {};
                          0 less than 1 is true by B-Lt {}
                        };
                        f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 0 |- [] evalto [] by E-Nil {}
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
