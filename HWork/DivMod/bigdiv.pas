type num=array[0..10000] of integer;
var     a,b,r:num;
        s,bs,rs,sh:integer;

procedure shrink(var n:num; var size:integer);       {works}
begin
   while (size>0) do
   begin
       if n[size-1]<>0 then break;
       dec(size);
   end;
end;

procedure readnum(var out:num; var size:integer);    {works}
var     i:integer;
        n:num;
        c:char;
begin
   i:=0;
   while true do
   begin
      read(c);
      if (ord(c)>=ord('0')) and (ord(c)<=ord('9')) then
      begin
         n[i]:=ord(c)-ord('0');
         inc(i);
      end else if i>0 then break
   end;

   size:=0;
   while i>0 do
   begin
      out[size]:=n[i-1];
      dec(i);
      inc(size);
   end;
   shrink(out,size);
end;

procedure writenum(var n:num; size:integer);        {works}
begin
   if size=0 then write(0);
   while size>0 do
   begin
      write(chr(n[size-1]+ord('0')));
      dec(size);
   end;
   writeln;
end;

procedure exactout(var n:num; size:integer);        {just debugging tool  that works}
var i:integer;
begin
   i:=0;
   if size=0 then write(0);
   while i<size do
   begin
      write(n[i]);
      inc(i);
   end;
   writeln;
end;
                                                    {should work}
function num_ge(var a:num; s:integer; var b:num; var bs:integer; bshift:integer):boolean;
var     k,j,i:integer;
begin
   j:=bs;
   i:=s;
   num_ge:=true;
   {writeln('as=',s,' bs=',bs);}
   if i<(j+bshift) then begin {write('*as=',s,' bs=',bs+bshift);} num_ge:=false end else
   begin
      if i=(j+bshift) then
      begin
         k:=1;
         while k<=j do
         begin
            if a[i-k]<b[j-k] then begin {write('**a=',a[s-k],' b=',b[j-k]);} num_ge:=false; break; end else
            if a[i-k]>b[j-k] then break;
            inc(k);
         end;
      end;
   end;
end;


procedure expand(var n:num; var size:integer; idx:integer);   {should work}
begin
   while size<=idx do
   begin
      n[size]:=0;
      inc(size);
   end;
end;


procedure num_inc_idx(var n:num; var size:integer; idx:integer);  {should also work now}

begin
   expand(n,size,idx);
   if n[idx]<9 then inc(n[idx]) else
   begin
     while n[idx]=9 do
     begin
        n[idx]:=0;
        inc(idx);
        if idx>=size then inc(size);
     end;
     inc(n[idx]);
   end;
end;

                                                    {should work better now}
procedure num_sub(var a:num; var s:integer; var b:num; bs:integer; bshift:integer);
var i,j:integer;
var c:num;
begin
   c:=b;
   i:=bshift;
   j:=0;
   while i<=(bshift+bs) do
   begin
      if a[i]<c[j] then
      begin
        a[i]:=a[i]+10;
        inc(c[j+1]);
      end;
      a[i]:=a[i]-c[j];
      inc(i);
      inc(j);
   end;
   shrink(a,s);
end;


begin
   rs:=0;
   sh:=0;
   readnum(a,s);
   readnum(b,bs);
  while num_ge(a,s,b,bs,sh) do inc(sh);
   while true do
   begin


      if num_ge(a,s,b,bs,sh) then
      begin
         num_sub(a,s,b,bs,sh);
         num_inc_idx(r,rs,sh);
      end else
         if sh>0 then dec(sh)
         else break;


   end;
   writenum(r,rs);
   writenum(a,s);

end.










