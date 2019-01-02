# CoPL 解答

## 単純な式の評価

### 第 31 問

```
1 + true + 2 evalto error by E-PlusErrorL {
  1 + true evalto error by E-PlusBoolR {
    true evalto true by E-Bool {};
  }
}
```

### 第 32 問

```
if 2 + 3 then 1 else 3 evalto error by E-IfInt {
  2 + 3 evalto 5 by E-Plus {
    2 evalto 2 by E-Int {};
    3 evalto 3 by E-Int {};
    2 plus 3 is 5 by B-Plus {}
  }
}
```

### 第 33 問

```
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

```
x = 3, y = 2 |- x evalto 3 by E-Var2 {
  x = 3 |- x evalto 3 by E-Var1 {}
}
```

### 第 35 問

```
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

```
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

```
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

```
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

```
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

```
|- fun x -> x + 1 evalto ()[fun x -> x + 1] by E-Fun {}
```

### 第 41 問

```
|- let y = 2 in fun x -> x + y evalto (y=2)[fun x -> x + y] by E-Let {
  |- 2 evalto 2 by E-Int {};
  y = 2 |- fun x -> x + y evalto (y=2)[fun x -> x + y] by E-Fun {}
}
```

### 第 42 問

```
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

```
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

```
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
