program translate;
var     i,m,t,h:integer;{input, modulo, type, helper}
        r:string;     {result}

begin
readln(i);
for t:=2 to 36 do
begin
{if t > 36 then
  begin
  writeln('ERROR');
  exit
  end;}
r := '';
h:=i;
while true do
  begin
  m := h mod t;
  if m < 10 then
     r := char(ord('0')+m)+r
  else
     r := char(ord('a')+m-10)+r;
  if m > 0 then h := h-m;
  h := h div t;
  if h=0 then break;
  end;
writeln(r);
end;
end.
