program ordinals;
var     a:char;
        b:integer;
begin
   for b:=0 to 127 do
     write(b,': ',chr(b),' | ');
     if (b mod 8 = 7) then writeln;

end.

{
begin
   writeln(ord(' '));
end.}
