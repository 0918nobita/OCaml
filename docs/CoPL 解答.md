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
