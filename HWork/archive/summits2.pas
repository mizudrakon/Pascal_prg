program summits;
var     i,m,k:real;
        c,n:integer;

begin
c:=0;
readln(i);
k:=i+1;
m:=i;
while i>0 do
   begin
   readln(i);
   c:=c+1;
   if i > m then
      n:=c
   else if (i < m) and (m >= k) then
        writeln('vzdalenost ',n,' vyska ',m:0:1);
   k:=m;
   m:=i;
   end;
end.
