program translate;
var     i,m,t:integer;
        r:string;

begin
readln(t);
if t > 36 then
  begin
  writeln('ERROR');
  exit
  end;
readln(i);
r := '';
while true do
  begin
  m := i mod t;
  if m <= 10 then
     r := char(ord('0')+m)+r
  else
     r := char(ord('a')+m-11)+r;
  if m > 0 then i := i-m;
  i := i div t;
  if i=0 then break;
  end;
writeln(r);
end.