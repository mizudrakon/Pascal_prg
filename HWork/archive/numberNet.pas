program numberNet;
var     i:string;
        n,r:integer;
        b,c:char;

begin   {nefunguje}
   read(i);
   r:=0;
   b:='0';
   c:='9';
   for n:=1 to length(i) do
      begin
        if (ord(i[n]) >= ord(b)) and (ord(i[n]) <= ord(c)) then
          r:= r*10 + (ord(i[n]) - ord(b));
       { else
          begin
           writeln('error');
           exit;
          end;}
      end;
   writeln(r);
end.
