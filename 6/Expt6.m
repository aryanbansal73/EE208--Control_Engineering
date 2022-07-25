clear
%% Creating the Analog System
A = [-0.14  -0.69  0.0;
     -0.19 -0.048 0.0;
       0.0    1.0   0.0];
B = [0.056; 
     -0.23; 
       0.0];
C = [1 0 0;
     0 1 0];
D = 0;  

system1 = ss(A,B,C,D);

%% Setting some names
set(system1, 'inputname',  {'rudder angle'}, ...
                'outputname', {'sway speed' 'yaw angle'}, ...
                'statename',  {'sway speed' 'yaw angle' 'yaw rate'});

%% Minimum-state realization
% system1 = sminreal(system1);

%% Eigendecomposition of the A matrix
%[EigVec_A,Diag_A] = eig(A);
% pzmap(system1)

%% Function that returns CL System for minimum realized OL Sytem

% function output = fsf(system,poles)
%     A = system.A;
%     B = system.B;
%     C = system.C;
%     D = system.D;
%     K = place(A,B,poles);
%     output = ss(A-B*K,B,C,D);
%     set(output, 'inputname',  {'rudder angle'}, ...
%                 'outputname', {'sway speed' 'yaw angle'}, ...
%                 'statename',  {'sway speed' 'yaw angle'});
%     output = sminreal(output);
% end

%% Condition for Observability
syms k1 k2 k3
K = [k1 k2 k3];
% A_cl = A-B*K;
% Ob = [C;
%       C*A_cl;
%       C*(A_cl^2)];


%% Characteristic Equation
% syms s
% CharEq = vpa(collect(det(s*eye(3) - A_cl),s),3);

%% Plotting for k1 k2 k3
syms a b c 
% Create equations 
eq1 = 0.0428*k3 == a*b*c; 
eq2 = 0.056*k1-0.23*k2+0.188 == -a-b-c;
eq3 = 0.161*k1-0.0428*k2-0.23*k3-0.124 == a*b+a*c+b*c;
% Solve, truncate to 3 decimal poins, a=-0.4590, b=0
[k1, k2, k3 ] = solve(eq1,eq2,eq3);
k1 = vpa(subs(vpa(k1,3),a, -0.459),3);
k2 = vpa(subs(vpa(k2,3),a, -0.459),3);
k3 = vpa(subs(vpa(k3,3),a, -0.459),3);
% Plot in the relevant range
%fplot([k1 k2 k3],[-0.459 0]), grid on;
% h = fsurf(k3,[-0.459 0]);
% 
% a = gca;
% a.TickLabelInterpreter = 'latex';
% a.Box = 'on';
% a.BoxStyle = 'full';
% 
% xlabel('$b$','Interpreter','latex')
% ylabel('$c$','Interpreter','latex')
% zlabel('$k_3$','Interpreter','latex')
% title_latex = ['$' 'k_3 = ' latex(k3) '$'];
% title(title_latex,'Interpreter','latex')


%% Step responses

% p1 = [0 0 -0.459];
% p2 = [0 -0.459 -0.459];
% p3 = [0 -0.459 -0.2710];
% p4 = [0 -0.459 -0.4];
% 
% sys1 = sminreal(fsf(system1,p4));
% eig(sys1)
% isstable(sys1)
% step(sys1)

% C = -1*[0.05 0.1 0.2 0.3 0.4];
%     
% for i=1:length(C)
%     sys1 = sminreal(fsf(system1,[0 -0.459 C(i)]));
%     step(sys1)
%     hold on
% end

% %% Plot for Step Responses
% B = [-0.1 -0.2 -0.3 -0.4];
% poles = unique(sort(combvec(B,B)',2),'rows');
% for i=1:length(poles)
%         sys1 = sminreal(fsf(system1,[-0.459 poles(i,:)]));
%         step(sys1)
%         hold on
% end

%% Complex conjugate plots

% s = tf('s');
% zeta = [0 0.3 0.707 1 2];
% Wn = [0.1 0.2 0.3 0.4 0.459]; 
% 
% i = 2;
% 
% for j = 1:5
%     p1 = pole(tf(1/(s^2+2*Wn(j)*zeta(i)*s+Wn(j)^2)))';
%     sys1 = sminreal(fsf(system1,[-0.459 p1]));
%     step(sys1)
%     hold on
% end
