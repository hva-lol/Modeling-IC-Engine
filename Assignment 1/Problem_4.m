clc
clear
 
% Making the Curve Function 

x_plot = linspace(-5,5,200);
curve_plot = 2*x_plot./(1+x_plot);

% Solving the 2 Equations

func = @(s) [(1+s(1))^2*(s(2)-1) - 2*s(1);
             s(2)*(1+s(1)) - 2*s(1)];

% Since there will be 2 tangents coming out of this point we will take 2
% initial guesses 

init_guess1 = [1,1];
init_guess2 = [0,-1];

% Root1 will give us (1+sqrt2, sqrt2) Root2 will give us (1-sqrt2,-sqrt2)
% These are point of contacts of the tangents from (0,1) to the curve
% 2x/(1+x)

root1 = fsolve(func,init_guess1);
root2 = fsolve(func,init_guess2);

h1 = root1(1); % Xcoord of First Tangent POC (1+sqrt2)
k1 = root1(2); % Ycoord of First Tangent POC (sqrt2)
h2 = root2(1); % Xcoord of Second Tangent POC (1-sqrt2)
k2 = root2(2); % Ycoord of Second Tangent Poc (-sqrt2)

% Slope = (y2-y1)/(x2-x1)

m1 = (k1-1)/h1; 
m2 = (k2-1)/h2;

x_plot1 = linspace(0,4.8284,3);
x_plot2 = linspace(-0.8284,0,3);

% Line passing through (0,1) and having slope = m, will have eqn y = mx+1

tang1_plot = m1*x_plot1 + 1;
tang2_plot = m2*x_plot2 + 1;

% In the plot the Magenta curve denotes the curve 2x/(1+x) and the Cyan and
% Green Curve denotes the tangents, the equations are written with the plot
% commands

figure(1)
plot(x_plot,curve_plot,'m')
hold on  
plot(x_plot1,tang1_plot,'c') % y = (0.1716)x + 1
hold on
plot(x_plot2,tang2_plot,'g') % y = (5.8284)x + 1