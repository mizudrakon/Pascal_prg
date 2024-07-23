program binary;
var     n,c,b,r:int64; {number, count, binary progression, result}

begin
        readln(n);
        c:=1;
        b:=1;
        r:=0;
        if (n >= 0) and (n < 2) then writeln(n);
        if (n < 0) then writeln('ERROR') else
        begin
                while n > 1 do begin
                        c := c*10;
                        b := b*2;
                        if (2*b) > n then begin
                                r := r + c;
                                n := n - b;
                                b := 1;
                                c :=1
                        end;
                        if n = 1 then r := r + n;
                end;
        writeln(r);
        end;
end.
