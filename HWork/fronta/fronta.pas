const   max=100000;
var     a:array[1..max] of longint;
        c,l:longint; {variable for keeping the array's length easily approachable}
        err:boolean;

procedure init;    {what size is the room?-n, array length must be n+1 (since indexing from zero)}
var     n:longint;
begin
   readln(n);
   l:=n;
end;

procedure sort;  {switches a bigger son for his smaller parent all the way up, so the 1st one is maximum}
var    n,p,s,j:longint;
begin
   n:=c;
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
   n:=1;  {the first one in the array is the highest rank}
   writeln(a[n]); {he gets his coffee...}
   a[n]:=0;       {and makes a clear space that is marked by '0'}
   while true do
   begin
      p:=n;
      if ((2*n) > l) then break;  {untill the 0 is at the lowes possble place...}
      ls:=2*n;
      rs:=(2*n)+1;
      if (a[ls]=0) and (a[rs]=0) then break;
      if a[ls]>a[rs] then {... it gets switched with its bigger son}
      begin             {left}
         a[p]:=a[ls];
         a[ls]:=0;
         n:=2*n;
      end else begin    {or right, it goes right if they are both the same size}
         a[p]:=a[rs];
         a[rs]:=0;
         n:=(2*n)+1;
      end;
   end;
   if n <> l then   {0 is at one of the lowest positions of the heap array, which may not be the last}
   begin            {of the array - I want it to make capacity checking easier...}
      a[n]:=a[l];   {so I switch them}
      a[l]:=0;
   end;
end;

procedure enter;
var     i,p,s:longint;
begin
   c:=0;
   while true do
   begin
      readln(i);           {reads the rank of each person who enters}
      if i=0 then break;
      if (i>0) and (i<1000000) then {ignores ranks that are not supported}
      begin
        inc(c);              {counts how many people is inside the room}
        a[c]:=i;
        sort;                {pushes higher ranks up}
        if c = l then        {if the room is full...}
        begin
          leave;             {...the highest ranked person leaves...}
          dec(c);      {...and makes space, which sinks onto one of the lowest positions of the heap}
        end;
      {end else begin
        writeln('error');
        err:=true;
        exit;}
      end;
   end;
end;

begin
   err:=false;
   readln(l);
   if (l<=100000)and(l>0) then {if the room capacity is a sensible number}
   begin
      enter;
      if err then exit;
      while true do
      begin
        leave;
        if a[1]= 0 then break;    {if there are no more people we are finished}
      end;
   end else
   begin
      writeln('error');
      exit;
   end;
end.
