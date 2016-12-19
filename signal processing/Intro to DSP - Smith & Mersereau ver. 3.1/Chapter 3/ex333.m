 % Exercise 3.3.3. A Parallel System.

 %   Copyright 2012-2016, Ilias S. Konsoulas.
 
 %% Workspace Initialization.
 
 clc; clear; close all;

%% Step (a). Display the Magnitude of H1(jù) and H2(jù).
h1 = [  0.04 -0.04 -0.3  0.6 -0.3 -0.04 0.04 ];
n1 = 0:6;


h2 = [  0.09 -0.12 -0.5 -0.5 0.12 0.09];
n2 = 0:5;

[~, H1] = my_DTFT(h1,n1);

[w H2] = my_DTFT(h2,n2);

figure('Name','Exercise 3.3.3. A Parallel System'); 
subplot(3,2,1);
plot(w,abs(H1));
set(gca,'XTick',[0 pi/4 pi/2 3*pi/4 pi]);
set(gca,'XTickLabel',{'0','pi/4','pi/2','3pi/4','pi' })
ylim([0 1.15]);
xlim([0 pi]);
grid on;
title('|{\itH_1}(j\omega)|');

subplot(3,2,2);
plot(w,angle(H1));
set(gca,'XTick',[0 pi/4 pi/2 3*pi/4 pi]);
set(gca,'XTickLabel',{'0','pi/4','pi/2','3pi/4','pi' })
xlim([0 pi]);
grid on;
title('\angle{\itH_1}(j\omega)');

subplot(3,2,3)
plot(w,abs(H2));
set(gca,'XTick',[0 pi/4 pi/2 3*pi/4 pi]);
set(gca,'XTickLabel',{'0','pi/4','pi/2','3pi/4','pi' })
ylim([0 1.15]);
xlim([0 pi]);
grid on;
title('|{\itH_2}(j\omega)|');

subplot(3,2,4);
plot(w,angle(H2));
set(gca,'XTick',[0 pi/4 pi/2 3*pi/4 pi]);
set(gca,'XTickLabel',{'0','pi/4','pi/2','3pi/4','pi' })
xlim([0 pi]);
grid on;
title('\angle{\itH_2}(j\omega)');


%% Step (b). Display the Magnitude of H3(jù) = DTFT{h1[n] + h2[n])}.
h3 = [ h1(1:6)+h2  h1(7)];  % Durates from n = 0 to n = 6.
n3 = n1;

[w H3] = my_DTFT(h3,n3);

%% Plot the results.
subplot(3,2,6)
plot(w,angle(H3));
set(gca,'XTick',[0 pi/4 pi/2 3*pi/4 pi]);
set(gca,'XTickLabel',{'0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
hold on;
xlim([0 pi]);
grid on;
title('\angle{\itH_3}(j\omega) = \angle{[{\itH_1}(j\omega)+{\itH_2}(j\omega)]}');

subplot(3,2,5)
plot(w,abs(H3));
set(gca,'XTick',[0 pi/4 pi/2 3*pi/4 pi]);
set(gca,'XTickLabel',{'0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([0 pi]);
ylim([0 1]);
grid on;
title('{|\itH_3}(j\omega)| = |DTFT\{{\ith_1}[n] + {\ith_2}[n]\}| = |{\itH_1}(j\omega)+{\itH_2}(j\omega)|');
hold on;

% Verify that this is true:
disp('Press any key to continue...');
pause();
stem(w,abs(H1+H2),'r.','Marker','none');

subplot(3,2,6)
stem(w,angle(H1 + H2),'r.','Marker','none');
xlim([0 pi]);
grid on;
