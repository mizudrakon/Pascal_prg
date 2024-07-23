program primes;
var p:array[2..1000] of boolean;
        i,j:integer;
begin
for i:=2 to 1000 do p[i]:=true;
for i:=2 to 1000 do
        begin
        if p[i] then
                begin
                writeln(i,' is prime');
                j:=2;
                while (i*j<1000) do
                        begin
                        p[i*j]:=false;
                        j:=j+1;
                        end;
                end;
        end;
end.