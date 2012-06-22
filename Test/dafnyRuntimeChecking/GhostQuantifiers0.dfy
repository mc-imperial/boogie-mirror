method Main()
{
  assert (forall i :: 2 <= i && i <= 8 ==> i < i+1);
  assert (exists i :: 2 <= i && i <= 8);

  assert (forall i :: i == true ==> !(!i));
  assert (exists i :: i == true);

  var Set := {2, 3, 5};
  var Seq := [7, 11, 13];

  assert (forall e :: e in Set ==> true);
  assert (exists e :: e in Set && e == 5);

  assert (forall e :: e in Seq ==> true);
  assert (exists e :: e in Seq && e == 13);
}
