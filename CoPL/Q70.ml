|- (1 + 2) :: (3 + 4) :: [] evalto 3 :: 7 :: [] by E-Cons {
  |- 1 + 2 evalto 3 by E-Plus {
    |- 1 evalto 1 by E-Int {};
    |- 2 evalto 2 by E-Int {};
    1 plus 2 is 3 by B-Plus {}
  };
  |- (3 + 4) :: [] evalto 7 :: [] by E-Cons {
    |- 3 + 4 evalto 7 by E-Plus {
      |- 3 evalto 3 by E-Int {};
      |- 4 evalto 4 by E-Int {};
      3 plus 4 is 7 by B-Plus {}
    };
    |- [] evalto [] by E-Nil {}
  }
}
