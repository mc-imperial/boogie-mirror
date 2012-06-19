var f: int;

method Main()
  modifies this`f;
  ensures f == old(f) + 1;
{
  f := f + 1;
}
