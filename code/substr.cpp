#include <iostream>
#include <string>
#include <fstream>

using namespace std;
int main(int argc,char *argv[])
{
    ifstream file(argv[1]);
    if(!file.is_open())
    {
        cout << "file open fail\n";
    }
    else
    {
        string line;
        while(getline(file,line))
        {
            cout << "0x"<< line.substr(line.size()-8) << ',' << endl;
        }
        file.close();
    }
    return 0;
}
