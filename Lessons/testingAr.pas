program testingAr;
var     a: array[1..100] of integer;
        text: array[5..50] of string;
        i:integer;

begin
        for i:=1 to 20 do
                a[i]:=i;
        for i:=2 to 15 do writeln(a[i]);

end.
