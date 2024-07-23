program radixsort;

var k:array[0..9]of list;
    a,i:integer;
begin
   init(s);
   while true do begin
        read(a);
        if a=0 then break;
        push(a,s);
   end;

   for i:=0 to 9 do init(k[i]);

   a:=1;
   while true do begin
        while not empty(s) do begin
                move_head(s,k[(front(s) div a) mod 10]);
                {push(front(s),k[(front(s) div a) mod 10]);
                pop(s);}
        end;
        for i:= 9 downto 0 do
        begin
           prepend_rev(k[i],s);

        end;
        if a<10000 then a:=a*10 else break;
   end;
   while not empt(s) do begin
        writeln(pop(s));
   end;