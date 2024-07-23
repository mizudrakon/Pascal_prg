const MAX=5;
type    mojepole=array[1..MAX] of integer;
var     pole:mojepole;
procedure bubblesort(var pole:mojepole);
var     i,c:integer;
        prohozeno:boolean;
begin
   prohozeno:=true;    {prohazovalo se nebo jsme na zacatku}
   while prohozeno do
   begin
        prohozeno:=false;
        for i:=1 to MAX-1 do
        begin
           if (pole[i]>pole[i+1]) then
           begin
              prohozeno:=true;
              c:=pole[i];
              pole[i]:=pole[i+1];
              pole[i+1]:=c;
           end;
        end;
   end;
end;

var i:integer;

begin
   for i:=1 to MAX do
      readln(pole[i]);
   bubblesort(pole);
   for i:=1 to MAX do
      write(pole[i],' ');
   writeln;
end.