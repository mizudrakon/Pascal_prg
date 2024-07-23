program vetsi;
const   max=9999;
var     i1,i2:array[1..max] of integer;
        i1l,i2l:longint;

procedure input(var a:array of integer;b:boolean);
var     c:char;
        ac:array[1..max] of char;
        n,i,j:longint;
begin

   c:='0';
   n:=1;
   while true do
   begin
      read(c);
      if c<>'0' then
      begin
         while (ord(c)<>10) do
         begin
         ac[n]:=c;
         inc(n);
         read(c);
         end;
      end;
      if (ord(c)=10) then
      begin
         dec(n);
         break;
      end;
   end;
   {for i:=0 to n do write(ac[i]);}
   i:=1;
   while n>0 do
   begin
      a[i]:=ord(ac[n])-ord('0');
      dec(n);
      inc(i);
   end;
   if b then i2l:=i else i1l:=i;
   {for n:=0 to i do write(a[n],', ');}
end;

function jevetsi(var a,b:array of integer):boolean;
var     p,al,bl:longint;
        i,j,k:integer;
begin
    al:=i1l;
    bl:=i2l;
    p:=al-bl;
    jevetsi:=false;
    if bl<(al-p) then jevetsi:=true else
    begin
       if bl=(al-p) then
       begin
          k:=0;
          while k<=i2l do
          begin
             if a[al-k]>b[bl-k] then begin jevetsi:=true; break; end else
             if a[al-k]<b[bl-k] then break;
             inc(k);
          end;
       end;
    end;

end;



begin
input(i1,true);
input(i2,false);
if jevetsi(i1,i2) then writeln('ano') else writeln('ne');

end.









