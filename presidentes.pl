% 1) Los presidentes

periodo(alfonsin,fecha(10,12,1983),fecha(7,7,1989),retornoDemocracia).
periodo(menem,fecha(8,7,1989),fecha(9,12,1995),revolucionProductiva).
periodo(menem,fecha(10,12,1995),fecha(9,12,1999),laReeleccion).
periodo(puerta,fecha(21,12,2001),fecha(23,12,2001),pasoFugaz).
% Se le agrega una descripcion inventada para identificiar a cada
% periodo presidencial. Tambien se podria haber utilizado la fecha de
% inicio o final, pero como ya hay muchas fechas, este nuevo dato le
% aporta legibilidad

% a) Quiénes fueron presidente por más de un período (sin importar si
% fueron sucesivos o no)

masDeUnPeriodo(Presidente):-
    periodo(Presidente, _ , _, Periodo1),
    periodo(Presidente, _, _, Periodo2),
    Periodo1 \= Periodo2.

% b) En una fecha dada, quién era el presidente.

presidenteEnFecha(Presidente, Fecha, Periodo):-
    periodo(Presidente, Inicio, Fin, Periodo),
    anterior(Inicio, Fecha),
    anterior(Fecha, Fin).

anterior(fecha(_,_,A1),fecha(_,_,A2)):-  A1 < A2.
anterior(fecha(_,M1,A),fecha(_,M2,A)):-  M1 < M2.
anterior(fecha(D1,M,A),fecha(D2,M,A)):-  D1 =< D2.


%2 Acciones de gobierno

accion(juicioJuntas,fecha(9,12,1985),buenosAires,30000000).
accion(hiperinflacion,fecha(1,1,1989),buenosAires,10).
accion(privatizacionYPF,fecha(3,5,1992),campana,1).

% a) Si un determinado acto de gobierno fue bueno.

buenaAccion(Accion):-
    accion(Accion,_,_,Beneficiados),
    Beneficiados > 10000.

% b) Si un presidente hizo algo bueno, es decir, si en alguno de sus
% periodos de gobierno hizo alguna accion de gobierno que se considere
% buena.

hizoAlgoBueno(Presidente,Periodo):-
    accionDelPresidente(Presidente,Accion,Periodo),
    buenaAccion(Accion).

accionDelPresidente(Presidente,Accion,Periodo):-
    accion(Accion,Fecha,_,_),
    presidenteEnFecha(Presidente,Fecha,Periodo).

% NOTA: Los parametros del periodo se agregan para el punto 3. Para el
% punto 1 y 2 se pueden obviar


% 3) Calificacion Logica de presidentes
% Calificar a los presidentes con las siguientes categorias:


% Insulso. En su período no hizo nada. (Puerta)

calificacion(Presidente,insulso):-
    periodo(Presidente,_,_,_),
    not(accionDelPresidente(Presidente,_,_)).

% Malo. Hizo cosas, pero nada bueno. (Menem)

calificacion(Presidente,malo):-
    accionDelPresidente(Presidente, _,_),
    not(hizoAlgoBueno(Presidente,_)).

% Regular. En todos sus períodos hizo al menos una cosa buena (Alfonsín)

calificacion(Presidente,regular):-
    periodo(Presidente,_,_,_),
    forall(periodo(Presidente,_,_,Periodo), hizoAlgoBueno(Presidente,Periodo)).

% Bueno. Tuvo al menos un período en el que hizo cosas y todo lo que
% hizo en ese período fue bueno.

calificacion(Presidente,bueno):-
    periodo(Presidente,_,_,Periodo),
    buenPeriodo(Periodo).

% Muy bueno. En todos los periodos en los que estuvo hizo cosas y todas
% las cosas que hizo en cada período fueron buenas.

calificacion(Presidente,muyBueno):-
    periodo(Presidente,_,_,_),
    forall(periodo(Presidente,_,_,Periodo), buenPeriodo(Periodo)).

buenPeriodo(Periodo):-
    accionDelPresidente(_,_,Periodo),
    forall(accionDelPresidente(_,Accion,Periodo),buenaAccion(Accion)).









