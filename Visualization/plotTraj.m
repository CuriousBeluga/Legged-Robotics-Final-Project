function plotTraj( ee_start, ee_end, robot_parameters )
    resolution = 100;
    % adjust resolution, or amount of points to plot to get to the endpoint
    % time = vector of evenly spaced times going from 0 to duration, with 
    %        size resolution

    [q, ~,~,~,~] = trapveltraj([ee_start, ee_end], resolution );
    
    figure(1);
    
    % draw the robot platform for every time in time
    for ii=1:size(q,2)
        drawRobot( q(:,ii), robot_parameters);
        pause(0.01);
    end
end

