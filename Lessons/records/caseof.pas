program coje;
var     c:char;

function WhatIsChar(c:char):string;
var     s:string;
begin
   s:=' ';
   case c of
      '0'..'9':s:='digit';
      'a'..'z':s:='lower case';
      'A'..'Z':s:='upper case';
   end;
   WhatIsChar:=s;
end;


begin
   readln(c);
   writeln(WhatIsChar(c));
end.