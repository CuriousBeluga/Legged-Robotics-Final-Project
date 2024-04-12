function plotTraj( ee_start, ee_end, robot_parameters )
    resolution = 10;
    % adjust resolution, or amount of points to plot to get to the endpoint
    % time = vector of evenly spaced times going from 0 to duration, with 
    %        size resolution
    time = linspace(0, 1, resolution+1);
%     delta_t = diff(time);

    ee_points = zeros(6, resolution);

%     q = zeros(2, resolution);
    delta_q = zeros(6, resolution);
    
    % for each of the ee fields, calculate a trajectory
    for ii=1:6
        %ee_points(ii,:) = interp1( [0 1], [ee_start(ii) ee_end(ii)], time );
        [q, ~,~,~,~] = trapveltraj([0 1; ee_start(ii) ee_end(ii)], resolution );
        ee_points(ii,:) = q(2,:);
        delta_q(ii,:) = q(1,:);
    end
    
    figure;
    

    % draw the robot platform for every time in time
    for ii=1:size(ee_points,2)
        drawPlatform( ee_points(:,ii), robot_parameters);
        if ii < length(time)
            pause(delta_q(1,ii));
        end
    end
end

