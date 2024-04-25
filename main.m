%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RBE 521 Final Project     %
% Authors: Martin Bleakley  %
%          Andrew Meyer     %
%          Sean Tseng       %
%          Lucas Vanslette  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% NOTE: the robot parameters are assumed to be known

%% STL image processing code
% inputs: stl file
% outputs: end effector positions over time (nodes)
% assume each position is evenly spaced out in time
load('simple_stadium_data.mat');

%% Inverse kinematics code
% inputs: end effector positions over time
% outputs: leg lengths over time


%% Forward kinematics code
% inputs: end effector positions over time
% outputs: kinematic calibration


%% Visualization code
% inputs: leg lengths and end effector positions over time
% outputs: visualized robot 
plotTraj( ee_points, robot_parameters );


