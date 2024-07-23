unit lists;

interface
   var  a:array[0..10]of char;
        c:char;

   procedure nacti;
   procedure vypis;

implementation
   procedure nacti;
   var i:integer;
   begin
      for i:=1 to 10 do
      begin
         read(c);
         a[i]:=c;
      end;
   end;

   procedure vypis;
   var  i:integer;
   begin
      for i:=1 to 10 do
      begin
         write(a[i],' ');
      end;
   end;

end.