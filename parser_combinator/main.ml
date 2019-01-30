open String

type result = Success of (string * int) | Failure

let parseHoge target position =
  if length target >= 4 && sub target 0 4 = "hoge"
    then Success ("hoge", position + 4)
    else Failure
