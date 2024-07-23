program prepis2;
{working with text files}
var     c,h:char;
        t:text;
        i,j,sl,rl:integer;
        s,r:string;
        jail:array of char;

begin

   readln(s);
   sl:=length(s);
   setlength(jail, sl+1);
   readln(r);

   assign(t,'qwer.txt');

   rewrite(t);
   i:=1;
   read(c);
   while not eof do
   begin
      h:=c;
      if h=s[i] then
      begin
            jail[i]:=h;
            inc(i);
            read(c)
      end;
      if (h<>s[i]) and (i-1 < sl) then
      begin
         for j:=1 to i-1 do write(t,jail[j]);
         i:=1;
      end;
      if (h<>s[i]) and (i-1 = sl) then
      begin
         write(t,r);
         i:=1;
      end;
      if h<>s[i]write(t,h);
   end;
   close(t);



   writeln;


   reset(t);
   while not eof(t) do
   begin
      read(t,c);
      write(c);

   end;
   close(t);
end.
