function complexdata = readdata(filename)
fileId=fopen(filename,'r') ;
A=fscanf(fileId,' 0x%x,\n' ) ;
fclose (fileId) ;
fdatai=mod(bitand(A,2^16-1)+2^15,2^16)-2^15;
fdataq=mod(bitshift(A,-16)+2^15, 2^16)-2^15;
complexdata=fdatai+1j*fdataq;
end
