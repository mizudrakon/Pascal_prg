program nmsn;
var a,b,c,u,v:integer;
begin
    readln(a);
    readln(b);
    if (a*b <= 0) then
        writeln('ERROR')
    else
        begin
                if (b > a) then
                begin
                        c:=a;
                        a:=b;
                        b:=c
                end;
                u:=a;
                v:=b;
                c:=1;
                while c <> 0 do
                begin
                        c := u mod v;
                        u := v;
                        v := c;
                end;
                writeln((a*b) div u);
        end;

end.
