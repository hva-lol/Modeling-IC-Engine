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

v0 = R1*t0/p0;
v1 = R1*t1/p1;
v2 = R1*t2/p2;
v3 = v0;

h1 = cp*(t1-t0);
h2 = cp*(t2-t1);
h3 = 0;

u1 = cv*(t1-t0);
u2 = cv*(t2-t1);
u3 = 0;


% Irreversible Processes (Only Calculating Work and Heat as Δu and Δh
% remains constant and using Efficiency E = 0.75 = w/q, w = q*0.75)

q1i = 0; % Adiabatic
w1i = 0.75*q1i;
q2i = h2; % Isobaric
w2i = 0.75*q2i;
q3i = R*t3*log(p2/p3); % Isothermal Heat remains unchanged between reversiblity and irreversibility
w3i = 0.75*q3i;

qti = q1i + q2i + q3i;
wti = w1i+w2i+w3i;

% Irreversible Processes can not be represented perfectly in a plot, so
% usually they are represented as linear lines between the states.

v1_table = linspace(v0,v1,100);
v2_table = linspace(v1,v2,100);
v3_table = linspace(v2,v3,100);
t1_table = linspace(t0,t1,100);
t2_table = linspace(t1,t2,100);
t3_table = linspace(t2,t3,100);
p1_table = linspace(p0,p1,100);
p2_table = linspace(p1,p2,100);
p3_table = linspace(p2,p3,100);

figure(1)
plot(v1_table,p1_table,'g--') % Green Adiabatic
hold on
plot(v2_table,p2_table,'r--') % Red , Isobaric
hold on
plot(v3_table,p3_table,'b--') % Blue, Isothermal
title('P-V Plot (Irreversible) ')
xlabel ('Volume in L')
ylabel ('Pressure in bar')

figure(2)
plot(t1_table,p1_table,'g--') % Green, Adiabatic
hold on
plot(t2_table,p2_table,'r--') % Red , Isobaric
hold on
plot(t3_table,p3_table,'b--') % Blue, Isothermal
title('P-T Plot (Irreversible)')
xlabel ('Temperature in K')
ylabel ('Pressure in bar')

figure(3)
plot(v1_table,t1_table,'g--') % Green, Adiabatic
hold on
plot(v2_table,t2_table,'r--') % Red , Isobaric
hold on
plot(v3_table,t3_table,'b--') % Blue, Isothermal
title('T-V Plot (Irreversible)')
xlabel ('Volume in L')
ylabel ('Temperature in K')