clear;
close all;
clc;


%% load data
fid = fopen('');

if fid == -1 
    error('Cannot Open File'); 
end
u32_data = fscanf(fid,'%s',[8 inf])';   
fclose(fid);

%% 变量定义
total_len = length(u32_data);
buffer = total_len/(16);
sub_sfn = buffer/64;
symb_num = 14;
sc_num = 12;
ant_num = 4;

%% 载波位置
sc_start  = 9; %sc索引，从0开始
sc_sche_num = 3;

%% 数据提取
data_real = hex2dec(u32_data(:,1:4));
data_imag = hex2dec(u32_data(:,5:8));
agc = hex2dec(u32_data(13:16:end,7:8));

max_val = 2^15-1;
index_neg = find(data_real>max_val);
data_real(index_neg) = data_real(index_neg)-2^16;
index_neg = find(data_imag>max_val);
data_imag(index_neg) = data_imag(index_neg)-2^16;

max_val_agc = 2^7-1;
index_neg_agc = find(agc>max_val_agc);
agc(index_neg_agc) = agc(index_neg_agc)-2^8;
%% agc拉齐，可能丢精度
agc = reshape(repmat(agc',[16 1]),[total_len,1]);
data_real = double(bitshift(cast(data_real,'int32'),agc));
data_imag = double(bitshift(cast(data_imag,'int32'),agc));

% 剔除多余4个sc,剔除非调度sc
data_real = reshape(data_real,16,[]);
data_imag = reshape(data_imag,16,[]);

data_real = data_real(sc_start+1:sc_start+sc_sche_num,:);
data_imag = data_imag(sc_start+1:sc_start+sc_sche_num,:);

% 剔除多余2个symb
data_real = reshape(data_real,16*sc_sche_num,[]);
data_imag = reshape(data_imag,16*sc_sche_num,[]);

data_real = data_real(1:sc_sche_num*14,:);
data_imag = data_imag(1:sc_sche_num*14,:);

pow = data_real.*data_real + data_imag.*data_imag;
pow = pow ./ (2^30);
pow = 10*log(pow);

pow = reshape(pow,sc_sche_num,14,4,[]);

pow = [reshape(pow(:,:,1,:),1 ,[])... 
        reshape(pow(:,:,2,:),1 ,[])...
        reshape(pow(:,:,3,:),1 ,[])...
        reshape(pow(:,:,4,:),1 ,[])];

pow = reshape(pow,[],4);

for ii = 1:ant_num
    subplot(2,2,ii);
    plot(pow(:,ii));
    grid on
    title(['ante',num2str(ii)])
end
