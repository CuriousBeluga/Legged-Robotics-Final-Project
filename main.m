%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RBE 521 Final Project     %
% Authors: Martin Bleakley  %
%          Andrew Meyer     %
%          Sean Tseng       %
%          Lucas Vanslette  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear
clc
% NOTE: the robot parameters are assumed to be known
Rm = 50/2; Rf = 150/2; % diameter of top and bottom platform in mm
alpha = 40*pi/180; beta = 80*pi/180; % angle of seperation for top and bottom platforms
dt = 0.1; % Time increment
botParams = [Rm, Rf, alpha, beta, dt]; % parameter collection


%% STL image processing code
% inputs: stl file
% outputs: end effector positions over time (nodes)
% assume each position is evenly spaced out in time
load('pipe_data.mat');
nodes = nodes';
%% Inverse kinematics code
% Desiredpose = [10  0 150 10 80 0;
%                10 20 150  0 60 0]'; % Test points
Desiredpose = nodes;
[LegsT] = InverseKinematics(Desiredpose, botParams);
% inputs: Robot parameters, end effector positions over time
% outputs: leg lengths over time

%% Forward kinematics code
% inputs: end effector positions over time
% outputs: kinematic calibration
initial_guess = [0 0 150 0 0 0]';
% P = ForwardKinematics(initial_guess, LegsT)

% for debugging: visualize the points from the input
plotPoints( nodes(1:3,:) );

%% Visualization code
% inputs: leg lengths and end effector positions over time
% outputs: visualized robot 
% plotTraj( nodes, LegsT, botParams );


