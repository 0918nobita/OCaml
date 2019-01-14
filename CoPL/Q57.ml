|- let . = 3 * 3 in let . = 4 * #1 in #2 + #1 evalto 45 by E-Let {
  |- 3 * 3 evalto 9 by E-Times {
    |- 3 evalto 3 by E-Int {};
    |- 3 evalto 3 by E-Int {};
    3 times 3 is 9 by B-Times {}
  };
  9 |- let . = 4 * #1 in #2 + #1 evalto 45 by E-Let {
    9 |- 4 * #1 evalto 36 by E-Times {
      9 |- 4 evalto 4 by E-Int {};
      9 |- #1 evalto 9 by E-Var {};
      4 times 9 is 36 by B-Times {}
    };
    9, 36 |- #2 + #1 evalto 45 by E-Plus {
      9, 36 |- #2 evalto 9 by E-Var {};
      9, 36 |- #1 evalto 36 by E-Var {};
      9 plus 36 is 45 by B-Plus {}
    }
  }
}
