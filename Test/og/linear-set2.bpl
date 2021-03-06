// RUN: %boogie -noinfer -typeEncoding:m -useArrayTheory "%s" > "%t"
// RUN: %diff "%s.expect" "%t"
type X;
function {:builtin "MapConst"} MapConstInt(int) : [X]int;
function {:builtin "MapConst"} MapConstBool(bool) : [X]bool;
function {:builtin "MapOr"} MapOr([X]bool, [X]bool) : [X]bool;

function {:inline} None() : [X]bool
{
    MapConstBool(false)
}

function {:inline} All() : [X]bool
{
    MapConstBool(true)
}

function {:inline} {:linear "x"} XCollector(xs: [X]bool) : [X]bool
{
  xs
}

var {:layer 0,1} x: int;
var {:layer 0,1} l: X;
const nil: X;

procedure {:yields} {:layer 1} Split({:linear_in "x"} xls: [X]bool) returns ({:linear "x"} xls1: [X]bool, {:linear "x"} xls2: [X]bool)
ensures {:layer 1} xls == MapOr(xls1, xls2) && xls1 != None() && xls2 != None();
{
  yield;
  call xls1, xls2 := SplitLow(xls);
  yield;
}

procedure {:yields} {:layer 1} Allocate() returns ({:linear "tid"} xls: X)
ensures {:layer 1} xls != nil;
{
  yield;
  call xls := AllocateLow();
  yield;
}

procedure {:yields} {:layer 0,1} Set(v: int);
ensures {:atomic} |{A: x := v; return true; }|;

procedure {:yields} {:layer 0,1} Lock(tidls: X);
ensures {:atomic} |{A: assume l == nil; l := tidls; return true; }|;

procedure {:yields} {:layer 0,1} Unlock();
ensures {:atomic} |{A: l := nil; return true; }|;

procedure {:yields} {:layer 0,1} SplitLow({:linear_in "x"} xls: [X]bool) returns ({:linear "x"} xls1: [X]bool, {:linear "x"} xls2: [X]bool);
ensures {:atomic} |{ A: assume xls == MapOr(xls1, xls2) && xls1 != None() && xls2 != None(); return true; }|;

procedure {:yields} {:layer 0,1} AllocateLow() returns ({:linear "tid"} xls: X);
ensures {:atomic} |{ A: assume xls != nil; return true; }|;

procedure {:yields} {:layer 1} main({:linear_in "tid"} tidls': X, {:linear_in "x"} xls': [X]bool) 
requires {:layer 1} tidls' != nil && xls' == All();
{
    var {:linear "tid"} tidls: X;
    var {:linear "x"} xls: [X]bool;
    var {:linear "tid"} lsChild: X;
    var {:linear "x"} xls1: [X]bool;
    var {:linear "x"} xls2: [X]bool;

    tidls := tidls';
    xls := xls';

    yield;
    call Set(42);
    yield;
    assert {:layer 1} xls == All();
    assert {:layer 1} x == 42;
    call xls1, xls2 := Split(xls);
    call lsChild := Allocate();
    yield;
    async call thread(lsChild, xls1);
    call lsChild := Allocate();
    yield;
    async call thread(lsChild, xls2);
    yield;
}

procedure {:yields} {:layer 1} thread({:linear_in "tid"} tidls': X, {:linear_in "x"} xls': [X]bool)
requires {:layer 1} tidls' != nil && xls' != None();
{
    var {:linear "x"} xls: [X]bool;
    var {:linear "tid"} tidls: X;

    tidls := tidls';
    xls := xls';

    yield;
    call Lock(tidls);
    yield;
    assert {:layer 1} tidls != nil && xls != None();
    call Set(0);
    yield;
    assert {:layer 1} tidls != nil && xls != None();
    assert {:layer 1} x == 0;
    yield;
    assert {:layer 1} tidls != nil && xls != None();
    call Unlock();
    yield;
}
