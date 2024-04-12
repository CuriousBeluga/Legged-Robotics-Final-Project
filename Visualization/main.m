close all

%% *** HW4 robot parameters for now ***


% define robot parameters which were given in Question 1
robot_parameters.beta = deg2rad(60);    % upper dish, in radians
robot_parameters.upper = 300;           % upper dish radius, millimeters
robot_parameters.alpha = deg2rad(60);   % lower dish, in radians
robot_parameters.lower = 480;           % lower dish radius, millimeters
robot_parameters.euler_angles = "XYZ";

% ee = [ 0;
%        10;
%        100;
%        deg2rad(5);
%        deg2rad(5);
%        0    ];
ee_start = [0;
            10;
            100;
            deg2rad(0);
            deg2rad(0);
            0    ];

ee_end = [  50;
            10;
            100;
            deg2rad(10);
            deg2rad(10);
            0    ];

% coxa, femur, and tibia leg segments, all in mm
robot_parameters.l1i = 20;
robot_parameters.l2i = 70;
robot_parameters.l3i = 100;

plotTraj( ee_start, ee_end, robot_parameters );


% calculate the joint angles, use them to plot
% [hip, knee, ankle, l_prime] = invKin_HWR(ee, robot_parameters);



% draw the legs of the HWR
% drawHWR( ee, robot_parameters, hip, knee, ankle, l_prime )








