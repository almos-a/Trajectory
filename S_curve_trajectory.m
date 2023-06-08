% S curve (seven segments) trajectory
clc
clear 
close all

%% Alt 1
% joint variable
q0 = [0 30]; % init
qf = [50 5]; % final

t0 = 0; %initial time
tf = 1; %final time

% derived
qdd = [];qd=[];q_traj=[];
for i = 1:length(q0) % for more than 1-DOF
    V = 1.5*(qf(i)-q0(i))/tf; % to set the constant velocity value
    tb = (q0(i)-qf(i) + V*tf)/V;
    
    t = linspace(t0,tf,50);
    ind1 = find((t0<=t) & (t<=tb));
    ind2 = find((tb<t) & (t<=tf-tb));
    ind3 = find((tf-tb<t) & (t<=tf));
    temp1 = q0(i) + V*t.^2/(2*tb);
    temp2 = (qf(i) + q0(i) - V*tf)/2 + V*t;
    temp3 = qf(i) - V*tf^2/(2*tb) + V*tf*t/tb - V*t.^2/(2*tb);
    
    q_traj = [q_traj;[temp1(ind1) temp2(ind2) temp3(ind3)]];
    
    qd = [qd; diff(q_traj(i,:))./diff(t)];
    qdd = [qdd; diff(qd(i,:))./diff(t(1:end-1))];
end

figure
plot(t,q_traj,'Linewidth',2);
grid on;xlabel('Time (s)');ylabel('Joint displacement (rad)');
figure
plot(t(1:end-1),qd,'Linewidth',2);
grid on;xlabel('Time (s)');ylabel('Joint velocity (rad/s)');
figure
plot(t(1:end-2),qdd,'Linewidth',2);grid on;
xlabel('Time (s)');ylabel('Joint acceleration (rad/s^2)');
%% Alt 2
% create quintic polynimial trajectory
qs = [0 30]; qf = [50 5];
t = linspace(t0,tf,50);
[q_traj,qd,qdd] = mtraj(@lspb,qs,qf,t);

figure
plot(t,q_traj,'Linewidth',2);
grid on;xlabel('Time (s)');ylabel('Joint displacement (rad)');
figure
plot(t,qd,'Linewidth',2);
grid on;xlabel('Time (s)');ylabel('Joint velocity (rad/s)');
figure
plot(t,qdd,'Linewidth',2);grid on;
xlabel('Time (s)');ylabel('Joint acceleration (rad/s^2)');