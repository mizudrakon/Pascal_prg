type    pmag=^mag;
        mag=record
                val:string;
                next:pmag;
        end;
var     head:pmag;
        bullet:string;

procedure init;
begin
   head:=nil;
end;

procedure push(b:string);
var pom:pmag;
begin
   new(pom);
   pom^.val:=b;
   pom^.next:=head;
   head:=pom;
end;

function pop:string;
var pom:pmag;
begin
   pom:=head;
   if head <> nil then
   begin
      pop:=head^.val;
      head:=pom^.next;
      dispose(pom);
   end
   else begin
      writeln('error!');
   end;

end;

var n:integer;
begin
   init;
   while not eof do
   begin
      readln(bullet);
      push(bullet);
   end;
   writeln('Get rady!');
   while true do
   begin
      writeln(head^.val);
      pop;
      if head=nil then break;
   end;
   dispose(head);
end.