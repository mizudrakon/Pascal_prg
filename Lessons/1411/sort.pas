const MAX=5;
type    mojepole=array[1..MAX] of integer;
var     pole:mojepole;

procedure intquicksort(var pole:mojepole;odkud,kam:integer);
var     pivot,pivotu,mensi,soucasny,vetsi,pom,i:integer; {pivot k deleni prvku na vetsi a mensi, pivotu - pocet
pivotu,...}

begin
   if (odkud<kam) then
   begin
   mensi:=odkud;
   vetsi:=kam+1;
   soucasny:=odkud;
   pivotu:=0;
      pivot:=pole[odkud];
      while soucasny<vetsi do
      begin
         if pole[soucasny]=pivot then
         begin
            inc(pivotu);
            inc(soucasny);
         end else
            if (pole[soucasny]<pivot) then
            begin
               pole[mensi]:=pole[soucasny];
               inc(mensi);
               inc(soucasny);
            end else {protoze a<b nebo a=b nebo a>b}
            begin
               pom:=pole[soucasny];
               dec(vetsi);
               pole[soucasny]:=pole[vetsi];
               pole[vetsi]:=pom;
            end;
      end;
      for i:=1 to pivotu do
      begin
         pole[mensi+i-1]:=pivot;
      end;
      intquicksort(pole,odkud,mensi-1);
      intquicksort(pole,vetsi,kam);
   end;
end;

procedure quicksort(var pole:mojepole);
begin
   intquicksort(pole,1,MAX);
end;

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

function indmin(i:integer;pole:mojepole):integer;
{vrati index min prvku v poli pole pocinaje od i}
var     j,zatim:integer;
begin
   zatim:=i;
   for j:=i+1 to MAX do
   begin
      if (pole[j]<pole[zatim]) then
         zatim:=j;
   end;
   indmin:=zatim;
end;


procedure selectsort(var pole:mojepole);
var     i,j,x,pom:integer;
begin
   for i:=1 to MAX-1 do {}
   begin
       x:=indmin(i,pole);{zjisti index minima v poli}
       pom:=pole[x];
       pole[x]:=pole[i];
       pole[i]:=pom;
   end;
end;

var i:integer;

begin
   for i:=1 to MAX do
      readln(pole[i]);
   quicksort(pole);
   for i:=1 to MAX do
      write(pole[i],' ');
   writeln;
end.