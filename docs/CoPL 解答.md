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
