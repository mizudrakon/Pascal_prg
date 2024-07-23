program temporary;
var     a:array of integer;
        b:array[1..256] of integer;
        i,j,k,l,multi,delka,m,modulo,n,pt,soucet,c,c2:integer;

procedure input;
begin
   readln(pt);
   setlength(a,pt+1);
   c:=1;
   while c <= pt do
   begin
      read(m);
      a[c]:=m;
      inc(c);
   end;
   readln(soucet);
end;

procedure firstline(var i,j:integer);
begin



   while true do
   begin
      if soucet >= a[i] then
      begin
         modulo := soucet mod a[i];
         b[j] := a[i];
         inc(j);
         soucet := soucet - a[i];
      end else inc(i);
      if i > pt then break;
   end;
   delka:= j-1;

end;

procedure rest(var d,i:integer; var m:array of integer);
var     h:array of integer;
        l:integer;
begin
   l:=d;
   while d>0 do
   begin

      if m[d] < m[d-1] then
      begin
         setlength(h, l-(d-1)+1);
         n:=l-length(h)+1;
         for c:=1 to length(h) do
            begin
            h[c]:= b[n];
            inc(n);
            end;
      end;
      d:=d-1;
   end;
   soucet := b[d];
   firstline(i,d);
   for c:=1 to delka do write(b[c]);
   for c:=1 to length(h) do write(h[c]);
   writeln;
end;


begin
   input;
   i:=1;
   j:=1;
   firstline(i,j);
   for c:=1 to delka do write(b[c]);
   writeln;
   i:=2;

   rest(delka,i,b);
   rest(delka,i,b);


end.