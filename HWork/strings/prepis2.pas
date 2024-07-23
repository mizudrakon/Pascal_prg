program prepis2;
{working with text files}
var     c,h:char;
        t:text;
        i,j,sl,rl:integer;
        s,r:string;
        jail:string;

begin

   readln(s);
   sl:=length(s);
   jail:=s;
   readln(r);

   assign(t,'qwer.txt');

   rewrite(t);
   i:=1;
   while not eof do
   begin

      read(c);
      if c=s[1] then
      begin
         while c=s[i] do
         begin
            jail[i]:=c;
            inc(i);
            read(c);
            if (i-1=sl) then begin i:=1; write(t,r) end;
         end;
         if i-1 < sl then for j:=1 to i-1 do
            write(t,jail[j]);
         write(t,c);
         i:=1;
      end else
         write(t,c);
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
