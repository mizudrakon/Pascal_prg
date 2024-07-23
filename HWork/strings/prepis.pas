program prepis2;

var     c,h:char;

        i,j,sl:integer;
        s,r:string;
        jail:string;

begin

   readln(s);
   sl:=length(s);
   jail:=s;
   readln(r);

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
            if (i-1=sl) then begin i:=1; write(r) end;
         end;
         if i-1 < sl then for j:=1 to i-1 do
            write(jail[j]);
         write(c);
         i:=1;
      end else
         write(c);
   end;
end.
