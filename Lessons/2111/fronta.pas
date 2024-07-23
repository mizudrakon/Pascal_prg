type    pzas=^zas;
        zas=record
                hod:integer;
                next:pzas;
        end;
var     hlava:pzas;

procedure init;
begin
   hlava:=nil;
end;

procedure push(co:integer);
var pom:pzas;
begin
   new(pom);
   pom^hod:=co;
   pom^.next:=hlava;
   hlava:=pom;
end;