program binary;
const   max=10000;
type    num=array[1..max];
var     m,i:integer;
        b,r:num;



procedure nacti(var a,b:array of integer);
var     ch:char;
        c:integer;
        a:num;
begin
c:=0;
while true do
begin
  read(ch);
  if (ord(ch)<=ord('1')) and (ord(ch)>=ord('0')) then
  begin
     inc(c);
     a[c]:=(ord(ch)-ord('0'));
  end
  else break;


end;

i:=0;
while c>0 do
begin
  inc(i);
  b[i]:=a[c];
  dec(c);
end;
for c:=1 to i do write(b[c],' ');
end;

procedure secti(var a,b:num);

begin


end;


procedure decadic;
var     c,j:integer;
        a,d:num;
begin
   while true do
   begin
       if b[i]>0 then
       begin
         a[1]:=2;
         c:=1;
         while c<=i do
         begin


         end;
       dec(i);
       end;
   end;

end;



{c:=1;
while true do
begin
if a[c]=0 then b[c]:=;
if i>0 then
  begin
     while i>0 do
        begin
            c:=c+1;
            m:= i mod 2;
            a[c]:=m;
            i:=i-m;
            i:=i div 2;
        end;
  for b:=c downto 1 do write(a[b]);
  end;
end;}
end.
