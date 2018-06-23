% pr1_1.m
sr=400;                                                     % Sample Rate
Nyq_freq=sr/2;                                              % Nyquist Frequency
fneeg=input('Filename  (with path and extension) :', 's');	
t=input('How many seconds in total of EEG ? : ');
ch=input('How many channels of EEG ? : ');
le=t*sr;                                                    % Length of the Recording
fid=fopen(fneeg, 'r', 'l');                                 % *) Open the file to read(‘r’) and little-endian (‘l’)
EEG=fread(fid,[ch,le],'int16');                             % Read Data -> EEG Matrix
fclose ('all');                                             % Close all open Files
