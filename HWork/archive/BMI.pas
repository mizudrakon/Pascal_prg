program BMI;
var     w,h,r:real; {weight, height, result}

begin
   read(w);
   read(h);
   r := w/(h*h);
   writeln(r:0:2);
end.