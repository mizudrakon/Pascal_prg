program syntaxChecker;
var     b,r,c,a,n,o,x:integer; {brackets, round, curly, angle, number, ok?, ord(i[n])}
        i:char; {input}

begin
   o:=0;
   b:=0;
   r:=0;
   c:=0;
   a:=0;
   while not eof do
   begin
      x:=ord(i[n]);
      if x = ord('[') then b := b+1;
      if x = ord(']') then b := b-1;
      if x = ord('{') then c := c+1;
      if x = ord('}') then c := c-1;
      if x = ord('(') then r := r+1;
      if x = ord(')') then r := r-1;
      if x = ord('<') then a := a+1;
      if x = ord('>') then a := a-1;
      if (b<0) or (r<0) or (c<0) or (a < 0) then begin o:=o+1 end;
      if ((x >= ord('a')) and (x <= ord('z'))) or ((x >= ord('A')) and (x <= ord('Z')))
         or ((x >= ord('0')) and (x <= ord('9'))) or (x = ord(' ')) or (x=ord('{')) then
         o:=o+0 else begin
                      o:=o+1;
                      writeln(o,' because of: ',char(x))

                      end;
   end;
   if b+r+c+a <> 0 then o:=o+1;
   if o=0 then writeln('OK') else writeln('NE');
end.
