program rozklad;
var     a,i:integer;
        opakujeme:boolean; {we use this to get marks for multiplying}
begin
        i:=2;
        opakujeme:=false; {we start with no *}
        readln(a);
        while i <= a do
        begin
                if (a div i)*i = a then
                begin
                        if opakujeme then
                                write('*') {unless it ends there will be *}
                        else opakujeme:=true;
                        write(i);
                        a:=a div i;
                end else i:=i+1;
        end;
end.
