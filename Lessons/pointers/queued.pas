program queued;
type    pq=^queue;
        queue=record
                val:integer;
                next:pq;
        end;
var     head,tail:pq;

procedure init;
begin
   head:=nil;
   tail:=nil;
end;

procedure enqueue(qi:integer);
var     pom:pq;
begin
   if head=nil then
      begin
         new(head);
         tail:=head;
         head^.next:=nil;
         head^.val:=qi;
      end
      else begin
         new(pom);
         pom^.next:=nil;
         pom^.val:=qi;
         head^.next:=pom;
         head:=pom;
      end;
end;

function dequeue:integer;
var pom:pq;
begin
   if head=nil then dequeue:=-1
   else begin
      if head=tail then
      begin
         dequeue:=tail^.val;
         dispose(tail);
         head:=nil;
         tail:=nil;
      end else
      begin
         dequeue:=tail^.val;
         pom:=tail;
         tail:=tail^.next;
         dispose(pom);
      end;
   end;
end;

var     i:integer;

begin
   init;
   while not eof do
   begin
      readln(i);
      enqueue(i);
   end;
   writeln;
   while tail<>nil do
   begin
      writeln(dequeue);
   end;

end.