program syntaxChecker2;

var     b,r,c,a,o,x:integer; {brackets, round, curly, angle, number, ok?, ord(i[n])}
        i:char; {input}
        abc,uABC,Number,br:boolean;

begin
   o:=0;
   b:=0;
   r:=0;
   c:=0;
   a:=0;
   while not eof do
   begin
      read(i);
      x:=ord(i);
      abc:=((x >= ord('a')) and (x <= ord('z')));
      uABC:=((x >= ord('A')) and (x <= ord('Z')));
      Number:=((x >= ord('0')) and (x <= ord('9')));
      br:=((i = '(') or (i = ')') or (i = '{') or (i = '}') or (i = '[') or (i = ']'));
      if i = '[' then b := b+1;
      if i = ']' then b := b-1;
      if i = '{' then c := c+1;
      if i = '}' then c := c-1;
      if i = '(' then r := r+1;
      if i = ')' then r := r-1;
      if i = '<' then a := a+1;
      if i = '>' then a := a-1;
      if (b<0) or (r<0) or (c<0) or (a < 0) then o:=o+1;
      if abc or uABC or Number or (i = ' ') or br or (x = 10) or (x = 13) or (x = 7) then
         o:=o+0 else o:=o+1;
   end;
   if b+r+c+a <> 0 then o:=o+1;
   if o=0 then writeln('OK') else writeln('NE');
end.
