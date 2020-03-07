% Exercise 5.4.2.d. Sketching Magnitude Responses from Pole/Zero Plots.
%	Pole & zeros & frequency response of the H4(z) digital filter - animation
%
% Note: This m-file contains large portions of code originally presented in the 
% companion software of the comprehensive and well-written DSP textbook:
% "Digital Signal Processing: Concepts and Applications", 2nd Ed.
% by B.Mulgrew, Peter Grant and John Thompson, Palgrave-Macmillan (2003).
% It was modified as necessary for solving Exercises 5.4.1., 5.4.2. and 5.4.5. 

%% Workspace Initialization.

clear; clc; close all; colordef black;

%% poles & zeros
pp = [ 0.6086*exp(1i*0.96924)  0.6086*exp(-1i*0.96924) ].';
zz  = [ exp(1i*2.4444)  exp(-1i*2.4444) ].';
[b,a] = zp2tf(zz,pp,1);

figure('Name','Exercise 5.4.2.d. Sketching Magnitude Response from Pole/Zero Plots');
subplot(1,2,1);
zplane(b,a);
title(['                    (1 - e^{j2.4444}z^{-1})(1 - e^{-j2.4444}z^{-1})       ';
         'H_4(z)  = ----------------------------------------------------------------';        
         '              (1 - 0.6086e^{j0.9692}z^{-1})(1 - 0.6086e^{-j0.9692}z^{-1}) '
         '                                                                          ';
         '                                                                          ';]);
hold on;
ylim([-1.5 1.5]);
xlim([-1.5 1.5]);

disp('Exercise 5.4.2.d: pole/zero plot - Hit any key to animate')
pause

th = -pi;
pt = exp(1i*th);
xx = real(pt);
yy = imag(pt);
l1 = line('Xdata',xx,'Ydata',yy);
set(l1,'Color','w','Marker','o','EraseMode','xor');
l2 = line('Xdata', real ([ pt pp(1)] ),'Ydata',imag([ pt pp(1)]),'Color','g','LineStyle','-','EraseMode','xor'); 
l3 = line('Xdata', real ([ pt pp(2)] ),'Ydata',imag([ pt pp(2)]),'Color','g','LineStyle','-','EraseMode','xor'); 
l4 = line('Xdata', real ([ pt zz(1)] ),'Ydata',imag([ pt zz(1)]),'Color','b','LineStyle','-','EraseMode','xor'); 
l5 = line('Xdata', real ([ pt zz(2)] ),'Ydata',imag([ pt zz(2)]),'Color','b','LineStyle','-','EraseMode','xor'); 
l6 = line('Xdata', real ([ 0 pt ] ),'Ydata',imag([0 pt ]),'Color','r','LineStyle','-','EraseMode','xor'); 

M = 128;
w = -pi:pi/M:pi;
hh = freqz(b,a,w);

h = abs(hh);
ang = unwrap(angle(hh))/pi*180;
angmax = max(ang);
angmin = min(ang);
maxh = max(h);
if min(h) < 0
	minh = min(h);
else
	minh = 0;
end

subplot(2,2,2)
title('|H_4(j\omega)|');
xx = [ w(1) w(1) ];
yy = [ h(1) h(1) ];
ll1 = line ('Xdata',xx,'Ydata',yy,'Color','y','LineStyle','-','Erasemode','none');
ll2 = line ('Xdata',w(1),'Ydata',h(1),'Color','w','Marker','o','Erasemode','xor');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' });
axis ([ -pi pi minh maxh ]);
grid
ylabel ('gain')
xlabel ('frequency \omega (rad/sample)');
hold on

subplot(2,2,4)
title('\angleH_4(j\omega)');
xx = [ w(1) w(1) ];
yy = [ ang(1) ang(1) ];
lx1 = line ('Xdata',xx,'Ydata',yy,'Color','y','LineStyle','-','Erasemode','none');
lx2 = line ('Xdata',w(1),'Ydata',h(1),'Color','w','Marker','o','Erasemode','xor');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' });
axis ([ -pi pi angmin angmax ]);
grid
ylabel ('phase (degrees)')
xlabel ('frequency \omega (rad/sample)');
hold on

step = 2*pi/M;

for ii = 1:4:2*M+2;
    
    th = -pi + (ii-1)*step/2;
    pt = exp( 1i*th);
    set(l1,'Xdata',real(pt),'Ydata',imag(pt));
    set(l2,'Xdata', real ([ pt pp(1)] ),'Ydata',imag([ pt pp(1)]));
    set(l3,'Xdata', real ([ pt pp(2)] ),'Ydata',imag([ pt pp(2)]));
    set(l4,'Xdata', real ([ pt  zz(1)] ),'Ydata',imag([ pt zz(1)]));
    set(l5,'Xdata', real ([ pt  zz(2)] ),'Ydata',imag([ pt zz(2)]));
    set(l6,'Xdata', real ([0 pt ] ),'Ydata',imag([0 pt ]));
    set(ll1,'Xdata',w(1:ii),'Ydata',h(1:ii));
    set(ll2,'Xdata',w(ii),'Ydata',h(ii));
    
    if ii==1,
        xx = [ w(1) w(1) ];
        yy = [ ang(1) ang(1) ];
    else
        xx = w(ii-1:ii);
        yy = ang(ii-1:ii);
    end
    set(lx1,'Xdata',w(1:ii),'Ydata',ang(1:ii));
    set(lx2,'Xdata',w(ii),'Ydata',ang(ii));
    
    pause(0.25)
    
end
