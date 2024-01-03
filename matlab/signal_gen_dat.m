clear all;
close all;
clc;

filename = 'src/ulpre_cp_indata_aau0_10ms.dat';

fid = fopen(filename,'r');
cp_o_data = fscanf(fid,'%08x');%4915200
fclose(fid);


%% fix point to double float 
data_real=fix(cp_o_data/2^16);
data_imag=mod(cp_o_data,2^16);


max_val = 2^15-1;
index_neg = find(data_real>max_val);
data_real(index_neg) = data_real(index_neg)-2^16;
index_neg = find(data_imag>max_val);
data_imag(index_neg) = data_imag(index_neg)-2^16;    
data = data_real + 1j*data_imag; 

ap_data = data / 2^15;
figure;
plot(abs(ap_data))



MaxValue = max(max([real(ap_data),imag(ap_data)]));
factor = 2*MaxValue;

Signal4TransmitingFinal = ap_data/factor;
% Signal4TransmitingFinal = fftshift(Signal4TransmitingFinal);
figure
plot(real(Signal4TransmitingFinal(1:4:end)));
figure
plot(imag(Signal4TransmitingFinal(1:4:end)) , 'r');


% fft_result = Signal4TransmitingFinal(1:4:end);
% fft_result_1 = fft_result(1:1:2048);
% fft_result_2 = fftshift(fft(fft_result_1,2048));
% fs1 = 20;
% xxx=linspace(-fs1/2,fs1/2,2048);
% figure(10)
% plot(xxx',abs(fft_result_2));

figure(11)
plot(abs(Signal4TransmitingFinal(1:4:end)))
fvtool(Signal4TransmitingFinal(1:4:end))

signal_out_real=real(Signal4TransmitingFinal);
signal_out_imag=imag(Signal4TransmitingFinal);

%只留子帧2的数据
% for ii = 1:30720*4*2
%     signal_out_real(ii) = 0;
%     signal_out_imag(ii) = 0;
% end
% for ii = 30720*4*3+1:30720*4*10
%     signal_out_real(ii) = 0;
%     signal_out_imag(ii) = 0;
% end
% figure(12)
% plot(abs(signal_out_real(1:4:end)))
% figure(13)
% plot(abs(signal_out_imag(1:4:end)))
%只留子帧2的数据end

csvwrite('ulpre_cp.i',signal_out_real(1:4:end));
csvwrite('ulpre_cp.q',signal_out_imag(1:4:end));
fclose all

