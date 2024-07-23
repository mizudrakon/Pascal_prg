const   max=100000;
var     a:array[1..max] of longint;
        k,c,l:longint; {variable for keeping the array's length easily approachable}

procedure init;    {what size is the room?-n, array length must be n+1 (since indexing from zero)}
var     n:longint;
begin
   readln(n);
   l:=n;
end;

procedure sort;  {switches a bigger son for his smaller parent all the way up}
var    n,p,s,j:longint;
begin
   n:=k;
   while n>1 do
   begin
      p:=(n div 2);
      {write('p=',p);}
      s:=n;
      {write('s=',s);}
      if a[p]<a[s] then
      begin
         j:=a[s];
         a[s]:=a[p];
         a[p]:=j;
         if (n div 2)>=1 then n:=(n div 2) else break;
      end else break;
   end;
end;

procedure leave;   {writes out the first (biggest) number and turns it into zero that than goes down
the sink hole always in direction of the bigger son, when it reaches an end, it checks if it's the end
and if not, they switch... which seem sound to me now}
var     n,p,ls,rs:longint;
begin
   n:=1;
   if a[n]<>0 then writeln(a[n]);
   a[n]:=0;
   while true do
   begin
      p:=n;
      if ((2*n) > l) then break;
      k:=n;   {I added k so I don't have to switch at the end}
      ls:=2*n;
      rs:=(2*n)+1;
      if (a[ls]=0) and (a[rs]=0) then break;
      if a[ls]>a[rs] then
      begin
         a[p]:=a[ls];
         a[ls]:=0;
         n:=2*n;
      end else begin
         a[p]:=a[rs];
         a[rs]:=0;
         n:=(2*n)+1;
      end;
   end;
   {no switching}
   {if n <> l then
   begin
      a[n]:=a[l];
      a[l]:=0;
   end;}
end;

procedure enter;   {people enter the coffee room while flashing their rank around = i}
var     i,p,s:longint;
begin
   c:=0;
   k:=0;
   while true do
   begin
      readln(i);
      if i=0 then break;
      if (i>0)and(i<1000000) then
      begin
        inc(c);
        inc(k);
        a[k]:=i;
        sort;
        if c = l then
        begin
          leave;
          dec(c);
        end;
      end;
   end;
end;

begin
   readln(l);
   if (l<=100000)and(l>0) then
   begin
      enter;
      while true do
      begin
        leave;
        if a[1]= 0 then break;
      end;
   end else
   begin
      writeln('error');
      exit;
   end;
end.
