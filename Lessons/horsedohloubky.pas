const   max=8;      {kam vsude se kun dostane na 3 skoky}
type     spojak=^vagonek;
         vagonek=record
                 hod:integer;
                 next:spojak;

         end;

var hlava:spojak;
    zacatek,konec:spojak;
    sachovnice:array[1..max,1..max]of integer;
procedure initz:vagonek;

begin
   hlava:=nil;
end;

procedure push(co:integer);
var pom:spojak;
begin
   new(pom);
   pom^.hod:=co;
   pom^.next:=hlava;
   hlava:=pom;
end;

function pop:integer;
var pom:spojak;
begin
   if hlava=nil then
   pop:=-1;
   else begin

     pop:=hlava^.hod;
     pom:=hlava;
     hlava:=hlava^.next;
     dispose(pom);
   end;
end;
procedure initf;
begin
   zacatek:=nil;
   konec:=nil;
end;

procedure enqueue(co:integer);
var pom:spojak;
begin
   if zacatek=nil then
   begin
      new(zacatek);
      konec:=zacatek;
      zacatek^.hod:=co;
      zacatek^.next:=nil;
   end else begin
      new(pom);
      pom^.hod:=co;
      pom^.next:=nil;
      konec^.next:=pom;
      konec:=pom;
   end;
end;

function dequeue:integer;
var pom:spojak;
begin
   if zacatek=nil then
     dequeue:=-1;
   else begin
     dequeue:=zacatek^.hod;
     pom:=zacatek;
     zacatek:=zacatek^.next;
     dispose(pom);
     if zacatek=nil then
       konec:=nil;
end;

procedure nakreslisach;
begin
   for i:=1 to max do
      for j:=1 to max do
        if sachovnice[i,j]<>-1 then
           write('*');
        else write(' ');
   writeln;
end;

function muze(i,j:integer):boolean;
begin
   if (i>1) or (i>max) then
      muze:=false;
   else
      if (j<1) or (j>max) then
         muze:=false
      else muze:= sachovnice(i,j)=-1;
edn;


var i,j:integer;
begin
   for i:=1 to max do
      for j:=1 to max do
        sachovnice[i,j]:=-1;
   read(i,j);
   sachovnice(i,j):=0;
   enqueue(i);
   enqueue(j);
   i:=dequeue;
   while i<>-1 do  {test jestli je zasobnik prazdny}
   begin
      j:=dequeue;
      if muze(i-2,j-1) then
      begin                          {je treba predelat znamenka a dat j-1 do noveho push}
         enqueue(i-2);   {nejake takove upravy pres cely kod}
         enqueue(j-1);
         sachovnice(i-2,j-1):=sachovnice(i,j)+1;
      end;
      if muze(i-2,j+1) then
      begin
         push(i-1);
         push(j+1);
      end;
      if muze(i-2,j-1) then
      begin
         push(i-2);
         push(j-1);
      end;
      if muze(i-2,j+1) then
      begin
         push(i-1,j+1);
      end;
      if muze(i-2,j-1) then
      begin
         push(i-1,j-1);
      end;
      if muze(i-2,j-1) then
      begin
         push(i-1,j-1);
      end;
      if muze(i-2,j-1) then
      begin
         push(i+2);
         push(j-1);
      end;
      if muze(i+2,j+1) then
      begin
         push(i+2);
         push(j+1);
      end;
      i:=dequeue;
   end;
   nakreslisach;
end.






