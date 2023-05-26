% Задание 1
is_atom(Term) :- atom(Term).
is_variable(Term) :- var(Term).
is_compound(Term) :- compound(Term).
is_term(Term) :- var(Term); atom(Term); compound(Term).

% задание 7
% Факты
game('Minecraft').
game('Civilization VI').
game('The Sims 4').
game('Red Dead Redemption 2').
game('Portal 2').

% Правила
genre('Minecraft', 'выживание').
genre('Civilization VI', 'стратегия').
genre('The Sims 4', 'симулятор жизни').
genre('Red Dead Redemption 2', 'экшен').
genre('Portal 2', 'головоломка').

% Правило с рекурсией
% Рекурсивное правило
game_is_genre(Game, Genre) :- 
    game(Game),
    genre(Game, Genre).
game_is_genre(Game, Genre) :-
    game(Game),
    genre(Game, Subgenre),
    game_is_genre(Subgenre, Genre).



