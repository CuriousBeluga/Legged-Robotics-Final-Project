function plotTraj( ee_start, ee_end, robot_parameters )
    resolution = 100;
    % adjust resolution, or amount of points to plot to get to the endpoint
    % time = vector of evenly spaced times going from 0 to duration, with 
    %        size resolution
    time = linspace(0, 1, resolution+1);
%     delta_t = diff(time);

    ee_points = zeros(6, resolution);

%     q = zeros(2, resolution);
    delta_q = zeros(6, resolution);

    [q, ~,~,~,~] = trapveltraj([ee_start, ee_end], resolution );
    
    figure(1);
    
    % draw the robot platform for every time in time
    for ii=1:size(q,2)
        drawPlatform( q(:,ii), robot_parameters);
        pause(0.01);
    end
end

