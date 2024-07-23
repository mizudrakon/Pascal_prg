program indexing;
var      i:string;
         a:integer;

begin   {it works now... needed to use else for the second conditional}
        read(i);
        for a:=1 to length(i) do
                begin
                if (ord(i[a])>=ord('A')) and (ord(i[a])<=ord('Z'))
                then i[a]:=char(ord(i[a]) - ord('A') + ord('a')) else
                  if (ord(i[a])>=ord('a')) and (ord(i[a])<=ord('z'))
                  then i[a]:=char(ord('A') + (ord(i[a]) - ord('a')));
                end;
        writeln(i);
end.


begin   {ohlasujeme, jestli i je velke nebo male}
        read(i);
        if (ord(i)>=ord('A')) and (ord(i)<=ord('Z')) then write('velke pismeno');
        if (ord(i)>=ord('a')) and (ord(i)<=ord('z')) then write('male pismeno');
end.
begin   {prirazujeme cislum znaky}
        for i:=0 to 255 do
        begin
                write(chr(i),' ',i:4, ' | ');
                if(i mod 8 = 7) then writeln();
        end;
end.
