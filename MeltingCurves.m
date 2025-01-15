MgOx = linspace(0, 1500, 1500);
MgOy = 3098*((MgOx/9.15) + 1).^(1/3.14);

plot(MgOx,MgOy, 'DisplayName', 'MgO Curve')
hold on
%%
FeOx = linspace(0, 1500, 1500);
FeOy = 1650*((FeOx/6.6) + 1).^(0.3);

plot(FeOx,FeOy, 'DisplayName', 'FeO Curve')
xlabel('Pressure (GPa)');
ylabel('Temperature (K)');
title('Melting Curves MgO & FeO');
legend('show');
grid on;
