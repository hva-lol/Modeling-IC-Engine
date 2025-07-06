clc
clear
R = 8.314; %in Joule/mol, all energy values will be in Joule/mol too
R1 = 0.0831; %in bar L, all volume values will be in L too
cv = 1.5*R;
cp = 2.5*R;
y = cp/cv; % adiabatic ratio
p0 = 1;
t0 = 70 + 273; %in K
t1 = 150 + 273; %in K
t2 = t0;
t3 = t0;
p3 = p0;

p1 = p0*(((t0/t1)^y)^(1/(1-y))); % process 1 is adiabatic, so t^y * p^(1-y) = const
p2 = p1; %isobaric

% States defined completely, lets solve for Energies now using First Law of
% Thermodynamics and Cp/Cv relation for ideal gases

% For Process 1, Adiabatic Compression
q1 = 0;
u1 = cv*(t1-t0);
w1 = -u1;
h1 = cp*(t1-t0);

% For Process 2, Isobaric Cooling 
u2 = cv*(t2-t1);
h2 = cp*(t2-t1);
q2 = h2;
w2 = q2-u2;

% For Process 3, Isothermal Expansion
u3 = 0;
h3 = 0;
w3 = R*t3*log(p2/p3);
q3 = w3;

% Overall
ut = u1+u2+u3;
ht = h1+h2+h3;
wt = w1+w2+w3;
qt = q1+q2+q3;

disp("Total Internal Energy Change =")
ut
disp("Total Enthalpy Change =")
ht
disp("Total Work Done =")
wt
disp("Total Heat Change =")
qt

% State Volumes 
v0 = R1*t0/p0;
v1 = R1*t1/p1;
v2 = R1*t2/p2;
v3 = v0;

% State Tables for Plotting X axes

v1_table = linspace(v0,v1,100);
v2_table = linspace(v1,v2,100);
v3_table = linspace(v2,v3,100);
t1_table = linspace(t0,t1,100);
t2_table = linspace(t1,t2,100);
t3_table = linspace(t2,t3,100);

% State Tables for Plotting Y axes

p_table1 = zeros(100,1); % Initialising
p_table2 = linspace(p1,p2,100); % Isobaric
p_table3 = zeros(100,1); % Initialising

t_table1 = zeros(100,1); % Initialising
t_table2 = zeros(100,1); % Initialising
t_table3 = linspace(t2,t3,100); % Isothermal

for i=1:100
    p_table1(i) = p0*((v0/v1_table(i))^y); % Adiabatic Eqn
    p_table3(i) = R1*t2/v3_table(i); % Isothermal Eqn
    t_table1(i) = p_table1(i)*v1_table(i)/R1; % Ideal Gas Eqn
    t_table2(i) = p_table2(i)*v2_table(i)/R1; % Ideal Gas Eqn
end



% Plots

figure(1)
plot(v1_table,p_table1,'g') % Green Adiabatic
hold on
plot(v2_table,p_table2,'r') % Red , Isobaric
hold on
plot(v3_table,p_table3,'b') % Blue, Isothermal
title('P-V Plot (Reversible) ')
xlabel ('Volume in L')
ylabel ('Pressure in bar')

figure(2)
plot(t1_table,p_table1,'g') % Green, Adiabatic
hold on
plot(t2_table,p_table2,'r') % Red , Isobaric
hold on
plot(t3_table,p_table3,'b') % Blue, Isothermal
title('P-T Plot (Reversible)')
xlabel ('Temperature in K')
ylabel ('Pressure in bar')

figure(3)
plot(v1_table,t_table1,'g') % Green, Adiabatic
hold on
plot(v2_table,t_table2,'r') % Red , Isobaric
hold on
plot(v3_table,t_table3,'b') % Blue, Isothermal
title('T-V Plot (Reversible)')
xlabel ('Volume in L')
ylabel ('Temperature in K')

% Area under PV Curve 

A1 = trapz(v1_table,p_table1); % For Process 1
A2 = trapz(v2_table,p_table2); % For Process 2
A3 = trapz(v3_table,p_table3); % For Process 3

Area_pv = (A1+A2+A3)*100; % 1 bar-lt = 100 Joules

if (Area_pv-wt < 1) % Check
    disp("Check for Area under the curve Passed, Area is sufficiently close to the Numerical value")
end

