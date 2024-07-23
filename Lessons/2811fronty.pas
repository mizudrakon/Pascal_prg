type     spojak=^vagonek;
         vagonek=record
                 hod:integer;
                 next:spojak;

         end;

var hlava:spojak;
    zacatek,konec:spojak;
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


begin

end.