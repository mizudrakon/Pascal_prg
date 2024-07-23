type     spojak=^vagonek;
         vagonek=record
                 hod:integer;
                 next:spojak;

         end;

var hlava:spojak;

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



begin

end.