function [complexdata]=byte2complex(filename)
fid = fopen(filename, 'r');
source_byte = fread(fid, inf, 'uint8');
fclose(fid);
index = 1;
for i = 1:length(source_byte)/4
    signalTimeSlotRX(index) = source_byte(1 + (i-1)*4) + bitshift(source_byte(2 + (i-1)*4),8)...
    + bitshift(source_byte(3 + (i-1)*4), 16) + bitshift(source_byte(4+(i-1)*4), 24);
    index = index + 1;
end

fdatai = mod(bitand(signalTimeSlotRX, 2^16-1) + 2^15,2^16)-2^15;
fdataq = mod(bitshift(signalTimeSlotRX, -16) + 2^15,2^16)-2^15;
complexdata = fdatai+1i*fdataq;

