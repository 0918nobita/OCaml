# CoPL 解答

## 単純な式の評価

### 第 31 問

```ocaml
1 + true + 2 evalto error by E-PlusErrorL {
  1 + true evalto error by E-PlusBoolR {
    true evalto true by E-Bool {};
  }
}
```

### 第 32 問

```ocaml
if 2 + 3 then 1 else 3 evalto error by E-IfInt {
  2 + 3 evalto 5 by E-Plus {
    2 evalto 2 by E-Int {};
    3 evalto 3 by E-Int {};
    2 plus 3 is 5 by B-Plus {}
  }
}
```

### 第 33 問

```ocaml
if 3 < 4 then 1 < true else 3 - false evalto error by E-IfTError {
  3 < 4 evalto true by E-Lt {
    3 evalto 3 by E-Int {};
    4 evalto 4 by E-Int {};
    3 less than 4 is true by B-Lt {}
  };
  1 < true evalto error by E-LtBoolR {
    true evalto true by E-Bool {}
  }
}
```

## 局所定義と環境

### 第 34 問

```ocaml
x = 3, y = 2 |- x evalto 3 by E-Var2 {
  x = 3 |- x evalto 3 by E-Var1 {}
}
```

### 第 35 問

```ocaml
x = true, y = 4 |- if x then y + 1 else y - 1 evalto 5 by E-IfT {
  x = true, y = 4 |- x evalto true by E-Var2 {
    x = true |- x evalto true by E-Var1 {}
  };
  x = true, y = 4 |- y + 1 evalto 5 by E-Plus {
    x = true, y = 4 |- y evalto 4 by E-Var1 {};
    x = true, y = 4 |- 1 evalto 1 by E-Int {};
    4 plus 1 is 5 by B-Plus {}
  }
}
```

### 第 36 問

```ocaml
|- let x = 1 + 2 in x * 4 evalto 12 by E-Let {
  |- 1 + 2 evalto 3 by E-Plus {
    |- 1 evalto 1 by E-Int {};
    |- 2 evalto 2 by E-Int {};
    1 plus 2 is 3 by B-Plus {}
  };
  x = 3 |- x * 4 evalto 12 by E-Times {
    x = 3 |- x evalto 3 by E-Var1 {};
    x = 3 |- 4 evalto 4 by E-Int {};
    3 times 4 is 12 by B-Times {}
  }
}
```

### 第 37 問

```ocaml
|- let x = 3 * 3 in let y = 4 * x in x + y evalto 45 by E-Let {
  |- 3 * 3 evalto 9 by E-Times {
    |- 3 evalto 3 by E-Int {};
    |- 3 evalto 3 by E-Int {};
    3 times 3 is 9 by B-Times {}
  };
  x = 9 |- let y = 4 * x in x + y evalto 45 by E-Let {
    x = 9 |- 4 * x evalto 36 by E-Times {
      x = 9 |- 4 evalto 4 by E-Int {};
      x = 9 |- x evalto 9 by E-Var1 {};
      4 times 9 is 36 by B-Times {}
    };
    x = 9, y = 36 |- x + y evalto 45 by E-Plus {
      x = 9, y = 36 |- x evalto 9 by E-Var2 {
        x = 9 |- x evalto 9 by E-Var1 {}
      };
      x = 9, y = 36 |- y evalto 36 by E-Var1 {};
      9 plus 36 is 45 by B-Plus {}
    }
  }
}
```

### 第 38 問

```ocaml
x = 3 |- let x = x * 2 in x + x evalto 12 by E-Let {
  x = 3 |- x * 2 evalto 6 by E-Times {
    x = 3 |- x evalto 3 by E-Var1 {};
    x = 3 |- 2 evalto 2 by E-Int {};
    3 times 2 is 6 by B-Times {}
  };
  x = 3, x = 6 |- x + x evalto 12 by E-Plus {
    x = 3, x = 6 |- x evalto 6 by E-Var1 {};
    x = 3, x = 6 |- x evalto 6 by E-Var1 {};
    6 plus 6 is 12 by B-Plus {}
  }
}
```

### 第 39 問

```ocaml
|- let x = let y = 3 - 2 in y * y in let y = 4 in x + y evalto 5 by E-Let {
  |- let y = 3 - 2 in y * y evalto 1 by E-Let {
    |- 3 - 2 evalto 1 by E-Minus {
      |- 3 evalto 3 by E-Int {};
      |- 2 evalto 2 by E-Int {};
      3 minus 2 is 1 by B-Minus {}
    };
    y = 1 |- y * y evalto 1 by E-Times {
      y = 1 |- y evalto 1 by E-Var1 {};
      y = 1 |- y evalto 1 by E-Var1 {};
      1 times 1 is 1 by B-Times {}
    }
  };
  x = 1 |- let y = 4 in x + y evalto 5 by E-Let {
    x = 1 |- 4 evalto 4 by E-Int {};
    x = 1, y = 4 |- x + y evalto 5 by E-Plus {
      x = 1, y = 4 |- x evalto 1 by E-Var2 {
        x = 1 |- x evalto 1 by E-Var1 {}
      };
      x = 1, y = 4 |- y evalto 4 by E-Var1 {};
      1 plus 4 is 5 by B-Plus {}
    }
  }
}
```

## (再帰)関数抽象・適用

### 第 40 問

```ocaml
|- fun x -> x + 1 evalto ()[fun x -> x + 1] by E-Fun {}
```

### 第 41 問

```ocaml
|- let y = 2 in fun x -> x + y evalto (y=2)[fun x -> x + y] by E-Let {
  |- 2 evalto 2 by E-Int {};
  y = 2 |- fun x -> x + y evalto (y=2)[fun x -> x + y] by E-Fun {}
}
```

### 第 42 問

```ocaml
|- let sq = fun x -> x * x in sq 3 + sq 4 evalto 25 by E-Let {
  |- fun x -> x * x evalto ()[fun x -> x * x] by E-Fun {};
  sq = ()[fun x -> x * x] |- sq 3 + sq 4 evalto 25 by E-Plus {
    sq = ()[fun x -> x * x] |- sq 3 evalto 9 by E-App {
      sq = ()[fun x -> x * x] |- sq evalto ()[fun x -> x * x] by E-Var1 {};
      sq = ()[fun x -> x * x] |- 3 evalto 3 by E-Int {};
      x = 3 |- x * x evalto 9 by E-Times {
        x = 3 |- x evalto 3 by E-Var1 {};
        x = 3 |- x evalto 3 by E-Var1 {};
        3 times 3 is 9 by B-Times {}
      }
    };
    sq = ()[fun x -> x * x] |- sq 4 evalto 16 by E-App {
      sq = ()[fun x -> x * x] |- sq evalto ()[fun x -> x * x] by E-Var1 {};
      sq = ()[fun x -> x * x] |- 4 evalto 4 by E-Int {};
      x = 4 |- x * x evalto 16 by E-Times {
        x = 4 |- x evalto 4 by E-Var1 {};
        x = 4 |- x evalto 4 by E-Var1 {};
        4 times 4 is 16 by B-Times {}
      }
    };
    9 plus 16 is 25 by B-Plus {}
  }
}
```

### 第 43 問

```ocaml
let sm = fun f -> f 3 + f 4 in
  sm (fun x -> x * x)
```

```ocaml
|- let sm = fun f -> f 3 + f 4 in sm (fun x -> x * x) evalto 25 by E-Let {
  |- fun f -> f 3 + f 4 evalto ()[fun f -> f 3 + f 4] by E-Fun {};
  sm = ()[fun f -> f 3 + f 4] |- sm (fun x -> x * x) evalto 25 by E-App {
    sm = ()[fun f -> f 3 + f 4] |- sm evalto ()[fun f -> f 3 + f 4] by E-Var1 {};
    sm = ()[fun f -> f 3 + f 4] |- fun x -> x * x evalto (sm = ()[fun f -> f 3 + f 4])[fun x -> x * x] by E-Fun {};
    f = (sm = ()[fun f -> f 3 + f 4])[fun x -> x * x] |- f 3 + f 4 evalto 25 by E-Plus {
      f = (sm = ()[fun f -> f 3 + f 4])[fun x -> x * x] |- f 3 evalto 9 by E-App {
        f = (sm = ()[fun f -> f 3 + f 4])[fun x -> x * x] |- f evalto (sm = ()[fun f -> f 3 + f 4])[fun x -> x * x] by E-Var1 {};
        f = (sm = ()[fun f -> f 3 + f 4])[fun x -> x * x] |- 3 evalto 3 by E-Int {};
        sm = ()[fun f -> f 3 + f 4], x = 3 |- x * x evalto 9 by E-Times {
          sm = ()[fun f -> f 3 + f 4], x = 3 |- x evalto 3 by E-Var1 {};
          sm = ()[fun f -> f 3 + f 4], x = 3 |- x evalto 3 by E-Var1 {};
          3 times 3 is 9 by B-Times {}
        }
      };
      f = (sm = ()[fun f -> f 3 + f 4])[fun x -> x * x] |- f 4 evalto 16 by E-App {
        f = (sm = ()[fun f -> f 3 + f 4])[fun x -> x * x] |- f evalto (sm = ()[fun f -> f 3 + f 4])[fun x -> x * x] by E-Var1 {};
        f = (sm = ()[fun f -> f 3 + f 4])[fun x -> x * x] |- 4 evalto 4 by E-Int {};
        sm = ()[fun f -> f 3 + f 4], x = 4 |- x * x evalto 16 by E-Times {
          sm = ()[fun f -> f 3 + f 4], x = 4 |- x evalto 4 by E-Var1 {};
          sm = ()[fun f -> f 3 + f 4], x = 4 |- x evalto 4 by E-Var1 {};
          4 times 4 is 16 by B-Times {}
        }
      };
      9 plus 16 is 25 by B-Plus {}
    }
  }
}
```

### 第 44 問

```ocaml
let
  max = fun x -> fun y -> if x < y then y else x
in
  max 3 5
```

```ocaml
|- let max = fun x -> fun y -> if x < y then y else x in max 3 5 evalto 5 by E-Let {
  |- fun x -> fun y -> if x < y then y else x evalto ()[fun x -> fun y -> if x < y then y else x] by E-Fun {};
  max = ()[fun x -> fun y -> if x < y then y else x] |- max 3 5 evalto 5 by E-App {
    max = ()[fun x -> fun y -> if x < y then y else x] |- max 3 evalto (x = 3)[fun y -> if x < y then y else x] by E-App {
      max = ()[fun x -> fun y -> if x < y then y else x] |- max evalto ()[fun x -> fun y -> if x < y then y else x] by E-Var1 {};
      max = ()[fun x -> fun y -> if x < y then y else x] |- 3 evalto 3 by E-Int {};
      x = 3 |- fun y -> if x < y then y else x evalto (x = 3)[fun y -> if x < y then y else x] by E-Fun {}
    };
    max = ()[fun x -> fun y -> if x < y then y else x] |- 5 evalto 5 by E-Int {};
    x = 3, y = 5 |- if x < y then y else x evalto 5 by E-IfT {
      x = 3, y = 5 |- x < y evalto true by E-Lt {
        x = 3, y = 5 |- x evalto 3 by E-Var2 {
          x = 3 |- x evalto 3 by E-Var1 {}
        };
        x = 3, y = 5 |- y evalto 5 by E-Var1 {};
        3 less than 5 is true by B-Lt {}
      };
      x = 3, y = 5 |- y evalto 5 by E-Var1 {}
    }
  }
}
```

### 第 45 問

```ocaml
let a = 3 in
  let f = fun y -> y * a in
    let a = 5 in
      f 4
```

```ocaml
|- let a = 3 in let f = fun y -> y * a in let a = 5 in f 4 evalto 12 by E-Let {
  |- 3 evalto 3 by E-Int {};
  a = 3 |- let f = fun y -> y * a in let a = 5 in f 4 evalto 12 by E-Let {
    a = 3 |- fun y -> y * a evalto (a = 3)[fun y -> y * a] by E-Fun {};
    a = 3, f = (a = 3)[fun y -> y * a] |- let a = 5 in f 4 evalto 12 by E-Let {
      a = 3, f = (a = 3)[fun y -> y * a] |- 5 evalto 5 by E-Int {};
      a = 3, f = (a = 3)[fun y -> y * a], a = 5 |- f 4 evalto 12 by E-App {
        a = 3, f = (a = 3)[fun y -> y * a], a = 5 |- f evalto (a = 3)[fun y -> y * a] by E-Var2 {
          a = 3, f = (a = 3)[fun y -> y * a] |- f evalto (a = 3)[fun y -> y * a] by E-Var1 {}
        };
        a = 3, f = (a = 3)[fun y -> y * a], a = 5 |- 4 evalto 4 by E-Int {};
        a = 3, y = 4 |- y * a evalto 12 by E-Times {
          a = 3, y = 4 |- y evalto 4 by E-Var1 {};
          a = 3, y = 4 |- a evalto 3 by E-Var2 {
            a = 3 |- a evalto 3 by E-Var1 {}
          };
          4 times 3 is 12 by B-Times {}
        }
      }
    }
  }
}
```

### 第 46 問

```ocaml
let
  twice = fun f -> fun x -> f (f x)
in
  twice (fun x -> x * x) 2
```

```ocaml
|- let twice = fun f -> fun x -> f (f x) in twice (fun x -> x * x) 2 evalto 16 by E-Let {
  |- fun f -> fun x -> f (f x) evalto ()[fun f -> fun x -> f (f x)] by E-Fun {};
  twice = ()[fun f -> fun x -> f (f x)] |- twice (fun x -> x * x) 2 evalto 16 by E-App {
    twice = ()[fun f -> fun x -> f (f x)] |- twice (fun x -> x * x) evalto (f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x])[fun x -> f (f x)] by E-App {
      twice = ()[fun f -> fun x -> f (f x)] |- twice evalto ()[fun f -> fun x -> f (f x)] by E-Var1 {};
      twice = ()[fun f -> fun x -> f (f x)] |- fun x -> x * x evalto (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x] by E-Fun {};
      f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x] |- fun x -> f (f x) evalto (f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x])[fun x -> f (f x)] by E-Fun {}
    };
    twice = ()[fun f -> fun x -> f (f x)] |- 2 evalto 2 by E-Int {};
    f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x], x = 2 |- f (f x) evalto 16 by E-App {
      f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x], x = 2 |- f evalto (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x] by E-Var2 {
        f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x] |- f evalto (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x] by E-Var1 {}
      };
      f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x], x = 2 |- f x evalto 4 by E-App {
        f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x], x = 2 |- f evalto (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x] by E-Var2 {
          f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x] |- f evalto (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x] by E-Var1 {}
        };
        f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x], x = 2 |- x evalto 2 by E-Var1 {};
        twice = ()[fun f -> fun x -> f (f x)], x = 2 |- x * x evalto 4 by E-Times {
          twice = ()[fun f -> fun x -> f (f x)], x = 2 |- x evalto 2 by E-Var1 {};
          twice = ()[fun f -> fun x -> f (f x)], x = 2 |- x evalto 2 by E-Var1 {};
          2 times 2 is 4 by B-Times {}
        }
      };
      twice = ()[fun f -> fun x -> f (f x)], x = 4 |- x * x evalto 16 by E-Times {
        twice = ()[fun f -> fun x -> f (f x)], x = 4 |- x evalto 4 by E-Var1 {};
        twice = ()[fun f -> fun x -> f (f x)], x = 4 |- x evalto 4 by E-Var1 {};
        4 times 4 is 16 by B-Times {}
      }
    }
  }
}
```

### 第 47 問

```ocaml
let
  twice = fun f -> fun x -> f (f x)
in
  twice twice (fun x -> x * x) 2
```

```ocaml
|- let twice = fun f -> fun x -> f (f x) in twice twice (fun x -> x * x) 2 evalto 65536 by E-Let {
  |- fun f -> fun x -> f (f x) evalto ()[fun f -> fun x -> f (f x)] by E-Fun {};
  twice = ()[fun f -> fun x -> f (f x)] |- twice twice (fun x -> x * x) 2 evalto 65536 by E-App {
    twice = ()[fun f -> fun x -> f (f x)] |- twice twice (fun x -> x * x) evalto (f = (f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x])[fun x -> f (f x)])[fun x -> f (f x)] by E-App {
      twice = ()[fun f -> fun x -> f (f x)] |- twice twice evalto (f = ()[fun f -> fun x -> f (f x)])[fun x -> f (f x)] by E-App {
        twice = ()[fun f -> fun x -> f (f x)] |- twice evalto ()[fun f -> fun x -> f (f x)] by E-Var1 {};
        twice = ()[fun f -> fun x -> f (f x)] |- twice evalto ()[fun f -> fun x -> f (f x)] by E-Var1 {};
        f = ()[fun f -> fun x -> f (f x)] |- fun x -> f (f x) evalto (f = ()[fun f -> fun x -> f (f x)])[fun x -> f (f x)] by E-Fun {}
      };
      twice = ()[fun f -> fun x -> f (f x)] |- fun x -> x * x evalto (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x] by E-Fun {};
      f = ()[fun f -> fun x -> f (f x)], x = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x] |- f (f x) evalto (f = (f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x])[fun x -> f (f x)])[fun x -> f (f x)] by E-App {
        f = ()[fun f -> fun x -> f (f x)], x = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x] |- f evalto ()[fun f -> fun x -> f (f x)] by E-Var2 {
          f = ()[fun f -> fun x -> f (f x)] |- f evalto ()[fun f -> fun x -> f (f x)] by E-Var1 {}
        };
        f = ()[fun f -> fun x -> f (f x)], x = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x] |- f x evalto (f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x])[fun x -> f (f x)] by E-App {
          f = ()[fun f -> fun x -> f (f x)], x = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x] |- f evalto ()[fun f -> fun x -> f (f x)] by E-Var2 {
            f = ()[fun f -> fun x -> f (f x)] |- f evalto ()[fun f -> fun x -> f (f x)] by E-Var1 {}
          };
          f = ()[fun f -> fun x -> f (f x)], x = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x] |- x evalto (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x] by E-Var1 {};
          f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x] |- fun x -> f (f x) evalto (f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x])[fun x -> f (f x)] by E-Fun {}
        };
        f = (f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x])[fun x -> f (f x)] |- fun x -> f (f x) evalto (f = (f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x])[fun x -> f (f x)])[fun x -> f (f x)] by E-Fun {}
      }
    };
    twice = ()[fun f -> fun x -> f (f x)] |- 2 evalto 2 by E-Int {};
    f = (f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x])[fun x -> f (f x)], x = 2 |- f (f x) evalto 65536 by E-App {
      f = (f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x])[fun x -> f (f x)], x = 2 |- f evalto (f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x])[fun x -> f (f x)] by E-Var2 {
        f = (f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x])[fun x -> f (f x)] |- f evalto (f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x])[fun x -> f (f x)] by E-Var1 {}
      };
      f = (f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x])[fun x -> f (f x)], x = 2 |- f x evalto 16 by E-App {
        f = (f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x])[fun x -> f (f x)], x = 2 |- f evalto (f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x])[fun x -> f (f x)] by E-Var2 {
          f = (f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x])[fun x -> f (f x)] |- f evalto (f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x])[fun x -> f (f x)] by E-Var1 {}
        };
        f = (f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x])[fun x -> f (f x)], x = 2 |- x evalto 2 by E-Var1 {};
        f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x], x = 2 |- f (f x) evalto 16 by E-App {
          f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x], x = 2 |- f evalto (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x] by E-Var2 {
            f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x] |- f evalto (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x] by E-Var1 {}
          };
          f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x], x = 2 |- f x evalto 4 by E-App {
            f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x], x = 2 |- f evalto (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x] by E-Var2 {
              f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x] |- f evalto (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x] by E-Var1 {}
            };
            f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x], x = 2 |- x evalto 2 by E-Var1 {};
            twice = ()[fun f -> fun x -> f (f x)], x = 2 |- x * x evalto 4 by E-Times {
              twice = ()[fun f -> fun x -> f (f x)], x = 2 |- x evalto 2 by E-Var1 {};
              twice = ()[fun f -> fun x -> f (f x)], x = 2 |- x evalto 2 by E-Var1 {};
              2 times 2 is 4 by B-Times {}
            }
          };
          twice = ()[fun f -> fun x -> f (f x)], x = 4 |- x * x evalto 16 by E-Times {
            twice = ()[fun f -> fun x -> f (f x)], x = 4 |- x evalto 4 by E-Var1 {};
            twice = ()[fun f -> fun x -> f (f x)], x = 4 |- x evalto 4 by E-Var1 {};
            4 times 4 is 16 by B-Times {}
          }
        }
      };
      f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x], x = 16 |- f (f x) evalto 65536 by E-App {
        f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x], x = 16 |- f evalto (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x] by E-Var2 {
          f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x] |- f evalto (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x] by E-Var1 {}
        };
        f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x], x = 16 |- f x evalto 256 by E-App {
          f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x], x = 16 |- f evalto (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x] by E-Var2 {
            f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x] |- f evalto (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x] by E-Var1 {}
          };
          f = (twice = ()[fun f -> fun x -> f (f x)])[fun x -> x * x], x = 16 |- x evalto 16 by E-Var1 {};
          twice = ()[fun f -> fun x -> f (f x)], x = 16 |- x * x evalto 256 by E-Times {
            twice = ()[fun f -> fun x -> f (f x)], x = 16 |- x evalto 16 by E-Var1 {};
            twice = ()[fun f -> fun x -> f (f x)], x = 16 |- x evalto 16 by E-Var1 {};
            16 times 16 is 256 by B-Times {}
          }
        };
        twice = ()[fun f -> fun x -> f (f x)], x = 256 |- x * x evalto 65536 by E-Times {
          twice = ()[fun f -> fun x -> f (f x)], x = 256 |- x evalto 256 by E-Var1 {};
          twice = ()[fun f -> fun x -> f (f x)], x = 256 |- x evalto 256 by E-Var1 {};
          256 times 256 is 65536 by B-Times {}
        } 
      }
    }
  }
}
```

### 第 48 問

```ocaml
|- let
  compose = fun f -> fun g -> fun x -> f (g x)
in 
  let p = fun x -> x * x in
    let q = fun x -> x + 4 in
      compose p q 4
evalto 64 by E-Let {
  |- fun f -> fun g -> fun x -> f (g x) evalto ()[fun f -> fun g -> fun x -> f (g x)] by E-Fun {};
  compose = ()[fun f -> fun g -> fun x -> f (g x)] |- let p = fun x -> x * x in let q = fun x -> x + 4 in compose p q 4 evalto 64 by E-Let {
    compose = ()[fun f -> fun g -> fun x -> f (g x)] |- fun x -> x * x evalto (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x] by E-Fun {};
    compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x] |- let q = fun x -> x + 4 in compose p q 4 evalto 64 by E-Let {
      compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x] |- fun x -> x + 4 evalto (compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x])[fun x -> x + 4] by E-Fun {};
      compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x], q = (compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x])[fun x -> x + 4] |- compose p q 4 evalto 64 by E-App {
        compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x], q = (compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x])[fun x -> x + 4] |- compose p q evalto (f = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x], g = (compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x])[fun x -> x + 4])[fun x -> f (g x)] by E-App {
          compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x], q = (compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x])[fun x -> x + 4] |- compose p evalto (f = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x])[fun g -> fun x -> f (g x)] by E-App {
            compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x], q = (compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x])[fun x -> x + 4] |- compose evalto ()[fun f -> fun g -> fun x -> f (g x)] by E-Var2 {
              compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x] |- compose evalto ()[fun f -> fun g -> fun x -> f (g x)] by E-Var2 {
                compose = ()[fun f -> fun g -> fun x -> f (g x)] |- compose evalto ()[fun f -> fun g -> fun x -> f (g x)] by E-Var1 {}
              }
            };
            compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x], q = (compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x])[fun x -> x + 4] |- p evalto (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x] by E-Var2 {
              compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x] |- p evalto (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x] by E-Var1 {}
            };
            f = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x] |- fun g -> fun x -> f (g x) evalto (f = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x])[fun g -> fun x -> f (g x)] by E-Fun {}
          };
          compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x], q = (compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x])[fun x -> x + 4] |- q evalto (compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x])[fun x -> x + 4] by E-Var1 {};
          f = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x], g = (compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x])[fun x -> x + 4] |- fun x -> f (g x) evalto (f = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x], g = (compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x])[fun x -> x + 4])[fun x -> f (g x)] by E-Fun {}
        };
        compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x], q = (compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x])[fun x -> x + 4] |- 4 evalto 4 by E-Int {};
        f = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x], g = (compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x])[fun x -> x + 4], x = 4 |- f (g x) evalto 64 by E-App {
          f = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x], g = (compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x])[fun x -> x + 4], x = 4 |- f evalto (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x] by E-Var2 {
            f = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x], g = (compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x])[fun x -> x + 4] |- f evalto (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x] by E-Var2 {
              f = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x] |- f evalto (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x] by E-Var1 {}
            }
          };
          f = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x], g = (compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x])[fun x -> x + 4], x = 4 |- g x evalto 8 by E-App {
            f = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x], g = (compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x])[fun x -> x + 4], x = 4 |- g evalto (compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x])[fun x -> x + 4] by E-Var2 {
              f = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x], g = (compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x])[fun x -> x + 4] |- g evalto (compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x])[fun x -> x + 4] by E-Var1 {}
            };
            f = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x], g = (compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x])[fun x -> x + 4], x = 4 |- x evalto 4 by E-Var1 {};
            compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x], x = 4 |- x + 4 evalto 8 by E-Plus {
              compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x], x = 4 |- x evalto 4 by E-Var1 {};
              compose = ()[fun f -> fun g -> fun x -> f (g x)], p = (compose = ()[fun f -> fun g -> fun x -> f (g x)])[fun x -> x * x], x = 4 |- 4 evalto 4 by E-Int {};
              4 plus 4 is 8 by B-Plus {}
            }
          };
          compose = ()[fun f -> fun g -> fun x -> f (g x)], x = 8 |- x * x evalto 64 by E-Times {
            compose = ()[fun f -> fun g -> fun x -> f (g x)], x = 8 |- x evalto 8 by E-Var1 {};
            compose = ()[fun f -> fun g -> fun x -> f (g x)], x = 8 |- x evalto 8 by E-Var1 {};
            8 times 8 is 64 by B-Times {}
          }
        }
      }
    }
  }
}
```

### 第 49 問

```ocaml
|- let
  s = fun f -> fun g -> fun x -> f x (g x)
in
  let k = fun x -> fun y -> x in
    s k k 7
evalto 7 by E-Let {
  |- fun f -> fun g -> fun x -> f x (g x) evalto ()[fun f -> fun g -> fun x -> f x (g x)] by E-Fun {};
  s = ()[fun f -> fun g -> fun x -> f x (g x)] |- let k = fun x -> fun y -> x in s k k 7 evalto 7 by E-Let {
    s = ()[fun f -> fun g -> fun x -> f x (g x)] |- fun x -> fun y -> x evalto (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x] by E-Fun {};
    s = ()[fun f -> fun g -> fun x -> f x (g x)], k = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x] |- s k k 7 evalto 7 by E-App {
      s = ()[fun f -> fun g -> fun x -> f x (g x)], k = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x] |- s k k evalto (f = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x], g = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x])[fun x -> f x (g x)] by E-App {
        s = ()[fun f -> fun g -> fun x -> f x (g x)], k = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x] |- s k evalto (f = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x])[fun g -> fun x -> f x (g x)] by E-App {
          s = ()[fun f -> fun g -> fun x -> f x (g x)], k = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x] |- s evalto ()[fun f -> fun g -> fun x -> f x (g x)] by E-Var2 {
            s = ()[fun f -> fun g -> fun x -> f x (g x)] |- s evalto ()[fun f -> fun g -> fun x -> f x (g x)] by E-Var1 {}
          };
          s = ()[fun f -> fun g -> fun x -> f x (g x)], k = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x] |- k evalto (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x] by E-Var1 {};
          f = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x] |- fun g -> fun x -> f x (g x) evalto (f = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x])[fun g -> fun x -> f x (g x)] by E-Fun {}
        };
        s = ()[fun f -> fun g -> fun x -> f x (g x)], k = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x] |- k evalto (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x] by E-Var1 {};
        f = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x], g = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x] |- fun x -> f x (g x) evalto (f = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x], g = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x])[fun x -> f x (g x)] by E-Fun {}
      };
      s = ()[fun f -> fun g -> fun x -> f x (g x)], k = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x] |- 7 evalto 7 by E-Int {};
      f = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x], g = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x], x = 7 |- f x (g x) evalto 7 by E-App {
        f = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x], g = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x], x = 7 |- f x evalto (s = ()[fun f -> fun g -> fun x -> f x (g x)], x = 7)[fun y -> x] by E-App {
          f = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x], g = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x], x = 7 |- f evalto (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x] by E-Var2 {
            f = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x], g = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x] |- f evalto (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x] by E-Var2 {
              f = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x] |- f evalto (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x] by E-Var1 {}
            }
          };
          f = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x], g = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x], x = 7 |- x evalto 7 by E-Var1 {};
          s = ()[fun f -> fun g -> fun x -> f x (g x)], x = 7 |- fun y -> x evalto (s = ()[fun f -> fun g -> fun x -> f x (g x)], x = 7)[fun y -> x] by E-Fun {}
        };
        f = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x], g = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x], x = 7 |- g x evalto (s = ()[fun f -> fun g -> fun x -> f x (g x)], x = 7)[fun y -> x] by E-App {
          f = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x], g = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x], x = 7 |- g evalto (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x] by E-Var2 {
            f = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x], g = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x] |- g evalto (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x] by E-Var1 {}
          };
          f = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x], g = (s = ()[fun f -> fun g -> fun x -> f x (g x)])[fun x -> fun y -> x], x = 7 |- x evalto 7 by E-Var1 {};
          s = ()[fun f -> fun g -> fun x -> f x (g x)], x = 7 |- fun y -> x evalto (s = ()[fun f -> fun g -> fun x -> f x (g x)], x = 7)[fun y -> x] by E-Fun {}
        };
        s = ()[fun f -> fun g -> fun x -> f x (g x)], x = 7, y = (s = ()[fun f -> fun g -> fun x -> f x (g x)], x = 7)[fun y -> x] |- x evalto 7 by E-Var2 {
          s = ()[fun f -> fun g -> fun x -> f x (g x)], x = 7 |- x evalto 7 by E-Var1 {}
        }
      }
    }
  }
}
```

### 第 50 問

```
|- let rec fact = fun n ->
  if n < 2 then 1 else n * fact (n - 1) in
    fact 3
evalto 6 by E-LetRec {
  fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)] |- fact 3 evalto 6 by E-AppRec {
    fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)] |- fact evalto ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)] by E-Var1 {};
    fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)] |- 3 evalto 3 by E-Int {};
    fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)], n = 3 |- if n < 2 then 1 else n * fact (n - 1) evalto 6 by E-IfF {
      fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)], n = 3 |- n < 2 evalto false by E-Lt {
        fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)], n = 3 |- n evalto 3 by E-Var1 {};
        fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)], n = 3 |- 2 evalto 2 by E-Int {};
        3 less than 2 is false by B-Lt {}
      };
      fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)], n = 3 |- n * fact (n - 1) evalto 6 by E-Times {
        fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)], n = 3 |- n evalto 3 by E-Var1 {};
        fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)], n = 3 |- fact (n - 1) evalto 2 by E-AppRec {
          fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)], n = 3 |- fact evalto ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)] by E-Var2 {
            fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)] |- fact evalto ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)] by E-Var1 {}
          };
          fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)], n = 3 |- n - 1 evalto 2 by E-Minus {
            fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)], n = 3 |- n evalto 3 by E-Var1 {};
            fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)], n = 3 |- 1 evalto 1 by E-Int {};
            3 minus 1 is 2 by B-Minus {}
          };
          fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)], n = 2 |- if n < 2 then 1 else n * fact (n - 1) evalto 2 by E-IfF {
            fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)], n = 2 |- n < 2 evalto false by E-Lt {
              fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)], n = 2 |- n evalto 2 by E-Var1 {};
              fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)], n = 2 |- 2 evalto 2 by E-Int {};
              2 less than 2 is false by B-Lt {}
            };
            fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)], n = 2 |- n * fact (n - 1) evalto 2 by E-Times {
              fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)], n = 2 |- n evalto 2 by E-Var1 {};
              fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)], n = 2 |- fact (n - 1) evalto 1 by E-AppRec {
                fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)], n = 2 |- fact evalto ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)] by E-Var2 {
                  fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)] |- fact evalto ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)] by E-Var1 {}
                };
                fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)], n = 2 |- n - 1 evalto 1 by E-Minus {
                  fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)], n = 2 |- n evalto 2 by E-Var1 {};
                  fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)], n = 2 |- 1 evalto 1 by E-Int {};
                  2 minus 1 is 1 by B-Minus {}
                };
                fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)], n = 1 |- if n < 2 then 1 else n * fact (n - 1) evalto 1 by E-IfT {
                  fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)], n = 1 |- n < 2 evalto true by E-Lt {
                    fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)], n = 1 |- n evalto 1 by E-Var1 {};
                    fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)], n = 1 |- 2 evalto 2 by E-Int {};
                    1 less than 2 is true by B-Lt {}
                  };
                  fact = ()[rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1)], n = 1 |- 1 evalto 1 by E-Int {};
                }
              };
              2 times 1 is 2 by B-Times {}
            }
          }
        };
        3 times 2 is 6 by B-Times {}
      }
    }
  }
}
```

### 第 51 問

```
|- let rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2) in
  fib 5
evalto 5 by E-LetRec {
  fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)] |- fib 5 evalto 5 by E-AppRec {
    fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)] |- fib evalto ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)] by E-Var1 {};
    fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)] |- 5 evalto 5 by E-Int {};
    fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 5 |- if n < 3 then 1 else fib (n - 1) + fib (n - 2) evalto 5 by E-IfF {
      fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 5 |- n < 3 evalto false by E-Lt {
        fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 5 |- n evalto 5 by E-Var1 {};
        fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 5 |- 3 evalto 3 by E-Int {};
        5 less than 3 is false by B-Lt {}
      };
      fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 5 |- fib (n - 1) + fib (n - 2) evalto 5 by E-Plus {
        fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 5 |- fib (n - 1) evalto 3 by E-AppRec {
          fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 5 |- fib evalto ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)] by E-Var2 {
            fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)] |- fib evalto ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)] by E-Var1 {}
          };
          fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 5 |- n - 1 evalto 4 by E-Minus {
            fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 5 |- n evalto 5 by E-Var1 {};
            fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 5 |- 1 evalto 1 by E-Int {};
            5 minus 1 is 4 by B-Minus {}
          };
          fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 4 |- if n < 3 then 1 else fib (n - 1) + fib (n - 2) evalto 3 by E-IfF {
            fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 4 |- n < 3 evalto false by E-Lt {
              fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 4 |- n evalto 4 by E-Var1 {};
              fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 4 |- 3 evalto 3 by E-Int {};
              4 less than 3 is false by B-Lt {}
            };
            fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 4 |- fib (n - 1) + fib (n - 2) evalto 3 by E-Plus {
              fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 4 |- fib (n - 1) evalto 2 by E-AppRec {
                fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 4 |- fib evalto ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)] by E-Var2 {
                  fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)] |- fib evalto ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)] by E-Var1 {}
                };
                fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 4 |- n - 1 evalto 3 by E-Minus {
                  fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 4 |- n evalto 4 by E-Var1 {};
                  fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 4 |- 1 evalto 1 by E-Int {};
                  4 minus 1 is 3 by B-Minus {}
                };
                fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 3 |- if n < 3 then 1 else fib (n - 1) + fib (n - 2) evalto 2 by E-IfF {
                  fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 3 |- n < 3 evalto false by E-Lt {
                    fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 3 |- n evalto 3 by E-Var1 {};
                    fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 3 |- 3 evalto 3 by E-Int {};
                    3 less than 3 is false by B-Lt {}
                  };
                  fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 3 |- fib (n - 1) + fib (n - 2) evalto 2 by E-Plus {
                    fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 3 |- fib (n - 1) evalto 1 by E-AppRec {
                      fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 3 |- fib evalto ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)] by E-Var2 {
                        fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)] |- fib evalto ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)] by E-Var1 {}
                      };
                      fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 3 |- n - 1 evalto 2 by E-Minus {
                        fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 3 |- n evalto 3 by E-Var1 {};
                        fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 3 |- 1 evalto 1 by E-Int {};
                        3 minus 1 is 2 by B-Minus {}
                      };
                      fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 2 |- if n < 3 then 1 else fib (n - 1) + fib (n - 2) evalto 1 by E-IfT {
                        fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 2 |- n < 3 evalto true by E-Lt {
                          fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 2 |- n evalto 2 by E-Var1 {};
                          fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 2 |- 3 evalto 3 by E-Int {};
                          2 less than 3 is true by B-Lt {}
                        };
                        fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 2 |- 1 evalto 1 by E-Int {}
                      }
                    };
                    fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 3 |- fib (n - 2) evalto 1 by E-AppRec {
                      fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 3 |- fib evalto ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)] by E-Var2 {
                        fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)] |- fib evalto ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)] by E-Var1 {}
                      };
                      fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 3 |- n - 2 evalto 1 by E-Minus {
                        fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 3 |- n evalto 3 by E-Var1 {};
                        fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 3 |- 2 evalto 2 by E-Int {};
                        3 minus 2 is 1 by B-Minus {}
                      };
                      fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 1 |- if n < 3 then 1 else fib (n - 1) + fib (n - 2) evalto 1 by E-IfT {
                        fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 1 |- n < 3 evalto true by E-Lt {
                          fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 1 |- n evalto 1 by E-Var1 {};
                          fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 1 |- 3 evalto 3 by E-Int {};
                          1 less than 3 is true by B-Lt {}
                        };
                        fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 1 |- 1 evalto 1 by E-Int {}
                      }
                    };
                    1 plus 1 is 2 by B-Plus {}
                  }
                }
              };
              fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 4 |- fib (n - 2) evalto 1 by E-AppRec {
                fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 4 |- fib evalto ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)] by E-Var2 {
                  fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)] |- fib evalto ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)] by E-Var1 {}
                };
                fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 4 |- n - 2 evalto 2 by E-Minus {
                  fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 4 |- n evalto 4 by E-Var1 {};
                  fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 4 |- 2 evalto 2 by E-Int {};
                  4 minus 2 is 2 by B-Minus {}
                };
                fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 2 |- if n < 3 then 1 else fib (n - 1) + fib (n - 2) evalto 1 by E-IfT {
                  fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 2 |- n < 3 evalto true by E-Lt {
                    fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 2 |- n evalto 2 by E-Var1 {};
                    fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 2 |- 3 evalto 3 by E-Int {};
                    2 less than 3 is true by B-Lt {}
                  };
                  fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 2 |- 1 evalto 1 by E-Int {}
                }
              };
              2 plus 1 is 3 by B-Plus {}
            }
          }
        };
        fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 5 |- fib (n - 2) evalto 2 by E-AppRec {
          fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 5 |- fib evalto ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)] by E-Var2 {
            fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)] |- fib evalto ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)] by E-Var1 {}
          };
          fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 5 |- n - 2 evalto 3 by E-Minus {
            fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 5 |- n evalto 5 by E-Var1 {};
            fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 5 |- 2 evalto 2 by E-Int {};
            5 minus 2 is 3 by B-Minus {}
          };fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 3 |- if n < 3 then 1 else fib (n - 1) + fib (n - 2) evalto 2 by E-IfF {
            fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 3 |- n < 3 evalto false by E-Lt {
              fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 3 |- n evalto 3 by E-Var1 {};
              fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 3 |- 3 evalto 3 by E-Int {};
              3 less than 3 is false by B-Lt {}
            };
            fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 3 |- fib (n - 1) + fib (n - 2) evalto 2 by E-Plus {
              fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 3 |- fib (n - 1) evalto 1 by E-AppRec {
                fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 3 |- fib evalto ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)] by E-Var2 {
                  fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)] |- fib evalto ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)] by E-Var1 {}
                };
                fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 3 |- n - 1 evalto 2 by E-Minus {
                  fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 3 |- n evalto 3 by E-Var1 {};
                  fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 3 |- 1 evalto 1 by E-Int {};
                  3 minus 1 is 2 by B-Minus {}
                };
                fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 2 |- if n < 3 then 1 else fib (n - 1) + fib (n - 2) evalto 1 by E-IfT {
                  fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 2 |- n < 3 evalto true by E-Lt {
                    fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 2 |- n evalto 2 by E-Var1 {};
                    fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 2 |- 3 evalto 3 by E-Int {};
                    2 less than 3 is true by B-Lt {}
                  };
                  fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 2 |- 1 evalto 1 by E-Int {}
                }
              };
              fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 3 |- fib (n - 2) evalto 1 by E-AppRec {
                fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 3 |- fib evalto ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)] by E-Var2 {
                  fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)] |- fib evalto ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)] by E-Var1 {}
                };
                fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 3 |- n - 2 evalto 1 by E-Minus {
                  fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 3 |- n evalto 3 by E-Var1 {};
                  fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 3 |- 2 evalto 2 by E-Int {};
                  3 minus 2 is 1 by B-Minus {}
                };
                fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 1 |- if n < 3 then 1 else fib (n - 1) + fib (n - 2) evalto 1 by E-IfT {
                  fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 1 |- n < 3 evalto true by E-Lt {
                    fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 1 |- n evalto 1 by E-Var1 {};
                    fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 1 |- 3 evalto 3 by E-Int {};
                    1 less than 3 is true by B-Lt {}
                  };
                  fib = ()[rec fib = fun n -> if n < 3 then 1 else fib (n - 1) + fib (n - 2)], n = 1 |- 1 evalto 1 by E-Int {}
                }
              };
              1 plus 1 is 2 by B-Plus {}
            }
          }
        };
        3 plus 2 is 5 by B-Plus {}
      }
    }
  }
}
```
