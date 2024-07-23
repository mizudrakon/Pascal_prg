const   max=16;
type    pint=^sint;
        sint=record
                cislo:integer;
                next:pint;
        end;
var     spojak,pom,last:pint;
        l:integer;


procedure input;

begin
   l:=1;
   spojak:=nil;
   pom:=nil;
   last:=nil;
   new(pom);
   readln(pom^.cislo);
   pom^.next:=spojak;
   spojak:=pom;
   last:=pom;
   new(pom);
   while not eof do
   begin
        inc(l);
        readln(pom^.cislo);
        pom^.next:=spojak;
        spojak:=pom;
        new(pom);
   end;
   dispose(pom);
   last^.next:=spojak;

end;


procedure writeout;
var i,j:integer;

begin
   i:=1;
   j:=1;
   while i<=max do
   begin
       writeln(spojak^.cislo);
       pom:=spojak;
       spojak:=spojak^.next;
       inc(i);
       inc(j);
       if j > l then begin writeln; j:=1 end;
       if i > max-(l-1) then dispose(pom);
   end;
end;


begin
   input;
   writeout;

end.
