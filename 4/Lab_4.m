z = tf('z',1);
G_ol = (z^2 + 1.5*z-1)/(z-1)^3;
g1 = 1/(z-1)^3;
a = 0.1; b=0.9;
g0 = (z-a)*(z-b)*g1;
k = 1.1053;
cltff = feedback(g0*k,1);
% [p,z] = pzmap(cltff)
% pzmap(cltff)