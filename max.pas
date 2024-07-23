program max;
uses crt;
var     a,n:integer;
begin
        read(a);
        n:=a;
        while a <> -1 do
        begin
                if a > n then n:=a;
                read(a);
        end;
        writeln(n);

end.
