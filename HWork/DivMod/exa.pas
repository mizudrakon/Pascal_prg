
{
  Integer division of long numbers with remainder.

  All numbers are represented by an array of fixed size with one decimal digit
  per array field, together with an accompanying integer "size" that states how
  many valid digits are actually stored in the array.

  Array is ordered so that less-significant digits get lower array indexes.

  E.g. how to represent some integers:
  0    ->  size := 0
  1    ->  a[0]:=1; size:=1;
  2    ->  a[0]:=2; size:=1;
  5000 ->  a[0]:=0; a[1]:=0; a[2]:=0; a[3]:=5; size:=4;

  It doesn't quite matter what's in array fields with index>=size, as those
  should never be used anyway.

  The implemented algorithm is then mostly straightfoward, basically made out
  of iterated subtraction, like this:

  246341234123412341234    --input
 -1230                     --left-shifted divisor
     |  (subtract twice)
     v
     200000000000000000    --partial result (cummulative)
     399234123412341234    --partial remainder
    -1230
        |  (subtract again, three times)
	v
     200300000000000000
     ... etc.
}

type num=array [0..10000] of integer; { 10k is the required limit }

{ variables A (input), B (divisor), and R (result) + their sizes }
var a,b,r:num;
    as,bs,rs,sh: integer;
{ sh represents the current shift of the divisor }


{ shrink

  Convert number with "leading zeroes" to compact&consistent form,
  e.g. 0001230 (size=7) to 1230 (size=4)
  
  We'll keep all numbers in this form to avoid unnecessary confusion. }
procedure shrink(var n:num; var size:integer);
begin
	while (size>0) do begin
		if n[size-1]<>0 then break;
		dec(size);
	end;
end;


{ readnum

  Read a number from the input, store it in output arguments. }
procedure readnum(var out:num; var size:integer);
var 	i:integer;
	n:num;
	c:char;
begin
	i:=0;
	while true do begin
		read(c);
		if    (ord(c)>=ord('0'))
		  and (ord(c)<=ord('9')) then begin
			n[i]:=ord(c)-ord('0');
			inc(i);
		end else if i>0 then break;
	end;

	{ human numbers start with high-radix digits. reverse them. }
	size:=0;
	while i>0 do begin
		out[size]:=n[i-1];
		dec(i);
		inc(size);
	end;

	{ remove leading zeroes }
	shrink(out,size);
end;


{ writenum
  
  Write a number to the output. }
procedure writenum(var n:num; size:integer);
begin
	if size=0 then write(0);
	while size>0 do begin
		write(chr(n[size-1]+ord('0')));
		dec(size);
	end;
	writeln;
end;


{ num_ge                         (= number is _g_reater or _e_qual)

  A function to compare numbers before each division step. Returns true if and
  only if number represented by `a' (of size `as') is greater or equal to
  number `b' shifted left by `bshift' decimals.

  i.e. it should return an equivalent of (A >= B*(10^bshift))

  Example: 333 is greater than 4 with shift 1 (= 40) -> true
       but 333 is less than 4 with shift 2 (= 400) -> false }
function num_ge(
	var a:num; as:integer;
	var b:num; bs:integer;
	bshift:integer):boolean;
begin
	{ asserted for you: bs>0 }

	{ TODO }
	{ hint: as the incoming numbers are properly shrunk, you can
	        rely on the sizes to remove lots of special cases. }
end;


{ expand
  
  Ensure that the `size' of a number is big enough to represent digits on the
  position of 10^idx. Result is unshrinked -- not in standard form!
  
  E.g. expanding number 123 with idx=5 results in 000123. }
procedure expand(var n:num; var size:integer; idx:integer);
begin
	while size<=idx do begin
		n[size]:=0;
		inc(size);
	end;
end;


{ num_inc_idx
  
  Increase a digit on idx-th decimal position in the number.
  
  Equivalent of N := N + 1 * 10^idx }
procedure num_inc_idx(var n:num; var size:integer; idx:integer);
begin
	{ TODO }
	{ hint: use expand function from above }
	{ hint: remember about possible carry }
end;


{ num_sub

  Subtraction. Basically, decrease A by shifted B.
  A := A - B * 10^bshift

  It is ensured (by callers) that the subtraction never underflows
  (i.e. that A is greater than shifted B). }
procedure num_sub(
	var a:num; var as:integer;
	var b:num; bs:integer;
	bshift:integer);
begin
	{ asserted for you:
	  a >= b*10^bshift
	  otherwise this doesn't need to terminate }

	{ TODO }
	{ hint: do not forget to shrink A to remove
	        possible new leading zeroes. }
end;

{ 8< -------------------------------------------------------------- }

begin
	readnum(a, as);
	readnum(b, bs);
	
	rs:=0; { set result size to zero, i.e. R:=0 }
	sh:=0; { sh represents the shift of the number
	         we're currently subtracting. Start with 0 }

	{ increase sh until shifted B is certainly greater than A }
	while num_ge(a,as,b,bs,sh) do inc(sh);

	while true do begin
		{ uncomment for debugging:
		  writeln('shift: ', sh);
		  write('a: '); writenum(a,as);
		  write('b: '); writenum(b,bs);
		  write('r: '); writenum(r,rs);
		  writeln; }

		{ if there's something to subtract on this shift }
		if num_ge(a,as,b,bs,sh) then begin
			num_sub(a,as,b,bs,sh); { ..then do it, }
			num_inc_idx(r,rs,sh);  { increase the result on
			                         that position, }
			{ ... and retry. }
		end
		else { if there was nothing more to subtract, }
		if sh>0 then dec(sh) { then either downshift }
		else break; { or finish, if there's nothing more to do }
	end;
	
	writenum(r,rs); { the accumulated result }
	writenum(a,as); { whatever was left in A is now a proper remainder }
end.
