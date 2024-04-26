
function J = Jacobian(P)
Rm = 250/2; Rf = 650/2; % diameter of top and bottom platform in mm
alpha = 40*pi/180; beta = 80*pi/180; % angle of seperation for top and bottom platforms
dt = 0.1; % Time increment
botParams = [Rm, Rf, alpha, beta, dt];

Xp=P(1:3,1);
teta=P(4:6,1);
[IK]=InverseKinematics(P, botParams);

R=[cos(teta(3))*cos(teta(2)),-sin(teta(3))*cos(teta(1))+sin(teta(1))*sin(teta(2))*cos(teta(3)),sin(teta(1))*sin(teta(3))+cos(teta(1))*cos(teta(3))*sin(teta(2));
    sin(teta(3))*cos(teta(2)),cos(teta(3))*cos(teta(1)),sin(teta(1))*sin(teta(2))*sin(teta(3));
    -sin(teta(2)),sin(teta(1))*cos(teta(2)),cos(teta(1))*cos(teta(2))];

% s from Table 1 in the paper:
s=[Rm*cos(beta/2),-Rm*sin(pi/6-beta/2),-Rm*sin(pi/6+beta/2),-Rm*cos(pi/3-beta/2),-Rm*cos(pi/3+beta/2),Rm*cos(beta/2);
    Rm*sin(beta/2),Rm*cos(pi/6-beta/2),Rm*cos(pi/6+beta/2),-Rm*sin(pi/3-beta/2),-Rm*sin(pi/3+beta/2),-Rm*sin(beta/2);
    0,0,0,0,0,0];

J=[n(:,1)',cross(R*s(:,1),n(:,1))';
    n(:,2)',cross(R*s(:,2),n(:,2))';
    n(:,3)',cross(R*s(:,3),n(:,3))';
    n(:,4)',cross(R*s(:,4),n(:,4))';
    n(:,5)',cross(R*s(:,5),n(:,5))';
    n(:,6)',cross(R*s(:,6),n(:,6))'];