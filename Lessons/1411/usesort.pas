uses trideni,crt;
var pole:mojepole;
    i:integer;
begin
   clrscr;
   for i:=1 to MAX do
      readln(pole[i]);
   quicksort(pole);
   for i:=1 to MAX do
      write(pole[i],' ');
   writeln;
end.