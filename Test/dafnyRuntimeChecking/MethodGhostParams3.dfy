method Set() returns (ghost p: int)
{
  p := 7;
}

method Main()
{
  var x := Set();
  ghost var y := Set();
}
