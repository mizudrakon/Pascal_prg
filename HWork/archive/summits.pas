program summits;
var     i,m,k:real;
        c,n:integer;

begin
c:=0;
{SI-}
read(i);
{SI+}
if ioresult <> 0 then begin writeln('ERROR'); exit; end;
k:=i+1;
while true do {gets stuck on typing wrong input type}
   begin
   m:=i;
   {SI-}
   read(i);
   {SI+}
   if ioresult <> 0 then begin writeln('ERROR'); exit; end;
   if i < 0 then break;
   c:=c+1;
   if i > m then
      begin
      k:=m;
      m:=i;
      n:=c;
      end
   else if (i < m) and (m >= k) then
        begin
        writeln('vzdalenost ',n,' vyska ',m:0:1);
        k:=m;
        m:=i;
        end;
   end;

end.
