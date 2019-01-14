|- let rec . = fun . ->  if #1 < 2 then 1 else #1 * #2 (#1 - 1) in #1 3 evalto 6 by E-LetRec {
  ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)] |- #1 3 evalto 6 by E-AppRec {
    ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)] |- #1 evalto ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)] by E-Var {};
    ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)] |- 3 evalto 3 by E-Int {};
    ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)], 3 |- if #1 < 2 then 1 else #1 * #2 (#1 - 1) evalto 6 by E-IfF {
      ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)], 3 |- #1 < 2 evalto false by E-Lt {
        ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)], 3 |- #1 evalto 3 by E-Var {};
        ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)], 3 |- 2 evalto 2 by E-Int {};
        3 less than 2 is false by B-Lt {}
      };
      ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)], 3 |- #1 * #2 (#1 - 1) evalto 6 by E-Times {
        ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)], 3 |- #1 evalto 3 by E-Var {};
        ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)], 3 |- #2 (#1 - 1) evalto 2 by E-AppRec {
          ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)], 3 |- #2 evalto ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)] by E-Var {};
          ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)], 3 |- #1 - 1 evalto 2 by E-Minus {
            ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)], 3 |- #1 evalto 3 by E-Var {};
            ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)], 3 |- 1 evalto 1 by E-Int {};
            3 minus 1 is 2 by B-Minus {}
          };
          ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)], 2 |- if #1 < 2 then 1 else #1 * #2 (#1 - 1) evalto 2 by E-IfF {
            ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)], 2 |- #1 < 2 evalto false by E-Lt {
              ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)], 2 |- #1 evalto 2 by E-Var {};
              ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)], 2 |- 2 evalto 2 by E-Int {};
              2 less than 2 is false by B-Lt {}
            };
            ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)], 2 |- #1 * #2 (#1 - 1) evalto 2 by E-Times {
              ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)], 2 |- #1 evalto 2 by E-Var {};
              ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)], 2 |- #2 (#1 - 1) evalto 1 by E-AppRec {
                ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)], 2 |- #2 evalto ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)] by E-Var {};
                ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)], 2 |- #1 - 1 evalto 1 by E-Minus {
                  ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)], 2 |- #1 evalto 2 by E-Var {};
                  ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)], 2 |- 1 evalto 1 by E-Int {};
                  2 minus 1 is 1 by B-Minus {}
                };
                ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)], 1 |- if #1 < 2 then 1 else #1 * #2 (#1 - 1) evalto 1 by E-IfT {
                  ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)], 1 |- #1 < 2 evalto true by E-Lt {
                    ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)], 1 |- #1 evalto 1 by E-Var {};
                    ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)], 1 |- 2 evalto 2 by E-Int {};
                    1 less than 2 is true by B-Lt {}
                  };
                  ()[rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1)], 1 |- 1 evalto 1 by E-Int {}
                }
              };
              2 times 1 is 2 by B-Times {}
            }
          }
        };
        3 times 2 is 6 by B-Times {}
      };
    }
  }
}
