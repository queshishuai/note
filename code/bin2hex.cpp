#include <stdio.h>
#include <stdint.h>
#include <iostream>
#include <fstream>
#include <string>
#include <stdlib.h>
#include <iomanip>

typedef unsigned char uint8_t;

typedef unsigned short uint16_t;
typedef short int16_t;
typedef unsigned int uint32_t;
typedef int int32_t;


//unsigned char g_buffer[6400000] = {0};
//int length;


int main(int argc,char** argv)
{
	//printf("%s\n",argv[1]);
	FILE*file = fopen(argv[1],"rb");
    std::string write_file_name = "hex_";
	write_file_name.append(argv[1]);
	void *p_buffer;
	int j;
	
    if(file == NULL)
    {
        printf("file open err!\n");
		return -1;
    }
	
	// Move file pointer to the end of the file
    fseek(file, 0, SEEK_END);

    // Get the file size
    long fileSize = ftell(file);

    // Move file pointer back to the beginning of the file
    fseek(file, 0, SEEK_SET);

    printf("File size: %ld bytes,%ld lines\n", fileSize,fileSize/4);
	
	p_buffer = malloc(fileSize);
	
	if (0 != p_buffer)
	{
		fread((void*)p_buffer,fileSize,1,file);
		fclose(file);
	}
	else
	{
		printf("malloc %ld bytes fail!\n",fileSize);
		fclose(file);
		return -1;
	}
	
    std::ofstream os;
    os.open(write_file_name,std::ios::out);

    std::string str;
    int *ptr = (int *)p_buffer;
    for(j = 0;j < fileSize;j+=4)
    {
        os << "0x";
        os << std::setw(8) << std::setfill('0') << std::hex << *(ptr++) << "," << std::endl;
    }
	os.close();
	return 0;
}
#if 0
int main(int argc,char** argv)
{
    int i,j,k;
    int c;
    length = 4 * atoi(argv[1]);//行号
    FILE*fp = fopen("./input.dat","rb");
    std::string write_file_name = "./output.dat";
    if(fp == NULL)
    {
        printf("file open err!");
    }

    printf("end\n");
    //printf("g_buffer size=%d\n",sizeof(g_buffer));
    fread((void*)&g_buffer[0],sizeof(g_buffer),1,fp);
    fclose(fp);

    std::ofstream os;
    os.open(write_file_name,std::ios::out);

    std::string str;
    int *ptr = (int *) &g_buffer[0];
    for(j = 0;j < length;j+=4)
    {
        os << "0x";
        os << std::setw(8) << std::setfill('0') << std::hex << *(ptr++) << "," << std::endl;
    }
    return 0;
}
#endif
