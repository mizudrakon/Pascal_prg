program byrokrat;

type    pi=^cell;
        cell=record
                x:integer;
                next:pi;
        end;
var     spoj,p,f:pi; {spoj,pomoc,first}
        il,rl,el:array of integer; {input list, rule list, cycles list}



procedure input;
var     s:string;
        i,n,c1,c2:integer;
begin
   spoj:=nil;
   p:=nil;

   readln(n);
   setlength(il,n);
   setlength(el,n);
   setlength(rl,n);
   i:=1;
   while i<=n do
   begin
      readln(s);
      c1:=(ord(s[1])-ord('0'));
      c2:=(ord(s[3])-ord('0'));
      il[i]:=c1;
      rl[i]:=c2;
      inc(i);
   end;


end;

{procedure nsn;}

procedure writeout(var a:array of integer);
var     j:integer;
begin
  for j:=1 to length(a) do
  begin
    write(a[j],' ');
  end;
end;



begin
   input;
   writeout(il);
   writeln;
   writeout(rl);
end.
