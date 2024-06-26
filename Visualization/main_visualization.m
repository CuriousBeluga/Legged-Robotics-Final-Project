close all

%% *** HW4 robot parameters for now ***


% define robot parameters which were given in Question 1
robot_parameters.beta = deg2rad(60);    % upper dish, in radians
robot_parameters.upper = 300;           % upper dish radius, millimeters
robot_parameters.alpha = deg2rad(60);   % lower dish, in radians
robot_parameters.lower = 480;           % lower dish radius, millimeters
robot_parameters.euler_angles = "XYZ";

ee_start = [0;
            10;
            100;
            deg2rad(0);
            deg2rad(0);
            0    ];
ee_end = [0;
            10;
            110;
            deg2rad(5);
            deg2rad(5);
            0    ];


% ee_end = [  0;
%             10;
%             100;
%             deg2rad(20);
%             deg2rad(20);
%             0    ];
% ee_end = [  80;
%             10;
%             100;
%             deg2rad(0);
%             deg2rad(0);
%             0    ];

% coxa, femur, and tibia leg segments, all in mm
robot_parameters.l1i = 20;
robot_parameters.l2i = 70;
robot_parameters.l3i = 100;

ee_points = [ee_start, ee_end];

plotTraj( ee_points, robot_parameters );

