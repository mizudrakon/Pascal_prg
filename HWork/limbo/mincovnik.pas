program minceovnik;
{this program is supposed to write out all possible ways to use certain coins to
pay certain amount.}
{var pt is the first input that marks how many types of coin there is to be used}
{var m is used to read all the specific coin types that user puts in, there has
to be pt-many of them.}
{The las user input is var soucet, it tells us what amount are all the combinations
of coin supposed to make up}
{All above is taken care of with the input procedure}



{type    mince=array of integer;}
var     a:array of integer;
        b:array[1..256] of integer;
        i,j,k,l,multi,m,modulo,n,pt,soucet,c,c2:integer;

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

begin
   input;      {read all the user input, creates an array a of coin 'types'}
   n:=0;
   while true do
   begin
      c:=1;
      for i:=n+1 to pt do
      begin
         k:=soucet;
         if k > a[i] then
         begin

            modulo := k mod a[i];
            l:= k - modulo;
            multi := l div a[i];
            k := k - l;
            c2:=c;
            for j:=c to c+multi-1 do
            begin
               b[j]:=a[i];
               inc(c2);
            end;
            c:=c2;
         end;
      end;
      writeln(c);
      for i:=1 to c do write(b[i],' ');
      writeln;
      inc(n);
      if n>pt then break;
   end;





end.
