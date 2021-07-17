program Autos;
uses crt;
const
tarifabase=25000;
var
Kilometros,costoKilometroRecorrido,opcion,costo: integer;
begin
writeln('Coloque 1 si no rebaso los 300 Km');
writeln('Coloque 2 si rebaso los 300 Km pero no supero los 1000 Km');
writeln('Coloque 3 si rebaso los 1000 Km');
readln(opcion);

case opcion of
  1:
     writeln('Se cancelaran ', tarifabase, ' Bs.');
  2: begin
       writeln('Cuantos kilometros recorrio: ');
       readln(Kilometros);
       costoKilometroRecorrido := kilometros * 8500;
       costo := tarifabase + costoKilometroRecorrido;
       writeln('Se cancelaran ', costo, ' Bs.');
     end;
  3: begin
       writeln('Cuantos kilometros recorrio: ');
       readln(Kilometros);
       costoKilometroRecorrido := kilometros * 6500;
       costo := tarifabase + costoKilometroRecorrido;
       writeln('Se cancelaran ', costo, ' Bs.');
     end;
else
  writeln('Las unicas opciones disponibles son 1, 2 y 3');
end;
readln;
end.
