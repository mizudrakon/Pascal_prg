program GameOfLife;

const   max = 512;

var     field : array[1..max]of array[1..max]of integer;
        stop:boolean;

//writeout procedure variables
var     row,col,endrow,endcol:integer;


//input procedures:
var     irow,icol:integer;
        iendrow,iendcol:integer;

procedure parse(var s:integer);
var     h:string;
        n,i:integer;

begin
   readln(h);
   i:=1;
   while i<=length(h) do
   begin
      if (h[i]='s') or (h[i]='S') or (h='stop') then
      begin
          stop:=true;
          exit;
      end
      else if (ord(h[i])>=ord('0')) and (ord(h[i])<=ord('9')) then
         n:=ord(h[i])-ord('0')
      else begin
      writeln('Wrong input! Must be integer from {1,...,512}');
      break;
      end;
      s:=10*s+n;
      inc(i);
      if (s<1) or (s>max) then
      begin
           writeln('Wrong input! Must be integer from {1,...,512}');
           s:=0;
           break;
      end;
   end;
end;

procedure position();
begin
   irow:=0;
   icol:=0;
   writeln('Please define the fist row and colum of the pattern:');
   while irow=0 do
   begin
      if stop then exit;
      write('row (1 - 512):');
      parse(irow);
   end;
   while icol=0 do
   begin
      if stop then exit;
      write('column (1 - 512):');
      parse(icol);
   end;
end;

procedure readmatrix();
var     i,j:integer;
        c:char;
        n:integer;
begin
   if stop then Exit;
   writeln('Insert your pattern line by line (mark "e" the end of each line and "s" the end of the pattern):');
   iendrow:=max;
   iendcol:=max;
   i:=irow;
   j:=icol;
   n:=1;
   while (i < iendrow+1) do        //what happens to the field when different things are read
   begin
         read(c);
         if (ord(c)>=ord('0')) and (ord(c)<=ord('9')) then
         begin
            field[i,j]:=ord(c)-ord('0'); //number
            inc(j);
         end
         else if (c='x') or (c='n') or (c='X') or (c='N') then inc(j)         //no change
         else if (c='e') or (c='E') or (j=max+1) then              //new line
         begin
           inc(i);
           if n<j-1 then n:=j-1;
           j:=icol;
         end
         else if (c='i') or (c='I') then
         begin
            field[i,j]:=10;     //immortal cell
            inc(j);
         end
         else if (c='q') or (c='s') or (c='Q') or (c='S') then
         begin
            if n<j then n:=j;
            iendrow:=i;
            break;  //end of input
         end;
   end;
   iendcol:=n;
   read(c);
end;

procedure input();
var     yes:boolean;
        ans:char;
begin
   row:=512;
   col:=512;
   endrow:=1;
   endcol:=1;
   yes:=true;
   while yes do
   begin
      position();
      if stop then exit;
      readmatrix();
      if row>irow then row:=irow;                  //rows and cols used for writeout
      if col>icol then col:=icol;
      if endcol<iendcol then endcol:=iendcol;
      if endrow<iendrow then endrow:=iendrow;
      while yes do
      begin
         write('Do you wish to insert another pattern? (Y/N):');
         readln(ans);
         if (ans='y')or(ans='Y') then break
         else if (ans='n')or(ans='N') then
         begin
             yes:=false;
             break;
         end
         else if (ans='s')or(ans='S') then
         begin
            stop:=true;
            exit;
         end;
      end;
   end;
end;


//procedures to write out the rusults
procedure writeout(var row,col,endrow,endcol:integer);   //if it is shor enouhg to fit on my screen
var i,j:integer;
begin
   write('    ');
   for j:=col to endcol do
   begin
      if j<10 then write(j,'  ')
      else if (j>9) and (j<100) then write(j,' ')
      else write(j);
   end;
   writeln;
   for i:=row to endrow do
    for j:=col to endcol do
    begin
       if j = col then
       begin
           if i<10 then write(i,'   ') else
           if (i<100) and (i>9) then write(i,'  ')
           else write(i,' ');
       end;
       if field[i,j] < 10 then write(field[i,j],'  ')
       else write('I  ');
       if j = endcol then
       begin
          writeln;
          writeln;
       end;
    end;
end;

procedure longout(var row,col,endrow, endcol:integer);  //if it is larger
var i,j:integer;
begin
   write('  ');
   for j:=col to endcol do
   begin
      if (j=col) or (j=endcol) then write(j)
      else write(' ');
   end;
   writeln;
   for i:=row to endrow do
    for j:=col to endcol do
    begin
       if j = col then
       begin
           if (i=row) or (i=endrow) then write(i,' ',field[i,j])
           else write('  ',field[i,j]);
       end
       else if field[i,j]=10 then write('I') else write(field[i,j]);
       if j = endcol then
       begin
          writeln;
       end;
    end;
end;


//The game itself:
function lifecheck(a,b:integer):integer;     //checks what should be the state of a particular cell
var     n,a1,b1:integer;
        c1,c2:integer;
begin
   n:=0;
   c1:=1;
   c2:=1;
   if a=1 then a1:=max else a1:=a-1;
   if b=1 then b1:=max else b1:=b-1;
   while c1<4 do
   begin
      if field[a1,b1]>0 then inc(n);
      if b1=max then b1:=1 else inc(b1);
      inc(c2);
      if c2=4 then
      begin
         inc(c1);
         c2:=1;
         if b1=1 then b1:=max-1
         else if b1=2 then b1:=max
         else b1:=b1-3;
         if a1=max then a1:=1 else inc(a1);
      end;
   end;

   if (n<3) and (4<n) then       //then cell should die or get older
      if (0<field[a,b]) and (field[a,b]<10) then field[a,b]:=field[a,b]-1
   else if n=3 then if field[a,b]=0 then inc(field[a,b]); //a new cell is born or living cell should survive
end;

procedure life();    //finds the next state of the field
var     pom:array[1..max] of array[1..max] of integer;
        i,j:integer;
        pr,pc,per,pec:integer;
begin
   if row>1 then i:=row-1 else i:=1;
   pr:=max;
   pc:=max;
   per:=1;
   pec:=1;
   while i<endrow+2 do
   begin
      if col>1 then j:=col-1 else j:=1;
      if (row=1) and (i=1) then         //special case: starts on top so i has to be max
      begin
         i:=max;
         if (j=1) and (col=1) then  //special case: corner
         begin
            j:=max;
            pom[i,j]:=lifecheck(i,j);
            if lifecheck(i,j)>0 then
            begin
                pec:=max;
                per:=max;
            end;
            j:=col;
            while j<=endcol do
            begin
               pom[i,j]:=lifecheck(i,j);
               if lifecheck(i,j)>0 then
               begin
                  per:=i;
                  if j<pc then pc:=j;
                  if j>pec then pec:=j;
               end;
               inc(j);
            end;
            if endcol<max then
            begin
               pom[i,endcol+1]:=lifecheck(i,endcol+1);    //endcol<max
               if lifecheck(i,endcol+1)>0 then
               begin
                  per:=i;
                  pec:=endcol+1;
               end;
            end;
            //j:=1;
         end else begin
            for j:=col to endcol do
            begin
               pom[i,j]:=lifecheck(i,j);
               if lifecheck(i,j)>0 then
               begin
                  per:=i;
                  if j<pc then pc:=j;
                  if j>pec then pec:=j;
               end;
            end;
            //j:=col;
            if endcol=max then
            begin
               pom[i,1]:=lifecheck(i,1);
               if lifecheck(i,1)>0 then
               begin
                  per:=i;
                  if 1<pc then pc:=1;
               end;
            end;
         end;

         i:=1;                          //NOW ALL OF IT AGAIN for i=1
         if (j=1) and (col=1) then
         begin
            j:=max;
            pom[i,j]:=lifecheck(i,j);
            if lifechcek(i,j)>0 then pec:=max;
            for j:=col to endcol do
            begin
               pom[i,j]:=lifecheck(i,j);
               if lifecheck(i,j)>0 then
               begin
                  if j<pc then pc:=j;
                  if j>pec then pec:=j;
                  if 1<pr then pr:=1;
               end;
            end;
            if endcol<max then
            begin
               pom[i,endcol+1]:=lifecheck(i,endcol+1);
               if lifecheck(i,endcol+1)>0 then pec:=endcol+1;
            end;
            //j:=1;
         end else begin
            for j:=col to endcol do
            begin
               pom[i,j]:=lifecheck(i,j);
               if lifecheck(i,j)>0 then
               begin
                  if j<pc then pc:=j;
                  if j>pec then pec:=j;
                  if 1<pr then pr:=1;
               end;
            end;
            //j:=col;
            if endcol=max then
            begin
               pom[i,1]:=lifecheck(i,1);
               if lifecheck(i,1)>0 then
               begin
                  if j<pc then pc:=j;
                  if j>pec then pec:=j;
                  if 1<pr then pr:=1;
               end;
            end;
         end;           //i is 1 here
      end

      else if (i=endrow+1) and (endrow=max) then     //WHAT IF ENDROW IS max
      begin
         i:=1;
         if (j=1) and (col=1) then
         begin
            j:=max;
            pom[i,j]:=lifecheck(i,j);
            if lifechcek(i,j)>0 then pec:=max;
            for j:=col to endcol do
            begin
               pom[i,j]:=lifecheck(i,j);
               if lifecheck(i,j)>0 then
               begin
                  if j<pc then pc:=j;
                  if j>pec then pec:=j;
                  if 1<pr then pr:=1;
               end;
            end;
            if endcol<max then
            begin
               pom[i,endcol+1]:=lifecheck(i,endcol+1);
               if lifecheck(i,endcol+1)>0 then
               begin
                  pec:=endcol+1;
                  if 1<pr then pr:=1;
                  if j<pc then pc:=j;
               end;
            end;
            //j:=1;
         end else begin
            for j:=col to endcol do
            begin
               pom[i,j]:=lifecheck(i,j);
               if lifecheck(i,j)>0 then
               begin
                  if j<pc then pc:=j;
                  if j>pec then pec:=j;
                  if 1<pr then pr:=1;
               end;
            end;
            //j:=col;
            if endcol=max then
            begin
               pom[i,1]:=lifecheck(i,1);
               if lifecheck(i,1)>0 then
               begin
                  if j<pc then pc:=j;
                  if j>pec then pec:=j;
                  if 1<pr then pr:=1;
               end;
            end;
         end;
         break;             //Has to be the last row to check so break
      end

      else if (j=1) and (col=1) then                 //special case: starts at extreme left
      begin
            j:=max;
            pom[i,j]:=lifecheck(i,j);
            if lifechcek(i,j)>0 then
            begin
                pec:=max;
                if i<pr then pr:=i;
                if i>per then per:=i;
                if j<pc then pc:=j;
                if j>pec then pec:=j;
            end;
            for j:=1 to endcol do
            begin
               pom[i,j]:=lifecheck(i,j);
               if lifecheck(i,j)>0 then
               begin
                  if i<pr then pr:=i;
                  if i>per then per:=i;
                  if j<pc then pc:=j;
                  if j>pec then pec:=j;
               end;
            end;
      end
      else begin
        while j<=endcol do
        begin
          pom[i,j]:=lifecheck(i,j);
          if lifecheck(i,j)>0 then
          begin
             if i<pr then pr:=i;
             if i>per then per:=i;
             if j<pc then pc:=j;
             if j>pec then pec:=j;
          end;
          inc(j);
        end;
        if endcol=max then
        begin
               pom[i,1]:=lifecheck(i,1);
               if lifecheck(i,1)>0 then
               begin
                 if i<pr then pr:=i;
                 if i>per then per:=i;
                 if j<pc then pc:=j;
                 if j>pec then pec:=j;
               end;
        end else begin
               pom[i,endcol+1]:=lifecheck(i,endcol+1);
               if lifecheck(i,endcol+1)>0 then
               begin
                 pec:=endcol+1;
                 if i>per then per:=i;
                 if i<pr then pr:=i;

               end;
        end;
      end;
      inc(i);
   end;
   row:=pr;
   col:=pc;
   endrow:=per;
   endcol:=pec;
end;

var     a:string;
//MAIN
begin
stop:=false;
input();
if stop then Exit;
{if endcol-col<60 then
   writeout(row,col,endrow,endcol)
else longout(row,col,endrow,endcol);}
writeln('do it?');
readln(a);
if a='y' then
  begin
   life();
   if endcol-col<60 then
   writeout(row,col,endrow,endcol)
   else longout(row,col,endrow,endcol);
  end;
end.

