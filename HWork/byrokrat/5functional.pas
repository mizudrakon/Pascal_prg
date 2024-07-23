program byrokrat;
type    pi=^cell;                 {node structured to support a linear linked list of other linear linekd lists as cycles}
        cell=record
                value:longint;
                lnext:pi;
                cnext:pi;
                last:pi;
        end;
type    pn=^num;             {simpler node structure to keep lengths of all the cycles - I could have put it as another number
                             to cell, but what the heck...}
        num=record
                value:longint;
                next:pn;
        end;

var     i,j,k:longint;
        l1,l2:longint;
        line:string;
        c:char;
        ls,cs,head,pom:pi;
        nh,ph:pn;
        f:text;
{
procedure writefile;
var     c:string;
begin
   while not eof do
   begin
      readln(c);
      writeln(f,c);
   end;
end;
}
procedure readline;    {reads instructions from one line of a file}
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
{connects new cell to the begining of a cycle}
begin
   new(cs);
   cs^:=ls^;
   ls^.value:=l1;
   ls^.cnext:=cs;
end;

procedure connect;  {uses instructions to make a linked list of cycles, which are represented by linear linked lists...}
begin               {it expects that instructions do eventually lead to the initial permutation... I just don't check in any way at all}
   if head=nil then
   begin
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
            new(cs);
            cs^.value:=l2;
            cs^.cnext:=nil;
            pom^.last^.cnext:=cs;
            pom^.last:=cs;
            break;
         end else if (l2=pom^.value) and (l1=pom^.last^.value) then break
         else if (l2=pom^.value) and (l1<>pom^.last^.value) then
         begin
            push;
            break;
         end else pom:= ls^.lnext;
         if pom <> nil then ls:=pom;
         if pom = nil then
         begin
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

procedure count;  {counts how many iterations each cycle takes and puts the numbers into another linekd list}
var     n:longint;
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
            if (ls^.value)=(ls^.last^.value) then
            begin
               dispose(cs);
               cs:=nil;
            end;
          end;
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

procedure nsn;  {finds the least common multiple which I expect to be the final answer... and it writes it out}
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
   assign(f,'5.in');
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
