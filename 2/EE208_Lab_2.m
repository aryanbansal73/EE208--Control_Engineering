a0 = 0.1;
b0 = 0.2;
s = tf('s');
G_original = 30/(s^2*(1+a0*s)*(1+b0*s)); % OLTF when T=0
T = [linspace(0,0.05,100) linspace(0.05,1,100) linspace(1,4,50)]; % Array of +ve T values

% Now for the "effective" OLTF which we saw in the "Understanding the
% Problem" section
num = [a0*b0,a0+b0,1,0,0];
den = [a0*b0, a0+b0, 1, 30];
G = tf(num,den);

% We'll also create the CLTF array
cltf = tf(zeros(1,1,1,length(T)));
for i = 1:length(T)
    cltf(:,:,:,i) = minreal(feedback(G_original*tf(1,[T(i),1]),1));
end

zeta = [0.2 0.25];
w = 0;

% Varying a
a1 = 0.1*linspace(0.8,1.2,10);
b1 = 0.2*ones(1,length(a1));    
G1 = tf(zeros(1,1,1,length(a1)));
for i = 1:length(a1)
num = [a1(i)*b1(i), a1(i)+b1(i),1,0,0];
den = [a1(i)*b1(i), a1(i)+b1(i), 1, 30];
G1(:,:,:,i) = tf(num,den);
end

% Varying b
b2 = 0.2*linspace(0.8,1.2,10);
a2 = 0.1*ones(1,length(b2));
G2 = tf(zeros(1,1,1,length(a2)));
for i = 1:length(a2)
num = [a2(i)*b2(i), a2(i)+b2(i),1,0,0];
den = [a2(i)*b2(i), a2(i)+b2(i), 1, 30];
G2(:,:,:,i) = tf(num,den);
end

% Varying both together
a3 = 0.1*linspace(0.8,1.2,10);
b3 = 0.2*linspace(0.8,1.2,10);
G3 = tf(zeros(1,1,1,length(a3)));
for i = 1:length(a3)
num = [a3(i)*b3(i), a3(i)+b3(i),1,0,0];
den = [a3(i)*b3(i), a3(i)+b3(i), 1, 30];
G3(:,:,:,i) = tf(num,den);
end