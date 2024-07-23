program binary;
var     i,m,c,b:integer;
        a:array[1..15]of integer;

begin
readln(i);
c:=0;
if i<0 then write('ERROR');
if i=0 then write(0);
if i>0 then
  begin
     while i>0 do
        begin
            c:=c+1;
            m:= i mod 2;
            a[c]:=m;
            i:=i-m;
            i:=i div 2;
        end;
  for b:=c downto 1 do write(a[b]);
  end;

end.
