program sito;
const MAX=100;
var     a: array[2..MAX] of boolean;
        i,j:integer;

begin
        for i:=2 to MAX do
                a[i]:=true;
        for i:=2 to MAX do
                if (a[i]) then
                begin
                        write(i, ' ');
                        j:=2;
                        while(j*i<=MAX)do
                        begin
                                a[j*i]:=false;
                                inc(j);
                        end;
                end;
end.
