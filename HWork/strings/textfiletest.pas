{working with text files}
var     c:char;
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
   while not eof do
   begin
      read(c);
      if c=s[1] then
      begin
         while true do
         begin
            jail[i]:=c;
            inc(i);
            if i>sl then break;
            read(c);
            if s[i]<>c then break;
         end;
         if i-1 < length(s) then
         begin
            for j:=1 to i-1 do
               write(t,jail[j]);
            write(t,c);
            i:=1;
         end else
            write(t,r);
      end else write(t,c);
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
