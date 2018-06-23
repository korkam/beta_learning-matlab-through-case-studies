% pr4_3.m
% !! run after pr4_1.m !!!
% Simulation of a 1 bit ADC

q=input('Did you run pr4_1.m first (y/n)? : ','s');

if (q=='y');
    
    for k=1:sz;
        for m=1:sz;
            if (NOISE_TRIALS(k,m) < 0);	% Is the element < 0 ?
                NOISE_TRIALS(k,m)=0;	% if yes, the simulated ADC result=0
            else;
                NOISE_TRIALS(k,m)=1;	% if not, the simulated ADC result=1
            end;
        end;
    end;

    average2=sum(NOISE_TRIALS)/sz;
    figure
    plot(average2)                  % Signal between 0 and 1
    title('Signal Averaged with a 1-bit ADC')

else;
    ('Pls run pr4_1 first then return to this script')
end;
    
