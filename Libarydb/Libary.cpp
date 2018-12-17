#include "Libary.h"
int main()
{
	Ways way;
	int i=way.connect_option();
	Libary * lib;
	if(i==1)
		lib=new Libary();
	if(i==2)
	{
		lib=new Libary(way.connect_parameters(1),way.connect_parameters(2),way.connect_parameters(3),way.connect_parameters(4));
	}
	lib->Lib_Run();
	//system("pause");
	return 0;
}