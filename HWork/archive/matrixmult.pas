program matrixmult;
var     i:integer;
        a,b:array[1..16] of integer;
        k,n:integer;

procedure matrix;
var   i,c:integer;

begin
   for c:=1 to 16 do
   begin
      read(i);
      if (k mod 2)=1 then a[c]:=i
      else b[c]:=i;
   end;
end;

begin
   read(n);
   if n = 0 then writeln('nothing');
   k:=1;
   while k<=n do
   begin
     matrix;
     inc(k);
   end;
   for i:=1 to 9 do
   write(a[i], ', ');
   writeln;
   for i:=1 to 9 do
   write(b[i], ', ');

end.