program testling;
var   f:text;
        c:char;

begin
      assign(f,'help');
      reset(f);
      while not eof(f) do
      begin
         read(f,c);
         write(c);
      end;
end.
