program GameOfLife;

const   max = 512;                                        //the field is 512x512
type    twod = array[1..max] of array[1..max] of integer;
var     field : twod;
        stop,next:boolean;                 //stop is used to stop the program by appropriate input
        row,col,endrow,endcol:integer;  //are used to limit the relevant part of the field
        f:text;

//PROCEDURES USED TO MANAGE USER INPUT: parse(output variable,ceiling), position(), readmatrix() and input()-combines them together
var     irow,icol:integer;
        iendrow,iendcol:integer;    //temporary i-variants... were just easier to declare globablly

procedure helpfile(); //help file with instructions
var     ch:char;
begin
      writeln;
      assign(f,'help');
      reset(f);
      while not eof(f) do
      begin
         read(f,ch);
         write(ch);
      end;
      close(f);
      writeln;
end;


procedure parse(var s:integer;min,a:integer); //used to make sense of short user input required as instructions
var     h:string;
        n,i,m:integer;

begin
   readln(h);
   m:=0;
   if h='help' then
   begin
     helpfile();
     m:=s;
   end
   else if h='insert' then
   begin
     next:=true;
     m:=s;
   end
   else begin
     i:=1;
     while i<=length(h) do      //it reads the whole input
     begin
        if (h[i]='s') or (h[i]='S') then   //'s', 'S' or anything resembling 'stop' is used to stop the program
        begin
           stop:=true;
           exit;
        end
        else if (ord(h[i])>=ord('0')) and (ord(h[i])<=ord('9')) then  //integers are used to make up the final number
          n:=ord(h[i])-ord('0')
        else begin
          writeln('Wrong input! Must be integer from {',min,',...,',a,'}');  //anything else just breaks it - there is no place for forgiveness here
          m:=s;
          break;
        end;
        m:=10*m+n;
        inc(i);
        if (m<min) or (m>a) then    //also the number must not be greater then specified ceiling
        begin
           writeln('Wrong input! Must be integer from {',min,',...,',a,'}');
           m:=s;
           break;
        end;
     end;
   end;
   s:=m;
end;

procedure position();    //uses parse procedure to MAKE user state coordinates of the upmost leftmost point of a square containing desired pattern
begin
   irow:=0;
   icol:=0;
   writeln('Please define the fist row and colum of the pattern:');
   while irow=0 do
   begin
      if stop then exit;
      write('row (1 - 512):');
      parse(irow,1,max);
   end;
   while icol=0 do
   begin
      if stop then exit;
      write('column (1 - 512):');
      parse(icol,1,max);
   end;
end;

procedure readmatrix();  //procedure that reads user input of a pattern and places it into the field.
var     i,j:integer;   //i is row, j is column index
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
   while (i < iendrow+1) do
   begin
         read(c);
         if (ord(c)>=ord('0')) and (ord(c)<=ord('9')) then  //It accepts number 0 for specified dead cells, 1-9 for cells with specified durability (9 means 9 generations of slowly dying without hope)
         begin
            field[i,j]:=ord(c)-ord('0');
            inc(j);
         end
         else if (c='x') or (c='n') or (c='X') or (c='N') then inc(j)     // 'x' or 'n' marks no change
         else if (c='e') or (c='E') or (j=max+1) then              //'e'marks the end of input for specific row
         begin
           inc(i);
           if n<j-1 then n:=j-1;
           j:=icol;
         end
         else if (c='i') or (c='I') then          // 'I' is for immortal cells, which are stored as 10 in the matrix
         begin
            field[i,j]:=10;     //immortal cell
            inc(j);
         end
         else if (c='q') or (c='s') or (c='Q') or (c='S') then  //'s' or 'q' can be used to stop input procedure at the current point, it will stop anyway if the count reaches [max,max]
         begin
            if n<j then n:=j;
            iendrow:=i;
            break;
         end
         else if c='h' then
         begin
           helpfile(); //I just want help to be awaylable anywhere
         end;
   end;
   iendcol:=n-1;
   read(c);
end;

procedure input();   //just puts all the previous procedures together for initial user input (asks where to put what and does the work)
var     yes:boolean;
        ans:char;
begin
   row:=max;
   col:=max;
   endrow:=1;
   endcol:=1;
   yes:=true;
   while yes do
   begin
      position();
      if stop then exit;
      readmatrix();
      if row>irow then row:=irow;
      if col>icol then col:=icol;
      if endcol<iendcol then endcol:=iendcol;
      if endrow<iendrow then endrow:=iendrow;
      while yes do
      begin
         write('Do you wish to insert another pattern? (Y/N):'); //you can insert as many patterns as you wish
         readln(ans);                            //simpler answer analyzing system = every wrong answer is ignored
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
         end
         else if (ans='h') then helpfile();
      end;
   end;
end;

//WRITEOUT PROCEDURES: writeout(),longout() (the arguments are mostly useful for debugging)
//there are two procedures to write out the relevant part of the field based on it's size
procedure writeout(var row,col,endrow,endcol:integer;list:twod);   //this will be used for smaller fields
var i,j:integer;                                                   //every row and column is numbered
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
       if (list[i,j] > 0) and (list[i,j] < 10) then write(list[i,j],'  ')
       else if list[i,j]=10 then write('I  ') else write('.  ');       // '.' instead of 0 for better visibility
       if j = endcol then
       begin
          writeln;
          writeln;
       end;
    end;
end;

procedure longout(var row,col,endrow,endcol:integer;list:twod);  //this is for bigger outputs - only the first and last rows and columns are numbered
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
           if (i=row) or (i=endrow) then
           begin
              if (list[i,j] > 0) and (list[i,j] < 10) then write(i,' ',list[i,j]) else write(i,' .')       // '.' for better visibility
           end
           else if (list[i,j] > 0) and (list[i,j] < 10) then write('  ',list[i,j])
           else write('  .');
       end
       else if list[i,j]=10 then write('I') else if (list[i,j] > 0) and (list[i,j] < 10) then write(list[i,j]) else write('.');
       if j = endcol then
       begin
          writeln;
       end;
    end;
end;

//THE GAME ITSELF:  lifechack(cell coordinates)=cell's next state, chcecknbound(), rowork(), life().  The field islooped, so there are numerous special cases
function lifecheck(var a,b:integer):integer;     //checks what should be the state of a particular cell by chcecking all its neighbouring cells
var     n,a1,b1:integer;
        c1,c2:integer;
begin
   n:=0;
   c1:=1;
   c2:=1;
   if a=1 then a1:=max else a1:=a-1;        //cells in the first row or column also need cells with opposite coordinates to determine their future
   if b=1 then b1:=max else b1:=b-1;
   while c1<4 do
   begin
      if field[a1,b1]>0 then inc(n);      //n counts how many of the nine cells are alive
      inc(c2);
      if b1=max then b1:=1 else inc(b1);
      if c2=4 then
      begin
         inc(c1);
         c2:=1;
         if b1=1 then b1:=max-2
         else if b1=2 then b1:=max-1
         else b1:=b1-3;
         if a1=max then a1:=1 else inc(a1);
      end;

   end;
   if n=3 then       //3 living cells mean that the central cell will live
   begin
      if field[a,b]=0 then lifecheck:=1
      else lifecheck:=field[a,b];
   end
   else if n=4 then lifecheck:=field[a,b]   //4 means it remains the same
   else begin
      if ((0<field[a,b]) and (field[a,b]<10)) then lifecheck:=(field[a,b]-1)
      else if field[a,b]=10 then lifecheck:=field[a,b] else lifecheck:=0;      //everything else means it will die (or decay)
   end;
end;

procedure checknbound(var pr,per,pc,pec,i,j:integer;var pom:twod);  //executes lifecheck and checks if the borders of relevance were changed
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

procedure rowork(var pr,per,pc,pec:integer;i:integer; var pom:twod); //used to compute next stage for every cell in specific row with checknbound procedure
var j:integer;
begin
   j:=col;
   if j=1 then
   begin
         j:=max;
         checknbound(pr,per,pc,pec,i,j,pom);
         j:=1;
   end else j:=col-1;
   while j<=endcol do
   begin
      checknbound(pr,per,pc,pec,i,j,pom);
      inc(j);
   end;
   if j=max+1 then j:=1;
   checknbound(pr,per,pc,pec,i,j,pom);
end;

procedure life();    //uses rowork to compute the whole field withing the bounderies specified earlier (while changing them for next iterations or writeout)
var     pom:twod;  //changes are first applied to a temporary two dimensional field so the original remains intact as long as neccesarry
        i:integer;
        pr,pc,per,pec:integer;  //helper variables for row, column, endrow, endcolumn
begin
   if row>1 then i:=row-1 else i:=1;
   pr:=max;           //they all start in opposite extremes and are narrowed down
   pc:=max;
   per:=1;
   pec:=1;
   while i<=(endrow+1) do
   begin
      if (row=1) and (i=1) then         //special case: starts on top so the last row has to be also chacked
      begin
         i:=max;
         rowork(pr,per,pc,pec,i,pom);
         i:=1;
         rowork(pr,per,pc,pec,i,pom);
      end
      else if (i=endrow+1) and (endrow=max) then     //special case: the last row is not empty, so the first row also has to be chacked
      begin
         i:=1;
         rowork(pr,per,pc,pec,i,pom);
         break;           //this has to be the last row
      end else begin      //normal case when everything is somewhere in the open
         rowork(pr,per,pc,pec,i,pom);
      end;
      inc(i);
   end;
   row:=pr;
   col:=pc;
   endrow:=per;
   endcol:=pec;
   field:=pom;   //original field is rewritten by the temporary one
end;

//main part where it all goes together:
var     a:string;
        gen:integer;

begin
  writeln('Hello, welcome to GGS!');        //obligatory greetings
  writeln('Type "help" to see tutorial');
  stop:=false;
  next:=true;
  //input();
  while stop=false do
  begin
    if next=true then
    begin
       input();
       next:=false;
    end;
    if stop then Exit;
    gen:=-1;
    while gen=-1 do
    begin
      write('Number of generations?');
      parse(gen,0,512);
      if stop=true then exit;
      if next=true then break;
    end;
    if next=false then
    begin
      while gen>0 do
      begin
         life();
         gen:=gen-1;
      end;
      if endcol-col<60 then writeout(row,col,endrow,endcol,field)
      else longout(row,col,endrow,endcol,field);
    end;
  end;
end.

