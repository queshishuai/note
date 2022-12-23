
close all
clear all
clc

%信号的采样率
fs = 30.72;

% % % % ------------生成业务数据----------------------
% data_i = load('E:\工程\SMW200A信号源\100m_491\100m_yw.i');
% data_q = load('E:\工程\SMW200A信号源\100m_491\100m_yw.q');
% data=data_i+j*data_q;
%输入IQ文件，数据为十六进制，要写上扩展名
fid = fopen('\\192.168.40.105\01 2.1g 4tr\2.1G NR数据源\算法数据源\ifft_proc_intv_ch0.am','r');
u32_data = fscanf(fid,'%x',[1 inf]);   
fclose(fid);

u32_data = u32_data.';
lut_len = length(u32_data);
u32_s = dec2hex(u32_data);
%如果是4天线数据，1:1:end中间的’1‘改成4，如果 单天线数据 就不改
u32_i(:,1:4) = u32_s(1:4:end,1:4);
u32_q(:,1:4) = u32_s(1:4:end,5:8);


data_i_temp = hex2dec(u32_i);
data_q_temp = hex2dec(u32_q);

data_i = data_i_temp(1:1:end);
data_q = data_q_temp(1:1:end);

indxi = find(data_i >32767);
data_i(indxi) = data_i(indxi) - 65536;
indxq = find(data_q >32767);
data_q(indxq) = data_q(indxq) - 65536;

data = data_i + data_q *1i;

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


