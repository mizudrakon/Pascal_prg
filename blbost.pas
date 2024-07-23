program nanic;
const   x=57;
        text='padesat sedm';
var     a:integer;
        b:integer;
        c:string;
        d:string;
begin
        write('write something: ');
        readln(c);

        write('another string: ');
        readln(d);

        write('number: ');
        read(a);
        write('another number: ');
        read(b);

        writeln(c, ' and ', a+b, d);
end.
