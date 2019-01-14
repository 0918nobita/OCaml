|- let rec append = fun l1 -> fun l2 ->
  match l1 with
      [] -> l2
    | x :: y -> x :: append y l2 in
  append (1 :: 2 :: []) (3 :: 4 :: 5 :: [])
evalto 1 :: 2 :: 3 :: 4 :: 5 :: [] by E-LetRec {
  append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2] |- append (1 :: 2 :: []) (3 :: 4 :: 5 :: []) evalto 1 :: 2 :: 3 :: 4 :: 5 :: [] by E-App {
    append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2] |- append (1 :: 2 :: []) evalto (append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2], l1 = 1 :: 2 :: [])[fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2] by E-AppRec {
      append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2] |- append evalto ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2] by E-Var {};
      append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2] |- 1 :: 2 :: [] evalto 1 :: 2 :: [] by E-Cons {
        append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2] |- 1 evalto 1 by E-Int {};
        append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2] |- 2 :: [] evalto 2 :: [] by E-Cons {
          append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2] |- 2 evalto 2 by E-Int {};
          append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2] |- [] evalto [] by E-Nil {}
        }
      };
      append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2], l1 = 1 :: 2 :: [] |- fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2 evalto (append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2], l1 = 1 :: 2 :: [])[fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2] by E-Fun {}
    };
    append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2] |- 3 :: 4 :: 5 :: [] evalto 3 :: 4 :: 5 :: [] by E-Cons {
      append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2] |- 3 evalto 3 by E-Int {};
      append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2] |- 4 :: 5 :: [] evalto 4 :: 5 :: [] by E-Cons {
        append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2] |- 4 evalto 4 by E-Int {};
        append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2] |- 5 :: [] evalto 5 :: [] by E-Cons {
          append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2] |- 5 evalto 5 by E-Int {};
          append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2] |- [] evalto [] by E-Nil {}
        }
      }
    };
    append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2], l1 = 1 :: 2 :: [], l2 = 3 :: 4 :: 5 :: [] |- match l1 with [] -> l2 | x :: y -> x :: append y l2 evalto 1 :: 2 :: 3 :: 4 :: 5 :: [] by E-MatchCons {
      append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2], l1 = 1 :: 2 :: [], l2 = 3 :: 4 :: 5 :: [] |- l1 evalto 1 :: 2 :: [] by E-Var {};
      append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2], l1 = 1 :: 2 :: [], l2 = 3 :: 4 :: 5 :: [], x = 1, y = 2 :: [] |- x :: append y l2 evalto 1 :: 2 :: 3 :: 4 :: 5 :: [] by E-Cons {
        append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2], l1 = 1 :: 2 :: [], l2 = 3 :: 4 :: 5 :: [], x = 1, y = 2 :: [] |- x evalto 1 by E-Var {};
        append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2], l1 = 1 :: 2 :: [], l2 = 3 :: 4 :: 5 :: [], x = 1, y = 2 :: [] |- append y l2 evalto 2 :: 3 :: 4 :: 5 :: [] by E-App {
          append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2], l1 = 1 :: 2 :: [], l2 = 3 :: 4 :: 5 :: [], x = 1, y = 2 :: [] |- append y evalto (append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2], l1 = 2 :: [])[fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2] by E-AppRec {
            append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2], l1 = 1 :: 2 :: [], l2 = 3 :: 4 :: 5 :: [], x = 1, y = 2 :: [] |- append evalto ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2] by E-Var {};
            append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2], l1 = 1 :: 2 :: [], l2 = 3 :: 4 :: 5 :: [], x = 1, y = 2 :: [] |- y evalto 2 :: [] by E-Var {};
            append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2], l1 = 2 :: [] |- fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2 evalto (append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2], l1 = 2 :: [])[fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2] by E-Fun {}
          };
          append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2], l1 = 1 :: 2 :: [], l2 = 3 :: 4 :: 5 :: [], x = 1, y = 2 :: [] |- l2 evalto 3 :: 4 :: 5 :: [] by E-Var {};
          append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2], l1 = 2 :: [], l2 = 3 :: 4 :: 5 :: [] |- match l1 with [] -> l2 | x :: y -> x :: append y l2 evalto 2 :: 3 :: 4 :: 5 :: [] by E-MatchCons {
            append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2], l1 = 2 :: [], l2 = 3 :: 4 :: 5 :: [] |- l1 evalto 2 :: [] by E-Var {};
            append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2], l1 = 2 :: [], l2 = 3 :: 4 :: 5 :: [], x = 2, y = [] |- x :: append y l2 evalto 2 :: 3 :: 4 :: 5 :: [] by E-Cons {
              append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2], l1 = 2 :: [], l2 = 3 :: 4 :: 5 :: [], x = 2, y = [] |- x evalto 2 by E-Var {};
              append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2], l1 = 2 :: [], l2 = 3 :: 4 :: 5 :: [], x = 2, y = [] |- append y l2 evalto 3 :: 4 :: 5 :: [] by E-App {
                append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2], l1 = 2 :: [], l2 = 3 :: 4 :: 5 :: [], x = 2, y = [] |- append y evalto (append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2], l1 = [])[fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2] by E-AppRec {
                  append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2], l1 = 2 :: [], l2 = 3 :: 4 :: 5 :: [], x = 2, y = [] |- append evalto ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2] by E-Var {};
                  append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2], l1 = 2 :: [], l2 = 3 :: 4 :: 5 :: [], x = 2, y = [] |- y evalto [] by E-Var {};
                  append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2], l1 = [] |- fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2 evalto (append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2], l1 = [])[fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2] by E-Fun {}
                };
                append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2], l1 = 2 :: [], l2 = 3 :: 4 :: 5 :: [], x = 2, y = [] |- l2 evalto 3 :: 4 :: 5 :: [] by E-Var {};
                append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2], l1 = [], l2 = 3 :: 4 :: 5 :: [] |- match l1 with [] -> l2 | x :: y -> x :: append y l2 evalto 3 :: 4 :: 5 :: [] by E-MatchNil {
                  append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2], l1 = [], l2 = 3 :: 4 :: 5 :: [] |- l1 evalto [] by E-Var {};
                  append = ()[rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2], l1 = [], l2 = 3 :: 4 :: 5 :: [] |- l2 evalto 3 :: 4 :: 5 :: [] by E-Var {}
                }
              }
            }
          }
        }
      }
    }
  }
}
