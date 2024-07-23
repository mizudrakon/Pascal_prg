program byrocratic;
const   max=100000;
var     list:array[1..max] of longint;
        l1,l2,len,i:longint;
        f:text;

procedure writefile;
var     c:string;
begin
   while not eof do
   begin
      readln(c);
      writeln(f,c);
   end;
end;

procedure writeout;
var     i:longint;
begin
   for i:=1 to max do
   begin
      write(list[i],' ');
   end;
end;

procedure readline;    {reads instructions from one line of a file}
var     c:char;
        i:longint;
begin
   l1:=0;
   l2:=0;
   begin
     read(f,c);
     while (ord(c)<=ord('9')) and (ord(c)>=ord('0')) do
     begin
        l1:=(l1*10)+(ord(c)-ord('0'));
        read(f,c);
     end;
     read(f,c);
     while (ord(c)<=ord('9')) and (ord(c)>=ord('0')) do
     begin
        l2:=l2*10+(ord(c)-ord('0'));
        read(f,c);
     end;
   end;
end;

function nsn(var a,b:longint):longint;  {finds the least common multiple}
var     c,u,v:longint;
begin
        begin
                if (b > a) then
                begin
                        c:=a;
                        a:=b;
                        b:=c
                end;
                u:=a;
                v:=b;
                c:=1;
                while c <> 0 do
                begin
                        c := u mod v;
                        u := v;
                        v := c;
                end;
                nsn:=((a*b) div u);
        end;

end;

procedure cyclist;    {creates an array of permutations and calls nsn, and writes out the final answer}
var     i,j,k1,k2,l,c:longint;
begin
   j:=1;
   k2:=1;
   c:=0;
   while j<=max do
   begin
     i:=j;
     while list[i]=0 do
     begin
        inc(i);
        if i=max then break;
     end;
     j:=i;
     k1:=0;
     while true do
     begin
        {writeln('l1=',i,' l2=',list[i]);}
        l:=list[i];
        list[i]:=0;
        i:=l;
        if i=0 then break;
        inc(c);
        {writeln('c=',c,' len=',len);}
        inc(k1);


     end;
     {writeln(k2,' ',k1); }
     if k1>1 then k2:=nsn(k2,k1);
     if c=len then break;
   end;
   write(k2);
end;

begin
   assign(f,'5.in');
   {rewrite(f);
   writefile;}
   reset(f);
   readln(f,len);
   if len<1 then
   begin
      writeln('0');
      exit;
   end;
   i:=1;
   while i<=len do
   begin
     readline;

     list[l1]:=l2;
     inc(i);
   end;

   close(f);
   {writeout;}
   cyclist;
end.