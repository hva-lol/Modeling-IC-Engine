clc
clear

p1 = 100;
v1 = 0.0038;
t1 = 30 + 273; %in Kelvin
cr = 8;
Ru = 8.314; %in kJ/kmol-K
MW = 28.7; %in kg/kmol
R = Ru/MW; % Gas Constant for Air
Cv = 0.718;
k = 1.4;

% Determining P,V,T in all the remaining 3 states, assuming air to be an ideal gas

v2 = v1/cr; % Compression Ratio
p2 = ((cr)^k)*p1; % Adiabatic Process, v1/v2 = cr
t2 = p2*v2*t1/(p1*v1); % Mass of Air remains constant

v3 = v2; % Isochoric
t3 = 1200 + 273; % Peak Temperature given, in Kelvin
p3 = p2*v2*t3/(v3*t2);

v4 = v1; % Isochoric
p4 = ((cr)^-k)*p3; % Adiabatic, v3/v4 = v2/v1 = 1/cr = cr^-1 
t4 = p4*v4*t3/(p3*v3);

% All states defined, finding mass of air used in the cycle (in kg)

m = p1*v1/(t1*R);

% Heat Rejection happens in the Isochoric Process between states 4 and 1
% (in kJ)

Qout = - (m*Cv*(t1 - t4)) % Isochoric Process, Q = delU = mCv(delT), negative sign to just get the magnitude)

% Net Work Output, no work done in the isochoric processes (in kJ)

Win = m*Cv*(t2-t1); % Adiabatic Process, W = delU = mCv(delT)
Wout = -m*Cv*(t4-t3); % Adiabatic Process, W = delU = mCv(delT), Negative sign to just get the magnitude

Wnet = (Wout - Win)

% Thermal Efficiency, Need Qin first

Qin = m*Cv*(t3-t2);
eff = Wnet*100/Qin

% Mean Effective Pressure (in kPa)

MEP = Wnet/(v1-v2)

% P-V Plot

v_table = linspace(v2,v1,100);
p_table1 = zeros(100,1);
p_table2 = zeros(100,1);

for i = 1:100
    p_table1(i) = p1*((v1/v_table(i))^k);
    p_table2(i) = p4*((v1/v_table(i))^k);
end

v_table3 = linspace(v2,v2,100);
p_table3 = linspace(p2,p3,100);
v_table4 = linspace(v1,v1,100);
p_table4 = linspace(p1,p4,100);

figure(1)
plot(v_table,p_table1,'b')
hold on
plot(v_table,p_table2,'b') 
hold on
plot(v_table3,p_table3,'b') 
hold on 
plot(v_table4,p_table4,'b')
title('P-V Plot')
grid on
xlabel ('Volume in m3')
ylabel ('Pressure in kPa')