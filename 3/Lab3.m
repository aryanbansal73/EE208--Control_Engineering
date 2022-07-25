% s = tf('s');
% 
% % Lung Time Constant
% tau_L = 1; 
% % Lung TF
% Lungs = 1/(1+tau_L*s); 
% 
% % Circulatory System TF
% Circulatory = 0.1   /((s+0.5)*(s+0.1)*(s+0.2)); 
% 
% % TF of Human Body 
% Body = Lungs*Circulatory; 
% 
% % Chemoreceptor Gain
% Kf = 0.1; 
% % Chemoreceptor TF
% Chemoreceptor = tf(Kf,1); 
% 
% % Ventilator TF
% Ventilator = 1; 
% 
% % System CLTF
% CLTF = feedback(Ventilator*Lungs*Circulatory, Chemoreceptor); 
% 
% % 0.061596 : Value from ControlSystemDesigner for 45deg PM
% 
% % To get bode plot
% % bode(Lungs,CirculatorySystem,CLTF), grid on
% 
% % To get GM and PM data
% %margin(CLTF), grid on
% %Gm,Pm,Wcg,Wcp] = margin(CLTF);


tau = [1 2.5 5 7.5 10];
kf = [0.01 0.05 0.1 0.5 1];
B = tf(zeros(1,1,length(kf), length(tau)));
s = tf('s');
for i = 1:length(kf)
    for j = 1:length(tau)
        B(:,:,i,j) = 0.1/((tau(j)*s+1)*(s+0.5)*(s+0.2)*(s+0.1) + 0.1*kf(i));
    end
end
% [kfgrid,taugrid] = ndgrid(kf,tau);
% B.SamplingGrid = struct('kf',kfgrid,'tau',taugrid);
% bode(B), grid on;

% margin(B(1,1,3,1)), grid on % Kf = 0.1, Tau = 1

% use phlead
cltf = tf(zeros(1,1,1,5));
for i=1:5
    cltf(1,1,1,i) = B(1,1,i,1);
end
