function plotTraj( nodes, LegsT, botParams )
    save_video = true;
    debug = false;

    if save_video
        % initialize video saving 
        vidfile = VideoWriter('testmovie.mp4','MPEG-4');
        open(vidfile);
    end

    if debug
        % only plot every 200 nodes
        nodes = nodes(:,1:20:end);
    end

%     resolution = 100;
    % adjust resolution, or amount of points to plot to get to the endpoint
    % time = vector of evenly spaced times going from 0 to duration, with 
    %        size resolution

%     [q, ~,~,~,~] = trapveltraj([ee_start, ee_end], resolution );
    nodes = -1*nodes.*1000;

    figure(1);
    % draw the non-moving part of the simulation
    dims = max(abs(nodes(1:3,:)),[],2);
    dims(3) = dims(3);
%     xlim([-dims(1)-50 dims(1)+50])
%     ylim([-dims(2)-50 dims(2)+50])
%     zlim([0 dims(3)])

    xlim([-(botParams(2)+botParams(1)) (botParams(2)+botParams(1))])
    ylim([-(botParams(2)+botParams(1)) (botParams(2)+botParams(1))])
    zlim([0 dims(3)])

    if debug
        figure(2);
        xlim([-dims(1) dims(1)])
        ylim([-dims(2) dims(2)])
        zlim([0 dims(3)])
    end
    
    % draw the robot platform for every time in time
    num_nodes = size(nodes,2);
    for ii=1:num_nodes
        figure(1);
        drawSim( dims, botParams ); hold on
        drawRobot( nodes(:,ii), LegsT.l{ii}, LegsT.u{ii}, LegsT.t(ii), botParams);
        view(60,5);
        hold off
        if save_video
            frame = getframe(gcf); 
            writeVideo(vidfile,frame);
        end
        if debug
            figure(2);
            % draw end effector points
            scatter3( nodes(1,ii), nodes(2,ii), nodes(3,ii) ); hold on
            x = [nodes(1,ii); nodes(1,mod(ii,num_nodes)+1)];
            y = [nodes(2,ii); nodes(2,mod(ii,num_nodes)+1)];
            z = [nodes(3,ii); nodes(3,mod(ii,num_nodes)+1)];
            plot3(x,y,z, 'Color', 'red'); 
        end
        pause(0.001);
    end

    if save_video
        close(vidfile)
    end
end


function drawSim(dims, botParams)
    % draw the stationary 3d printer casing as well as the printer tip
    a = -pi : pi/2 : pi;                                % Define Corners
    ph = pi/4;                                          % Define Angular Orientation (‘Phase’)
    x = [cos(a+ph); cos(a+ph)]/cos(ph);
    y = [sin(a+ph); sin(a+ph)]/sin(ph);
    z = [zeros(size(a)); ones(size(a))];
    % Plot Cube
    s = surf(x*(botParams(2)+botParams(1)), y*(botParams(2)+botParams(1)), z*dims(3), 'FaceColor','g','FaceAlpha','flat');  
    alpha(s,.25)
    hold on

    scatter3(0, 0, dims(3), 'filled', 'o');

%     r = dims(1)/3;
%     h = dims(3)/4;
%     m = (h/r);
%     [R,A] = meshgrid(linspace(0,r,11),linspace(0,2*pi,41));
%     X = (R .* cos(A));
%     Y = (R .* sin(A));
% %     Z = (m*R);
%     Z = dims(3) + R*m;
%     h=surf(X,Y,Z);

end

