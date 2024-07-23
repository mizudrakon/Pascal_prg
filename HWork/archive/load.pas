program load;
var     b,i:integer;
        a:array[1..9] of integer;
begin
  i:=1;
  while i<10 do
  begin
     read(b);
     a[i]:=b;
     inc(i);

  end;
  for i:=1 to 9 do
     write(a[i], ', ');
end.