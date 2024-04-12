function [L_o, l, u_o, s_c, R_co] = inv_kin( ee, robot_parameters )
    
    a = robot_parameters.alpha;     % in radians
    b = robot_parameters.beta;      % in radians
    Rm = (robot_parameters.upper)/2;    % upper dish radius, meters
    Rf = (robot_parameters.lower)/2;    % lower dish radius, meters

    % R_co = rotate from the c frame to the o frame
    switch robot_parameters.euler_angles
        case "XYZ"
            R_co = rotx(ee(4))*roty(ee(5))*rotz(ee(6));
        case "ZYX"
            R_co = rotz(ee(4))*roty(ee(5))*rotx(ee(6));
        case "ZYZ"
            R_co = rotz(ee(4))*roty(ee(5))*rotz(ee(6));
        otherwise
            disp('Error: bad Euler Angle input')
            R_co = -1;
            return;
    end

    % Rm = upper
    s1 = [Rm*cos(b/2); Rm*sin(b/2); 0];
    s2 = [-Rm*sin(pi/6-b/2); Rm*cos(pi/6-b/2); 0];
    s3 = [-Rm*sin(pi/6+b/2); Rm*cos(pi/6+b/2); 0];
    s4 = [-Rm*cos(pi/3-b/2); -Rm*sin(pi/3-b/2); 0];
    s5 = [-Rm*cos(pi/3+b/2); -Rm*sin(pi/3+b/2); 0];
    s6 = [Rm*cos(b/2); -Rm*sin(b/2); 0];

    s_c = [s1 s2 s3 s4 s5 s6];  % 3x6 matrix

    % Rf = lower
    u1 = [Rf*cos(a/2); Rf*sin(a/2); 0];
    u2 = [-Rf*sin(pi/6-a/2); Rf*cos(pi/6-a/2); 0];
    u3 = [-Rf*sin(pi/6+a/2); Rf*cos(pi/6+a/2); 0];
    u4 = [-Rf*cos(pi/3-a/2); -Rf*sin(pi/3-a/2); 0];
    u5 = [-Rf*cos(pi/3+a/2); -Rf*sin(pi/3+a/2); 0];
    u6 = [Rf*cos(a/2); -Rf*sin(a/2); 0];

    u_o = [u1 u2 u3 u4 u5 u6];
    
    L_o = zeros( 3,6 );
    l = zeros( 6,1 );
    n = zeros( 3,6 );
    o_o = [ee(1);ee(2);ee(3)];

    for ii = 1:6
        L_o(:,ii) = o_o + R_co*s_c(:,ii) - u_o(:,ii);  % leg vector
        l(ii) = norm(L_o(:,ii),2);              % leg length
        n(:,ii) = L_o(:,ii)/l(ii);            % unit vector of ith leg
    end 
end

function Rz = rotx(t)
    Rz = [1 0 0; 0 cos(t) -sin(t); 0 sin(t) cos(t)];
end
function Rz = roty(t)
    Rz = [cos(t) 0 sin(t); 0 1 0; -sin(t) 0 cos(t)];
end
function Rz = rotz(t)
    Rz = [cos(t) -sin(t) 0; sin(t) cos(t) 0; 0 0 1];
end