program Bisiesto;
uses crt;
var
A: integer;
begin

writeln('Introduca un Año: ');
readln(A);

if A < 0 then
  writeln('UN AÑO NO PUEDE SER NEGATIVO')
else
  begin
    if (A mod 4 = 0) and (A mod 100 <> 0) then
      writeln('El año es bisiesto')
    else
      begin
        if (A mod 4 <> 0) and (A mod 100 = 0) then
          writeln('El año no es bisiesto')
        else
          begin
            if (A mod 400 = 0) and (A mod 100 = 0) then
              writeln('El año es bisiesto')
            else
               writeln('El año no es bisiesto');
          end;
      end;
  end;
readln;
end.
