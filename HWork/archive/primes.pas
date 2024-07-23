program primes;
var     prime:array of boolean;
        i,j,n:longint;

begin
   readln(n);
   setlength(prime,n+1);
   for i:=2 to n do prime[i]:=true;
   for i:=2 to n do
   begin
      if prime[i] then
      begin
         write(i,' ');
         j:=2;
         while(i*j <= n) do
         begin
            prime[i*j]:=false;
            inc(j);
         end;
      end;
   end;
end.