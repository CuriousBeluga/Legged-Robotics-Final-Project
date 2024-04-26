function plotTraj( ee_points, robot_parameters )

    ee_start = ee_points(:,1);
    ee_end = ee_points(:,end);

    resolution = 100;
    % adjust resolution, or amount of points to plot to get to the endpoint
    % time = vector of evenly spaced times going from 0 to duration, with 
    %        size resolution

    [q, ~,~,~,~] = trapveltraj([ee_start, ee_end], resolution );
    
    figure(1);


    % draw the non-moving part of the simulation
    dims = max(abs(ee_points(1:3,:)),[],2) + robot_parameters.lower;
    dims(3) = dims(3)-450;
    xlim([-dims(1) dims(1)])
    ylim([-dims(2) dims(2)])
    zlim([0 dims(3)])
    
    % draw the robot platform for every time in time
    for ii=1:size(q,2)
        drawSim( dims ); hold on
        drawRobot( q(:,ii), robot_parameters);
        hold off
        pause(0.01);
    end
end


function drawSim(dims)
    % draw the stationary 3d printer casing as well as the printer tip
    a = -pi : pi/2 : pi;                                % Define Corners
    ph = pi/4;                                          % Define Angular Orientation (‘Phase’)
    x = [cos(a+ph); cos(a+ph)]/cos(ph);
    y = [sin(a+ph); sin(a+ph)]/sin(ph);
    z = [zeros(size(a)); ones(size(a))];
    % Plot Cube
    s = surf(x*dims(1), y*dims(2), z*dims(3)*1.25, 'FaceColor','g','FaceAlpha','flat');  
    alpha(s,.25)
    hold on

    r = dims(1)/3;
    h = dims(3)/4;
    m = (h/r);
    [R,A] = meshgrid(linspace(0,r,11),linspace(0,2*pi,41));
    X = (R .* cos(A));
    Y = (R .* sin(A));
%     Z = (m*R);
    Z = dims(3) + R*m;
    h=surf(X,Y,Z);

end

