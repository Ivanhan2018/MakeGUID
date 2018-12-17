#ifndef _WAYS_H
#define _WAYS_H
#include <stdlib.h>
#include <string.h>
#include "appoint.h"
#include "Mysql_select.h"

class Ways
{
public:
	static string itos(int aa);
	
	static string ftos(float aa);
	
	static int connect_option();
	
	static string connect_parameters(int i);
	
	static int welcome_wind();
	
	static int manager_wind();
	
	static int super_manager_wind();
	
	static int reader_wind();
	
	static void input_id_pwd_wind();
	
	static string input_time_wind();
	
	static void Show_judge(int i);
	
	static int Show_data(MYSQL_RES * point,int * num);
	
	static string Now(int a=0,int b=0,int c=0);

	static string Now_time();
};


#endif