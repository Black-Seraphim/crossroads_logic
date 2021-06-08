% crossroads logic
% defines the right of way logic on a crossroads using prolog
% 	- first defines cars with color, positions, and directions
%	- second defines neighbours of positions
%	- third checks if is allowed to drive



% define cars, positions, and directions 
% carPosition(Color, Position, Direction).

% Case A
carPosition(blue, north, right).
carPosition(red, east, straight).
carPosition(grey, west, left).

% Case B
% carPosition(blue, north, right).
% carPosition(red, east, straight).
% carPosition(green, south, left).

% Case C
% carPosition(blue, north, right).
% carPosition(grey, west, left).
% carPosition(green, south, straight).

% Case D
% carPosition(grey, west, left).

% Case E
% carPosition(blue, north, right).

% Case F
% carPosition(red, east, straight).



% define right and straight neighbours
% neighbours(Position, RightNeighbour, StraightNeighbour).
neighbours(north, west, south).
neighbours(west, south, east).
neighbours(south, east, north).
neighbours(east, north, west).



% check if turn is allowed
allowed(Color) :-

% Check right turns
	carPosition(Color, _, right),!;

% Check left turns
	carPosition(Color, Position, left),
	neighbours(Position, RightNeighbour, StraightNeighbour),
	aggregate_all(count, carPosition(_, StraightNeighbour, _), CountStraight),
	aggregate_all(count, carPosition(_, RightNeighbour, _), CountRight),
	(CountStraight + CountRight) < 1,!;

% Check straight turns
	carPosition(Color, Position, straight),
	neighbours(Position, RightNeighbour, _),
	aggregate_all(count, carPosition(_, RightNeighbour, _), CountRight),
	CountRight < 1.
