method Main()
{
  var x := 0;
  var y := 0;
  while (x < 10)
    free invariant x <= 10;
    free invariant y == 0;
  {
    x := x + 1;
  }
}
