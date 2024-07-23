program digit-count;
uses crt;

var     a:integer;
        b:integer;

begin
        b:=0;
        read(a);
        while a > 1 do
                begin
                a := a / 10;
                inc(b);
                end;
        write(b);
end.