clc
clear

y1 = @(x) 2*x + 1;
y2 = @(x) 2*x ./ (1+(0.2*x));

% Now since our problem is given in terms of an integral over dy1, we'll
% convert it to dx, as y1 = 2*x + 1, dy1 = 2*dx, so y3 for integration will
% be dy1/(y1+y2) = 2*dx/(y1+y2). Same for y4

y3 = @(x) 2 ./(y1(x)-y2(x));

% Since the limits 0,15 are for the integral over y1, and since y1 = 2x+1,
% the new limits for the integral over x are 2x+1=0, x = -0.5 and 2x+1=15,
% x = 7 respectively

integral = integral(y3,-0.5,7) % Required Answer
