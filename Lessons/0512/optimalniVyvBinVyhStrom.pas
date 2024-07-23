uses trideni {unit s tridicimi funkcemi}
const   max=1000;
type    koren=^prvek;
        prvek=record
                hod:integer;
                left,right:koren;
        end;
        mojepole=array[1..max]of integer;
var     mp:mojepole;

function postavovbvs(a:mojepole;odkud,kam:integer):koren;  {postav vyvazeny binarni vyhledavaci strom}
var     im:integer; {index medianu}
        ko:koren;
begin
  if odkud<=kam then
  begin
   im:=(odkud+kam) div 2;
   new(ko);
   ko^.hod:=mp(im);
   ko^.left:=postavovbvs(a,odkud,im-1);
   ko^.right:==postavovbvs(a,im+1,kam);
   postavovbvs:=ko;
  end else
   postavovbvs:=nil;
end;
var     i:integer;
        s:koren;
begin
    for i:1 to max do read(mp[i]);
    quicksort(mp);
    s:=postavovbs(mp,1,max);
end.