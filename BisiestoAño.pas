program Bisiesto;
uses crt;
var
A: integer;
begin

writeln('Introduca un A�o: ');
readln(A);

if A < 0 then
  writeln('UN A�O NO PUEDE SER NEGATIVO')
else
  begin
    if (A mod 4 = 0) and (A mod 100 <> 0) then
      writeln('El a�o es bisiesto')
    else
      begin
        if (A mod 4 <> 0) and (A mod 100 = 0) then
          writeln('El a�o no es bisiesto')
        else
          begin
            if (A mod 400 = 0) and (A mod 100 = 0) then
              writeln('El a�o es bisiesto')
            else
               writeln('El a�o no es bisiesto');
          end;
      end;
  end;
readln;
end.
