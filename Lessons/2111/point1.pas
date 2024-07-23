type    pint=^integer;
var     a,b:pint;
        i:integer;

begin
   {i:=1;
   while i<10 do
   begin

   end;}

   new(a);
   a^:=5;
   new(b);
   b^:=a^+5;
   dispose(a);
   new(a);
   a^:=b^;
   writeln(a^);
end.
