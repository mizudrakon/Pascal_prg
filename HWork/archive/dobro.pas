program dobro;
var     i,j,m,n,p,c:integer;

begin
readln(i);
if i <= 0 then writeln('ERROR') else
   begin
   c:=0;
   for n:=1 to i do
     begin
     j:=1;
     p:=n;
     while p>0 do
        begin
        m:= p mod 10;
        if m<>0 then
          begin
          if (n mod m) > 0 then
            begin j:= 1; break; end else j:= 0;
          p:= (p - m) div 10;
          end else begin j:=1; break end;
        end;

     if j=0 then
       c:=c+1;
     {else writeln(i, ' je zle!');}
     end;
     writeln(c);
   end;
end.
