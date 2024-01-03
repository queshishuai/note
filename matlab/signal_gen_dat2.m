% qyl v1.0 20201209


clc;clearvars;close all;

% 杈撳叆鍙傝?鏂囦欢
% 涓?埇涓?澶╃嚎鏁版嵁鍩哄甫鏁版嵁锛堥暱搴?915200锛夛紝涔熷彲浠ユ槸鍗曞ぉ绾垮熀甯︽暟鎹紙闀垮害1228800锛?
%filename_cankao = 'ifft_proc_intv_ch0.am';
filename_cankao = 'ulpre_cp_indata0_10ms.dat';
%
filename_cankao_split = split(filename_cankao,'.');

% 杈撳嚭婧愭枃浠?
filename_out = sprintf('%s_N5182A_source.dat',filename_cankao_split{1});

%%

fid = fopen(filename_cankao,'r');
cp_o_data = fscanf(fid,'%08x');%4915200
fclose(fid);

if length(cp_o_data) == 4915200
    cp_o_data = cp_o_data(1:4:end);
% elseif length(cp_o_data) == 4915200/4
%     cp_o_data = cp_o_data;
end

data_real=fix(cp_o_data/2^16);
data_imag=mod(cp_o_data,2^16);
clear cp_o_data;

max_val = 2^15-1;
index_neg = find(data_real>max_val);
data_real(index_neg) = data_real(index_neg)-2^16;
index_neg = find(data_imag>max_val);
data_imag(index_neg) = data_imag(index_neg)-2^16;    

MaxValue = max(max([abs(data_real),abs(data_imag)]));
ap_data = data_real + 1i * data_imag;
clear data_real data_imag index_neg

Signal4TransmitingFinal = fix ( ap_data * ( (2^15-0.1)/MaxValue ) );
clear ap_data MaxValue

if max(real(Signal4TransmitingFinal))>(2^15-1) || max(imag(Signal4TransmitingFinal))>(2^15-1)
    error('鏈?ぇ鍊艰秴瓒?');
elseif min(real(Signal4TransmitingFinal))<-2^15 || min(imag(Signal4TransmitingFinal))<-2^15
    error('鏈?皬鍊艰秴瓒?');
end

%%
% Signal4TransmitingFinal1 = reshape(Signal4TransmitingFinal,4,[]).';
% fid = fopen(filename_out,'w');
% for i = 1:size(Signal4TransmitingFinal1,1)
%     data_a = [real(Signal4TransmitingFinal1(i,:));imag(Signal4TransmitingFinal1(i,:))];
%     data_a = reshape(data_a,1,[]);
%     data_a(data_a<0) = data_a(data_a<0)+2^16;
%     fprintf(fid,'%04x %04x %04x %04x %04x %04x %04x %04x\n',data_a(:));
% %     fprintf('%04x %04x %04x %04x %04x %04x %04x %04x\n',data_a(:));
% end
% fclose(fid);

%%
data_a = reshape([real(Signal4TransmitingFinal),imag(Signal4TransmitingFinal)].',[],1);
% data_a(data_a<0) = data_a(data_a<0)+2^16;

fid = fopen(filename_out,'w');
fwrite(fid,data_a,'int16','b');
fclose(fid);



