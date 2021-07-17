program Proyecto_Los_Simpson;
{Kevin Acosta y Luigi Bastidas}
uses crt;

const
  filasAhorcado = 10;
  columnasAhorcado = 4;

type
  Ahorcado = array[1..filasAhorcado,1..columnasAhorcado] of string;
  Trivia = array[1..10] of string;
  TriviaMatriz = array[1..20,1..20] of string;
var
  Eleccion,Resp:char;
  Usuario,UbicaAhorcado,UbicaTrivia,SaliTrivia,SaliAhorcado:string;
  EntradaT,SalidaT:text;
  EntradaA,SalidaA:text;
  PuntajeT,PuntajeAhorcado:text;
  respuesta,verificacion: boolean;
  filas,columnas,contJugadores,LongitudPalabra,Errores,Puntos,Num_Opciones:integer;
  palabrasA: Ahorcado;
  respuestasTrivia: Trivia;
  PreguntasOpcionesTrivia:TriviaMatriz;
  Num: set of char;

{procedure VerificarFilasAhorcado(var EntradaA:text; var filas: integer; var columnas: integer);
  var
    contFilas,contColumnas: integer;
    linea: string;
  begin
    reset(EntradaA);
    contFilas:=0;contColumnas:=0;
    while not(eof(EntradaA)) do
      begin
        readln(EntradaA,linea);
        contFilas:=contFilas+1;
      end;
    filas:=contFilas;
    columnas:=contColumnas;
  end;   }

function validarletra(letra:char):boolean;
  begin
    letra:=lowercase(letra);
    if letra in ['a'..'z'] then
      validarletra:=true
    else
      validarletra:=false;
  end;

procedure ValidarDatosAhorcado (var EntradaA:text;var respuesta:boolean);
var
    Linea,Cadena,Palabra:string;
    LongitudPalabra,Puntos,Errores,T,Codigo,Posicion,control,contLineas,i:integer;
  begin
    reset(EntradaA);control:=1;contLineas:=0;
    respuesta:=true;
    while (not(eof(EntradaA))) and (respuesta = true) do
      begin
        control:=control+1;
        readln(EntradaA,Linea);
        contLineas:=contLineas+1;
        i:=1;cadena:='';
        while Linea[i]<>' ' do
         begin
          Cadena:= Cadena + Linea[i];
          i:=i+1;
         end;
        T:=length(Cadena);
        posicion:=pos(Cadena,Linea);
        val(Cadena,LongitudPalabra,Codigo);
        if Codigo <> 0 then
          respuesta:=false;
        delete(Linea,posicion,T);
        while Linea[1] = ' ' do
          begin
            delete(Linea,1,1);
          end;
        Palabra:='';i:=1;
        repeat
          Palabra:= Palabra + Linea[i];
          i:=i+1;
        until Linea[i] = ' ';

        posicion:=pos(Palabra,Linea);
        T:=length(Palabra)+1;
        delete(Linea,Posicion,T);

        i:=1;Cadena:='';
        repeat
          Cadena:= Cadena + Linea[i];
          i:=i+1;
        until Linea[i] = ' ';
        posicion:=pos(Cadena,Linea);
        T:=length(Cadena)+1;
        delete(Linea,Posicion,T);
        val(Cadena,Puntos,Codigo);
        if Codigo <> 0 then
          respuesta:=false;
        {writeln('Puntos = ',Puntos);}
        {writeln('');}

        Cadena:= Linea[1];
        val(Cadena,Errores,Codigo);
        if Codigo <> 0 then
          respuesta:=false;
        if length(palabra) <> LongitudPalabra then
          respuesta:=false
        else
          begin
           i:=1;
           while ((i<=LongitudPalabra) and respuesta) do
             begin
               respuesta:=validarletra(palabra[i]);
               i:=i+1;
             end;
          end;
      end;
    if contLineas > 10 then
      respuesta:=false;
    close(EntradaA);
  end;

procedure LlenarMatrizAhorcado(var EntradaA:text;var palabrasA:Ahorcado);
  var
    linea,palabra,PuntajeCaracter,LongitudPalabraCaracter,ErroresCaracter:string;
    i,control1,control2,Puntaje,codigo,LongitudPalabra:integer;
  begin
    reset(EntradaA);
    while not(eof(EntradaA)) do
      begin
        for control1:=1 to filasAhorcado do
          begin
            readln(EntradaA,linea);
            control2:=1;
            LongitudPalabraCaracter:='';
            PuntajeCaracter:='';
            while (control2<=columnasAhorcado) do
              begin
                while linea[1] = ' ' do
                 begin
                  delete(linea,1,1);
                 end;
                while linea[1] <> ' ' do
                  begin
                    LongitudPalabraCaracter:=LongitudPalabraCaracter+linea[1];
                    val(LongitudPalabraCaracter,LongitudPalabra,codigo);
                    delete(linea,1,1);
                  end;
                palabrasA[control1,control2]:=LongitudPalabraCaracter;
                control2:=control2+1;
                i:=1;
                palabra:='';
                while linea[1] = ' ' do
                 begin
                  delete(linea,1,1);
                 end;
                i:=1;
                while linea[i] <> ' ' do
                  begin
                    palabra:=palabra+linea[i];
                    i:=i+1;
                  end;
                palabrasA[control1,control2]:=palabra;
                control2:=control2+1;
                delete(linea,1,LongitudPalabra);
                while linea[1] = ' ' do
                 begin
                  delete(linea,1,1);
                 end;
                i:=1;
                while linea[1] <> ' ' do
                  begin
                    PuntajeCaracter:=PuntajeCaracter+linea[i];
                    delete(linea,1,1);
                  end;
                palabrasA[control1,control2]:=PuntajeCaracter;
                control2:=control2+1;
                while linea[1] = ' ' do
                  begin
                    delete(linea,1,1);
                  end;
                ErroresCaracter:=linea[1];
                palabrasA[control1,control2]:=ErroresCaracter;
                control2:=control2+1;
              end;
            end;
      end;
      close(EntradaA);
  end;



procedure imprimirPalabra(palabra:string;Longitud:integer;letras:string);
  var
    control1,control2,Inicio,Fin: integer;
  begin
    Inicio:=1;
    Fin:=length(palabra);
    if Longitud >= 8 then
     begin
       write(palabra[Inicio]);
       for control1:=(Inicio+1) to (Fin-1) do
         begin
           control2:=1;
           while (control2 <= length(letras)) do
             begin
               if letras[control1] = palabra[control1] then
                 begin
                   write(' ',letras[control1],' ');
                   control2:=length(letras) + 5;
                 end;
               control2:=control2+1;
             end;
          if control2 <> length(letras)+6 then
            write(' _ ')
         end;
       write(palabra[Fin]);
     end;
    writeln('');
    if Longitud < 8 then
     begin
       write(palabra[Inicio]);
       for control1:=(Inicio+1) to (Fin-1) do
         begin
           control2:=1;
           while (control2 <= length(letras)) do
             begin
               if letras[control2] = palabra[control1] then
                 begin
                   write(' ',letras[control2],' ');
                   control2:=length(letras) + 5;
                 end;
               control2:=control2+1;
             end;
          if control2 <> length(letras)+6 then
            write(' _ ')
         end;
       write(palabra[Fin]);
     end;
     writeln('');

  end;

function Repeticionletra(palabra: string; letra:char):integer;
  var
    repeticion,control:integer;
  begin
    repeticion:=0;
    for control:=1 to length(palabra) do
      begin
        if palabra[control] = letra then
          repeticion:=repeticion+1;
      end;
    Repeticionletra:=repeticion;
  end;

{function contarFilasPuntaje (var PuntajeAhorcado:text):boolean;
  var
    cont:integer;
    Linea: string;
  begin
    reset(PuntajeAhorcado);
    cont:=0;
    while not(eof(PuntajeAhorcado)) do
      begin
        readln(PuntajeAhorcado,Linea);
        cont:=cont+1;
      end;
    if cont = 5 then
      contarFilasPuntaje:=true;
    if cont <> 5 then
      contarFilasPuntaje:=false;
  end;    }

{procedure PuntajeArchivo(var PuntajeAhorcado:text;PuntajeTotal:integer;Usuario:string);
  var
    verificador: boolean;
  begin
    verificador:=contarFilasPuntaje(PuntajeAhorcado);
    append(PuntajeAhorcado);
    if verificador = false then
     begin
       write(PuntajeAhorcado,Usuario);
       write(PuntajeAhorcado,' ');
       write(PuntajeAhorcado,PuntajeTotal);
       write(PuntajeAhorcado,' Puntos');
       close(PuntajeAhorcado);
     end;
  end;   }

procedure JuegoAhorcado(palabrasA:Ahorcado;Usuario:string;var contJugadores:integer;var PuntajeAhorcado:text);
  var
    respuesta,NumErrores,palabra,letras,Encontrar: string;
    letra:char;
    verificacion:boolean;
    control1,Num_Errores,Puntaje,PuntajeTotal,Longitud,Inicio,Fin,Fin2,aciertos: integer;
  begin
    Append(PuntajeAhorcado);
    respuesta:='S';
    while respuesta = 'S' do
     begin
      Inicio:=1;
      respuesta:='S';
      control1:=1;
      aciertos:=0;
      val(palabrasA[control1,1],Longitud);
      palabra:=palabrasA[control1,2];
      Fin:=length(palabra);
      writeln('');
      PuntajeTotal:=0;
      while (control1<=filasAhorcado) and (respuesta = 'S') do
        begin
          writeln('Usuario = ',Usuario);
          palabra:=palabrasA[control1,2];
          Inicio:=1;
          aciertos:=0;
          letras:=' ';
          NumErrores:=palabrasA[control1,4];
          val(NumErrores,Num_Errores);
          val(palabrasA[control1,3],Puntaje);
          val(palabrasA[control1,1],Longitud);
          Fin2:=length(palabra)-2;
          Encontrar:=copy(palabra,Inicio+1,Fin2);
          imprimirPalabra(palabra,Longitud,letras);
          while ((Num_Errores > 0) and (aciertos < (length(Encontrar)))) do
            begin
              writeln('>>Escriba una letra ');
              readln(letra);
              verificacion:=validarletra(letra);
              if ((pos(letra,letras) = 0) and (verificacion = true)) then
                begin
                  letras:=letras+letra;
                  if pos(letra,Encontrar) = 0 then
                     begin
                       writeln('>>Lo siento, la letra no se encuentra localizada en la palabra');
                       Num_Errores:=Num_Errores-1;
                       writeln('>>Le quedan ',Num_Errores,' intentos');
                       writeln('');
                     end
                  else
                    begin
                     aciertos:=aciertos+Repeticionletra(Encontrar,letra);
                     imprimirPalabra(palabra,Longitud,letras);
                    end;
                end
              else
                writeln('>>La letra no es valida o ya la habia colocado');
            end;

          if Num_Errores = 0 then
            writeln('Perdiste :(, se te acabaron las oportunidades');
            writeln('');
            writeln('  - - - - -');
            writeln('  |');
            writeln('  |');
            writeln('  O');
            writeln(' /|\');
            writeln('  |');
            writeln(' / \');
            writeln('');
          if Num_Errores <> 0 then
            begin
             writeln('FELICIDADES :D gano la partida, Acertaste');
             PuntajeTotal:=PuntajeTotal+Puntaje;
             writeln('Desea avanzar a la siguiente palabra, S=Si N=No: ');
             readln(respuesta);
             respuesta:=upcase(respuesta);
             writeln('respuesta = ',respuesta);
            end;
          control1:=control1+1;
        end;
        contJugadores:=contJugadores+1;
        writeln('Puntaje Total del jugador[',Usuario,'] = ',PuntajeTotal);
        {PuntajeArchivo(PuntajeAhorcado,PuntajeTotal,Usuario); }
     end;
    close(PuntajeAhorcado);
  end;


{function verificarTrivia(var EntradaT:text):boolean;
  var
    Linea,Pregunta,numero: string;
    control,codigo,Num_preguntas,cont,cont2,posicion: integer;
    verificar: boolean ;
  begin
    reset(EntradaT);
    verificar:=true;
    control:=1;
    Num_preguntas:=0;
    while (not(eof(EntradaT)) and (verificar = true)) do
      begin
          cont:=0;
          readln(EntradaT,Linea);
          for control:=1 to length(Linea) do
            begin
              if Linea[control] = '-' then
                cont:=cont+1;
            end;
          if cont = 1 then
            begin
              posicion:=pos('-',Linea);
              delete(Linea,1,posicion+1);
              writeln(Linea);
              control:=1;
              numero:='';
              while Linea[control] <> ' ' do
                begin
                  numero:=numero+Linea[control];
                  control:=control+1;
                end;
              val(numero,Num_preguntas,codigo);
              if codigo = 1 then
                verificar:=false;
              if codigo = 0 then
                begin
                  posicion:=pos(numero,Linea);
                  delete(Linea,1,posicion);
                  cont:=0;
                  for control:=1 to length(Linea) do
                    begin
                      val(Linea[control],Num_preguntas,codigo);
                      if codigo = 0 then
                        cont:=cont+1;
                    end;
                  if cont = 1 then
                    verificar:=false;
                end;
            end;




      end;
    verificarTrivia:=verificar;
  end;}


procedure llenarVector(var respuestasTrivia:Trivia;var EntradaT:text);
  var
    Linea: string;
    posicion,control: integer;
  begin
    reset(EntradaT);
    control:=1;
    while not(eof(EntradaT)) do
      begin
        readln(EntradaT,Linea);
        posicion:=pos('puntos',Linea);
        if posicion <> 0 then
          begin
             delete(Linea,posicion,length(Linea));
             delete(Linea,length(Linea),1);
             respuestasTrivia[control]:=Linea;
             control:=control+1;
          end;
      end;
    close(EntradaT);
  end;

procedure llenarMatrizTrivia(var EntradaT:text;var PreguntasOpcionesTrivia:TriviaMatriz);
  var
    posicion,contcolumnas,contFilas:integer;
    Linea: string;
  begin
    reset(EntradaT);
    contcolumnas:=0;
    contFilas:=1;
    while not(eof(EntradaT)) do
      begin
        readln(EntradaT,Linea);
        posicion:=pos('?',Linea);
        if posicion <> 0 then
          begin
            posicion:=pos('-',Linea);
            delete(Linea,posicion,length(Linea));
            contcolumnas:=contcolumnas+1;
            PreguntasOpcionesTrivia[1,contcolumnas]:=Linea;
            contFilas:=1;
          end;
        if posicion = 0 then
          begin
            posicion:=pos('puntos',Linea);
            if posicion = 0 then
              begin
                contFilas:=contFilas+1;
                PreguntasOpcionesTrivia[contfilas,contcolumnas]:=Linea;
              end;
          end;
      end;
    close(EntradaT);
  end;

{procedure Numero_Opciones(EntradaT:text;var Num_Opciones:integer);
 var
   control: integer;
   Opciones: string;
 begin
   Opciones:='';
   writeln('Linea = ',Linea);
   while not(eof(EntradaT)) do
     begin
       readln(EntradaT,Linea)
   while Linea[1] <> '-' do
     begin
       delete(Linea,1,1);
       writeln('linea = ',Linea);
     end;
   repeat
     delete(Linea,1,1);
   until Linea[1] in ['0'..'9'];

   control:=1;
   while Linea[control] <> ' ' do
    begin
      Opciones:=Opciones+Linea[control];
      control:=control+1;
    end;
   val(Opciones,Num_Opciones);
 end;  }

procedure JuegoTrivia(var EntradaT:text;PreguntasOpcionesTrivia:TriviaMatriz;Num_Opciones:integer;respuestasTrivia:Trivia);
var
  Linea,respuesta,ResUsua,opciones:string;
  contFilas,contColumnas,posicion,control,i,contVector: integer;
  acierto: boolean;
begin
  reset(EntradaT);
  contFilas:=1;contColumnas:=1;contVector:=1;
  repeat
    contFilas:=1;
    if PreguntasOpcionesTrivia[contFilas,contColumnas] = '' then
      writeln('No hay mas preguntas');      //Aqui

    while PreguntasOpcionesTrivia[contFilas,contColumnas] <> '' do
      begin
        writeln(PreguntasOpcionesTrivia[contFilas,contColumnas]);
        contFilas:=contFilas+1;
      end;
    writeln();
    readln(ResUsua);
    control:=2;
    acierto:=false;
    opciones:=respuestasTrivia[contVector];
    writeln('opciones = ',opciones);
    if ResUsua = opciones[1] then
      acierto:=true;
    if acierto = false then
      writeln();
    if acierto = true then
      begin
        writeln('Desea ir a la otra pregunta? S=si o N=no');
        readln(respuesta);
        respuesta:=upcase(respuesta);
        contColumnas:=contColumnas+1;
        contVector:=contVector + 1;
      end;
  until (respuesta = 'N') or (acierto = false);
 close(EntradaT);
 readln;
end;






begin    {Programa principal}
  respuesta:=true;
  Num_Opciones:=0;
  repeat
  clrscr;
  writeln('Muy buenas querido jugador');
  writeln('');
  writeln('Bienvenido a "The Simpsons Games" :D');
  writeln('');
  write('Introduzca su nombre por favor: ');
  readln(Usuario);
  writeln('');
  writeln('Hay 2 opciones para jugar');
  writeln('');
  writeln('Opcion A) Trivia');
  writeln('');
  writeln('Opcion B) Ahorcado');
  writeln('');
  write('Cual desea escoger: ');
  readln(Eleccion);
  Eleccion:= upcase(Eleccion);

  case Eleccion of
  'A': begin
       writeln('---------------------------------');
       writeln('Oh, asi que elegiste esta opcion');
       writeln('---------------------------------');
       writeln('Bienvenido a la Trivia :D');
       writeln('');
       writeln('Aqui podras desafiar todo el conocimiento que poseas de la serie');
       writeln('');
       writeln('Te sientes preparado?');
       writeln('');
       write('Primero, necesito la ruta del archivo por favor: ');
       readln(UbicaTrivia);
       assign(EntradaT,UbicaTrivia);
       llenarMatrizTrivia(EntradaT,PreguntasOpcionesTrivia);
       {verificacion:=verificarTrivia(EntradaT);}
       llenarVector(respuestasTrivia,EntradaT);
       JuegoTrivia(EntradaT,PreguntasOpcionesTrivia,Num_Opciones,respuestasTrivia);
       assign(SalidaT,'C:\ProyectoAlgoritmo\SimpsonTrivia.txt');
       {ImprimirTrivia(EntradaT,'Trivia'); }
       readln;
       end;
  'B': begin
         writeln('---------------------------------');
         writeln('Interesante eleccion');
         writeln('---------------------------------');
         writeln('Bienvenido al Ahorcado :D');
         writeln('');
         writeln('Seras capaz de acertar correctamente?');
         writeln('');
         writeln('Lo descubriremos');
         write('Primero, necesito la fuente del archivo por favor: ');
         readln(UbicaAhorcado);
         assign(EntradaA,UbicaAhorcado);
         ValidarDatosAhorcado(EntradaA,respuesta);
          if respuesta = false then
            writeln();
          if respuesta = true then
           begin
             writeln('Usuario = ',Usuario);
             llenarMatrizAhorcado(EntradaA,palabrasA);
             assign(PuntajeAhorcado,'C:\Proyecto\Mejores 5 Puntajes.txt');
             JuegoAhorcado(palabrasA,Usuario,contJugadores,PuntajeAhorcado);
           end;
         readln;
       end;
  else
     begin
         writeln('---------------------------------');
         writeln('Oh');
         writeln('');
         writeln('Lo siento mucho, no existe la opcion que escogio');
     end;
  end;

 writeln('---------------------------------');
 writeln('Muy bien jugado, felicidades');
 writeln('');
 writeln('Desea volver a jugar? o Hay algun otro jugador?');
 writeln('');
 write('s para Si y n para No: ');
 readln(Resp);
 Resp:= upcase(Resp);
 until (Resp = 'n') or (Resp = 'N');
 readkey;
end.
