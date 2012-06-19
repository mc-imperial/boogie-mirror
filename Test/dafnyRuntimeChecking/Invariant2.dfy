method Main()
{
  var x := 0;
  while (x < 10)
    free invariant x <= 10;
  {
    x := x + 1;
  }
}
