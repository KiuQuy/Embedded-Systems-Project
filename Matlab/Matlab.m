%parameter for train
m = 1000;  %kg
g = 9.8;
anpha = pi/4;
% state 1
x1 = 0;
h1 = 10;
dx = 0.01;
x2 = 20;
h2 = 30;
x = x1 : dx : x2;
h = x + 10;
% calculate speed
v1 = 5;
v2 = 10;
s = 28;
a = (v2 * v2 - v1 * v1 ) / (2 * s);
t_sum = (v2 - v1) / a;
dt = 0.01;
t = 0 : dt : t_sum;
v = v1 + a * t;

% position ~ speed

v10 = sqrt(2*sqrt(2)*a*x + v1 * v1);
W = 1/2 * m * v2 * v2 + m * g * h2;
%tinh phan luc
F = W - 1/2 * m * v1 * v1 - m * g * h1;
N1 = F + m * a * cos(anpha);

%state 2: down
x3 = 30;
h3 = 0;
x31 = x2 : dx : x3;
x32 = 0: dx : (x3 - x2);
h31 = -3 * x32 + x3;

v3 = sqrt(2 * W / m - 2 * g * h31);
v3max = sqrt(2 * W /m);
a3 = (v3max * v3max - v2 * v2) / (2 * sqrt(1000));
N3 = m * a3;

%calculate speed in state 2
%state 3: straight down
x4 = 35;
x41 = x3 : dx : x4;
x42 = 0 : dx : (x4 - x2);
h41 = 0 * x41;
v4 = sqrt(2 * W / m );
%state 4: loop
x5 = 35;
r5 = 5;
ang5 = 0 : pi/100 : 2*pi;
xunit5 = r5*cos(ang5) + x5;
yunit5 = r5*sin(ang5) + r5;
    %gia toc huong tam: ac 
ac = v4 * v4 / r5;

figure;
hold on;

subplot(3,1,1);
hold on;
%shape of race
plot(x,h,'-om');
plot(x31,h31,'-om');
plot(x41,h41,'-om');
plot(xunit5, yunit5, '-om');

%speed
plot(x,v10,':bs');
plot(x31, v3, ':bs');


%label
xlabel('x _ position');
ylabel('h _ position');



subplot(3,1,2);
hold on;
plot(t,v,':bs');
xlabel('time');
ylabel('speed');


subplot(3,1,3);
hold on;
%Phan luc
plot(x, N1 , '-.*r');
plot(x31, N3, '-.*r');
%label
xlabel('x _ position');
ylabel('Phan luc');



