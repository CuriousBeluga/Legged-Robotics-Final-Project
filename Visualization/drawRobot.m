function drawRobot( ee, robot_parameters)
    % draw upper platform
    create_circle( ee(1), ee(2), robot_parameters.upper/2, robot_parameters.l3i, ee, 'black' );
    hold on
    % create cone shape at the top
    create_cone( ee, robot_parameters );
    % draw lower platform
    create_circle( 0, 0, robot_parameters.lower/2, 0, zeros([6,1]), 'black' );

    xlim([-robot_parameters.lower robot_parameters.lower])
    ylim([-robot_parameters.lower robot_parameters.lower])
    zlim([0 robot_parameters.lower])

    % calculate direct (virtual) leg lengths
    [L_o, l, u_o, s_c, R_co] = inv_kin( ee, robot_parameters );
    % draw 6 legs as line segments
    for ii=1:6
        x = [u_o(1,ii); u_o(1,ii)+L_o(1,ii)];
        y = [u_o(2,ii); u_o(2,ii)+L_o(2,ii)];
        z = [u_o(3,ii); u_o(3,ii)+L_o(3,ii)];
        plot3(x,y,z, 'Color', 'black'); hold on
    end
    hold off
end

function create_cone( ee, robot_parameters )
    % EVERYTHING WORKS UP UNTIL HERE
    
    r = robot_parameters.upper/2;
    h = robot_parameters.upper/2;
    m = (h/r);
    [R,A] = meshgrid(linspace(0,r,11),linspace(0,2*pi,41));
    X = (R .* cos(A));
    Y = (R .* sin(A));
    Z = (-m*R);
    h=surf(X+ee(1),Y+ee(2),Z+ee(3)+robot_parameters.upper/2);
    inclined_x = rad2deg(ee(4)); % in degrees
    inclined_y = rad2deg(ee(5)); % in degrees
    inclined_z = rad2deg(ee(6)); % in degrees
    rotate(h, [1 0 0], inclined_x);
    rotate(h, [0 1 0], inclined_y);
    rotate(h, [0 0 1], inclined_z);
% 
%     [X,Y,Z]=cylinder([robot_parameters.upper/2 0]);
%     
%     M=makehgtform('translate',ee(1:3)); %  ,'xrotate',ee(4),'yrotate',pi+ee(5),'zrotate',ee(6));
%     
%     Z = Z*robot_parameters.upper/2;
%     scatter3(ee(1), ee(2), ee(3), 10, 'filled');
%     h=surf(X,Y,Z,'Parent',hgtransform('Matrix',M),'LineStyle','none','FaceAlpha',0.6);
%     light
%     zlim([0 400]);


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