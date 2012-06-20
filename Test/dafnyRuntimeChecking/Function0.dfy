function Fib(n: int): int
  requires 0 <= n;
  ensures 0 <= Fib(n);
{
  if n < 2 then n else
  Fib(n-2) + Fib(n-1)
}

var f: int;

method Main()
  requires f < Fib(7);
{}
