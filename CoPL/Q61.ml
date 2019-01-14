|- let . = let . = 3 - 2 in #1 * #1 in let . = 4 in #2 + #1 evalto 5 by E-Let {
  |- let . = 3 - 2 in #1 * #1 evalto 1 by E-Let {
    |- 3 - 2 evalto 1 by E-Minus {
      |- 3 evalto 3 by E-Int {};
      |- 2 evalto 2 by E-Int {};
      3 minus 2 is 1 by B-Minus {}
    };
    1 |- #1 * #1 evalto 1 by E-Times {
      1 |- #1 evalto 1 by E-Var {};
      1 |- #1 evalto 1 by E-Var {};
      1 times 1 is 1 by B-Times {}
    }
  };
  1 |- let . = 4 in #2 + #1 evalto 5 by E-Let {
    1 |- 4 evalto 4 by E-Int {};
    1, 4 |- #2 + #1 evalto 5 by E-Plus {
      1, 4 |- #2 evalto 1 by E-Var {};
      1, 4 |- #1 evalto 4 by E-Var {};
      1 plus 4 is 5 by B-Plus {}
    }
  }
}
