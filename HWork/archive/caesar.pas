program caesar;
const   d:integer=26;
var     i:string;
        n,c:integer;

begin
   readln(n);
   readln(i);
   for c:=1 to length(i) do
      begin
      //if (ord(i[c]) >= ord('A')) and (ord(i[c]) <= ord('Z')) then
        //begin
          //i[c] := char(ord(i[c]) - ord('A') + ord('a'))
        //end;
      if (ord(i[c]) >= ord('a')) and (ord(i[c]) <= ord('z')) then
        begin
        if (n > 0) then
          begin
             if n > d then n := n mod d;
             if (ord(i[c])+n) <= ord('z') then
               i[c] := char(ord(i[c]) + n)
             else
               begin
               i[c] := char((ord(i[c])+n)-ord('z')+ord('z')-1)
               end
          end else
          begin
             if n < (-d) then n := -((-n) mod d);
             if (ord(i[c])+n) >= ord('a') then
               i[c] := char(ord(i[c])+n)
             else
               begin
               i[c] := char(ord('z')+((ord(i[c])-ord('a'))+n)+1)
               end
          end;
        end;
      end;
   writeln(i);
end.
