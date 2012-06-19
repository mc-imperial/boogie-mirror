var f: int;
var g: int;

method Main()
  modifies this`f;
  ensures f == old(f) + old(old(g));
{
  f := f + g;
}
