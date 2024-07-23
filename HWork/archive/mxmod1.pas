program MXmult;
var     i,j,x,y,x2,y2,y3:integer;
        a,b,c:array[1..16]of integer;

procedure load;
begin
   for i:=1 to 16 do
   begin
     read(x);
     b[i]:=x;
   end;
end;

procedure multi(var x:integer; var y3:integer; var y2:integer);
var y4:integer;
begin
   x2:=x;
   y4:=y3;
   c[y2]:=0;
   while x2 <= x+3 do
   begin
      c[y2]:=c[y2]+a[x2]*b[y4];
      inc(x2);
      y4:=y4+4;
   end;
end;

procedure writeout;
begin
   for i:=1 to 16 do
   begin
     write(c[i], ' ');
     if (i mod 4) = 0 then writeln
   end;
end;

begin
   for i:=1 to 16 do
   begin
     read(x);
     a[i]:=x;
   end;

   load;


   y2:=1;
   while y2<16 do
   begin
      x:=y2;
      for y:=1 to 4 do
      begin
          y3:=y;
          multi(x,y3,y2);
          inc(y2);
      end;
   end;

   writeout;


end.
