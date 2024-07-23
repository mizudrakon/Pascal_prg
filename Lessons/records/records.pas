program records;

type    book=record
                author:string[30];
                title:string[50];
                stars:integer;
        end;

var     sf:array[1..3]of book;
        t:integer;


procedure input;
var an,tn,sn,s:integer;
    i:string;
begin
   an:=0;
   tn:=0;
   sn:=0;
   readln(i);
   while i<>'done' do
   begin
      if i='author' then
      begin
         readln(i);
         inc(an);
         sf[an].author:=i;
      end else
      if i='title' then
      begin
         readln(i);
         inc(tn);
         sf[tn].title:=i;
      end else
      if i='stars' then
      begin
         readln(s);
         inc(sn);
         sf[sn].stars:=s;
      end else writeln('commands: author, title, stars, done');
      readln(i);
   end;
end;

procedure output(i:integer);
begin
   writeln(i,'. ',sf[i].author,': ',sf[i].title,', stars:',sf[i].stars,';');
end;

begin

   input;
   for t:=1 to 3 do
   begin
     output(t);
   end;


end.