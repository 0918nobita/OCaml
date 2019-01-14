3 |- let . = #1 * 2 in #1 + #1 evalto 12 by E-Let {
  3 |- #1 * 2 evalto 6 by E-Times {
    3 |- #1 evalto 3 by E-Var {};
    3 |- 2 evalto 2 by E-Int {};
    3 times 2 is 6 by B-Times {}
  };
  3, 6 |- #1 + #1 evalto 12 by E-Plus {
    3, 6 |- #1 evalto 6 by E-Var {};
    3, 6 |- #1 evalto 6 by E-Var {};
    6 plus 6 is 12 by B-Plus {}
  }
}
