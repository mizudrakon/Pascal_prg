program cosi;
var cislo, kandidat:integer;
begin
        readln(cislo);
        kandidat:=2;
        while (kandidat<=cislo) do
        begin
               if ((cislo mod kandidat) = 0) then
               begin
                write(kandidat, ' ');
                cislo:=cislo div kandidat;
               end else
               begin
                inc(kandidat);
               end;
        end;
end.
