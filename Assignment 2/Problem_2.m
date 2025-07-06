clc
clear

k = 1.35;
p0 = 101.325;

%State 1 variables
p1=110; %in kPa
t1=400; %in Kelvin


%Engine parameters (in meters)
bore=0.09;
stroke=0.1;
connecting_rod=0.14;
c_r=8.5; 

%Calculating swept and clearance volume
v_swept = (pi/4)*bore^2*stroke;
v_clearance = v_swept/(c_r - 1);
v1 = v_swept + v_clearance;
v2 = v_clearance;

%State 2 variables
p2 = p1*(c_r^(k));
t2 = p2*v2*t1/(p1*v1);

constant_compression = p1*v1^(k);
V_compression = engine_kinematics(bore, stroke, connecting_rod, c_r, 0, 180);
P_compression = constant_compression./V_compression.^k;
Vc_nokinematics = linspace(v2,v1,180);
Pc_nokinematics = constant_compression./Vc_nokinematics.^k;

%State 3 variables
v3 = v2;
t3 = 2800;
p3 = p2*t3/t2;

constant_expansion = p3*v3^(k);
V_expansion = engine_kinematics(bore, stroke, connecting_rod, c_r, 180, 0);
P_expansion = constant_expansion./V_expansion.^k;
Ve_nokinematics = linspace(v2,v1,180);
Pe_nokinematics = constant_expansion./Ve_nokinematics.^k;

%State 4 variables
v4 = v1;
p4 = p3*(v3/v4)^(k);

thermal_efficiency = 1 - (1/(c_r - 1)^(k - 1))

figure (1)
hold on 
line([v2 v1],[p0 p1],'color','y')
plot(Vc_nokinematics, Pc_nokinematics,'b')
line([v2 v3], [p2 p3],'color','r')
plot(Ve_nokinematics, Pe_nokinematics,'g')
line([v4 v1], [p4 p1],'color','m')

grid on
xlabel('Volume')
ylabel('Pressure')
title('Otto cycle - PV graph ignoring Piston Kinematics')
legend('intake/exhaust','compression','combustion','expansion','heat rejection')

text(v2,p0,'0')
text(v1,p1,'1')
text(v2,p2,'2')
text(v3,p3,'3')
text(v4,p4,'4')


figure (2)
hold on

line([v2 v1],[p0 p1],'color','y')
plot(V_compression, P_compression,'b')
line([v2 v3], [p2 p3],'color','r')
plot(V_expansion, P_expansion,'g')
line([v4 v1], [p4 p1],'color','m')

grid on
xlabel('Volume')
ylabel('Pressure')
title('Otto cycle - PV graph accounting for Piston Kinematics')
legend('intake/exhaust','compression','combustion','expansion','heat rejection')

text(v2,p0,'0')
text(v1,p1,'1')
text(v2,p2,'2')
text(v3,p3,'3')
text(v4,p4,'4')


cr_table = linspace(7,11,101);
efficiency_table = zeros(101,1);
for i = 1:101
    efficiency_table(i) = 1 - (1/(cr_table(i) - 1)^(k - 1));
end
figure(3)
plot(cr_table,efficiency_table)
title('Efficiency v/s Compression Ratio')
xlabel("Compression Ratio")
ylabel('Efficiency')

% Inference from the plot :- Clearly as Compression Ratio increases, the
% associated Efficiency with it will also increase


% Code for Function:

function [V_compression] = engine_kinematics(bore, stroke, connecting_rod, c_r, start_crank, end_crank)

%inputs
crankpin_radius = stroke/2;
R = connecting_rod/crankpin_radius;

v_swept = (pi/4)*bore^2*stroke;
v_clearance = v_swept/(c_r - 1);

theta = linspace(start_crank,end_crank,180);

term1 = 0.5*(c_r - 1);
term2 = R + 1 - cosd(theta);
term3 = (R^2 - sind(theta).^2).^(0.5);

%how the volume inside the combustion chamber changes
V_compression = (1+term1*(term2-term3))*v_clearance;

end

