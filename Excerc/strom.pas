type
         tree=^Ttree;
         Ttree=record
                value:integer;
                parent,left,right:tree;
         end;

procedure Tinit(var t:tree);
begin
   t:=nil;
end;

function Tempty(t:tree):boolean;
begin
   Tempty:=t=nil;
end;

function Tfind(t:tree; v:integer):tree;
var     i:tree;
begin
   if Tempty(t) then Tfind:=nil
   else
     begin
        i:=t;
        while true do
        begin
           if i^.value=v then
           begin
              Tfind:=i;
           end else
           begin
              if v<i^.value then i:=i^.left
              else i:=i^.right;
              if i=nil then begin Tfind:=nil; exit; end;
           end;

        end;
     end;

end;

procedure Tinsert2(var t:tree; v:integer; var c:tree);
var     i:tree;
begin
    if Tempty(t) then
    begin
       new(i);
       t^.value:=v;
       t^.parent:=nil;
       t^.left:=nil;
       t^.right:=nil;
       exit;
    end;
    if t^.value=v then exit;
    if v < t^.value then Tinsert2(t^.left,v,t)
    else Tinsert2(t^.right,v,t);
end;

procedure Tinsert(var t:tree; v:integer);

begin
   Tinsert2(t,v,nil);
end;

procedure Terase(var t:tree; v:integer);
var     i,nm,tmp:tree; {nejblizsi mensi}
begin
   i:=Tfind(t,v);
   if i=nil then exit;
   nm:=i^.left;

   if nm=nil then begin
      if i^.right=nil then
      begin
         if i^.parent<>nil then
            if i=i^.parent^.left then
               i^.parent^.left:=nil
            else
               i^.parent^.right:=nil;
      end;
      end else begin
         if i^.parent<>nil then
            if i=i^.parent^.left then
               i^.parent^.left:=i^.right
            else
               i^.parent^.right:=i^.right;
         end;
         i^.right^.parent:=i^.parent;
      end;
      dispose(i);

      exit;
   end;

   while nm^.right<>nil do nm:=nm^.right;
   i^.value:=nm^.value;
   nm^.value:=v;
   Terase(nm,v);

end;

procedure Tclear(var t:tree);
begin
   while not Tempty(t) do Terase(t, t^.value);
end;

begin
end.