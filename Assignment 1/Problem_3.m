clc
clear

% First we write the function m(x,y) such that, m(1) = x and m(2) = y then
% write the equations of circle and parabola in terms of m(1) and m(2)

func = @(m) [m(1).^2 + m(2).^2 - 4;
             m(1).^2 - m(2) - 1];

% Now by making a general figure in the notebook, you can clearly see that
% the parabola will intersect the circle at 2 points, one on positive x
% side and one on negative x side, so we take our initial guesses
% accordingly.

guess_1 = [1;0]; % (x,y)
guess_2 = [-1;0]; % (x,y)

% Now using F solve (Solution in the format (X,Y)) 

point1 = fsolve(func,guess_1) %Point of Intersection 1
point2 = fsolve(func,guess_2) %Point of Intersection 2