
close all
clear all
clc

%信号的采样率
% fs = 30.72;
fs = 61.44;
ant = 1;

% % % % ------------生成业务数据----------------------
% data_i = load('E:\工程\SMW200A信号源\100m_491\100m_yw.i');
% data_q = load('E:\工程\SMW200A信号源\100m_491\100m_yw.q');
% data=data_i+j*data_q;
%输入IQ文件，数据为十六进制，要写上扩展名
% fid = fopen('./ul_rru_to_chan_ca_cell_64bit00_data0_hfn_442.txt','r');
% fid = fopen('./ul_rru_to_chan_ca_cell_64bit00_data6_hfn_758_1.txt','r');
% fid = fopen('./ul_rru_to_chan_ca_cell_64bit00_data6_hfn_818.txt','r');
% fid = fopen('./ul_rru_to_chan_ca_cell_64bit00_data6_hfn_782_100_51.txt','r');
% fid = fopen('./ul_rru_to_chan_ca_cell_64bit00_data6_hfn_302_100_msg3.txt','r');
fid = fopen('./data_60M_cmpr.txt','r');


u32_data = fscanf(fid,'%16lx',[1 inf]);   
fclose(fid);

u32_data = u32_data.';
lut_len = length(u32_data);
u32_s = dec2hex(u32_data); 
% u32_i = char(lut_len/4);
% u32_q = char(lut_len/4);
%如果是4天线数据，1:1:end中间的’1‘改成4，如果 单天线数据 就不改

agc = 0;

bit14 = 14;
bit29 = 29 - 1;
bit44 = 44 - 2;
bit59 = 59 - 3;

bit299 = -bit59;



m = 127;
n1 = 0;
n2 =-7;
n3 =-15;
n4 =-22;
n5 =-30;
n6 =-37;
n7 =-45;
n8 =-52;

sft = bitshift(u32_data(1),n2);

bita = bitand(sft,m);
bitb = typecast(bita,'int16');
bitb = bitshift(bitb,9);
bitc = bitshift(bitb,-3);


t1 = bitshift(u32_data(1),-bit59);
tt1 = bitand(t1,8);

agc = bitand(bitshift(u32_data(1),-bit14),1) + ...
    bitand(bitshift(u32_data(1),-bit29),2) + ...
    bitand(bitshift(u32_data(1),-bit44),4) + ...
    bitand(bitshift(u32_data(1),-bit59),8) ;
agcc = 0-typecast(agc,'int64');

u32_i = bitshift(bitshift(typecast(bitand(bitshift(u32_data(1),n1),m),'int16'),9),-typecast(agc,'int64')) ;
u32_q = bitshift(bitshift(typecast(bitand(bitshift(u32_data(1),n2),m),'int16'),9),-typecast(agc,'int64')) ;

u32_tmp_i = zeros(1,4);
u32_tmp_q = zeros(1,4);
for i = 0:lut_len/4 -1
    
    agc = bitand(bitshift(u32_data(4*i+ant),-bit14),1) + ...
    bitand(bitshift(u32_data(4*i+ant),-bit29),2) + ...
    bitand(bitshift(u32_data(4*i+ant),-bit44),4) + ...
    bitand(bitshift(u32_data(4*i+ant),-bit59),8) ;

    u32_tmp_i = bitshift(bitshift(typecast(bitand(bitshift(u32_data(4*i+ant),n1),m),'int16'),9),-typecast(agc,'int64')) ;
    u32_tmp_q = bitshift(bitshift(typecast(bitand(bitshift(u32_data(4*i+ant),n2),m),'int16'),9),-typecast(agc,'int64')) ;
    u32_i(4*i+1) = u32_tmp_i(1);
    u32_q(4*i+1) = u32_tmp_q(1);
    
    u32_tmp_i = bitshift(bitshift(typecast(bitand(bitshift(u32_data(4*i+ant),n3),m),'int16'),9),-typecast(agc,'int64')) ;
    u32_tmp_q = bitshift(bitshift(typecast(bitand(bitshift(u32_data(4*i+ant),n4),m),'int16'),9),-typecast(agc,'int64')) ;
    u32_i(4*i+2) = u32_tmp_i(1);
    u32_q(4*i+2) = u32_tmp_q(1);
    
    u32_tmp_i = bitshift(bitshift(typecast(bitand(bitshift(u32_data(4*i+ant),n5),m),'int16'),9),-typecast(agc,'int64')) ;
    u32_tmp_q = bitshift(bitshift(typecast(bitand(bitshift(u32_data(4*i+ant),n6),m),'int16'),9),-typecast(agc,'int64')) ;
    u32_i(4*i+3) = u32_tmp_i(1);
    u32_q(4*i+3) = u32_tmp_q(1);
    
    u32_tmp_i = bitshift(bitshift(typecast(bitand(bitshift(u32_data(4*i+ant),n7),m),'int16'),9),-typecast(agc,'int64')) ;
    u32_tmp_q = bitshift(bitshift(typecast(bitand(bitshift(u32_data(4*i+ant),n8),m),'int16'),9),-typecast(agc,'int64')) ;
    u32_i(4*i+4) = u32_tmp_i(1);
    u32_q(4*i+4) = u32_tmp_q(1);

end
% u32_i(:,1:2) = u32_s(1:16:end,1:2);
% u32_q(:,1:2) = u32_s(1:16:end,2:3);


% data_i_temp = hex2dec(u32_i);
% data_q_temp = hex2dec(u32_q);
% 
% data_i = data_i_temp(1:1:end);
% data_q = data_q_temp(1:1:end);

data_i = double(u32_i);
data_q = double(u32_q);

% indxi = find(data_i >127);
% data_i(indxi) = data_i(indxi) - 256;
% indxq = find(data_q >127);
% data_q(indxq) = data_q(indxq) - 256;

indxi = find(data_i >32767);
data_i(indxi) = data_i(indxi) - 65536;
indxq = find(data_q >32767);
data_q(indxq) = data_q(indxq) - 65536;

data1 = data_i + data_q*1i;
% data = data1(30720*8:30720*8+2047);
data = data1(245860:245860+2047);

figure
plot(abs(data));
hold off;
grid on;
title('时域图');

figure
len1=length(data);
x=linspace(-fs/2,fs/2,len1);
plot(x,20*log10(abs(fftshift(fft(data./length(data)./2^15)))),'b');
hold off;
grid on;
title('频域图');



status = 1;
InstrObject = 0;

% Use the raw TCP/IP socket connection on port 5025
% [status, InstrObject] = rs_connect( 'tcpip', 'smbv100a255025' );

if( ~status )
    clear;
    disp( 'rs_connect() failed.' );
    return;
end

% target instrument path for waveform file，保存的路径
 InstrTargetPath = 'D:\0927\TM3_1A';                   % MS Windows based, e.g. SMU, SMJ, SMATE, AFQ
%InstrTargetPath = '/var/smbv/';            % Linux based, flash memory, e.g. SMBV
%InstrTargetPath = '/hdd/';                 % Linux based, hard drive, e.g. SMBV 

StartARB         = 1;                       % start in path A
KeepLocalFile    = 1;                       % waveform only temporarily saved
%保存的文件名
LocalFileName    = 'TM3_1A.wv';              % The local and remote file name

% *************************************************************************
% Create Signal
% *************************************************************************

% set the waveform parameters
%数据 的采样率，单位Hz
Fsample =fs*10^6;                            %sample rate is 300MHz
Tperiod = 1/Fsample;                        %sample time interval is 10/3ns
Spacing = 1e6;
% Ponecarrier = 1000000;
% t = [0:1:Ponecarrier-1]*Tperiod;
% 
% Signal_I = randn(1, Ponecarrier);
% Signal_Q = randn(1, Ponecarrier);
% Signal_I = fft(Signal_I);
% Signal_Q = fft(Signal_Q);
% Signal_I(round(0.1 * length(Signal_I)) : round(0.9 * length(Signal_I))) = 0;
% Signal_Q(round(0.1 * length(Signal_I)) : round(0.9 * length(Signal_I))) = 0;
% Signal_I = real(ifft(Signal_I));
% Signal_Q = real(ifft(Signal_Q));
Signal_I = real(data)';
Signal_Q = imag(data)';
Ponecarrier = length(data);
t = [0:1:Ponecarrier-1]*Tperiod;

% Signal_I(1:1:Ponecarrier) = sin(2*pi*Spacing.*t);
% Signal_Q(1:1:Ponecarrier) = cos(2*pi*Spacing.*t);

% *************************************************************************
% Setup Waveform Structure
% *************************************************************************

IQInfo.I_data         = Signal_I;
IQInfo.Q_data         = Signal_Q;
IQInfo.comment        = ''; % optional comment
IQInfo.copyright      = 'Rohde&Schwarz';    % optional copyright
IQInfo.clock          = Fsample;            % sample rate
IQInfo.no_scaling     = 0;                  % do not scale level
IQInfo.path           = InstrTargetPath;    % location on instrument 
IQInfo.filename       = LocalFileName;      % local and remote file name
IQInfo.markerlist.one = [[0 1];[1 0]];      % marker signal 1
% IQInfo.markerlist.two = [[0 1];[1 0]];

% *************************************************************************
% Plot Data
% *************************************************************************

% rs_visualize( Fsample, IQInfo.I_data, IQInfo.Q_data );

% *************************************************************************
% Instrument Setup
% *************************************************************************

% check for R&S device, we also need the *IDN? result later...
disp( 'Genarate waveform...' );

% generate and send waveform
[status] = rs_generate_wave( InstrObject, IQInfo, StartARB, KeepLocalFile );
% if( ~status ); clear;  return; end

disp( 'Complete...' );

% clear variables
% clear;

% return;


