function drawRobot( ee, robot_parameters)
    [Rm, Rf, alpha, beta, dt] = robot_parameters;
    % draw upper platform
    create_circle( ee(1), ee(2), robot_parameters.upper/2, ee(3), ee, 'black' );
    hold on
    % draw lower platform
    create_circle( 0, 0, robot_parameters.lower/2, 0, zeros([6,1]), 'black' );

    % calculate direct (virtual) leg lengths
    [L_o, l, u_o, s_c, R_co] = inv_kin( ee, robot_parameters );
    % draw 6 legs as line segments
    for ii=1:6
        x = [u_o(1,ii); u_o(1,ii)+L_o(1,ii)];
        y = [u_o(2,ii); u_o(2,ii)+L_o(2,ii)];
        z = [u_o(3,ii); u_o(3,ii)+L_o(3,ii)];
        plot3(x,y,z, 'Color', 'black'); hold on
    end
end

function create_circle(xoffset,yoffset,r,platform_height,ee,color)
    theta = 0:pi/50:2*pi;
    x = r*cos(theta) + xoffset;
    y = r*sin(theta) + yoffset;
    c = plot3(x,y,repmat(platform_height, [length(x),1]), 'Color', color);
    inclined_x = rad2deg(ee(4)); % in degrees
    inclined_y = rad2deg(ee(5)); % in degrees
    inclined_z = rad2deg(ee(6)); % in degrees
    rotate(c, [1 0 0], inclined_x);
    rotate(c, [0 1 0], inclined_y);
    rotate(c, [0 0 1], inclined_z);
end