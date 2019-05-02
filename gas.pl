% -----------------------------------------------------------------------------
% -----------------------------CONSTANTES--------------------------------------
% -----------------------------------------------------------------------------
% Niveles de gas
ninguno.
bajo.
medio.
alto.

% -----------------------------------------------------------------------------
% -----------------------------HECHOS------------------------------------------
% -----------------------------------------------------------------------------

% Hechos sin variable
% Este predicado relaciona los niveles de GAS con las respuestas a dar
gasAnswer(ninguno, [
	'No tienes GAS. Eres un tio con cabeza. Seguro que sabes cuando darte un capricho y cuamnd no.', 
	'No tienes GAS. Prueba a comprarte algo hombre. Tu no tienes peligro de caer en GAS.',
	'No tienes GAS. Enhorabuena. Si quieres comporar algo puedes hacerlo']).

gasAnswer(bajo, [
	'Tienes un poco de GAS. No es preocupoante mucha gente le entusiasma su hobby, mientras no vaya a mas no hay problema.',
	'Apenas tienes GAS, no hay problema mientras no vayas a más.',
	'No te preocupes no tienes casi GAS, sigue pensando que compras te aportan algo y cuales no.']).
gasAnswer(medio, [
	'Tu nivel de GAS es preocupante. De aquí a despilfarrar el dinero hay un paso. Piensa bien cuando compra.s', 
	'Tienes bastante GAS, cada vez que hagas una compra intenta que sea algo que te aporte de verdad. Que no acaben las cosas en un cajón.',
	'Nivel considerable de GAS, tu verás a donde vas. Piensa bien si necesitas todo lo que compras']).
gasAnswer(alto, [
	'Pffff vaya manera de despilfarrar el dinero. No seas tonto anda, padeces de GAS, debes saberlo',
	'Tienes GAS, no hay mas. Intenta no comprar nada en un año, y vende todo lo que no uses',
	'Anda cambia de hobby. Este te produce demasiado GAS. Acabaras arruinado.']).


% Hechos con variables dinamicas
:-dynamic pointList/1.
pointList([]).   % Voy almacenando los resulatados en puntos de cada respuesta

% Representa un punto de la lista de puntos
point(_).

% Lista que almacena las puntuaciones de cada opción de respuesta
questionPoints([10, 50, 100, 500]).

% -----------------------------------------------------------------------------
% -----------------------------PREDICADOS AUXILIARES---------------------------
% -----------------------------------------------------------------------------
% Limpia la pantalla
clearScreen:- write('\033[2J').

% Función que suma los elementos de una lista
sum([],0).
sum([X|C],T):-sum(C,Aux),T is Aux+X.

% Función que devuelñve el elemento N de una lista
getElementList([X|_],1,X).
getElementList([_|Xs],N,Y):- N2 is N-1, getElementList(Xs,N2,Y).

% Función que añade una puntuación a la lista.
insert(X,L,[X|L]).

% Función que borra la lista de puntos de las respuestas
clearPointList:-pointList(PL), retract(pointList(PL)), asserta(pointList([])).

% -----------------------------------------------------------------------------
% -----------------------------PREDICADOS PRINCIPALES--------------------------
% -----------------------------------------------------------------------------

/* Almacena en una lista cada opción respondida en preguntas, si el número es mayor que 4 se muestra mensaje de error y se repite la pregunta */
processOption(R,Current):- 
	R > 4, nl,nl,nl,tab(5),write('A ver si aparte de GAS tienes algo mas... Volvemos a empezar. Introduce un numero de 1 al 4 anda'),nl,nl,nl, question(Current);
	R =< 4, pointList(P), point(E), questionPoints(Points),
		    getElementList(Points, R, E), insert(E, P, I), asserta(pointList(I)), clearScreen.
                  

% Se inicializan las preguntas
question(1):-nl,tab(5),write('En relaccion a tus ingresos cuanto dinero crees que gastas al mes de media?'),nl,
	tab(10),write('1) Menos del 5% del salario'),nl,
	tab(10),write('2) Entre el 5% y el 10%'),nl,
	tab(10),write('3) Entre el 10% y el 15%'),nl,
	tab(10),write('4) Mas del 15%.'),nl,
	nl,nl,tab(5),write('Elija una de las opciones(Recuerde terminar en punto): '),read(Y),
	processOption(Y, 1).

question(2):-nl,tab(5),write('Cada vez que sale algo nuevo, si es parecido a lo que ya tienes pero un poco mejor...'),nl,
	tab(10),write('1) Lo miro pero no lo compro. Si no es algo significativa,emte mejor o que necesite no gasto el dinero'),nl,
	tab(10),write('2) Intento vender lo que ya tengo y si no es mucho mas lo compro.'),nl,
	tab(10),write('3) Lo compro inmediatamente. Ya intentare vender lo anterior que tengo.'),nl,
	tab(10),write('4) Lo compro sin pensarmelo dos veces.'),nl,
	nl,nl,tab(5),write('Elija una de las opciones(Recuerde terminar en punto): '),read(Y),
	processOption(Y, 2).

question(3):-nl,tab(5),write('Cada cuanto frecuentas precia especializada sobre tu equipo?'),nl,
	tab(10),write('1) Cada mes mas o menos'),nl,
	tab(10),write('2) Todas las semanas.'),nl,
	tab(10),write('3) Todos los dias varias.'),nl,
	tab(10),write('4) Todos los dias varias veces, estoy al tanto de todo lo que sale'),nl,
	nl,nl,tab(5),write('Elija una de las opciones(Recuerde terminar en punto): '),read(Y),
	processOption(Y, 3).

question(4):-nl,tab(5),write('Te arrepientes de cosas que compraste y ya no usas?'),nl,
	tab(10),write('1) No, no tengo nada que no use'),nl,
	tab(10),write('2) No, suelo vender lo que ya no uso.'),nl,
	tab(10),write('3) Si, hay cosas en las que gaste mucho dinero y no las aprovecho.'),nl,
	tab(10),write('4) ¿Como quieres que use todo lo que compro? estamos loqos o que.'),nl,
	nl,nl,tab(5),write('Elija una de las opciones(Recuerde terminar en punto): '),read(Y),
	processOption(Y, 4).

question(5):-nl,tab(5),write('Alguna vez has pasado problemas economicos por culpa de adquirir equipo para tu hobby?'),nl,
	tab(10),write('1) No, no gasto mas de lo que puedo y siempre ahorro'),nl,
	tab(10),write('2) No, algun mes me tuve que apretar el cinturon para darme el capriho, pero nunca me a faltadfo dinero.'),nl,
	tab(10),write('3) Tenfo que pedir prestado a veces.'),nl,
	tab(10),write('4) Estoy endeudado hasta las cejas, pero tengo muchas cosas, puedo venderlas si no quueda mas remedio.'),nl,
	nl,nl,tab(5),write('Elija una de las opciones(Recuerde terminar en punto): '),read(Y),
	processOption(Y, 5).


% Este predicado devuelve uno de los grados de GAS existentes en función de la puntuación obtenida
gasGrade(Num, Grade):-
	Num<250,Grade=ninguno;
	Num>=250,Num<500,Grade=bajo;
	Num>=500,Num<1500,Grade=medio;
	Num>=1500,Grade=alto.


randomAnswer(List, Answer):-length(List, Length), Idx is random(Length), nth0(Idx, List ,Answer).

% Esta función , para cada tipo de grado elegirá uno al azar de la lista
persuadeByGrade(Grade):- gasAnswer(Grade, List), randomAnswer(List, Answer), nl, write(Answer).

% Le las posibles opciones de repetir o no el test
option(s):- clearPointList, menu.
option(n):- halt.
option(_):- nl, write('Por favor, escriba s o n: '), restart.

% PAra volver al menu inicial una vez finalizado el test o salir
restart:- nl,write('Quiere volver al menu principal s/n?: '),read(R),option(R).

% Obtiene el consejo a dar al usuario en función del nivel de gas obtenido como resultado del test así como el número de puntos
getResult:- pointList(Points), sum(Points, Result),
            clearScreen, write('Has obtenido '),write(Result), write(' puntos '), 
            gasGrade(Result, Grade), persuadeByGrade(Grade), restart.

startTest:- question(1), question(2), question(3), question(4), question(5), 
            getResult.

% Acciones según respuestas del menú
action(1):- clearScreen, startTest.
action(2):- clearScreen.
action(3):- halt.

% Menu de incio del programa, con las opciones elegidas */
menu:-clearScreen,
    tab(10),write('=============================='),nl,
    clearPointList, tab(10),write('CONSEJOS PARA EVITAR EL GAS'),nl,
	tab(10),write('=============================='),nl,
	tab(15),write('1) Comenzar el test.'),nl,
	tab(15),write('2) Borrar pantalla.'),nl,
	tab(15),write('3) Salir.'),nl,nl,
	tab(10),write('Elija una de las opciones: '),
	read(X), action(X).

% Inicio de el menú
init:- menu.