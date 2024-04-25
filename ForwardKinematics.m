
function p = ForwardKinematics(P0, lg)
    % Robot Parameters
    Rm = 250/2;
    Rf = 650/2;
    alpha = 40 * pi / 180;
    beta = 80 * pi / 180;

    % initial guess
    P(:, 1) = P0;
    i = 2;

    %iterative loop
    Dp = 1;
    e = 0.0001;
    while Dp > e
        J = Jacobian(P(:, i-1));
        
        a = P(4, i-1) * pi/180; % zyz
        b = P(5, i-1) * pi/180;
        c = P(6, i-1) * pi/180;
    
        % B = [0 -sin(a) sin(b)*cos(a);
        %      0 cos(a)  sin(b)*sin(a);
        %      1 0       cos(b)]; % zyz

        B = [1 0      sin(b)*cos(a);
             0 cos(a) -sin(a)*sin(b);
             0 sin(a) cos(a)*cos(b)]; % xyz
    
        % calculate T
        T = [eye(3) zeros(3, 3); 
             zeros(3, 3) B];
    
        % calculate IK
        [l n R s] = IK(P(:, i-1));
    
        Dl = lg - l'; % calculate delta L (given leg lengths - found)
        
        % plug into Pi = Pi-1 + (JT)^-1 * delta L

        P(:, i) = P(:, i-1) + pinv(J*T) * Dl;

        Dp = norm(P(:, i) - P(:, i-1), 2);
        i = i + 1;

    end

    p = P(:, end);
end