program byrokrat;
type    pi=^cell;
        cell=record
                value:longint;
                lnext:pi;
                cnext:pi;
                last:pi;
        end;
type    pn=^num;
        num=record
                value:longint;
                next:pn;
        end;

var     i,j,k:longint;
        l1,l2:longint;
        c:char;
        ls,cs,head,pom:pi;
        nh,ph:pn;
        f:text;
        n:boolean;

procedure writefile;
var     c:string;
begin
   while not eof do
   begin
      readln(c);
      writeln(f,c);
   end;
end;

procedure readline;
var     c:char;

begin
   l1:=0;
   l2:=0;
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

procedure push;
{push the cycle one cell in}
begin
   new(cs);
   cs^:=ls^;
   ls^.value:=l1;
   ls^.cnext:=cs;
end;

procedure connect;
begin
   if head=nil then
   begin
      {write(' new head! '); }
      new(head);
      head^.value:=l1;
      head^.lnext:=nil;
      new(cs);
      cs^.value:=l2;
      cs^.cnext:=nil;
      head^.last:=cs;
      head^.cnext:=cs;
   end else
   begin
      pom:=head;
      ls:=head;
      while true do
      begin
         if (l1=pom^.last^.value) and (pom^.value<>l2) then
         begin
            {write(' append! '); }
            new(cs);
            cs^.value:=l2;
            cs^.cnext:=nil;
            pom^.last^.cnext:=cs;
            pom^.last:=cs;
            break;
         end else if (l2=pom^.value) and (l1=pom^.last^.value) then break
         else if (l2=pom^.value) and (l1<>pom^.last^.value) then
         begin
            {write(' push! '); }
            push;
            break;
         end else pom:= ls^.lnext;
         if pom <> nil then ls:=pom;
         if pom = nil then
         begin
            {write(' now! ');    }
            new(pom);
            ls^.lnext:=pom;
            ls:=pom;
            ls^.value:=l1;
            ls^.lnext:=nil;
            new(cs);
            ls^.cnext:=cs;
            ls^.last:=cs;
            cs^.value:=l2;
            cs^.cnext:=nil;
            break;
         end;
      end;
   end;
end;

procedure count;
var     n:integer;
begin
   nh:=nil;
   ls:=head;
   while ls <> nil do
   begin
      cs:=ls;
      n:=0;
      while cs<>nil do
          begin

            pom:=cs^.cnext;
            if cs<>ls then dispose(cs);
            cs:=pom;
            inc(n);
            {write('n=',n,' '); }
            if (ls^.value)=(ls^.last^.value) then
            begin
               dispose(cs);
               cs:=nil;
            end;
          end;
      {write('n=',n,' ');}
      new(ph);
      ph^.value:=n;
      ph^.next:=nh;
      nh:=ph;
      head:=ls^.lnext;
      dispose(ls);
      ls:=head;
   end;
   dispose(ls);
end;
{
procedure destroy;
begin
   ph:=nh;
   while ph<>nil do
   begin
      write('x');
      ph:=nh^.next;
      dispose(nh);
      nh:=ph;
   end;
   dispose(nh);
end;
}

procedure nsn;
var     a,b,c,u,v:longint;
        h:pn;
begin
   ph:=nh;
   a:=ph^.value;
   while (ph^.next)<>nil do
   begin
      b:=ph^.next^.value;
      if a=b then begin
         h:=ph^.next;
         dispose(ph);
         ph:=h;
      end else begin
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
         a:=(a*b) div u;
         h:=ph^.next;
         dispose(ph);
         ph:=h;
      end;
   end;
   dispose(ph);
   writeln(a);
end;


begin
   head:=nil;
   assign(f,'pravidla.in');
   {rewrite(f);}
   {writefile;}
   reset(f);
   readln(f,i);
   {i:=ord(line[1])-ord('0');}
   if i<1 then
   begin
      writeln('error');
      exit;
   end;
   j:=1;
   while j<=i do
   begin
      readline;

      connect;
      inc(j);
   end;
   close(f);
   count;
   nsn;
end.
