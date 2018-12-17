#include "ways.h"

string Ways::itos(int aa)
{
	string str;   
	char ch[10];   
	//itoa(aa,ch,10); 
	sprintf(ch,"%d",aa);  
	str.append(ch);
	return str;
}

string Ways::ftos(float aa)
{
	char str[10];
	string b;
	sprintf(str,"%f",aa);
	b.append(str);
	return b;
}

int Ways::connect_option()
{
	cout<<"**************************************"<<endl;
	cout<<"*       请选择连接服务器的方式       *"<<endl;
	cout<<"*------------------------------------*"<<endl;
	cout<<"*       1.默认     2.手动配置        *"<<endl;
	cout<<"*------------------------------------*"<<endl;
	int i=3;
	while(i!=1 && i!=2)
	{
		cin>>i;
	}
	return i;
}

string Ways::connect_parameters(int i)
{
	string str;
	if(i==1)
	{
		cout<<"*------------------------------------*"<<endl;
		cout<<"*  对方IP:"<<endl;;
		cin>>str;
		return str;
	}
	if(i==2)
	{
		cout<<"*  用户名:"<<endl;
		cin>>str;
		return str;
	}
	if(i==3)
	{
		cout<<"*  密码:"<<endl;
		cin>>str;
		return str;
	}
	if(i==4)
	{
		cout<<"*  数据库:"<<endl;
		cin>>str;
		cout<<"*------------------------------------*"<<endl;
		return str;
	}
}

int Ways::welcome_wind()
{
	cout<<"*************************************"<<endl;
	cout<<"*           欢迎使用本系统          *"<<endl;
	cout<<"*-----------------------------------*"<<endl;
	cout<<"*    1.管理员    2.读者    0.退出   *"<<endl;
	cout<<"*************************************"<<endl;
	int i;
	cin>>i;
	return i;
}

int Ways::manager_wind()
{
	cout<<"*************************************"<<endl;
	cout<<"*        1.未归还书本查询           *"<<endl;
	cout<<"*        2.超期未还查询             *"<<endl;
	cout<<"*        3.修改图书信息             *"<<endl;
	cout<<"*        4.图书馆书籍总查询         *"<<endl;
	cout<<"*        5.还书操作                 *"<<endl;
	cout<<"*        6.借书操作                 *"<<endl;
	cout<<"*        7.更改密码操作             *"<<endl;
	cout<<"*        8.查询图书信息             *"<<endl;
	cout<<"*        9.图书挂失                 *"<<endl;
	cout<<"*        10.挂失图书归还            *"<<endl;
	cout<<"*        11.处理读者预约            *"<<endl;
	cout<<"*        0.返回上一层               *"<<endl;	
	cout<<"*************************************"<<endl;
	int i;
	cin>>i;
	return i;
}

int Ways::super_manager_wind()
{
	cout<<"*************************************"<<endl;
	cout<<"*         1.增加管理员              *"<<endl;
	cout<<"*         2.增加图书                *"<<endl;
	cout<<"*         3.增加学生                *"<<endl;
	cout<<"*         4.去除管理员              *"<<endl;
	cout<<"*         5.删除图书                *"<<endl;
	cout<<"*         6.去除学生                *"<<endl;
	cout<<"*         7.显示所有学生信息        *"<<endl;
	cout<<"*         8.显示所有管理员信息      *"<<endl;
	cout<<"*         9.显示所有图书信息        *"<<endl;
	cout<<"*         10.管理员操作查询         *"<<endl;
	cout<<"*         11.借还书记录总查询       *"<<endl;
	cout<<"*         12.预约记录总查询         *"<<endl;
	cout<<"*         0.退出                    *"<<endl;
	cout<<"*************************************"<<endl;
	int i;
	cin>>i;
	return i;
}

int Ways::reader_wind()
{
	cout<<"*************************************"<<endl;
	cout<<"*        1.丢失书本查询             *"<<endl;
	cout<<"*        2.赔款书本查询             *"<<endl;
	cout<<"*        3.图书馆在册书查询         *"<<endl;
	cout<<"*        4.借阅历史查询             *"<<endl;
	cout<<"*        5.现借书及情况查询         *"<<endl;
	cout<<"*        6.更改密码操作             *"<<endl;
	cout<<"*        7.预定图书操作             *"<<endl;
	cout<<"*        8.取消预订图书操作         *"<<endl;
	cout<<"*        9.预约情况查询             *"<<endl;
	cout<<"*        0.返回上一层               *"<<endl;
	cout<<"*************************************"<<endl;
	int i;
	cin>>i;
	return i;
}

void Ways::input_id_pwd_wind()
{
	cout<<"*************************************"<<endl;
	cout<<"*        请输入你的id号及密码       *"<<endl;
	cout<<"*************************************"<<endl;
}

string Ways::input_time_wind()
{
	cout<<"*************************************"<<endl;
	cout<<"*           请输入截止日期          *"<<endl;
	cout<<"*-----------------------------------*"<<endl;
	cout<<"*      年：      月：      日：     *"<<endl;
	cout<<"*************************************"<<endl;
	int i,j,k;
	cin>>i>>j>>k;
	string str="";
	str=itos(i)+"-"+itos(j)+"-"+itos(k);
	return str;
}

void Ways::Show_judge(int i)
{
	if(i==1)
		cout<<"执行成功"<<endl;
	else if(i==2)
		cout<<"执行失败"<<endl;
	else 
		cout<<"未连接到数据库"<<endl;
}

int Ways::Show_data(MYSQL_RES * point,int * num)
{
	long j = mysql_num_fields(point); 
	MYSQL_FIELD * field = mysql_fetch_fields(point); 
	cout<<std::setiosflags(ios::left);
	for(int l=0;l<j;l++) 
	{ 
		cout<<std::setw(*(num+l))<<field[l].name<<"  "; 
	} 
	cout<<endl;
	MYSQL_ROW row; 
	while( row = mysql_fetch_row(point)) 
	{ 
		for(int l=0 ; l< j;l++) 
		{ 
			if(row[l]==NULL || !strlen(row[l])) 
				cout<<"NULL"; 
			else 
				cout<<std::setw(*(num+l))<<row[l]<<"  "; 
		} 
		cout<<endl;
	} 
	return 1;
}

string Ways::Now(int a/*=0*/,int b/*=0*/,int c/*=0*/)
{
	tm *dt;
	time_t ct;
	time(&ct);
	dt=localtime(&ct);
	string str="";
	str=itos(dt->tm_year+1900+a)+"-"+itos(dt->tm_mon+1+b)+"-"+itos(dt->tm_mday+c);
	return str;
}

string Ways::Now_time()
{
	tm *dt;
	time_t ct;
	time(&ct);
	dt=localtime(&ct);
	string str="";
	str=itos(dt->tm_year+1900)+"-"+itos(dt->tm_mon+1)+"-"+itos(dt->tm_mday)+"-"+itos(dt->tm_hour)+"-"+itos(dt->tm_min)+"-"+itos(dt->tm_sec);
	return str;
}
