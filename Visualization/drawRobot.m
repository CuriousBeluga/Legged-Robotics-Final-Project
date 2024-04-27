function drawRobot( ee, L_o, u_o, t, botParams)
    Rm = botParams(1); % top circle
    Rf = botParams(2); % bottom circle
    alpha = botParams(3);
    beta = botParams(4);

    robot_parameters.alpha = alpha;     % in radians
    robot_parameters.beta = beta;      % in radians
    robot_parameters.upper = Rm*2;    % upper dish radius, meters
    robot_parameters.lower = Rf*2; 
    robot_parameters.euler_angles = "XYZ";
    
    
    % draw upper platform
    create_circle( ee, Rm, 'black' );
    hold on
    % draw lower platform
    create_circle( zeros([6,1]), Rf, 'black' );
    [L_o, ~, u_o, ~, ~] = inv_kin( ee, robot_parameters );
    
    % draw 6 legs as line segments
    for ii=1:6
        x = [u_o(1,ii); u_o(1,ii)+L_o(1,ii)];
        y = [u_o(2,ii); u_o(2,ii)+L_o(2,ii)];
        z = [u_o(3,ii); u_o(3,ii)+L_o(3,ii)];
        plot3(x,y,z, 'Color', 'black'); hold on

%         % plot the connection points just in case the circle looks bad
%         x = [u_o(1,ii)+L_o(1,ii); u_o(1,mod(ii,6)+1)+L_o(1,mod(ii,6)+1)];
%         y = [u_o(2,ii)+L_o(2,ii); u_o(2,mod(ii,6)+1)+L_o(2,mod(ii,6)+1)];
%         z = [u_o(3,ii)+L_o(3,ii); u_o(3,mod(ii,6)+1)+L_o(3,mod(ii,6)+1)];
%         plot3(x,y,z, 'Color', 'red'); 
    end

end

function create_circle(ee,r,color)
    theta = 0:pi/50:2*pi;
    x = r*cos(theta) + ee(1);
    y = r*sin(theta) + ee(2);
    c = plot3(x,y,repmat(ee(3), [length(x),1]), 'Color', color);
    inclined_x = rad2deg(ee(4)); % in degrees
    inclined_y = rad2deg(ee(5)); % in degrees
    inclined_z = rad2deg(ee(6)); % in degrees
    rotate(c, [1 0 0], inclined_x);
    rotate(c, [0 1 0], inclined_y);
    rotate(c, [0 0 1], inclined_z);
end