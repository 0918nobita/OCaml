|- let . = 2 in fun . -> #1 + #2 evalto (2)[fun . -> #1 + #2] by E-Let {
  |- 2 evalto 2 by E-Int {};
  2 |- fun . -> #1 + #2 evalto (2)[fun . -> #1 + #2] by E-Fun {}
}
