type    pint=^sint;
        sint=record
                cislo:integer;
                next:pint;
        end;
var     spojak,pom,last,first,fin:pint;
        l:integer;
        prev,dal:pint;
        max:integer;

procedure input;

begin
   l:=1;
   spojak:=nil;
   pom:=nil;
   last:=nil;
   new(pom);
   readln(pom^.cislo);
   fin:=pom;
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
   first:=spojak;

end;


procedure writeout;
var i,j,k:integer;

begin
   i:=1;
   j:=1;
   k:=0;
   spojak:=first;
   while true do
   begin
       writeln(spojak^.cislo);
       pom:=spojak;
       spojak:=spojak^.next;
       inc(i);
       inc(j);
       if spojak=first then writeln;
       if (i > max-l) and (spojak=first^.next) then begin dispose(pom); k:=1 end;
       if (k>=1) then inc(k);
       if (k>=l) and (spojak=fin) then begin writeln(fin^.cislo); break; end;
   end;
end;

procedure find(var n:integer);

begin
   spojak:=first;
   while true do
   begin

      if spojak^.cislo=n then
      begin
         dal:=spojak;
         break;
      end;
      prev:=spojak;
      spojak:=spojak^.next;
   end;
end;

procedure bridge(n:integer);
begin
   find(n);
   prev^.next:=dal^.next;
   dispose(dal);
   dec(l);
end;

var     a:integer;

begin
   max:=16;
   input;
   bridge(65);
   bridge(75);
   {writeln(prev^.cislo, ', ',dal^.cislo);}
   writeln;
   writeout;


end.
