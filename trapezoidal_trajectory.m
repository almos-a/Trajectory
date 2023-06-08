% Trapezoidal trajectory
clc
clear 
close all

qs = 0; qf = 50;
t0 = 0; tf = 1; 
t = linspace(t0,tf,50);
%[q_traj,qd,qdd] = jtraj(qs,qf,t); % joint space traj same as multi-axis but with @tpoly
[q_traj,qd,qdd] = mtraj(@tpoly,qs,qf,t); 

figure
plot(t,q_traj,'Linewidth',2);
grid on;xlabel('Time (s)');ylabel('Joint displacement (rad)');
figure
plot(t,qd,'Linewidth',2);
grid on;xlabel('Time (s)');ylabel('Joint velocity (rad/s)');
figure
plot(t,qdd,'Linewidth',2);grid on;
xlabel('Time (s)');ylabel('Joint acceleration (rad/s^2)');