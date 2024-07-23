program rozklad;
var a,i:integer;
begin
        i:=2;
        readln(a);
        while i <= a do
        begin if (a div i)*i = a then
                begin
                        write(i);
                        a:=a div i;
                end
        else    i:=i+1;
        end;
end.