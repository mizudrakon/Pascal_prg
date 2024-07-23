program numerology;
var     i,p,m,c:integer;
        a:array[1..20]of integer;
begin
  p:=0;
  readln(i);
  while i>0 do
    begin
    p:=p+1;
    m:= i mod 10;
    a[p]:=m;
    i:= (i - m) div 10;
    end;
  c:=p-1;
  m:=0;
  while c > 0 do
    begin
    m:= m + a[c];
    c:= c - 2;
    end;
  writeln(m);
end.
