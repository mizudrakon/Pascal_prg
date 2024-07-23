program digits;


var     a:integer;
        b:integer;

begin
        b:=0;
        read(a);
        while a > 0 do
        begin
                a := a div 10;
                inc(b)
        end;
        write(b);
end.
