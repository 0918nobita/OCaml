true, 4 |- if #2 then #1 + 1 else #1 - 1 evalto 5 by E-IfT {
  true, 4 |- #2 evalto true by E-Var {};
  true, 4 |- #1 + 1 evalto 5 by E-Plus {
    true, 4 |- #1 evalto 4 by E-Var {};
    true, 4 |- 1 evalto 1 by E-Int {};
    4 plus 1 is 5 by B-Plus {}
  }
}
