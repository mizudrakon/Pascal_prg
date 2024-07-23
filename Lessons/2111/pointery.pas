type    tbod=^bod;
        bod= record
                x:integer;
                next:tbod;
        end;
var     b,pom:tbod;
        i,j:integer;
begin
   {new(b);
   b^.x:=1;
   b^.y:=2;}

   readln(j);
   b:=nil;
   for i:=1 to j do
   begin
      pom:=b;
      new(b);
      readln(b^.x);
      b^.next:=pom;
   end;
   while b<>nil do
   begin
      write(b^.x, ', ');
      pom:=b;
      b:=b^.next;
      dispose(pom);
   end;
end.