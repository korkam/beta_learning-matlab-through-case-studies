% Exercise 5.4.6. Interaction of Poles and Zeros.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

    clc; clear; close all;
    
%% Step (a). First move the zero towards the pole on the real axis.
NSamples = 128;
w = -pi:pi/NSamples:pi;
zer1 = -2:0.1:2;
pol1 = 0.5;

figure('Name','Exercise 5.4.6. Interaction of Poles and Zeros - Zero Movement');
  
for k=1:length(zer1)
    
    b = [1 -zer1(k)];
    a = [1 -pol1    ];

    subplot(1,2,1);
    zplane(b,a);
    if zer1(k)<0
           title(['H(z) = (1 + ',num2str(-zer1(k)),'z^{-1})/(1 - 0.5z^{-1})']);
    elseif zer1(k)==0
           title('H(z) = 1/(1 - 0.5z^{-1})');
    elseif zer1(k)>0
           title(['H(z) = (1 - ',num2str(zer1(k)),'z^{-1})/(1 - 0.5z^{-1})']);
    end
    grid on;
    
    H = freqz(b,a,w);
    subplot(1,2,2);
    plot(w,abs(H));
    title('|H(z)|');   
  
    set(gca,'XTick',-pi:pi/4:pi);
    set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' });
    xlim([-pi pi]);
    xlabel('Digital Frequency (rad/sample)');
    axis tight;
    grid on;

    pause(1);
    
end

%% Now plot the "big picture"
point_n = 100;
zer1 = linspace(-2,2, point_n);
[xx, yy] = meshgrid(w,zer1);
HH1 = zeros(size(xx));

 a = [1  -pol1];  
 
 for i=1:point_n
      b = [1  -zer1(i)];
      HH1(i,:) = abs(freqz(b,a,w));
 end
  
figure('Name','Exercise 5.4.6. Interaction of Poles and Zeros');
meshc(xx,yy,HH1);
xlabel('Digital Frequency (rad/sample)');
ylabel('Zero Values in [-2 2]');
zlabel('|H(z)|');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' });
xlim([-pi pi]);
xlabel('Digital Frequency (rad/sample)');

%% Step (b). Now move the pole towards the zero on the real axis.
pol2 = -2:0.1:2;
zer2 = 0.5;

figure('Name','Exercise 5.4.6. Interaction of Poles and Zeros - Pole Movement');
  
for k=1:length(pol2)
    
    b = [1 -zer2];
    a = [1 -pol2(k)];

    subplot(1,2,1);
    zplane(b,a);
    if pol2(k)<0
           title(['H(z) = (1 - 0.5z^{-1})/(1 + ',num2str(-pol2(k)),'z^{-1})']);
    elseif pol2(k)==0
           title('H(z) = 1 - 0.5z^{-1}');
    elseif pol2(k)>0
           title(['H(z) = (1 - 0.5z^{-1})/(1 - ',num2str(pol2(k)),'z^{-1})']);
    end
    grid on;
    
    H = freqz(b,a,w);
    subplot(1,2,2);
    plot(w,abs(H));
    title('|H(z)|');       
    
   set(gca,'XTick',-pi:pi/4:pi);
   set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' });
   xlim([-pi pi]);
   xlabel('Digital Frequency (rad/sample)');
   axis tight;
   grid on;
   pause(1);
        
end

%% Now plot the "big picture"
point_n = 100;
pol2 = linspace(-2,2, point_n);
[xx, yy] = meshgrid(w,pol2);
HH2 = zeros(size(xx));

 a = [1  -zer2];  
 
 for i=1:point_n
      a = [1 -pol2(i)];
      HH2(i,:) = abs(freqz(b,a,w));
 end
  
figure('Name','Exercise 5.4.6. Interaction of Poles and Zeros');
meshc(xx,yy,HH2);
zlim([0 6]);
xlabel('Digital Frequency (rad/sample)');
ylabel('Pole Values in [-2 2]');
zlabel('|H(z)|');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' });
xlim([-pi pi]);
xlabel('Digital Frequency (rad/sample)');
