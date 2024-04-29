% input: 3xn end effector positions
% output: timelapse of points plotted onto the screen
function plotPoints( points )
    ii = 1;

    n = size(points, 2);
%     n = 100;  % first 100 points

    % create figure
    f = figure(1);
    dims = max(abs(points),[],2);
    xlim([-dims(1) dims(1)])
    ylim([-dims(2) dims(2)])
    zlim([-dims(3) dims(3)])
    hold on
    camproj('perspective');
    while ii < n
        scatter3( points(1,ii),points(2,ii),points(3,ii) );
        pause(0.1);
        ii = ii + 1;
    end
    hold off


end
