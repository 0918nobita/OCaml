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
