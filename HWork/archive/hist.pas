program histogram;
var   a:array [1..10] of integer;
      i,j:integer;

begin

   while true do
   begin
      read(i);
      if i<0 then break;
      if (i<1) or (i>10) then continue;
      inc(a[i]);
   end;
   for i:=1 to 10 do begin
      write (i:3, ' ');
      for j:=1 to a[i] do write('*');
      writeln;
   end;
end.
