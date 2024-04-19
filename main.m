%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RBE 521 Final Project     %
% Authors: Martin Bleakley  %
%          Andrew Meyer     %
%          Sean Tseng       %
%          Lucas Vanslette  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc
% NOTE: the robot parameters are assumed to be known
Rm = 250/2; Rf = 650/2; % diameter of top and bottom platform in mm
alpha = 40*pi/180; beta = 80*pi/180; % angle of seperation for top and bottom platforms
dt = 0.1; % Time increment
botParams = [Rm, Rf, alpha, beta, dt]; % parameter collection


%% STL image processing code
% inputs: stl file
% outputs: end effector positions over time
load('simple_stadium_data.mat');

%% Inverse kinematics code
Desiredpose = [10  0 150 10 80 0;
               10 20 150  0 60 0]'; % Test points
[LegsT] = InverseKinematics(Desiredpose, botParams)
% inputs: Robot parameters, end effector positions over time
% outputs: leg lengths over time


%% Forward kinematics code
% inputs: end effector positions over time
% outputs: kinematic calibration


%% Visualization code
% inputs: leg lengths and end effector positions over time
% outputs: visualized robot 
plotTraj( ee_points, robot_parameters );


