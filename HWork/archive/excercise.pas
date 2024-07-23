program excercise;
var     a:array[1..5]of array[1..5]of integer;
        i,j:integer;

procedure load;
var     c:integer;
begin
   for i:=1 to 5 do
   begin
      for j:=1 to 5 do
      begin
         read(c);
         a[i,j]:=c
      end;
   end;
end;

{function soucet(b:array of integer):integer;
begin

   for i:=1 to length(b) do soucet := soucet + b[i];

end; }

begin
   load;
   for i:=1 to 5 do
   begin
      for j:=1 to 5 do
      begin
      write(a[i,j], ' ');
      end;
      writeln;
   end;
   {writeln(soucet(a));}
end.