program orientace;
{popis: robot stoji v pocatku soustavy souradnice(0,0,0),
        v pravo: x+,
        nahoru: y+,
        dopredu: z+
        prikazy pro robota:
                F - forward
                otoceni  (turn 90 deg):
                L - left
                R - right
                U - up
                D - down
                < - left side
                > - right side

        input: retezec prikazu v radku za sebou ukonceny'.' napr FFLFRF<FRFUFF.
        vystup: trojce cisel udavajici akt polohu napr 0 0 1 po kazdem jednotlivem prikazu}
type    dir=(n,w,s,e);
        turning=(r,l,tu,td);
var     smer:dir;
        turn:turning;
        pozice:array[1..3] of integer;
        i:integer;
        c:char;

procedure otoc(var x:turn);

begin

end;


begin
  smer:=n;
  for i:=1 to 3 do pozice[i]:=0;
  while c<>'.' do
  begin
     read(c);
     if c='F' then
        case smer of
        n: inc(pozice[3]);
        e: dec(pozice[1]);
        s: dec(pozice[3]);
        w: inc(pozice[1]);
        u: inc(pozice[2]);
        d: dec(pozice[2]);
        end;







  end;

end.