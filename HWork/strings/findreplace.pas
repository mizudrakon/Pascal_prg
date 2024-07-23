program find_replace;
{popis:
        input:
                1.radek: string k nahrazeni
                2.radek: string, kterym ma byt nahrazen
                3.radek: vstup (velmi dlouhy text, ktery si nelze cely ulozit do array)

        vystup: puvodni text po nahrazeni (1,2)}
var     c:char;
        t:text;
        i:longint;


procedure load(var a:text);
begin
   rewrite(t);
   while not eof do
   begin
      read(c);
      write(t,c);
   end;
   close(t);
end;

procedure writeout(var a:text);
begin
   reset(a);
   while not eof(a) do
   begin
      read(a,c);
      write(c);

   end;
   close(t);
end;

begin
   assign(t,'qwer.txt');
   load(t);
   writeln;
   writeout(t);

end.
