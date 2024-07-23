program MXmult;
var     i,j,x,y,x2,y2,y3,k,n:integer; {too many variables, k - where are we now, n - total number}
        a,b,c:array[1..16]of integer; {A - first matrix, B - second, C - helper}

procedure load;      {read matrix B}
begin
   for i:=1 to 16 do
   begin
     read(x);
     b[i]:=x;
   end;
end;

procedure multi(var x:integer; var y3:integer; var y2:integer);
var y4:integer;                    {gets result of multiplication for single unit of C}
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

procedure writeout;      {write out C which should be identical to the final A}
begin
   for i:=1 to 16 do
   begin
     write(c[i], ' ');
   end;
end;

procedure AtimesB;       {}
begin
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
end;

procedure CtoA;
begin
   for i:=1 to 16 do
      a[i]:=c[i];
end;

{main program:}
begin
   readln(n);               {How many matrices? -n}
   if n < 0 then begin
      writeln('ERROR'); exit; end;
   if n = 0 then begin writeln(0); exit; end;
   k:=1;                    {Now we'll have 1}
   for i:=1 to 16 do        {read first array A}
   begin
     read(x);
     a[i]:=x;
   end;
   if n>k then              {do we need more? is n more than 1? then}
   begin
     while true do
     begin
        inc(k);                   {k+1 since we're about to get B}
        load;                     {read B}
        AtimesB;                  {A*B=C}
        CtoA;                     {A:=C}
        if k=n then break;
     end;
   end;
   writeout;

end.
