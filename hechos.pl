% -- Hechos (Base de Conocimientos) --
personaje('Elara', 5, 100).
personaje('Kael', 3, 80).
personaje('Rin', 7, 120).

mision(m1, 'Bosque de Sombras', 2, 50).
mision(m2, 'Cueva del Dragon', 5, 120).
mision(m3, 'Torre Arcana', 7, 200).

inventario('Elara', [espada, escudo, pocion]).
inventario('Kael', [arco, flechas]).
inventario('Rin', [varita, grimorio, pocion, amuleto]).

requiere(m2, escudo).
requiere(m2, pocion).
requiere(m3, grimorio).
requiere(m3, pocion).

% -- Reglas Aritmeticas y Recursivas --

% 1. Verificación de nivel (Operador Relacional >=)
puede_aceptar(Personaje, ID_Mision) :-
    personaje(Personaje, Nivel, _),
    mision(ID_Mision, _, Dificultad, _),
    Nivel >= Dificultad.

% 2. Calculo recursivo de XP acumulada
xp_acumulada(0, 0).
xp_acumulada(N, Total) :-
    N > 0,
    N1 is N - 1,
    xp_acumulada(N1, Prev),
    Total is Prev + (30 * N).

% 3. Verificación de inventario con member/2
tiene_requerido(Personaje, Objeto) :-
    inventario(Personaje, Lista),
    member(Objeto, Lista).

% -- Regla de Unificación y comparación --

% 1. Detectar personajes del mismo nivel exacto
mismo_nivel(P1, P2) :-
    personaje(P1, N, _),
    personaje(P2, N, _),
    P1 \== P2.

% 2. Validar balance aritmetico estricto
es_balanceado(Personaje) :-
    personaje(Personaje, _, Vida),
    Vida =:= 100.

% --- PROCESAMIENTO DE LISTAS Y NLP ---

% 1. Fusionar inventarios
fusionar_equipo(P1, P2, EquipoFusionado) :-
    inventario(P1, L1),
    inventario(P2, L2),
    append(L1, L2, EquipoFusionado).

% 2. Base de conjugación
tiempo(presente). tiempo(pasado). tiempo(futuro).
persona(primera). persona(segunda). persona(tercera).
numero(singular). numero(plural).

ser(presente, tercera, singular, "es").
ser(pasado, tercera, singular, "fue").
ser(futuro, tercera, singular, "será").
ser(presente, primera, singular, "soy").
ser(presente, primera, plural, "somos").

% 3. Regla de inferencia con estructura condicional
conjugar_accion(Verbo, Tiempo, Persona, Numero, Conjugacion) :-
    tiempo(Tiempo), persona(Persona), numero(Numero),
    ( Verbo = "ser" -> 
        ser(Tiempo, Persona, Numero, R),
        Conjugacion = R
    ;   Conjugacion = Verbo
    ).

% 4. Generación de reporte narrativo 
generar_reporte(Personaje, MisionID, Mensaje) :-
    puede_aceptar(Personaje, MisionID),
    mision(MisionID, Nombre, _, XP),
    conjugar_accion("ser", presente, tercera, singular, FormaVerbal),
    atomic_list_concat([Personaje, FormaVerbal, 'capaz de completar', Nombre, 'por', XP, 'XP'], ' ', Mensaje).

    