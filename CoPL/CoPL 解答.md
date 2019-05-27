# CoPL 解答

## 自然数の加算・乗算

### 第 1 問

```ocaml
Z plus Z is Z by P-Zero {}
```

### 第 2 問

```ocaml
Z plus S(S(Z)) is S(S(Z)) by P-Zero {}
```

### 第 3 問

```ocaml
S(S(Z)) plus Z is S(S(Z)) by P-Succ {
  S(Z) plus Z is S(Z) by P-Succ {
    Z plus Z is Z by P-Zero {}
  }
}
```

### 第 4 問

```ocaml
S(Z) plus S(S(S(Z))) is S(S(S(S(Z)))) by P-Succ {
  Z plus S(S(S(Z))) is S(S(S(Z))) by P-Zero {}
}
```

### 第 5 問

```ocaml
Z times S(S(Z)) is Z by T-Zero {}
```

### 第 6 問

```ocaml
S(S(Z)) times Z is Z by T-Succ {
  S(Z) times Z is Z by T-Succ {
    Z times Z is Z by T-Zero {};
    Z plus Z is Z by P-Zero {}
  };
  Z plus Z is Z by P-Zero {}
}
```

### 第 7 問

```ocaml
S(S(Z)) times S(Z) is S(S(Z)) by T-Succ {
  S(Z) times S(Z) is S(Z) by T-Succ {
    Z times S(Z) is Z by T-Zero {};
    S(Z) plus Z is S(Z) by P-Succ {
      Z plus Z is Z by P-Zero {}
    }
  };
  S(Z) plus S(Z) is S(S(Z)) by P-Succ {
    Z plus S(Z) is S(Z) by P-Zero {}
  }
}
```

### 第 8 問

```ocaml
S(S(Z)) times S(S(Z)) is S(S(S(S(Z)))) by T-Succ {
  S(Z) times S(S(Z)) is S(S(Z)) by T-Succ {
    Z times S(S(Z)) is Z by T-Zero {};
    S(S(Z)) plus Z is S(S(Z)) by P-Succ {
      S(Z) plus Z is S(Z) by P-Succ {
        Z plus Z is Z by P-Zero {}
      }
    }
  };
  S(S(Z)) plus S(S(Z)) is S(S(S(S(Z)))) by P-Succ {
    S(Z) plus S(S(Z)) is S(S(S(Z))) by P-Succ {
      Z plus S(S(Z)) is S(S(Z)) by P-Zero {}
    }
  }
}
```

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

```ocaml
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

```ocaml
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

### 第 54 問

```ocaml
|- let rec sum = fun f -> fun n -> if n < 1 then 0 else f n + sum f (n - 1) in
  sum (fun x -> x * x) 2
evalto 5 by E-LetRec {
  sum = ()[rec sum = fun f -> fun n -> if n < 1 then 0 else f n + sum f (n - 1)] |- sum (fun x -> x * x) 2 evalto 5 by E-AppRec {
    sum = ()[rec sum = fun f -> fun n -> if n < 1 then 0 else f n + sum f (n - 1)] |- sum (fun x -> x * x) evalto ??? by {
      sum = ()[rec sum = fun f -> fun n -> if n < 1 then 0 else f n + sum f (n - 1)] |- sum evalto ()[rec sum = fun f -> fun n -> if n < 1 then 0 else f n + sum f (n - 1)] by E-Var1 {};
      sum = ()[rec sum = fun f -> fun n -> if n < 1 then 0 else f n + sum f (n - 1)] |- fun x -> x * x evalto (sum = ()[rec sum = fun f -> fun n -> if n < 1 then 0 else f n + sum f (n - 1)])[fun x -> x * x] by E-Fun {};
      sum = ()[rec sum = fun f -> fun n -> if n < 1 then 0 else f n + sum f (n - 1)], f = (sum = ()[rec sum = fun f -> fun n -> if n < 1 then 0 else f n + sum f (n - 1)])[fun x -> x * x] |- fun n -> if n < 1 then 0 else f n + sum f (n - 1) evalto (sum = ()[rec sum = fun f -> fun n -> if n < 1 then 0 else f n + sum f (n - 1)], f = (sum = ()[rec sum = fun f -> fun n -> if n < 1 then 0 else f n + sum f (n - 1)])[fun x -> x * x])[fun n -> if n < 1 then 0 else f n + sum f (n - 1)] by E-Fun {}
    };
    sum = ()[rec sum = fun f -> fun n -> if n < 1 then 0 else f n + sum f (n - 1)] |- 2 evalto 2 by E-Int {};
  }
}
```

### 第 56 問

```ocaml
|- let x = 3 * 3 in let y = 4 * x in x + y ==> let . = 3 * 3 in let . = 4 * #1 in #2 + #1 by Tr-Let {
  |- 3 * 3 ==> 3 * 3 by Tr-Times {
    |- 3 ==> 3 by Tr-Int {};
    |- 3 ==> 3 by Tr-Int {}
  };
  x |- let y = 4 * x in x + y ==> let . = 4 * #1 in #2 + #1 by Tr-Let {
    x |- 4 * x ==> 4 * #1 by Tr-Times {
      x |- 4 ==> 4 by Tr-Int {};
      x |- x ==> #1 by Tr-Var1 {}
    };
    x, y |- x + y ==> #2 + #1 by Tr-Plus {
      x, y |- x ==> #2 by Tr-Var2 {
        x |- x ==> #1 by Tr-Var1 {}
      };
      x, y |- y ==> #1 by Tr-Var1 {}
    }
  }
}
```

### 第 58 問

```ocaml
x |- let x = x * 2 in x + x ==> let . = #1 * 2 in #1 + #1 by Tr-Let {
  x |- x * 2 ==> #1 * 2 by Tr-Times {
    x |- x ==> #1 by Tr-Var1 {};
    x |- 2 ==> 2 by Tr-Int {}
  };
  x, x |- x + x ==> #1 + #1 by Tr-Plus {
    x, x |- x ==> #1 by Tr-Var1 {}; 
    x, x |- x ==> #1 by Tr-Var1 {}
  }
}
```

### 第 60 問

```ocaml
|- let x = let y = 3 - 2 in y * y in let y = 4 in x + y ==> let . = let . = 3 - 2 in #1 * #1 in let . = 4 in #2 + #1 by Tr-Let {
  |- let y = 3 - 2 in y * y ==> let . = 3 - 2 in #1 * #1 by Tr-Let {
    |- 3 - 2 ==> 3 - 2 by Tr-Minus {
      |- 3 ==> 3 by Tr-Int {};
      |- 2 ==> 2 by Tr-Int {}
    };
    y |- y * y ==> #1 * #1 by Tr-Times {
      y |- y ==> #1 by Tr-Var1 {};
      y |- y ==> #1 by Tr-Var1 {}
    }
  };
  x |- let y = 4 in x + y ==> let . = 4 in #2 + #1 by Tr-Let {
    x |- 4 ==> 4 by Tr-Int {};
    x, y |- x + y ==> #2 + #1 by Tr-Plus {
      x, y |- x ==> #2 by Tr-Var2 {
        x |- x ==> #1 by Tr-Var1 {}
      };
      x, y |- y ==> #1 by Tr-Var1 {}
    }
  }
}
```

### 第 62 問

```ocaml
|- let y = 2 in fun x -> x + y ==> let . = 2 in fun . -> #1 + #2 by Tr-Let {
  |- 2 ==> 2 by Tr-Int {};
  y |- fun x -> x + y ==> fun . -> #1 + #2 by Tr-Fun {
    y, x |- x + y ==> #1 + #2 by Tr-Plus {
      y, x |- x ==> #1 by Tr-Var1 {};
      y, x |- y ==> #2 by Tr-Var2 {
        y |- y ==> #1 by Tr-Var1 {}
      }
    }
  }
}
```

### 第 64 問

```ocaml
|- let sm = fun f -> f 3 + f 4 in sm (fun x -> x * x) ==> let . = fun . -> #1 3 + #1 4 in #1 (fun . -> #1 * #1) by Tr-Let {
  |- fun f -> f 3 + f 4 ==> fun . -> #1 3 + #1 4 by Tr-Fun {
    f |- f 3 + f 4 ==> #1 3 + #1 4 by Tr-Plus {
      f |- f 3 ==> #1 3 by Tr-App {
        f |- f ==> #1 by Tr-Var1 {};
        f |- 3 ==> 3 by Tr-Int {}
      };
      f |- f 4 ==> #1 4 by Tr-App {
        f |- f ==> #1 by Tr-Var1 {};
        f |- 4 ==> 4 by Tr-Int {}
      }
    }
  };
  sm |- sm (fun x -> x * x) ==> #1 (fun . -> #1 * #1) by Tr-App {
    sm |- sm ==> #1 by Tr-Var1 {};
    sm |- fun x -> x * x ==> fun . -> #1 * #1 by Tr-Fun {
      sm, x |- x * x ==> #1 * #1 by Tr-Times {
        sm, x |- x ==> #1 by Tr-Var1 {};
        sm, x |- x ==> #1 by Tr-Var1 {}
      }
    }
  }
}
```

### 第 66 問

```ocaml
|- let a = 3 in let f = fun y -> y * a in let a = 5 in f 4 ==> let . = 3 in let . = fun . -> #1 * #2 in let . = 5 in #2 4 by Tr-Let {
  |- 3 ==> 3 by Tr-Int {};
  a |- let f = fun y -> y * a in let a = 5 in f 4 ==> let . = fun . -> #1 * #2 in let . = 5 in #2 4 by Tr-Let {
    a |- fun y -> y * a ==> fun . -> #1 * #2 by Tr-Fun {
      a, y |- y * a ==> #1 * #2 by Tr-Times {
        a, y |- y ==> #1 by Tr-Var1 {};
        a, y |- a ==> #2 by Tr-Var2 {
          a |- a ==> #1 by Tr-Var1 {}
        }
      }
    };
    a, f |- let a = 5 in f 4 ==> let . = 5 in #2 4 by Tr-Let {
      a, f |- 5 ==> 5 by Tr-Int {};
      a, f, a |- f 4 ==> #2 4 by Tr-App {
        a, f, a |- f ==> #2 by Tr-Var2 {
          a, f |- f ==> #1 by Tr-Var1 {}
        };
        a, f, a |- 4 ==> 4 by Tr-Int {}
      }
    }
  }
}
```

### 第 68 問

```ocaml
|- let rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1) in fact 3
  ==> let rec . = fun . -> if #1 < 2 then 1 else #1 * #2 (#1 - 1) in #1 3 by Tr-LetRec {
    fact, n |- if n < 2 then 1 else n * fact (n - 1) ==> if #1 < 2 then 1 else #1 * #2 (#1 - 1) by Tr-If {
      fact, n |- n < 2 ==> #1 < 2 by Tr-Lt {
        fact, n |- n ==> #1 by Tr-Var1 {};
        fact, n |- 2 ==> 2 by Tr-Int {}
      };
      fact, n |- 1 ==> 1 by Tr-Int {};
      fact, n |- n * fact (n - 1) ==> #1 * #2 (#1 - 1) by Tr-Times {
        fact, n |- n ==> #1 by Tr-Var1 {};
        fact, n |- fact (n - 1) ==> #2 (#1 - 1) by Tr-App {
          fact, n |- fact ==> #2 by Tr-Var2 {
            fact |- fact ==> #1 by Tr-Var1 {}
          };
          fact, n |- n - 1 ==> #1 - 1 by Tr-Minus {
            fact, n |- n ==> #1 by Tr-Var1 {};
            fact, n |- 1 ==> 1 by Tr-Int {}
          }
        }
      }
    };
    fact |- fact 3 ==> #1 3 by Tr-App {
      fact |- fact ==> #1 by Tr-Var1 {};
      fact |- 3 ==> 3 by Tr-Int {}
    }
  }
```

### 第 55 問

```ocaml
true, 4 |- if #2 then #1 + 1 else #1 - 1 evalto 5 by E-IfT {
  true, 4 |- #2 evalto true by E-Var {};
  true, 4 |- #1 + 1 evalto 5 by E-Plus {
    true, 4 |- #1 evalto 4 by E-Var {};
    true, 4 |- 1 evalto 1 by E-Int {};
    4 plus 1 is 5 by B-Plus {}
  }
}
```

### 第 57 問

```ocaml
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
```

### 第 59 問

```ocaml
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
```

### 第 61 問

```ocaml
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
```

### 第 63 問

```ocaml
|- let . = 2 in fun . -> #1 + #2 evalto (2)[fun . -> #1 + #2] by E-Let {
  |- 2 evalto 2 by E-Int {};
  2 |- fun . -> #1 + #2 evalto (2)[fun . -> #1 + #2] by E-Fun {}
}
```

### 第 65 問

[こちら](https://twitter.com/0918nobita/status/1084637334593662976)

### 第 67 問

```ocaml
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
```

### 第 69 問

```ocaml
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
```

## リスト

### 第 70 問

```ocaml
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
```

### 第 71 問

```ocaml
|- let f = fun x -> match x with [] -> 0 | a :: b -> a in f (4::[]) + f [] + f (1 :: 2 :: 3 :: []) evalto 5 by E-Let {
  |- fun x -> match x with [] -> 0 | a :: b -> a evalto ()[fun x -> match x with [] -> 0 | a :: b -> a] by E-Fun {};
  f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- f (4::[]) + f [] + f (1 :: 2 :: 3 :: []) evalto 5 by E-Plus {
    f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- f (4::[]) + f [] evalto 4 by E-Plus {
      f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- f (4::[]) evalto 4 by E-App {
        f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- f evalto ()[fun x -> match x with [] -> 0 | a :: b -> a] by E-Var {};
        f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- 4::[] evalto 4::[] by E-Cons {
          f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- 4 evalto 4 by E-Int {};
          f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- [] evalto [] by E-Nil {};
        };
        x = 4::[] |- match x with [] -> 0 | a :: b -> a evalto 4 by E-MatchCons {
          x = 4::[] |- x evalto 4::[] by E-Var {};
          x = 4::[], a = 4, b = [] |- a evalto 4 by E-Var {}
        }
      };
      f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- f [] evalto 0 by E-App {
        f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- f evalto ()[fun x -> match x with [] -> 0 | a :: b -> a] by E-Var {};
        f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- [] evalto [] by E-Nil {};
        x = [] |- match x with [] -> 0 | a :: b -> a evalto 0 by E-MatchNil {
          x = [] |- x evalto [] by E-Var {};
          x = [] |- 0 evalto 0 by E-Int {}
        }
      };
      4 plus 0 is 4 by B-Plus {}
    };
    f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- f (1 :: 2 :: 3 :: []) evalto 1 by E-App {
      f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- f evalto ()[fun x -> match x with [] -> 0 | a :: b -> a] by E-Var {};
      f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- 1 :: 2 :: 3 :: [] evalto 1 :: 2 :: 3 :: [] by E-Cons {
        f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- 1 evalto 1 by E-Int {};
        f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- 2 :: 3 :: [] evalto 2 :: 3 :: [] by E-Cons {
          f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- 2 evalto 2 by E-Int {};
          f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- 3 :: [] evalto 3 :: [] by E-Cons {
            f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- 3 evalto 3 by E-Int {};
            f = ()[fun x -> match x with [] -> 0 | a :: b -> a] |- [] evalto [] by E-Nil {}
          }
        }
      };
      x = 1 :: 2 :: 3 :: [] |- match x with [] -> 0 | a :: b -> a evalto 1 by E-MatchCons {
        x = 1 :: 2 :: 3 :: [] |- x evalto 1 :: 2 :: 3 :: [] by E-Var {};
        x = 1 :: 2 :: 3 :: [], a = 1, b = 2 :: 3 :: [] |- a evalto 1 by E-Var {}
      }
    };
    4 plus 1 is 5 by B-Plus {}
  }
}
```

### 第 72 問

```ocaml
|- let rec f = fun x -> if x < 1 then [] else x :: f (x - 1) in f 3 evalto 3 :: 2 :: 1 :: [] by E-LetRec {
  f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)] |- f 3 evalto 3 :: 2 :: 1 :: [] by E-AppRec {
    f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)] |- f evalto ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)] by E-Var {};
    f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)] |- 3 evalto 3 by E-Int {};
    f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 3 |- if x < 1 then [] else x :: f (x - 1) evalto 3 :: 2 :: 1 :: [] by E-IfF {
      f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 3 |- x < 1 evalto false by E-Lt {
        f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 3 |- x evalto 3 by E-Var {};
        f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 3 |- 1 evalto 1 by E-Int {};
        3 less than 1 is false by B-Lt {}
      };
      f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 3 |- x :: f (x - 1) evalto 3 :: 2 :: 1 :: [] by E-Cons {
        f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 3 |- x evalto 3 by E-Var {};
        f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 3 |- f (x - 1) evalto 2 :: 1 :: [] by E-AppRec {
          f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 3 |- f evalto ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)] by E-Var {};
          f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 3 |- x - 1 evalto 2 by E-Minus {
            f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 3 |- x evalto 3 by E-Var {};
            f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 3 |- 1 evalto 1 by E-Int {};
            3 minus 1 is 2 by B-Minus {}
          };
          f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 2 |- if x < 1 then [] else x :: f (x - 1) evalto 2 :: 1 :: [] by E-IfF {
            f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 2 |- x < 1 evalto false by E-Lt {
              f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 2 |- x evalto 2 by E-Var {};
              f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 2 |- 1 evalto 1 by E-Int {};
              2 less than 1 is false by B-Lt {}
            };
            f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 2 |- x :: f (x - 1) evalto 2 :: 1 :: [] by E-Cons {
              f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 2 |- x evalto 2 by E-Var {};
              f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 2 |- f (x - 1) evalto 1 :: [] by E-AppRec {
                f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 2 |- f evalto ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)] by E-Var {};
                f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 2 |- x - 1 evalto 1 by E-Minus {
                  f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 2 |- x evalto 2 by E-Var {};
                  f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 2 |- 1 evalto 1 by E-Int {};
                  2 minus 1 is 1 by B-Minus {}
                };
                f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 1 |- if x < 1 then [] else x :: f (x - 1) evalto 1 :: [] by E-IfF {
                  f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 1 |- x < 1 evalto false by E-Lt {
                    f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 1 |- x evalto 1 by E-Var {};
                    f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 1 |- 1 evalto 1 by E-Int {};
                    1 less than 1 is false by B-Lt {}
                  };
                  f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 1 |- x :: f (x - 1) evalto 1 :: [] by E-Cons {
                    f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 1 |- x evalto 1 by E-Var {};
                    f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 1 |- f (x - 1) evalto [] by E-AppRec {
                      f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 1 |- f evalto ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)] by E-Var {};
                      f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 1 |- x - 1 evalto 0 by E-Minus {
                        f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 1 |- x evalto 1 by E-Var {};
                        f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 1 |- 1 evalto 1 by E-Int {};
                        1 minus 1 is 0 by B-Minus {}
                      };
                      f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 0 |- if x < 1 then [] else x :: f (x - 1) evalto [] by E-IfT {
                        f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 0 |- x < 1 evalto true by E-Lt {
                          f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 0 |- x evalto 0 by E-Var {};
                          f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 0 |- 1 evalto 1 by E-Int {};
                          0 less than 1 is true by B-Lt {}
                        };
                        f = ()[rec f = fun x -> if x < 1 then [] else x :: f (x - 1)], x = 0 |- [] evalto [] by E-Nil {}
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
```

### 第 73 問

```ocaml
|- let rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y in length (1 :: 2 :: 3 :: []) evalto 3 by E-LetRec {
  length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- length (1 :: 2:: 3 :: []) evalto 3 by E-AppRec {
    length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- length evalto ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] by E-Var {};
    length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 1 :: 2 :: 3 :: [] evalto 1 :: 2 :: 3 :: [] by E-Cons {
      length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 1 evalto 1 by E-Int {};
      length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 2 :: 3 :: [] evalto 2 :: 3 :: [] by E-Cons {
        length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 2 evalto 2 by E-Int {};
        length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 3 :: [] evalto 3 :: [] by E-Cons {
          length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 3 evalto 3 by E-Int {};
          length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- [] evalto [] by E-Nil {}
        }
      }
    };
    length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 1 :: 2 :: 3 :: [] |- match l with [] -> 0 | x :: y -> 1 + length y evalto 3 by E-MatchCons {
      length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 1 :: 2 :: 3 :: [] |- l evalto 1 :: 2 :: 3 :: [] by E-Var {};
      length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 1 :: 2 :: 3 :: [], x = 1, y = 2 :: 3 :: [] |- 1 + length y evalto 3 by E-Plus {
        length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 1 :: 2 :: 3 :: [], x = 1, y = 2 :: 3 :: [] |- 1 evalto 1 by E-Int {};
        length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 1 :: 2 :: 3 :: [], x = 1, y = 2 :: 3 :: [] |- length y evalto 2 by E-AppRec {
          length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 1 :: 2 :: 3 :: [], x = 1, y = 2 :: 3 :: [] |- length evalto ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] by E-Var {};
          length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 1 :: 2 :: 3 :: [], x = 1, y = 2 :: 3 :: [] |- y evalto 2 :: 3 :: [] by E-Var {};
          length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 2 :: 3 :: [] |- match l with [] -> 0 | x :: y -> 1 + length y evalto 2 by E-MatchCons {
            length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 2 :: 3 :: [] |- l evalto 2 :: 3 :: [] by E-Var {};
            length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 2 :: 3 :: [], x = 2, y = 3 :: [] |- 1 + length y evalto 2 by E-Plus {
              length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 2 :: 3 :: [], x = 2, y = 3 :: [] |- 1 evalto 1 by E-Int {};
              length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 2 :: 3 :: [], x = 2, y = 3 :: [] |- length y evalto 1 by E-AppRec {
                length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 2 :: 3 :: [], x = 2, y = 3 :: [] |- length evalto ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] by E-Var {};
                length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 2 :: 3 :: [], x = 2, y = 3 :: [] |- y evalto 3 :: [] by E-Var {};
                length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 3 :: [] |- match l with [] -> 0 | x :: y -> 1 + length y evalto 1 by E-MatchCons {
                  length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 3 :: [] |- l evalto 3 :: [] by E-Var {};
                  length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 3 :: [], x = 3, y = [] |- 1 + length y evalto 1 by E-Plus {
                    length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 3 :: [], x = 3, y = [] |- 1 evalto 1 by E-Int {};
                    length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 3 :: [], x = 3, y = [] |- length y evalto 0 by E-AppRec {
                      length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 3 :: [], x = 3, y = [] |- length evalto ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] by E-Var {};
                      length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = 3 :: [], x = 3, y = [] |- y evalto [] by E-Var {};
                      length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = [] |- match l with [] -> 0 | x :: y -> 1 + length y evalto 0 by E-MatchNil {
                        length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = [] |- l evalto [] by E-Var {};
                        length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = [] |- 0 evalto 0 by E-Int {}
                      }
                    };
                    1 plus 0 is 1 by B-Plus {}
                  }
                }
              };
              1 plus 1 is 2 by B-Plus {}
            }
          }
        };
        1 plus 2 is 3 by B-Plus {}
      }
    }
  }
}
```

### 第 74 問

```ocaml
|- let rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y in length ((1 :: 2 :: []) :: (3 :: 4 :: 5 :: []) :: []) evalto 2 by E-LetRec {
  length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- length ((1 :: 2 :: []) :: (3 :: 4 :: 5 :: []) :: []) evalto 2 by E-AppRec {
    length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- length evalto ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] by E-Var {};
    length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- (1 :: 2 :: []) :: (3 :: 4 :: 5 :: []) :: [] evalto (1 :: 2 :: []) :: (3 :: 4 :: 5 :: []) :: [] by E-Cons {
      length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 1 :: 2 :: [] evalto 1 :: 2 :: [] by E-Cons {
        length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 1 evalto 1 by E-Int {};
        length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 2 :: [] evalto 2 :: [] by E-Cons {
          length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 2 evalto 2 by E-Int {};
          length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- [] evalto [] by E-Nil {}
        }
      };
      length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- (3 :: 4 :: 5 :: []) :: [] evalto (3 :: 4 :: 5 :: []) :: [] by E-Cons {
        length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 3 :: 4 :: 5 :: [] evalto 3 :: 4 :: 5 :: [] by E-Cons {
          length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 3 evalto 3 by E-Int {};
          length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 4 :: 5 :: [] evalto 4 :: 5 :: [] by E-Cons {
            length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 4 evalto 4 by E-Int {};
            length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 5 :: [] evalto 5 :: [] by E-Cons {
              length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- 5 evalto 5 by E-Int {};
              length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- [] evalto [] by E-Nil {}
            }
          }
        };
        length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] |- [] evalto [] by E-Nil {}
      }
    };
    length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = (1 :: 2 :: []) :: (3 :: 4 :: 5 :: []) :: [] |- match l with [] -> 0 | x :: y -> 1 + length y evalto 2 by E-MatchCons {
      length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = (1 :: 2 :: []) :: (3 :: 4 :: 5 :: []) :: [] |- l evalto (1 :: 2 :: []) :: (3 :: 4 :: 5 :: []) :: [] by E-Var {};
      length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = (1 :: 2 :: []) :: (3 :: 4 :: 5 :: []) :: [], x = 1 :: 2 :: [], y = (3 :: 4 :: 5 :: []) :: [] |- 1 + length y evalto 2 by E-Plus {
        length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = (1 :: 2 :: []) :: (3 :: 4 :: 5 :: []) :: [], x = 1 :: 2 :: [], y = (3 :: 4 :: 5 :: []) :: [] |- 1 evalto 1 by E-Int {};
        length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = (1 :: 2 :: []) :: (3 :: 4 :: 5 :: []) :: [], x = 1 :: 2 :: [], y = (3 :: 4 :: 5 :: []) :: [] |- length y evalto 1 by E-AppRec {
          length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = (1 :: 2 :: []) :: (3 :: 4 :: 5 :: []) :: [], x = 1 :: 2 :: [], y = (3 :: 4 :: 5 :: []) :: [] |- length evalto ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] by E-Var {};
          length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = (1 :: 2 :: []) :: (3 :: 4 :: 5 :: []) :: [], x = 1 :: 2 :: [], y = (3 :: 4 :: 5 :: []) :: [] |- y evalto (3 :: 4 :: 5 :: []) :: [] by E-Var {};
          length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = (3 :: 4 :: 5 :: []) :: [] |- match l with [] -> 0 | x :: y -> 1 + length y evalto 1 by E-MatchCons {
            length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = (3 :: 4 :: 5 :: []) :: [] |- l evalto (3 :: 4 :: 5 :: []) :: [] by E-Var {};
            length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = (3 :: 4 :: 5 :: []) :: [], x = 3 :: 4 :: 5 :: [], y = [] |- 1 + length y evalto 1 by E-Plus {
              length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = (3 :: 4 :: 5 :: []) :: [], x = 3 :: 4 :: 5 :: [], y = [] |- 1 evalto 1 by E-Int {};
              length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = (3 :: 4 :: 5 :: []) :: [], x = 3 :: 4 :: 5 :: [], y = [] |- length y evalto 0 by E-AppRec {
                length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = (3 :: 4 :: 5 :: []) :: [], x = 3 :: 4 :: 5 :: [], y = [] |- length evalto ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y] by E-Var {};
                length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = (3 :: 4 :: 5 :: []) :: [], x = 3 :: 4 :: 5 :: [], y = [] |- y evalto [] by E-Var {};
                length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = [] |- match l with [] -> 0 | x :: y -> 1 + length y evalto 0 by E-MatchNil {
                  length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = [] |- l evalto [] by E-Var {};
                  length = ()[rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y], l = [] |- 0 evalto 0 by E-Int {}
                }
              };
              1 plus 0 is 1 by B-Plus {}
            }
          }
        };
        1 plus 1 is 2 by B-Plus {}
      }
    }
  }
}
```

### 第 75 問

```ocaml
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
```

### 第 76 問

```ocaml
|- let rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x) in
  apply ((fun x -> x * x) :: (fun y -> y + 3) :: []) 4 
evalto 49 by E-LetRec {
  apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)] |- apply ((fun x -> x * x) :: (fun y -> y + 3) :: []) 4 evalto 49 by E-App {
    apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)] |- apply ((fun x -> x * x) :: (fun y -> y + 3) :: []) evalto (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun x -> x * x] :: (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [])[fun x -> match l with [] -> x | f :: l -> f (apply l x)] by E-AppRec {
      apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)] |- apply evalto ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)] by E-Var {};
      apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)] |- (fun x -> x * x) :: (fun y -> y + 3) :: [] evalto (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun x -> x * x] :: (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [] by E-Cons {
        apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)] |- fun x -> x * x evalto (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun x -> x * x] by E-Fun {};
        apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)] |- (fun y -> y + 3) :: [] evalto (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [] by E-Cons {
          apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)] |- fun y -> y + 3 evalto (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] by E-Fun {};
          apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)] |- [] evalto [] by E-Nil {}
        }
      };
      apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun x -> x * x] :: (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [] |- fun x -> match l with [] -> x | f :: l -> f (apply l x) evalto (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun x -> x * x] :: (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [])[fun x -> match l with [] -> x | f :: l -> f (apply l x)] by E-Fun {}
    };
    apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)] |- 4 evalto 4 by E-Int {};
    apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun x -> x * x] :: (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [], x = 4 |- match l with [] -> x | f :: l -> f (apply l x) evalto 49 by E-MatchCons {
      apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun x -> x * x] :: (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [], x = 4 |- l evalto (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun x -> x * x] :: (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [] by E-Var {};
      apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun x -> x * x] :: (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [], x = 4, f = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun x -> x * x], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [] |- f (apply l x) evalto 49 by E-App {
        apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun x -> x * x] :: (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [], x = 4, f = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun x -> x * x], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [] |- f evalto (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun x -> x * x] by E-Var {};
        apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun x -> x * x] :: (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [], x = 4, f = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun x -> x * x], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [] |- apply l x evalto 7 by E-App {
          apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun x -> x * x] :: (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [], x = 4, f = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun x -> x * x], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [] |- apply l evalto (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [])[fun x -> match l with [] -> x | f :: l -> f (apply l x)] by E-AppRec {
            apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun x -> x * x] :: (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [], x = 4, f = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun x -> x * x], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [] |- apply evalto ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)] by E-Var {};
            apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun x -> x * x] :: (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [], x = 4, f = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun x -> x * x], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [] |- l evalto (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [] by E-Var {};
            apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [] |- fun x -> match l with [] -> x | f :: l -> f (apply l x) evalto (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [])[fun x -> match l with [] -> x | f :: l -> f (apply l x)] by E-Fun {}
          };
          apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun x -> x * x] :: (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [], x = 4, f = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun x -> x * x], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [] |- x evalto 4 by E-Var {};
          apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [], x = 4 |- match l with [] -> x | f :: l -> f (apply l x) evalto 7 by E-MatchCons {
            apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [], x = 4 |- l evalto (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [] by E-Var {};
            apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [], x = 4, f = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3], l = [] |- f (apply l x) evalto 7 by E-App {
              apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [], x = 4, f = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3], l = [] |- f evalto (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] by E-Var {};
              apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [], x = 4, f = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3], l = [] |- apply l x evalto 4 by E-App {
                apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [], x = 4, f = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3], l = [] |- apply l evalto (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], l = [])[fun x -> match l with [] -> x | f :: l -> f (apply l x)] by E-AppRec {
                  apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [], x = 4, f = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3], l = [] |- apply evalto ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)] by E-Var {};
                  apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [], x = 4, f = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3], l = [] |- l evalto [] by E-Var {};
                  apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], l = [] |- fun x -> match l with [] -> x | f :: l -> f (apply l x) evalto (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], l = [])[fun x -> match l with [] -> x | f :: l -> f (apply l x)] by E-Fun {}
                };
                apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3] :: [], x = 4, f = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)])[fun y -> y + 3], l = [] |- x evalto 4 by E-Var {};
                apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], l = [], x = 4 |- match l with [] -> x | f :: l -> f (apply l x) evalto 4 by E-MatchNil {
                  apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], l = [], x = 4 |- l evalto [] by E-Var {};
                  apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], l = [], x = 4 |- x evalto 4 by E-Var {}
                }
              };
              apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], y = 4 |- y + 3 evalto 7 by E-Plus {
                apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], y = 4 |- y evalto 4 by E-Var {}; 
                apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], y = 4 |- 3 evalto 3 by E-Int {};
                4 plus 3 is 7 by B-Plus {}
              }
            }
          }
        };
        apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], x = 7 |- x * x evalto 49 by E-Times {
          apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], x = 7 |- x evalto 7 by E-Var {};
          apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> f (apply l x)], x = 7 |- x evalto 7 by E-Var {};
          7 times 7 is 49 by B-Times {}
        }
      }
    }
  }
}
```

### 第 77 問

```ocaml
|- let rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x) in
  apply ((fun x -> x * x) :: (fun y -> y + 3) :: []) 4 
evalto 19 by E-LetRec {
  apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)] |- apply ((fun x -> x * x) :: (fun y -> y + 3):: []) 4 evalto 19 by E-App {
    apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)] |- apply ((fun x -> x * x) :: (fun y -> y + 3) :: []) evalto (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun x -> x * x] :: (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [])[fun x -> match l with [] -> x | f :: l -> apply l (f x)] by E-AppRec {
      apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)] |- apply evalto ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)] by E-Var {};
      apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)] |- (fun x -> x * x) :: (fun y -> y + 3) :: [] evalto (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun x -> x * x] :: (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [] by E-Cons {
        apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)] |- fun x -> x * x evalto (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun x -> x * x] by E-Fun {};
        apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)] |- (fun y -> y + 3) :: [] evalto (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [] by E-Cons {
          apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)] |- fun y -> y + 3 evalto (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] by E-Fun {};
          apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)] |- [] evalto [] by E-Nil {}
        }
      };
      apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun x -> x * x] :: (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [] |- fun x -> match l with [] -> x | f :: l -> apply l (f x) evalto (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun x -> x * x] :: (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [])[fun x -> match l with [] -> x | f :: l -> apply l (f x)] by E-Fun {}
    };
    apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)] |- 4 evalto 4 by E-Int {};
    apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun x -> x * x] :: (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [], x = 4 |- match l with [] -> x | f :: l -> apply l (f x) evalto 19 by E-MatchCons {
      apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun x -> x * x] :: (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [], x = 4 |- l evalto (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun x -> x * x] :: (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [] by E-Var {};
      apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun x -> x * x] :: (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [], x = 4, f = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun x -> x * x], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [] |- apply l (f x) evalto 19 by E-App {
        apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun x -> x * x] :: (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [], x = 4, f = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun x -> x * x], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [] |- apply l evalto (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [])[fun x -> match l with [] -> x | f :: l -> apply l (f x)] by E-AppRec {
          apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun x -> x * x] :: (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [], x = 4, f = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun x -> x * x], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [] |- apply evalto ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)] by E-Var {};
          apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun x -> x * x] :: (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [], x = 4, f = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun x -> x * x], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [] |- l evalto (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [] by E-Var {};
          apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [] |- fun x -> match l with [] -> x | f :: l -> apply l (f x) evalto (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [])[fun x -> match l with [] -> x | f :: l -> apply l (f x)] by E-Fun {}
        };
        apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun x -> x * x] :: (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [], x = 4, f = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun x -> x * x], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [] |- f x evalto 16 by E-App {
          apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun x -> x * x] :: (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [], x = 4, f = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun x -> x * x], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [] |- f evalto (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun x -> x * x] by E-Var {};
          apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun x -> x * x] :: (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [], x = 4, f = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun x -> x * x], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [] |- x evalto 4 by E-Var {};
          apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], x = 4 |- x * x evalto 16 by E-Times {
            apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], x = 4 |- x evalto 4 by E-Var {};
            apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], x = 4 |- x evalto 4 by E-Var {};
            4 times 4 is 16 by B-Times {}
          }
        };
        apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [], x = 16 |- match l with [] -> x | f :: l -> apply l (f x) evalto 19 by E-MatchCons {
          apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [], x = 16 |- l evalto (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [] by E-Var {};
          apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [], x = 16, f = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3], l = [] |- apply l (f x) evalto 19 by E-App {
            apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [], x = 16, f = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3], l = [] |- apply l evalto (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], l = [])[fun x -> match l with [] -> x | f :: l -> apply l (f x)] by E-AppRec {
              apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [], x = 16, f = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3], l = [] |- apply evalto ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)] by E-Var {};
              apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [], x = 16, f = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3], l = [] |- l evalto [] by E-Var {};
              apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], l = [] |- fun x -> match l with [] -> x | f :: l -> apply l (f x) evalto (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], l = [])[fun x -> match l with [] -> x | f :: l -> apply l (f x)] by E-Fun {}
            };
            apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [], x = 16, f = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3], l = [] |- f x evalto 19 by E-App {
              apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [], x = 16, f = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3], l = [] |- f evalto (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] by E-Var {};
              apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], l = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3] :: [], x = 16, f = (apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)])[fun y -> y + 3], l = [] |- x evalto 16 by E-Var {};
              apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], y = 16 |- y + 3 evalto 19 by E-Plus {
                apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], y = 16 |- y evalto 16 by E-Var {};
                apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], y = 16 |- 3 evalto 3 by E-Int {};
                16 plus 3 is 19 by B-Plus {}
              }
            };
            apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], l = [], x = 19 |- match l with [] -> x | f :: l -> apply l (f x) evalto 19 by E-MatchNil {
              apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], l = [], x = 19 |- l evalto [] by E-Var {};
              apply = ()[rec apply = fun l -> fun x -> match l with [] -> x | f :: l -> apply l (f x)], l = [], x = 19 |- x evalto 19 by E-Var {}
            }
          }
        }
      }
    }
  }
}
```

## パターンマッチング

### 第 78 問

```ocaml
|- let rec max = fun l -> match l with 
    x :: [] -> x 
  | x :: y :: z -> if x < y then max (y :: z) else max (x :: z) in
      max (9 :: 2 :: 3 :: [])
evalto 9 by E-LetRec {
  max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)] |- max (9 :: 2 :: 3 :: []) evalto 9 by E-AppRec {
    max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)] |- max evalto ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)] by E-Var {};
    max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)] |- 9 :: 2 :: 3 :: [] evalto 9 :: 2 :: 3 :: [] by E-Cons {
      max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)] |- 9 evalto 9 by E-Int {};
      max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)] |- 2 :: 3 :: [] evalto 2 :: 3 :: [] by E-Cons {
        max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)] |- 2 evalto 2 by E-Int {};
        max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)] |- 3 :: [] evalto 3 :: [] by E-Cons {
          max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)] |- 3 evalto 3 by E-Int {};
          max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)] |- [] evalto [] by E-Nil {}
        }
      }
    };
    max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)], l = 9 :: 2 :: 3 :: [] |- match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z) evalto 9 by E-MatchN {
      max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)], l = 9 :: 2 :: 3 :: [] |- l evalto 9 :: 2 :: 3 :: [] by E-Var {};
      x :: [] doesn't match 9 :: 2 :: 3 :: [] by NM-ConsConsR {
        [] doesn't match 2 :: 3 :: [] by NM-ConsNil {}
      };
      max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)], l = 9 :: 2 :: 3 :: [] |- match l with x :: y :: z -> if x < y then max (y :: z) else max (x :: z) evalto 9 by E-MatchM1 {
        max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)], l = 9 :: 2 :: 3 :: [] |- l evalto 9 :: 2 :: 3 :: [] by E-Var {};
        x :: y :: z matches 9 :: 2 :: 3 :: [] when (x = 9, y = 2, z = 3 :: []) by M-Cons {
          x matches 9 when (x = 9) by M-Var {};
          y :: z matches 2 :: 3 :: [] when (y = 2, z = 3 :: []) by M-Cons {
            y matches 2 when (y = 2) by M-Var {};
            z matches 3 :: [] when (z = 3 :: []) by M-Var {}
          }
        };
        max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)], l = 9 :: 2 :: 3 :: [], x = 9, y = 2, z = 3 :: [] |- if x < y then max (y :: z) else max (x :: z) evalto 9 by E-IfF {
          max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)], l = 9 :: 2 :: 3 :: [], x = 9, y = 2, z = 3 :: [] |- x < y evalto false by E-Lt {
            max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)], l = 9 :: 2 :: 3 :: [], x = 9, y = 2, z = 3 :: [] |- x evalto 9 by E-Var {};
            max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)], l = 9 :: 2 :: 3 :: [], x = 9, y = 2, z = 3 :: [] |- y evalto 2 by E-Var {};
            9 less than 2 is false by B-Lt {}
          };
          max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)], l = 9 :: 2 :: 3 :: [], x = 9, y = 2, z = 3 :: [] |- max (x :: z) evalto 9 by E-AppRec {
            max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)], l = 9 :: 2 :: 3 :: [], x = 9, y = 2, z = 3 :: [] |- max evalto ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)] by E-Var {};
            max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)], l = 9 :: 2 :: 3 :: [], x = 9, y = 2, z = 3 :: [] |- x :: z evalto 9 :: 3 :: [] by E-Cons {
              max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)], l = 9 :: 2 :: 3 :: [], x = 9, y = 2, z = 3 :: [] |- x evalto 9 by E-Var {};
              max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)], l = 9 :: 2 :: 3 :: [], x = 9, y = 2, z = 3 :: [] |- z evalto 3 :: [] by E-Var {}
            };
            max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)], l = 9 :: 3 :: [] |- match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z) evalto 9 by E-MatchN {
              max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)], l = 9 :: 3 :: [] |- l evalto 9 :: 3 :: [] by E-Var {};
              x :: [] doesn't match 9 :: 3 :: [] by NM-ConsConsR {
                [] doesn't match 3 :: [] by NM-ConsNil {}
              };
              max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)], l = 9 :: 3 :: [] |- match l with x :: y :: z -> if x < y then max (y :: z) else max (x :: z) evalto 9 by E-MatchM1 {
                max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)], l = 9 :: 3 :: [] |- l evalto 9 :: 3 :: [] by E-Var {};
                x :: y :: z matches 9 :: 3 :: [] when (x = 9, y = 3, z = []) by M-Cons {
                  x matches 9 when (x = 9) by M-Var {};
                  y :: z matches 3 :: [] when (y = 3, z = []) by M-Cons {
                    y matches 3 when (y = 3) by M-Var {};
                    z matches [] when (z = []) by M-Var {}
                  }
                };
                max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)], l = 9 :: 3 :: [], x = 9, y = 3, z = [] |- if x < y then max (y :: z) else max (x :: z) evalto 9 by E-IfF {
                  max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)], l = 9 :: 3 :: [], x = 9, y = 3, z = [] |- x < y evalto false by E-Lt {
                    max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)], l = 9 :: 3 :: [], x = 9, y = 3, z = [] |- x evalto 9 by E-Var {};
                    max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)], l = 9 :: 3 :: [], x = 9, y = 3, z = [] |- y evalto 3 by E-Var {};
                    9 less than 3 is false by B-Lt {}
                  };
                  max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)], l = 9 :: 3 :: [], x = 9, y = 3, z = [] |- max (x :: z) evalto 9 by E-AppRec {
                    max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)], l = 9 :: 3 :: [], x = 9, y = 3, z = [] |- max evalto ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)] by E-Var {};
                    max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)], l = 9 :: 3 :: [], x = 9, y = 3, z = [] |- x :: z evalto 9 :: [] by E-Cons {
                      max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)], l = 9 :: 3 :: [], x = 9, y = 3, z = [] |- x evalto 9 by E-Var {};
                      max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)], l = 9 :: 3 :: [], x = 9, y = 3, z = [] |- z evalto [] by E-Var {}
                    };
                    max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)], l = 9 :: [] |- match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z) evalto 9 by E-MatchM2 {
                      max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)], l = 9 :: [] |- l evalto 9 :: [] by E-Var {};
                      x :: [] matches 9 :: [] when (x = 9) by M-Cons {
                        x matches 9 when (x = 9) by M-Var {};
                        [] matches [] when () by M-Nil {}
                      };
                      max = ()[rec max = fun l -> match l with x :: [] -> x | x :: y :: z -> if x < y then max (y :: z) else max (x :: z)], l = 9 :: [], x = 9 |- x evalto 9 by E-Var {}
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
```

### 第 79 問

```ocaml
|- let rec heads = fun l -> match l with
    [] -> []
  | [] :: l' -> heads l'
  | (x :: _) :: l' -> x :: heads l'
in
  heads ((1 :: 2 :: []) :: [] :: (3 :: []) :: [])
evalto 1 :: 3 :: [] by E-LetRec {
  heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'] |- heads ((1 :: 2 :: []) :: [] :: (3 :: []) :: []) evalto 1 :: 3 :: [] by E-AppRec {
    heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'] |- heads evalto ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'] by E-Var {};
    heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'] |- (1 :: 2 :: []) :: [] :: (3 :: []) :: [] evalto (1 :: 2 :: []) :: [] :: (3 :: []) :: [] by E-Cons {
      heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'] |- 1 :: 2 :: [] evalto 1 :: 2 :: [] by E-Cons {
        heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'] |- 1 evalto 1 by E-Int {};
        heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'] |- 2 :: [] evalto 2 :: [] by E-Cons {
          heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'] |- 2 evalto 2 by E-Int {};
          heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'] |- [] evalto [] by E-Nil {}
        }
      };
      heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'] |- [] :: (3 :: []) :: [] evalto [] :: (3 :: []) :: [] by E-Cons {
        heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'] |- [] evalto [] by E-Nil {};
        heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'] |- (3 :: []) :: [] evalto (3 :: []) :: [] by E-Cons {
          heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'] |- 3 :: [] evalto 3 :: [] by E-Cons {
            heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'] |- 3 evalto 3 by E-Int {};
            heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'] |- [] evalto [] by E-Nil {}
          };
          heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'] |- [] evalto [] by E-Nil {}
        }
      }
    };
    heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = (1 :: 2 :: []) :: [] :: (3 :: []) :: [] |- match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l' evalto 1 :: 3 :: [] by E-MatchN {
      heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = (1 :: 2 :: []) :: [] :: (3 :: []) :: [] |- l evalto (1 :: 2 :: []) :: [] :: (3 :: []) :: [] by E-Var {};
      [] doesn't match (1 :: 2 :: []) :: [] :: (3 :: []) :: [] by NM-ConsNil {};
      heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = (1 :: 2 :: []) :: [] :: (3 :: []) :: [] |- match l with [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l' evalto 1 :: 3 :: [] by E-MatchN {
        heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = (1 :: 2 :: []) :: [] :: (3 :: []) :: [] |- l evalto (1 :: 2 :: []) :: [] :: (3 :: []) :: [] by E-Var {};
        [] :: l' doesn't match (1 :: 2 :: []) :: [] :: (3 :: []) :: [] by NM-ConsConsL {
          [] doesn't match  1 :: 2 :: [] by NM-ConsNil {}
        };
        heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = (1 :: 2 :: []) :: [] :: (3 :: []) :: [] |- match l with (x :: _) :: l' -> x :: heads l' evalto 1 :: 3 :: [] by E-MatchM1 {
          heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = (1 :: 2 :: []) :: [] :: (3 :: []) :: [] |- l evalto (1 :: 2 :: []) :: [] :: (3 :: []) :: [] by E-Var {};
          (x :: _) :: l' matches (1 :: 2 :: []) :: [] :: (3 :: []) :: [] when (x = 1, l' = [] :: (3 :: []) :: []) by M-Cons {
            x :: _ matches 1 :: 2 :: [] when (x = 1) by M-Cons {
              x matches 1 when (x = 1) by M-Var {};
              _ matches 2 :: [] when () by M-Wild {}
            };
            l' matches [] :: (3 :: []) :: [] when (l' = [] :: (3 :: []) :: []) by M-Var {}
          };
          heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = (1 :: 2 :: []) :: [] :: (3 :: []) :: [], x = 1, l' = [] :: (3 :: []) :: [] |- x :: heads l' evalto 1 :: 3 :: [] by E-Cons {
            heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = (1 :: 2 :: []) :: [] :: (3 :: []) :: [], x = 1, l' = [] :: (3 :: []) :: [] |- x evalto 1 by E-Var {};
            heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = (1 :: 2 :: []) :: [] :: (3 :: []) :: [], x = 1, l' = [] :: (3 :: []) :: [] |- heads l' evalto 3 :: [] by E-AppRec {
              heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = (1 :: 2 :: []) :: [] :: (3 :: []) :: [], x = 1, l' = [] :: (3 :: []) :: [] |- heads evalto ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'] by E-Var {};
              heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = (1 :: 2 :: []) :: [] :: (3 :: []) :: [], x = 1, l' = [] :: (3 :: []) :: [] |- l' evalto [] :: (3 :: []) :: [] by E-Var {};
              heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = [] :: (3 :: []) :: [] |- match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l' evalto 3 :: [] by E-MatchN {
                heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = [] :: (3 :: []) :: [] |- l evalto [] :: (3 :: []) :: [] by E-Var {};
                [] doesn't match [] :: (3 :: []) :: [] by NM-ConsNil {};
                heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = [] :: (3 :: []) :: [] |- match l with [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l' evalto 3 :: [] by E-MatchM2 {
                  heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = [] :: (3 :: []) :: [] |- l evalto [] :: (3 :: []) :: [] by E-Var {};
                  [] :: l' matches [] :: (3 :: []) :: [] when (l' = (3 :: []) :: []) by M-Cons {
                    [] matches [] when () by M-Nil {};
                    l' matches (3 :: []) :: [] when (l' = (3 :: []) :: []) by M-Var {}
                  };
                  heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = [] :: (3 :: []) :: [], l' = (3 :: []) :: [] |- heads l' evalto 3 :: [] by E-AppRec {
                    heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = [] :: (3 :: []) :: [], l' = (3 :: []) :: [] |- heads evalto ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'] by E-Var {};
                    heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = [] :: (3 :: []) :: [], l' = (3 :: []) :: [] |- l' evalto (3 :: []) :: [] by E-Var {};
                    heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = (3 :: []) :: [] |- match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l' evalto 3 :: [] by E-MatchN {
                      heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = (3 :: []) :: [] |- l evalto (3 :: []) :: [] by E-Var {};
                      [] doesn't match (3 :: []) :: [] by NM-ConsNil {};
                      heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = (3 :: []) :: [] |- match l with [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l' evalto 3 :: [] by E-MatchN {
                        heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = (3 :: []) :: [] |- l evalto (3 :: []) :: [] by E-Var {};
                        [] :: l' doesn't match (3 :: []) :: [] by NM-ConsConsL {
                          [] doesn't match 3 :: [] by NM-ConsNil {}
                        };
                        heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = (3 :: []) :: [] |- match l with (x :: _) :: l' -> x :: heads l' evalto 3 :: [] by E-MatchM1 {
                          heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = (3 :: []) :: [] |- l evalto (3 :: []) :: [] by E-Var {};
                          (x :: _) :: l' matches (3 :: []) :: [] when (x = 3, l' = []) by M-Cons {
                            x :: _ matches 3 :: [] when (x = 3) by M-Cons {
                              x matches 3 when (x = 3) by M-Var {};
                              _ matches [] when () by M-Wild {}
                            };
                            l' matches [] when (l' = []) by M-Var {};
                          };
                          heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = (3 :: []) :: [], x = 3, l' = [] |- x :: heads l' evalto 3 :: [] by E-Cons {
                            heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = (3 :: []) :: [], x = 3, l' = [] |- x evalto 3 by E-Var {};
                            heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = (3 :: []) :: [], x = 3, l' = [] |- heads l' evalto [] by E-AppRec {
                              heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = (3 :: []) :: [], x = 3, l' = [] |- heads evalto ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'] by E-Var {};
                              heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = (3 :: []) :: [], x = 3, l' = [] |- l' evalto [] by E-Var {};
                              heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = [] |- match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l' evalto [] by E-MatchM2 {
                                heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = [] |- l evalto [] by E-Var {};
                                [] matches [] when () by M-Nil {};
                                heads = ()[rec heads = fun l -> match l with [] -> [] | [] :: l' -> heads l' | (x :: _) :: l' -> x :: heads l'], l = [] |- [] evalto [] by E-Nil {}
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
```

## 単純型システム

### 第 80 問

```ocaml
|- 3 + 5 : int by T-Plus {
  |- 3 : int by T-Int {};
  |- 5 : int by T-Int {}
}
```

### 第 81 問

```ocaml
|- if 4 < 5 then 2 + 3 else 8 * 8 : int by T-If {
  |- 4 < 5 : bool by T-Lt {
    |- 4 : int by T-Int {};
    |- 5 : int by T-Int {}
  };
  |- 2 + 3 : int by T-Plus {
    |- 2 : int by T-Int {};
    |- 3 : int by T-Int {}
  };
  |- 8 * 8 : int by T-Times {
    |- 8 : int by T-Int {};
    |- 8 : int by T-Int {}
  }
}
```

### 第 82 問

```ocaml
x : bool, y : int |- if x then y + 1 else y - 1 : int by T-If {
  x : bool, y : int |- x : bool by T-Var {};
  x : bool, y : int |- y + 1 : int by T-Plus {
    x : bool, y : int |- y : int by T-Var {};
    x : bool, y : int |- 1 : int by T-Int {}
  };
  x : bool, y : int |- y - 1 : int by T-Minus {
    x : bool, y : int |- y : int by T-Var {};
    x : bool, y : int |- 1 : int by T-Int {}
  }
}
```

### 第 83 問

```ocaml
|- let x = 3 < 2 in let y = 5 in if x then y else 2 : int by T-Let {
  |- 3 < 2 : bool by T-Lt {
    |- 3 : int by T-Int {};
    |- 2 : int by T-Int {};
  };
  x : bool |- let y = 5 in if x then y else 2 : int by T-Let {
    x : bool |- 5 : int by T-Int {};
    x : bool, y : int |- if x then y else 2 : int by T-If {
      x : bool, y : int |- x : bool by T-Var {};
      x : bool, y : int |- y : int by T-Var {};
      x : bool, y : int |- 2 : int by T-Int {}
    }
  }
}
```

### 第 84 問

```ocaml
|- fun x -> x + 1 : int -> int by T-Fun {
  x : int |- x + 1 : int by T-Plus {
    x : int |- x : int by T-Var {};
    x : int |- 1 : int by T-Int {};
  }
}
```

### 第 85 問

```ocaml
|- let f = fun x -> x + 1 in f 4 : int by T-Let {
  |- fun x -> x + 1 : int -> int by T-Fun {
    x : int |- x + 1 : int by T-Plus {
      x : int |- x : int by T-Var {};
      x : int |- 1 : int by T-Int {}
    }
  };
  f : int -> int |- f 4 : int by T-App {
    f : int -> int |- f : int -> int by T-Var {};
    f : int -> int |- 4 : int by T-Int {}
  }
}
```

### 第 86 問

```ocaml
|- fun f -> f 0 + f 1 : (int -> int) -> int by T-Fun {
  f : int -> int |- f 0 + f 1 : int by T-Plus {
    f : int -> int |- f 0 : int by T-App {
      f : int -> int |- f : int -> int by T-Var {};
      f : int -> int |- 0 : int by T-Int {}
    };
    f : int -> int |- f 1 : int by T-App {
      f : int -> int |- f : int -> int by T-Var {};
      f : int -> int |- 1 : int by T-Int {}
    }
  }
}
```

### 第 87 問

```ocaml
|- let max = fun x -> fun y -> if x < y then y else x in max 3 5 : int by T-Let {
  |- fun x -> fun y -> if x < y then y else x : int -> int -> int by T-Fun {
    x : int |- fun y -> if x < y then y else x : int -> int by T-Fun {
      x : int, y : int |- if x < y then y else x : int by T-If {
        x : int, y : int |- x < y : bool by T-Lt {
          x : int, y : int |- x : int by T-Var {};
          x : int, y : int |- y : int by T-Var {}
        };
        x : int, y : int |- y : int by T-Var {};
        x : int, y : int |- x : int by T-Var {}
      }
    }
  };
  max : int -> int -> int |- max 3 5 : int by T-App {
    max : int -> int -> int |- max 3 : int -> int by T-App {
      max : int -> int -> int |- max : int -> int -> int by T-Var {};
      max : int -> int -> int |- 3 : int by T-Int {}
    };
    max : int -> int -> int |- 5 : int by T-Int {}
  }
}
```

### 第 88 問

```ocaml
|- 4 :: [] : int list by T-Cons {
  |- 4 : int by T-Int {};
  |- [] : int list by T-Nil {}
}
```

### 第 89 問

```ocaml
|- true :: false :: [] : bool list by T-Cons {
  |- true : bool by T-Bool {};
  |- false :: [] : bool list by T-Cons {
    |- false : bool by T-Bool {};
    |- [] : bool list by T-Nil {}
  }
}
```

### 第 90 問

```ocaml
|- fun x -> fun y -> x : int -> int -> int by T-Fun {
  x : int |- fun y -> x : int -> int by T-Fun {
    x : int, y : int |- x : int by T-Var {}
  }
}
```

### 第 91 問

```ocaml
|- fun x -> fun y -> x : bool -> int -> bool by T-Fun {
  x : bool |- fun y -> x : int -> bool by T-Fun {
    x : bool, y : int |- x : bool by T-Var {}
  }
}
```

### 第 92 問

```ocaml
|- let k = fun x -> fun y -> x in k 3 true : int by T-Let {
  |- fun x -> fun y -> x : int -> bool -> int by T-Fun {
    x : int |- fun y -> x : bool -> int by T-Fun {
      x : int, y : bool |- x : int by T-Var {}
    }
  };
  k : int -> bool -> int |- k 3 true : int by T-App {
    k : int -> bool -> int |- k 3 : bool -> int by T-App {
      k : int -> bool -> int |- k : int -> bool -> int by T-Var {};
      k : int -> bool -> int |- 3 : int by T-Int {}
    };
    k : int -> bool -> int |- true : bool by T-Bool {}
  }
}
```

### 第 93 問

```ocaml
|- let k = fun x -> fun y -> x in k (1::[]) 3 : int list by T-Let {
  |- fun x -> fun y -> x : int list -> int -> int list by T-Fun {
    x : int list |- fun y -> x : int -> int list by T-Fun {
      x : int list, y : int |- x : int list by T-Var {}
    }
  };
  k : int list -> int -> int list |- k (1::[]) 3 : int list by T-App {
    k : int list -> int -> int list |- k (1::[]) : int -> int list by T-App {
      k : int list -> int -> int list |- k : int list -> int -> int list by T-Var {};
      k : int list -> int -> int list |- 1::[] : int list by T-Cons {
        k : int list -> int -> int list |- 1 : int by T-Int {};
        k : int list -> int -> int list |- [] : int list by T-Nil {}
      }
    };
    k : int list -> int -> int list |- 3 : int by T-Int {}
  }
}
```

### 第 94 問

```ocaml
|- let k = fun x -> fun y -> x in k true (fun x -> x + 1) : bool by T-Let {
  |- fun x -> fun y -> x : bool -> (int -> int) -> bool by T-Fun {
    x : bool |- fun y -> x : (int -> int) -> bool by T-Fun {
      x : bool, y : int -> int |- x : bool by T-Var {}
    }
  };
  k : bool -> (int -> int) -> bool |- k true (fun x -> x + 1) : bool by T-App {
    k : bool -> (int -> int) -> bool |- k true : (int -> int) -> bool by T-App {
      k : bool -> (int -> int) -> bool |- k : bool -> (int -> int) -> bool by T-Var {};
      k : bool -> (int -> int) -> bool |- true : bool by T-Bool {}
    };
    k : bool -> (int -> int) -> bool |- fun x -> x + 1 : int -> int by T-Fun {
      k : bool -> (int -> int) -> bool, x : int |- x + 1 : int by T-Plus {
        k : bool -> (int -> int) -> bool, x : int |- x : int by T-Var {};
        k : bool -> (int -> int) -> bool, x : int |- 1 : int by T-Int {}
      }
    }
  }
}
```

### 第 95 問

```ocaml
|- let compose = fun f -> fun g -> fun x -> f (g x) in
  let p = fun x -> x * x in
    let q = fun x -> x + 4 in
      compose p q
: int -> int by T-Let {
  |- fun f -> fun g -> fun x -> f (g x) : (int -> int) -> (int -> int) -> int -> int by T-Fun {
    f : int -> int |- fun g -> fun x -> f (g x) : (int -> int) -> int -> int by T-Fun {
      f : int -> int, g : int -> int |- fun x -> f (g x) : int -> int by T-Fun {
        f : int -> int, g : int -> int, x : int |- f (g x) : int by T-App {
          f : int -> int, g : int -> int, x : int |- f : int -> int by T-Var {};
          f : int -> int, g : int -> int, x : int |- g x : int by T-App {
            f : int -> int, g : int -> int, x : int |- g : int -> int by T-Var {};
            f : int -> int, g : int -> int, x : int |- x : int by T-Var {}
          }
        }
      }
    }
  };
  compose : (int -> int) -> (int -> int) -> int -> int |- let p = fun x -> x * x in let q = fun x -> x + 4 in compose p q : int -> int by T-Let {
    compose : (int -> int) -> (int -> int) -> int -> int |- fun x -> x * x : int -> int by T-Fun {
      compose : (int -> int) -> (int -> int) -> int -> int, x : int |- x * x : int by T-Times {
        compose : (int -> int) -> (int -> int) -> int -> int, x : int |- x : int by T-Var {};
        compose : (int -> int) -> (int -> int) -> int -> int, x : int |- x : int by T-Var {}
      }
    };
    compose : (int -> int) -> (int -> int) -> int -> int, p : int -> int |- let q = fun x -> x + 4 in compose p q : int -> int by T-Let {
      compose : (int -> int) -> (int -> int) -> int -> int, p : int -> int |- fun x -> x + 4 : int -> int by T-Fun {
        compose : (int -> int) -> (int -> int) -> int -> int, p : int -> int, x : int |- x + 4 : int by T-Plus {
          compose : (int -> int) -> (int -> int) -> int -> int, p : int -> int, x : int |- x : int by T-Var {};
          compose : (int -> int) -> (int -> int) -> int -> int, p : int -> int, x : int |- 4 : int by T-Int {}
        }
      };
      compose : (int -> int) -> (int -> int) -> int -> int, p : int -> int, q : int -> int |- compose p q : int -> int by T-App {
        compose : (int -> int) -> (int -> int) -> int -> int, p : int -> int, q : int -> int |- compose p : (int -> int) -> int -> int by T-App {
          compose : (int -> int) -> (int -> int) -> int -> int, p : int -> int, q : int -> int |- compose : (int -> int) -> (int -> int) -> int -> int by T-Var {};
          compose : (int -> int) -> (int -> int) -> int -> int, p : int -> int, q : int -> int |- p : int -> int by T-Var {}
        };
        compose : (int -> int) -> (int -> int) -> int -> int, p : int -> int, q : int -> int |- q : int -> int by T-Var {}
      }
    }
  }
}
```

### 第 96 問

```ocaml
|- let compose = fun f -> fun g -> fun x -> f (g x) in
  let p = fun x -> if x then 3 else 4 in
    let q = fun x -> x < 4 in
      compose p q
: int -> int by T-Let {
  |- fun f -> fun g -> fun x -> f (g x) : (bool -> int) -> (int -> bool) -> int -> int by T-Fun {
    f : bool -> int |- fun g -> fun x -> f (g x) : (int -> bool) -> int -> int by T-Fun {
      f : bool -> int, g : int -> bool |- fun x -> f (g x) : int -> int by T-Fun {
        f : bool -> int, g : int -> bool, x : int |- f (g x) : int by T-App {
          f : bool -> int, g : int -> bool, x : int |- f : bool -> int by T-Var {};
          f : bool -> int, g : int -> bool, x : int |- g x : bool by T-App {
            f : bool -> int, g : int -> bool, x : int |- g : int -> bool by T-Var {};
            f : bool -> int, g : int -> bool, x : int |- x : int by T-Var {}
          }
        }
      }
    }
  };
  compose : (bool -> int) -> (int -> bool) -> int -> int |- let p = fun x -> if x then 3 else 4 in let q = fun x -> x < 4 in compose p q : int -> int by T-Let {
    compose : (bool -> int) -> (int -> bool) -> int -> int |- fun x -> if x then 3 else 4 : bool -> int by T-Fun {
      compose : (bool -> int) -> (int -> bool) -> int -> int, x : bool |- if x then 3 else 4 : int by T-If {
        compose : (bool -> int) -> (int -> bool) -> int -> int, x : bool |- x : bool by T-Var {};
        compose : (bool -> int) -> (int -> bool) -> int -> int, x : bool |- 3 : int by T-Int {};
        compose : (bool -> int) -> (int -> bool) -> int -> int, x : bool |- 4 : int by T-Int {};
      }
    };
    compose : (bool -> int) -> (int -> bool) -> int -> int, p : bool -> int |- let q = fun x -> x < 4 in compose p q : int -> int by T-Let {
      compose : (bool -> int) -> (int -> bool) -> int -> int, p : bool -> int |- fun x -> x < 4 : int -> bool by T-Fun {
        compose : (bool -> int) -> (int -> bool) -> int -> int, p : bool -> int, x : int |- x < 4 : bool by T-Lt {
          compose : (bool -> int) -> (int -> bool) -> int -> int, p : bool -> int, x : int |- x : int by T-Var {};
          compose : (bool -> int) -> (int -> bool) -> int -> int, p : bool -> int, x : int |- 4 : int by T-Int {}
        }
      };
      compose : (bool -> int) -> (int -> bool) -> int -> int, p : bool -> int, q : int -> bool |- compose p q : int -> int by T-App {
        compose : (bool -> int) -> (int -> bool) -> int -> int, p : bool -> int, q : int -> bool |- compose p : (int -> bool) -> int -> int by T-App {
          compose : (bool -> int) -> (int -> bool) -> int -> int, p : bool -> int, q : int -> bool |- compose : (bool -> int) -> (int -> bool) -> int -> int by T-Var {};
          compose : (bool -> int) -> (int -> bool) -> int -> int, p : bool -> int, q : int -> bool |- p : bool -> int by T-Var {}
        };
        compose : (bool -> int) -> (int -> bool) -> int -> int, p : bool -> int, q : int -> bool |- q : int -> bool by T-Var {}
      }
    }
  }
}
```

### 第 97 問

```ocaml
|- let s = fun f -> fun g -> fun x -> f x (g x) in
  let k1 = fun x -> fun y -> x in
    let k2 = fun x -> fun y -> x in
      s k1 k2
: int -> int by T-Let {
  |- fun f -> fun g -> fun x -> f x (g x) : (int -> (int -> int) -> int) -> (int -> int -> int) -> int -> int by T-Fun {
    f : int -> (int -> int) -> int |- fun g -> fun x -> f x (g x) : (int -> int -> int) -> int -> int by T-Fun {
      f : int -> (int -> int) -> int, g : int -> int -> int |- fun x -> f x (g x) : int -> int by T-Fun {
        f : int -> (int -> int) -> int, g : int -> int -> int, x : int |- f x (g x) : int by T-App {
          f : int -> (int -> int) -> int, g : int -> int -> int, x : int |- f x : (int -> int) -> int by T-App {
            f : int -> (int -> int) -> int, g : int -> int -> int, x : int |- f : int -> (int -> int) -> int by T-Var {};
            f : int -> (int -> int) -> int, g : int -> int -> int, x : int |- x : int by T-Var {}
          };
          f : int -> (int -> int) -> int, g : int -> int -> int, x : int |- g x : int -> int by T-App {
            f : int -> (int -> int) -> int, g : int -> int -> int, x : int |- g : int -> int -> int by T-Var {};
            f : int -> (int -> int) -> int, g : int -> int -> int, x : int |- x : int by T-Var {}
          }
        }
      }
    }
  };
  s : (int -> (int -> int) -> int) -> (int -> int -> int) -> int -> int |- let k1 = fun x -> fun y -> x in let k2 = fun x -> fun y -> x in s k1 k2 : int -> int by T-Let {
    s : (int -> (int -> int) -> int) -> (int -> int -> int) -> int -> int |- fun x -> fun y -> x : int -> (int -> int) -> int by T-Fun {
      s : (int -> (int -> int) -> int) -> (int -> int -> int) -> int -> int, x : int |- fun y -> x : (int -> int) -> int by T-Fun {
        s : (int -> (int -> int) -> int) -> (int -> int -> int) -> int -> int, x : int, y : int -> int |- x : int by T-Var {}
      }
    };
    s : (int -> (int -> int) -> int) -> (int -> int -> int) -> int -> int, k1 : int -> (int -> int) -> int |- let k2 = fun x -> fun y -> x in s k1 k2 : int -> int by T-Let {
      s : (int -> (int -> int) -> int) -> (int -> int -> int) -> int -> int, k1 : int -> (int -> int) -> int |- fun x -> fun y -> x : int -> int -> int by T-Fun {
        s : (int -> (int -> int) -> int) -> (int -> int -> int) -> int -> int, k1 : int -> (int -> int) -> int, x : int |- fun y -> x : int -> int by T-Fun {
          s : (int -> (int -> int) -> int) -> (int -> int -> int) -> int -> int, k1 : int -> (int -> int) -> int, x : int, y : int |- x : int by T-Var {}
        }
      };
      s : (int -> (int -> int) -> int) -> (int -> int -> int) -> int -> int, k1 : int -> (int -> int) -> int, k2 : int -> int -> int |- s k1 k2 : int -> int by T-App {
        s : (int -> (int -> int) -> int) -> (int -> int -> int) -> int -> int, k1 : int -> (int -> int) -> int, k2 : int -> int -> int |- s k1 : (int -> int -> int) -> int -> int by T-App {
          s : (int -> (int -> int) -> int) -> (int -> int -> int) -> int -> int, k1 : int -> (int -> int) -> int, k2 : int -> int -> int |- s : (int -> (int -> int) -> int) -> (int -> int -> int) -> int -> int by T-Var {};
          s : (int -> (int -> int) -> int) -> (int -> int -> int) -> int -> int, k1 : int -> (int -> int) -> int, k2 : int -> int -> int |- k1 : int -> (int -> int) -> int by T-Var {}
        };
        s : (int -> (int -> int) -> int) -> (int -> int -> int) -> int -> int, k1 : int -> (int -> int) -> int, k2 : int -> int -> int |- k2 : int -> int -> int by T-Var {}
      }
    }
  }
}
```

### 第 98 問

```ocaml
|- let s = fun f -> fun g -> fun x -> f x (g x) in
  let k1 = fun x -> fun y -> x in
    let k2 = fun x -> fun y -> x in
      s k1 k2 (fun x -> x + 1)
: int -> int by T-Let {
  |- fun f -> fun g -> fun x -> f x (g x) : ((int -> int) -> (int -> int -> int) -> int -> int) -> ((int -> int) -> int -> int -> int) -> (int -> int) -> int -> int by T-Fun {
    f : (int -> int) -> (int -> int -> int) -> int -> int |- fun g -> fun x -> f x (g x) : ((int -> int) -> int -> int -> int) -> (int -> int) -> int -> int by T-Fun {
      f : (int -> int) -> (int -> int -> int) -> int -> int, g : (int -> int) -> int -> int -> int |- fun x -> f x (g x) : (int -> int) -> int -> int by T-Fun {
        f : (int -> int) -> (int -> int -> int) -> int -> int, g : (int -> int) -> int -> int -> int, x : int -> int |- f x (g x) : int -> int by T-App {
          f : (int -> int) -> (int -> int -> int) -> int -> int, g : (int -> int) -> int -> int -> int, x : int -> int |- f x : (int -> int -> int) -> int -> int by T-App {
            f : (int -> int) -> (int -> int -> int) -> int -> int, g : (int -> int) -> int -> int -> int, x : int -> int |- f : (int -> int) -> (int -> int -> int) -> int -> int by T-Var {};
            f : (int -> int) -> (int -> int -> int) -> int -> int, g : (int -> int) -> int -> int -> int, x : int -> int |- x : int -> int by T-Var {}
          };
          f : (int -> int) -> (int -> int -> int) -> int -> int, g : (int -> int) -> int -> int -> int, x : int -> int |- g x : int -> int -> int by T-App {
            f : (int -> int) -> (int -> int -> int) -> int -> int, g : (int -> int) -> int -> int -> int, x : int -> int |- g : (int -> int) -> int -> int -> int by T-Var {};
            f : (int -> int) -> (int -> int -> int) -> int -> int, g : (int -> int) -> int -> int -> int, x : int -> int |- x : int -> int by T-Var {}
          }
        }
      }
    }
  };
  s : ((int -> int) -> (int -> int -> int) -> int -> int) -> ((int -> int) -> int -> int -> int) -> (int -> int) -> int -> int |- let k1 = fun x -> fun y -> x in let k2 = fun x -> fun y -> x in s k1 k2 (fun x -> x + 1) : int -> int by T-Let {
    s : ((int -> int) -> (int -> int -> int) -> int -> int) -> ((int -> int) -> int -> int -> int) -> (int -> int) -> int -> int |- fun x -> fun y -> x : (int -> int) -> (int -> int -> int) -> int -> int by T-Fun {
      s : ((int -> int) -> (int -> int -> int) -> int -> int) -> ((int -> int) -> int -> int -> int) -> (int -> int) -> int -> int, x : int -> int |- fun y -> x : (int -> int -> int) -> int -> int by T-Fun {
        s : ((int -> int) -> (int -> int -> int) -> int -> int) -> ((int -> int) -> int -> int -> int) -> (int -> int) -> int -> int, x : int -> int, y : int -> int -> int |- x : int -> int by T-Var {}
      }
    };
    s : ((int -> int) -> (int -> int -> int) -> int -> int) -> ((int -> int) -> int -> int -> int) -> (int -> int) -> int -> int, k1 : (int -> int) -> (int -> int -> int) -> int -> int |- let k2 = fun x -> fun y -> x in s k1 k2 (fun x -> x + 1) : int -> int by T-Let {
      s : ((int -> int) -> (int -> int -> int) -> int -> int) -> ((int -> int) -> int -> int -> int) -> (int -> int) -> int -> int, k1 : (int -> int) -> (int -> int -> int) -> int -> int |- fun x -> fun y -> x : (int -> int) -> int -> int -> int by T-Fun {
        s : ((int -> int) -> (int -> int -> int) -> int -> int) -> ((int -> int) -> int -> int -> int) -> (int -> int) -> int -> int, k1 : (int -> int) -> (int -> int -> int) -> int -> int, x : int -> int |- fun y -> x : int -> int -> int by T-Fun {
          s : ((int -> int) -> (int -> int -> int) -> int -> int) -> ((int -> int) -> int -> int -> int) -> (int -> int) -> int -> int, k1 : (int -> int) -> (int -> int -> int) -> int -> int, x : int -> int, y : int |- x : int -> int by T-Var {}
        }
      };
      s : ((int -> int) -> (int -> int -> int) -> int -> int) -> ((int -> int) -> int -> int -> int) -> (int -> int) -> int -> int, k1 : (int -> int) -> (int -> int -> int) -> int -> int, k2 : (int -> int) -> int -> int -> int |- s k1 k2 (fun x -> x + 1) : int -> int by T-App {
        s : ((int -> int) -> (int -> int -> int) -> int -> int) -> ((int -> int) -> int -> int -> int) -> (int -> int) -> int -> int, k1 : (int -> int) -> (int -> int -> int) -> int -> int, k2 : (int -> int) -> int -> int -> int |- s k1 k2 : (int -> int) -> int -> int by T-App {
          s : ((int -> int) -> (int -> int -> int) -> int -> int) -> ((int -> int) -> int -> int -> int) -> (int -> int) -> int -> int, k1 : (int -> int) -> (int -> int -> int) -> int -> int, k2 : (int -> int) -> int -> int -> int |- s k1 : ((int -> int) -> int -> int -> int) -> (int -> int) -> int -> int by T-App {
            s : ((int -> int) -> (int -> int -> int) -> int -> int) -> ((int -> int) -> int -> int -> int) -> (int -> int) -> int -> int, k1 : (int -> int) -> (int -> int -> int) -> int -> int, k2 : (int -> int) -> int -> int -> int |- s : ((int -> int) -> (int -> int -> int) -> int -> int) -> ((int -> int) -> int -> int -> int) -> (int -> int) -> int -> int by T-Var {};
            s : ((int -> int) -> (int -> int -> int) -> int -> int) -> ((int -> int) -> int -> int -> int) -> (int -> int) -> int -> int, k1 : (int -> int) -> (int -> int -> int) -> int -> int, k2 : (int -> int) -> int -> int -> int |- k1 : (int -> int) -> (int -> int -> int) -> int -> int by T-Var {}
          };
          s : ((int -> int) -> (int -> int -> int) -> int -> int) -> ((int -> int) -> int -> int -> int) -> (int -> int) -> int -> int, k1 : (int -> int) -> (int -> int -> int) -> int -> int, k2 : (int -> int) -> int -> int -> int |- k2 : (int -> int) -> int -> int -> int by T-Var {}
        };
        s : ((int -> int) -> (int -> int -> int) -> int -> int) -> ((int -> int) -> int -> int -> int) -> (int -> int) -> int -> int, k1 : (int -> int) -> (int -> int -> int) -> int -> int, k2 : (int -> int) -> int -> int -> int |- fun x -> x + 1 : int -> int by T-Fun {
          s : ((int -> int) -> (int -> int -> int) -> int -> int) -> ((int -> int) -> int -> int -> int) -> (int -> int) -> int -> int, k1 : (int -> int) -> (int -> int -> int) -> int -> int, k2 : (int -> int) -> int -> int -> int, x : int |- x + 1 : int by T-Plus {
            s : ((int -> int) -> (int -> int -> int) -> int -> int) -> ((int -> int) -> int -> int -> int) -> (int -> int) -> int -> int, k1 : (int -> int) -> (int -> int -> int) -> int -> int, k2 : (int -> int) -> int -> int -> int, x : int |- x : int by T-Var {};
            s : ((int -> int) -> (int -> int -> int) -> int -> int) -> ((int -> int) -> int -> int -> int) -> (int -> int) -> int -> int, k1 : (int -> int) -> (int -> int -> int) -> int -> int, k2 : (int -> int) -> int -> int -> int, x : int |- 1 : int by T-Int {}
          }
        }
      }
    };
  }
}
```

### 第 99 問

```ocaml
|- let rec fact = fun n -> if n < 2 then 1 else n * fact (n - 1) in fact 3 : int by T-LetRec {
  fact : int -> int, n : int |- if n < 2 then 1 else n * fact (n - 1) : int by T-If {
    fact : int -> int, n : int |- n < 2 : bool by T-Lt {
      fact : int -> int, n : int |- n : int by T-Var {};
      fact : int -> int, n : int |- 2 : int by T-Int {}
    };
    fact : int -> int, n : int |- 1 : int by T-Int {};
    fact : int -> int, n : int |- n * fact (n - 1) : int by T-Times {
      fact : int -> int, n : int |- n : int by T-Var {};
      fact : int -> int, n : int |- fact (n - 1) : int by T-App {
        fact : int -> int, n : int |- fact : int -> int by T-Var {};
        fact : int -> int, n : int |- n - 1 : int by T-Minus {
          fact : int -> int, n : int |- n : int by T-Var {};
          fact : int -> int, n : int |- 1 : int by T-Int {}
        }
      }
    }
  };
  fact : int -> int |- fact 3 : int by T-App {
    fact : int -> int |- fact : int -> int by T-Var {};
    fact : int -> int |- 3 : int by T-Int {}
  }
}
```

### 第 100 問

```ocaml
|- let rec sum = fun f -> fun n -> if n < 1 then 0 else f n + sum f (n - 1) in sum (fun x -> x * x) 2 : int by T-LetRec {
  sum : (int -> int) -> int -> int, f : int -> int |- fun n -> if n < 1 then 0 else f n + sum f (n - 1) : int -> int by T-Fun {
    sum : (int -> int) -> int -> int, f : int -> int, n : int |- if n < 1 then 0 else f n + sum f (n - 1) : int by T-If {
      sum : (int -> int) -> int -> int, f : int -> int, n : int |- n < 1 : bool by T-Lt {
        sum : (int -> int) -> int -> int, f : int -> int, n : int |- n : int by T-Var {};
        sum : (int -> int) -> int -> int, f : int -> int, n : int |- 1 : int by T-Int {}
      };
      sum : (int -> int) -> int -> int, f : int -> int, n : int |- 0 : int by T-Int {};
      sum : (int -> int) -> int -> int, f : int -> int, n : int |- f n + sum f (n - 1) : int by T-Plus {
        sum : (int -> int) -> int -> int, f : int -> int, n : int |- f n : int by T-App {
          sum : (int -> int) -> int -> int, f : int -> int, n : int |- f : int -> int by T-Var {};
          sum : (int -> int) -> int -> int, f : int -> int, n : int |- n : int by T-Var {}
        };
        sum : (int -> int) -> int -> int, f : int -> int, n : int |- sum f (n - 1) : int by T-App {
          sum : (int -> int) -> int -> int, f : int -> int, n : int |- sum f : int -> int by T-App {
            sum : (int -> int) -> int -> int, f : int -> int, n : int |- sum : (int -> int) -> int -> int by T-Var {};
            sum : (int -> int) -> int -> int, f : int -> int, n : int |- f : int -> int by T-Var {}
          };
          sum : (int -> int) -> int -> int, f : int -> int, n : int |- n - 1 : int by T-Minus {
            sum : (int -> int) -> int -> int, f : int -> int, n : int |- n : int by T-Var {};
            sum : (int -> int) -> int -> int, f : int -> int, n : int |- 1 : int by T-Int {}
          }
        }
      }
    }
  };
  sum : (int -> int) -> int -> int |- sum (fun x -> x * x) 2 : int by T-App {
    sum : (int -> int) -> int -> int |- sum (fun x -> x * x) : int -> int by T-App {
      sum : (int -> int) -> int -> int |- sum : (int -> int) -> int -> int by T-Var {};
      sum : (int -> int) -> int -> int |- fun x -> x * x : int -> int by T-Fun {
        sum : (int -> int) -> int -> int, x : int |- x * x : int by T-Times {
          sum : (int -> int) -> int -> int, x : int |- x : int by T-Var {};
          sum : (int -> int) -> int -> int, x : int |- x : int by T-Var {}
        }
      }
    };
    sum : (int -> int) -> int -> int |- 2 : int by T-Int {}
  }
}
```

### 第 101 問

```ocaml
|- let l = (fun x -> x) :: (fun y -> 2) :: (fun z -> z + 3) :: [] in 2 : int by T-Let {
  |- (fun x -> x) :: (fun y -> 2) :: (fun z -> z + 3) :: [] : (int -> int) list by T-Cons {
    |- fun x -> x : int -> int by T-Fun {
      x : int |- x : int by T-Var {}
    };
    |- (fun y -> 2) :: (fun z -> z + 3) :: [] : (int -> int) list by T-Cons {
      |- fun y -> 2 : int -> int by T-Fun {
        y : int |- 2 : int by T-Int {}
      };
      |- (fun z -> z + 3) :: [] : (int -> int) list by T-Cons {
        |- fun z -> z + 3 : int -> int by T-Fun {
          z : int |- z + 3 : int by T-Plus {
            z : int |- z : int by T-Var {};
            z : int |- 3 : int by T-Int {}
          }
        };
        |- [] : (int -> int) list by T-Nil {}
      }
    }
  };
  l : (int -> int) list |- 2 : int by T-Int {}
}
```

### 第 102 問

```ocaml
|- let rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y in length : int list -> int by T-LetRec {
  length : int list -> int, l : int list |- match l with [] -> 0 | x :: y -> 1 + length y : int by T-Match {
    length : int list -> int, l : int list |- l : int list by T-Var {};
    length : int list -> int, l : int list |- 0 : int by T-Int {};
    length : int list -> int, l : int list, x : int, y : int list |- 1 + length y : int by T-Plus {
      length : int list -> int, l : int list, x : int, y : int list |- 1 : int by T-Int {};
      length : int list -> int, l : int list, x : int, y : int list |- length y : int by T-App {
        length : int list -> int, l : int list, x : int, y : int list |- length : int list -> int by T-Var {};
        length : int list -> int, l : int list, x : int, y : int list |- y : int list by T-Var {}
      }
    }
  };
  length: int list -> int |- length : int list -> int by T-Var {}
}
```

### 第 103 問

```ocaml
|- let rec length = fun l -> match l with [] -> 0 | x :: y -> 1 + length y in length ((fun x -> x) :: (fun y -> y + 3) :: []) : int by T-LetRec {
  length : (int -> int) list -> int, l : (int -> int) list |- match l with [] -> 0 | x :: y -> 1 + length y : int by T-Match {
    length : (int -> int) list -> int, l : (int -> int) list |- l : (int -> int) list by T-Var {};
    length : (int -> int) list -> int, l : (int -> int) list |- 0 : int by T-Int {};
    length : (int -> int) list -> int, l : (int -> int) list, x : int -> int, y : (int -> int) list |- 1 + length y : int by T-Plus {
      length : (int -> int) list -> int, l : (int -> int) list, x : int -> int, y : (int -> int) list |- 1 : int by T-Int {};
      length : (int -> int) list -> int, l : (int -> int) list, x : int -> int, y : (int -> int) list |- length y : int by T-App {
        length : (int -> int) list -> int, l : (int -> int) list, x : int -> int, y : (int -> int) list |- length : (int -> int) list -> int by T-Var {};
        length : (int -> int) list -> int, l : (int -> int) list, x : int -> int, y : (int -> int) list |- y : (int -> int) list by T-Var {}
      }
    }
  };
  length : (int -> int) list -> int |- length ((fun x -> x) :: (fun y -> y + 3) :: []) : int by T-App {
    length : (int -> int) list -> int |- length : (int -> int) list -> int by T-Var {};
    length : (int -> int) list -> int |- (fun x -> x) :: (fun y -> y + 3) :: [] : (int -> int) list by T-Cons {
      length : (int -> int) list -> int |- fun x -> x : int -> int by T-Fun {
        length : (int -> int) list -> int, x : int |- x : int by T-Var {}
      };
      length : (int -> int) list -> int |- (fun y -> y + 3) :: [] : (int -> int) list by T-Cons {
        length : (int -> int) list -> int |- fun y -> y + 3 : int -> int by T-Fun {
          length : (int -> int) list -> int, y : int |- y + 3 : int by T-Plus {
            length : (int -> int) list -> int, y : int |- y : int by T-Var {};
            length : (int -> int) list -> int, y : int |- 3 : int by T-Int {}
          }
        };
        length : (int -> int) list -> int |- [] : (int -> int) list by T-Nil {}
      }
    }
  }
}
```

### 第 104 問

```ocaml
|- let rec append = fun l1 -> fun l2 ->
  match l1 with [] -> l2 | x :: y -> x :: append y l2 in append
: int list -> int list -> int list by T-LetRec {
  append : int list -> int list -> int list, l1 : int list |- fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2 : int list -> int list by T-Fun {
    append : int list -> int list -> int list, l1 : int list, l2 : int list |- match l1 with [] -> l2 | x :: y -> x :: append y l2 : int list by T-Match {
      append : int list -> int list -> int list, l1 : int list, l2 : int list |- l1 : int list by T-Var {};
      append : int list -> int list -> int list, l1 : int list, l2 : int list |- l2 : int list by T-Var {};
      append : int list -> int list -> int list, l1 : int list, l2 : int list, x : int, y : int list |- x :: append y l2 : int list by T-Cons {
        append : int list -> int list -> int list, l1 : int list, l2 : int list, x : int, y : int list |- x : int by T-Var {};
        append : int list -> int list -> int list, l1 : int list, l2 : int list, x : int, y : int list |- append y l2 : int list by T-App {
          append : int list -> int list -> int list, l1 : int list, l2 : int list, x : int, y : int list |- append y : int list -> int list by T-App {
            append : int list -> int list -> int list, l1 : int list, l2 : int list, x : int, y : int list |- append : int list -> int list -> int list by T-Var {};
            append : int list -> int list -> int list, l1 : int list, l2 : int list, x : int, y : int list |- y : int list by T-Var {}
          };
          append : int list -> int list -> int list, l1 : int list, l2 : int list, x : int, y : int list |- l2 : int list by T-Var {}
        }
      }
    }
  };
  append : int list -> int list -> int list |- append : int list -> int list -> int list by T-Var {}
}
```

### 第 105 問

```ocaml
|- let rec append = fun l1 -> fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2 in append (true :: []) (false :: []) : bool list by T-LetRec {
  append : bool list -> bool list -> bool list, l1 : bool list |- fun l2 -> match l1 with [] -> l2 | x :: y -> x :: append y l2 : bool list -> bool list by T-Fun {
    append : bool list -> bool list -> bool list, l1 : bool list, l2 : bool list |- match l1 with [] -> l2 | x :: y -> x :: append y l2 : bool list by T-Match {
      append : bool list -> bool list -> bool list, l1 : bool list, l2 : bool list |- l1 : bool list by T-Var {};
      append : bool list -> bool list -> bool list, l1 : bool list, l2 : bool list |- l2 : bool list by T-Var {};
      append : bool list -> bool list -> bool list, l1 : bool list, l2 : bool list, x : bool, y : bool list |- x :: append y l2 : bool list by T-Cons {
        append : bool list -> bool list -> bool list, l1 : bool list, l2 : bool list, x : bool, y : bool list |- x : bool by T-Var {};
        append : bool list -> bool list -> bool list, l1 : bool list, l2 : bool list, x : bool, y : bool list |- append y l2 : bool list by T-App {
          append : bool list -> bool list -> bool list, l1 : bool list, l2 : bool list, x : bool, y : bool list |- append y : bool list -> bool list by T-App {
            append : bool list -> bool list -> bool list, l1 : bool list, l2 : bool list, x : bool, y : bool list |- append : bool list -> bool list -> bool list by T-Var {};
            append : bool list -> bool list -> bool list, l1 : bool list, l2 : bool list, x : bool, y : bool list |- y : bool list by T-Var {}
          };
          append : bool list -> bool list -> bool list, l1 : bool list, l2 : bool list, x : bool, y : bool list |- l2 : bool list by T-Var {}
        }
      }
    }
  };
  append : bool list -> bool list -> bool list |- append (true :: []) (false :: []) : bool list by T-App {
    append : bool list -> bool list -> bool list |- append (true :: []) : bool list -> bool list by T-App {
      append : bool list -> bool list -> bool list |- append : bool list -> bool list -> bool list by T-Var {};
      append : bool list -> bool list -> bool list |- true :: [] : bool list by T-Cons {
        append : bool list -> bool list -> bool list |- true : bool by T-Bool {};
        append : bool list -> bool list -> bool list |- [] : bool list by T-Nil {}
      }
    };
    append : bool list -> bool list -> bool list |- false :: [] : bool list by T-Cons {
      append : bool list -> bool list -> bool list |- false : bool by T-Bool {};
      append : bool list -> bool list -> bool list |- [] : bool list by T-Nil {}
    }
  }
}
```

### 第 106 問

```ocaml
|- let rec map = fun f -> fun l -> match l with [] -> [] | x :: y -> f x :: map f y in map (fun x -> x < 3) (4 :: 5 :: 1 :: []) : bool list by T-LetRec {
  map : (int -> bool) -> int list -> bool list, f : int -> bool |- fun l -> match l with [] -> [] | x :: y -> f x :: map f y : int list -> bool list by T-Fun {
    map : (int -> bool) -> int list -> bool list, f : int -> bool, l : int list |- match l with [] -> [] | x :: y -> f x :: map f y : bool list by T-Match {
      map : (int -> bool) -> int list -> bool list, f : int -> bool, l : int list |- l : int list by T-Var {};
      map : (int -> bool) -> int list -> bool list, f : int -> bool, l : int list |- [] : bool list by T-Nil {};
      map : (int -> bool) -> int list -> bool list, f : int -> bool, l : int list, x : int, y : int list |- f x :: map f y : bool list by T-Cons {
        map : (int -> bool) -> int list -> bool list, f : int -> bool, l : int list, x : int, y : int list |- f x : bool by T-App {
          map : (int -> bool) -> int list -> bool list, f : int -> bool, l : int list, x : int, y : int list |- f : int -> bool by T-Var {};
          map : (int -> bool) -> int list -> bool list, f : int -> bool, l : int list, x : int, y : int list |- x : int by T-Var {}
        };
        map : (int -> bool) -> int list -> bool list, f : int -> bool, l : int list, x : int, y : int list |- map f y : bool list by T-App {
          map : (int -> bool) -> int list -> bool list, f : int -> bool, l : int list, x : int, y : int list |- map f : int list -> bool list by T-App {
            map : (int -> bool) -> int list -> bool list, f : int -> bool, l : int list, x : int, y : int list |- map : (int -> bool) -> int list -> bool list by T-Var {};
            map : (int -> bool) -> int list -> bool list, f : int -> bool, l : int list, x : int, y : int list |- f : int -> bool by T-Var {}
          };
          map : (int -> bool) -> int list -> bool list, f : int -> bool, l : int list, x : int, y : int list |- y : int list by T-Var {}
        }
      }
    }
  };
  map : (int -> bool) -> int list -> bool list |- map (fun x -> x < 3) (4 :: 5 :: 1 :: []) : bool list by T-App {
    map : (int -> bool) -> int list -> bool list |- map (fun x -> x < 3) : int list -> bool list by T-App {
      map : (int -> bool) -> int list -> bool list |- map : (int -> bool) -> int list -> bool list by T-Var {};
      map : (int -> bool) -> int list -> bool list |- fun x -> x < 3 : int -> bool by T-Fun {
        map : (int -> bool) -> int list -> bool list, x : int |- x < 3 : bool by T-Lt {
          map : (int -> bool) -> int list -> bool list, x : int |- x : int by T-Var {};
          map : (int -> bool) -> int list -> bool list, x : int |- 3 : int by T-Int {}
        }
      }
    };
    map : (int -> bool) -> int list -> bool list |- 4 :: 5 :: 1 :: [] : int list by T-Cons { 
      map : (int -> bool) -> int list -> bool list |- 4 : int by T-Int {};
      map : (int -> bool) -> int list -> bool list |- 5 :: 1 :: [] : int list by T-Cons {
        map : (int -> bool) -> int list -> bool list |- 5 : int by T-Int {};
        map : (int -> bool) -> int list -> bool list |- 1 :: [] : int list by T-Cons {
          map : (int -> bool) -> int list -> bool list |- 1 : int by T-Int {};
          map : (int -> bool) -> int list -> bool list |- [] : int list by T-Nil {}
        }
      }
    }
  }
}
```
