ghost var x: int;
ghost var y: int;

method Main()
  modifies this`x, this`y;
{
  x, y := y, x;
}
