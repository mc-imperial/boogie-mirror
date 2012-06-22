method foo() returns (x: int)
  ensures old(x) == 42;
{
  x := 42;
}

method Main()
{
  var x := foo();
}
