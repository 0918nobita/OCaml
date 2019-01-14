|- let . = 3 in let . = fun . -> #1 * #2 in let . = 5 in #2 4 evalto 12 by E-Let {
  |- 3 evalto 3 by E-Int {};
  3 |- let . = fun . -> #1 * #2 in let . = 5 in #2 4 evalto 12 by E-Let {
    3 |- fun . -> #1 * #2 evalto (3)[fun . -> #1 * #2] by E-Fun {};
    3, (3)[fun . -> #1 * #2] |- let . = 5 in #2 4 evalto 12 by E-Let {
      3, (3)[fun . -> #1 * #2] |- 5 evalto 5 by E-Int {};
      3, (3)[fun . -> #1 * #2], 5 |- #2 4 evalto 12 by E-App {
        3, (3)[fun . -> #1 * #2], 5 |- #2 evalto (3)[fun . -> #1 * #2] by E-Var {};
        3, (3)[fun . -> #1 * #2], 5 |- 4 evalto 4 by E-Int {};
        3, 4 |- #1 * #2 evalto 12 by E-Times {
          3, 4 |- #1 evalto 4 by E-Var {};
          3, 4 |- #2 evalto 3 by E-Var {};
          4 times 3 is 12 by B-Times {}
        }
      }
    }
  }
}
