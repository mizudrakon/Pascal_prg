program GameOfLife;
const   max = 128;                                        //this will determine the size of playfield
type    twod = array[1..max] of array[1..max] of integer;
var     field,pom : twod;      //main playfield and its helper twin
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
   if h='help' then       //it understands help
   begin
     helpfile();
     m:=s;
   end
   else if h='insert' then   //it understands insert which is only relevant after the first input
   begin
     next:=true;
   end
   else begin
   i:=1;
   m:=0;
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
      writeln('Wrong input! Must be integer from {1,...,',a,'}');  //anything else just breaks it - there is no place for forgiveness here
      m:=s;
      break;
      end;
      m:=10*m+n;
      inc(i);
      if (m<min) or (a<s) then    //also the number must not be greater then specified ceiling
      begin
           writeln('Wrong input! Must be integer from {1,...,',a,'}');
           m:=0;
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
      write('row (1 - ',max,'):');
      parse(irow,1,max);
   end;
   while icol=0 do
   begin
      if stop then exit;
      write('column (1 - ',max,'):');
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
         end;
   end;
   iendcol:=n;
   read(c);
end;

procedure input();   //just puts all the previous procedures together for initial user input (asks where to put what and does the work)
var     yes:boolean;
        ans:char;
begin
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

procedure partout(var part,size:integer;list:twod); //used only to simplify longout(), if the output is too long for the screen,
var     i,j,s,e:integer;                            //it can be cut into multiple pieces decided by user input
begin
   s:=((part-1)*size)+1;                    //in longout() there are variables like: size - how many symbols are allowed in one partition
   if s < col then s:=col;                                                         //parts - how many partitions will there be
   e:=part*size;                                                                   //part is for the current part that is being deal with
   if e>endcol then e:=endcol;                                             //hopefully: no one will ever need this
   begin
   write('    ');
   j:=s;
   while j<=e do
   begin
      if (j=s) or (j=e) then write(j)
      else write(' ');
      inc(j);
   end;
   writeln;
   i:=row;
   while i<=endrow do
   begin
    j:=s;
    while j<=e do
    begin
       if j = s then
       begin
           if (i=row) or (i=endrow) then   //all the conditions are here to make the table and patterns this results in more clear
           begin
              if i<10 then write(i,'   ')
              else if (i<100) and (i>9) then write(i,'  ')
              else write(i,' ');
              if (list[i,j] > 0) and (list[i,j] < 10) then write(list[i,j])
              else write('.')       // '.' for better visibility

           end
           else begin
             write('    ');
             if (list[i,j] > 0) and (list[i,j] < 10) then write(list[i,j])
             else write('.');
           end;
       end
       else if list[i,j]=10 then write('I') else if (list[i,j] > 0) and (list[i,j] < 10) then write(list[i,j]) else write('.');
       if j = e then
       begin
          writeln;
       end;
       inc(j);
    end;
    inc(i);
   end;
end;
end;

procedure longout(var row,col,endrow,endcol,size:integer;list:twod);  //this is for bigger outputs - only the first and last rows and columns are numbered
var i,j,parts,part:integer;
begin
   while size=0 do                                                //asks what the allowed size is (in a number of symbols - needs experience to answer correctly)
   begin
     writeln('How many symbols fit on your screen horizontaly?');
     parse(size,1,max);
   end;                                                           //if it fits
   writeln;
   if endcol < size then
   begin
     write('   ');
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
              if i<10 then write(i,'   ')
              else if (i<100) and (i>9) then write(i,'  ')
              else write(i,' ');
              if (list[i,j] > 0) and (list[i,j] < 10) then write(list[i,j])
              else write('.')       // '.' for better visibility

           end
           else begin
             write('    ');
             if (list[i,j] > 0) and (list[i,j] < 10) then write(list[i,j])
             else write('.');
           end;
         end
         else if list[i,j]=10 then write('I') else if (list[i,j] > 0) and (list[i,j] < 10) then write(list[i,j]) else write('.');
         if j = endcol then
         begin
           writeln;
         end;
      end;
   end else                                                      //if it doesn't fit
    begin
       if ((endcol-col)/size)>((endcol-col) div size) then
         parts:= ((endcol-col) div size)+1
       else parts:= ((endcol-col) div size);
       part:=1;
       while part<=parts do
       begin
         partout(part,size,list);
         writeln;
         writeln;
         inc(part);
       end;
    end;
end;


//THE GAME ITSELF:  lifechack(cell coordinates)=cell's next state, chcecknbound(), rowork(), life().  The field is looped, so there are numerous special cases for border crossing
function lifecheck(var a,b:integer):integer;     //checks what should be the state of a particular cell by chcecking all its neighbouring cells
var     n,a1,b1:integer;
        c1,c2:integer;
begin
   n:=0;
   c1:=1;
   c2:=1;
   if a=1 then a1:=max else a1:=a-1;        //row index
   if b=1 then b1:=max else b1:=b-1;        //column index
   while c1<=3 do
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
         else if b1=3 then b1:=max
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

procedure rowork(var pr,per,pc,pec:integer;i:integer;var pom:twod); //used to compute next stage for every cell in specific row with checknbound procedure
var j:integer;
begin
   j:=col;
   if j=1 then                                  //special case: first column
   begin
         j:=max;
         checknbound(pr,per,pc,pec,i,j,pom);
         j:=2;
   end;
   j:=j-1;
   while j<=endcol do
   begin
      checknbound(pr,per,pc,pec,i,j,pom);
      inc(j);
      if (j=endcol+1) then
      begin
         if endcol<max then checknbound(pr,per,pc,pec,i,j,pom) //last relevant column that is not maximum
         else begin                                          //max column
           j:=1;
           checknbound(pr,per,pc,pec,i,j,pom);
           break;
         end;
      end;
   end;
end;

//procedures for rewriting some relevant part of 2d array by another 2d array.
//rerow() gets to be nested in rewrite and does all the rows
procedure rerow(var o,p:twod;r,col,endcol:integer);
var     c:integer;
begin
   c:=col;
   if c=1 then
   begin
         c:=max;
         o[r,c]:=p[r,c];
         c:=2;
   end;
   c:=c-1;
   while c<=endcol do
   begin
      o[r,c]:=p[r,c];
      inc(c);
      if (c=endcol+1) then
      begin
         if endcol<max then o[r,c]:=p[r,c]
         else begin
           c:=1;
           o[r,c]:=p[r,c];
           break;
         end;
      end;
   end;
end;

procedure rewrite(var o,p:twod;row,col,endrow,endcol:integer);
var     r:integer;

begin
   r:=row;
   if r=1 then
   begin
     r:=max;
     rerow(o,p,r,col,endcol);
     r:=2;
   end;
   r:=r-1;
   while r<=endrow do
   begin
        rerow(o,p,r,col,endcol);
        inc(r);
        if (r=endrow+1) then
        begin
           if (endrow=max) then
           begin
             r:=1;
             rerow(o,p,r,col,endcol);
             break;
           end else
             rerow(o,p,r,col,endcol);
        end;
   end;
end;



procedure life(var pom:twod);    //uses rowork to compute the whole field withing the bounderies specified earlier (while changing them for next iterations or writeout)
var     i:integer;
        pr,pc,per,pec:integer;  //helper variables for row, column, endrow, endcolumn
begin
   pr:=max;           //they all start in opposite extremes and are narrowed down
   pc:=max;           //and checked against row,col,endrow,endcol
   per:=1;
   pec:=1;
   i:=row;
   if i=1 then
   begin
     i:=max;
     rowork(pr,per,pc,pec,i,pom);
     i:=2;
   end;
   i:=i-1;
   while i<=endrow do
   begin
        rowork(pr,per,pc,pec,i,pom);
        inc(i);
        if (i=endrow+1) then     //special case: the last row is not empty, so the first row also has to be chacked
        begin
           if (endrow=max) then
           begin
             i:=1;
             rowork(pr,per,pc,pec,i,pom);
             break;           //this has to be the last row
           end else      //normal case when everything is somewhere in the open
             rowork(pr,per,pc,pec,i,pom);
        end;
   end;
   rewrite(field,pom,row,col,endrow,endcol);
   row:=pr;
   col:=pc;
   endrow:=per;
   endcol:=pec;
   //field:=pom;   //original field is rewritten by the temporary one
end;

//main part where it all goes together:
var    gen,size:integer;

begin
  row:=max;                              //all properties start in extremes that will get narrowed down
  col:=max;
  endrow:=1;
  endcol:=1;
  writeln('Hello, welcome to GGS!');      //obligatory welcome
  writeln('Type "help" to see tutorial'); //just so people know there is help (and can be called almost anywhere in the program)
  stop:=false;
  next:=true;
  while stop=false do                //program has to be eventually stopped... it doesn't stop by itself (you can always ask for nex generation or add some more pattersn)
  begin
    if stop then Exit;
    if next=true then                 //next is property
    begin
       input();
       next:=false;
    end;
    if stop then Exit;
    gen:=-1;
    while gen=-1 do                 //user is asked to specify number of steps that will be done in the background
    begin
      write('Number of generations?');
      parse(gen,0,3000);          //3000 is maximum in one go, can be changed
      if stop=true then exit;
      if next=true then break;
    end;
    if next=false then
    begin
      while gen>0 do
      begin
         life(pom);         //LIFE function!!!
         gen:=gen-1;
      end;
      writeln;
      if endcol-col<70 then writeout(row,col,endrow,endcol,field)  //two procedures to write it out... the limit is 60, could be greater.
      else longout(row,col,endrow,endcol,size,field);
    end;
  end;
end.

