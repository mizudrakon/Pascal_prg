program fort;

var     s:list;
        a:integer;
        cmd:string;
begin
   init(s);
   while true do begin
        readln(cmd);

        if cmd='q' then break;
        if cmd='x' then begin
                if empty(s) then writeln('error!')
                else pop(s);
        end;
        if cmd='p' then begin
                if empty(s) then writeln('error!!!');
                else writeln(front(s));
        end;
        if cmd='+' then begin
                if not empty(s) then begin
                        tmp:=pop(s);
                        if not empty(s) then begin
                                push(tmp*pop(s),s);
                                continue;
                        end;
                end;
                writeln('error');
        end else

        if not tryStrToInt(cmd, a) then
                writeln('error!!!!!')
        elsepush(a,s);
        end;
end.