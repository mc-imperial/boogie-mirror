method foo()
{
  var n: Node;

  assert allocated(n);
  n := new Node;
  assert allocated(n);
}

method Main()
{
  foo();
}

class Node
{}
