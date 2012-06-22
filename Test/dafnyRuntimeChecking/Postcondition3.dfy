method foo(n: int) returns (r: int)
  requires 0 < n;
  ensures r == 42;
  ensures 42 < n + r;
{
  r := 42;
}

method Main()
{
  var r := foo(7);
}
