var x: int;
var y: int;

procedure {:inline 1} bar()
modifies y;
{
  y := y + 1;
}

procedure {:inline 1} foo() 
modifies x, y;
{
  x := x + 1;
  call {:si_unique_call 1} bar();
  call {:si_unique_call 2} bar();
  x := x + 1;
}

procedure main()
requires x == y;
ensures x == y;
modifies x, y;
{
  if(*) {
    call {:si_unique_call 1} foo();
  } else {
    call {:si_unique_call 2} foo();
  }
}

