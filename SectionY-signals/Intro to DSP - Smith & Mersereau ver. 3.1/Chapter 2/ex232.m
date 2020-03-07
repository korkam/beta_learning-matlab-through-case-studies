%% Exercise 2.3.2. An Interpretation of Convolution.

%   Copyright 2012-2016, Ilias S. Konsoulas

% Attention: Maximize the resulting figure for best visual interpretation.
clc; clear; close all;

aa = [.3  -.2  .4  .5  -.3];
n = 0:4;

delta0 = [1 0 0 0 0 0];  % ä[n]
delta1 = [0 1 0 0 0 0];  % ä[n-1]
delta2 = [0 0 1 0 0 0];  % ä[n-2]
delta3 = [0 0 0 1 0 0];  % ä[n-3]

delta = [delta0; delta1; delta2; delta3;];
n1 = 0:5;

y0 = conv(aa,delta0);
y1 = conv(aa,delta1);
y2 = conv(aa,delta2);
y3 = conv(aa,delta3);
y   = [y0; y1; y2; y3;];
n2 = 0:size(y0,2)-1;

x = delta0 + delta1 + delta2 + delta3;
yt = conv(aa,x);

% Maximize this figure to see the convolution interpretation correctly.
fig = figure('Name','Exercise 2.3.2. An Interpretation of Convolution', ...
                   'Position', [50  50  1200 700] );

for i=1:4
     subplot(5,3,3*(i-1)+1);
     stem(n1,delta(i,:),'*');
     if i==1
        title('\delta[n]'); 
     else
       title(['\delta[n-',num2str(i-1),']']);
     end
     grid;
     axis tight;
   
     subplot(5,3,3*(i-1)+2);
     stem(n,aa,'r*');
     title('aa[n]'); 
     grid;
     axis tight;
   
     subplot(5,3,3*(i-1)+3);
     stem(n2,y(i,:),'m*');
     if i==1
        title('aa[n]'); 
     else
        title(['aa[n-',num2str(i-1),']']);
     end
     grid;
     axis tight;
end

 subplot(5,3,13);
 stem(n1,x,'*');
 title('x[n]=\delta[n]+\delta[n-1]+\delta[n-2]+\delta[n-3]');
 grid;
 axis tight;

 subplot(5,3,14);
 stem(n,aa,'r*');
 title('aa[n]'); 
 grid;
 axis tight;

 subplot(5,3,15);
 stem(0:size(y,2)-1,yt,'g*');
  title('y[n] = x[n]\astaa[n]');
 grid;
 axis tight;
 
%% Annotate the Produced Figure with math symbols as necessary:
% (Maximize the figure in order symbols to appear correctly).
x = 0.365;
y = 0.095;
annotation('textbox',[x y 0.1 0.1],'String','\ast','FontSize',26,'LineStyle','none');

y = 0.27;
annotation('textbox',[x y 0.1 0.1],'String','\ast','FontSize',26,'LineStyle','none');

y = 0.44;
annotation('textbox',[x y 0.1 0.1],'String','\ast','FontSize',26,'LineStyle','none');

y = 0.61;
annotation('textbox',[x y 0.1 0.1],'String','\ast','FontSize',26,'LineStyle','none');

y = 0.79;
annotation('textbox',[x y 0.1 0.1],'String','\ast','FontSize',26,'LineStyle','none');

x = 0.64;
y = 0.095;
annotation('textbox',[x y 0.1 0.1],'String','=','FontSize',26,'LineStyle','none');

y = 0.27;
annotation('textbox',[x y 0.1 0.1],'String','=','FontSize',26,'LineStyle','none');

y = 0.44;
annotation('textbox',[x y 0.1 0.1],'String','=','FontSize',26,'LineStyle','none');

y = 0.61;
annotation('textbox',[x y 0.1 0.1],'String','=','FontSize',26,'LineStyle','none');

y = 0.79;
annotation('textbox',[x y 0.1 0.1],'String','=','FontSize',26,'LineStyle','none');

x = 0.15;
y = 0.175;
annotation('textbox',[x y 0.1 0.1],'String','=','FontSize',26,'LineStyle','none');

y = 0.35;
annotation('textbox',[x y 0.1 0.1],'String','+','FontSize',26,'LineStyle','none');

y = 0.52;
annotation('textbox',[x y 0.1 0.1],'String','+','FontSize',26,'LineStyle','none');

y = 0.7;
annotation('textbox',[x y 0.1 0.1],'String','+','FontSize',26,'LineStyle','none');

x = 0.86;
y = 0.175;
annotation('textbox',[x y 0.1 0.1],'String','=','FontSize',26,'LineStyle','none');

y = 0.35;
annotation('textbox',[x y 0.1 0.1],'String','+','FontSize',26,'LineStyle','none');

y = 0.52;
annotation('textbox',[x y 0.1 0.1],'String','+','FontSize',26,'LineStyle','none');

y = 0.7;
annotation('textbox',[x y 0.1 0.1],'String','+','FontSize',26,'LineStyle','none');
