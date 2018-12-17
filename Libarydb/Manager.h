#ifndef _MANAGER_H
#define _MANAGER_H
#include "appoint.h"
#include "ways.h"

class Manager
{
private:
	string Manager_id;
	string Manager_pwd;
	string Manager_name;
	string Manager_position;
public:
	//Ways *way;
	Manager():Manager_id("0"),Manager_pwd("0"),Manager_name("0"),Manager_position("0"){}
	Manager(string id,string pwd,string name,string position):Manager_id(id),Manager_pwd(pwd),Manager_name(name),Manager_position(position){}
	Manager(const Manager &man)
	{
		Manager_id=man.Manager_id;
		Manager_pwd=man.Manager_pwd;
		Manager_name=man.Manager_name;
		Manager_position=man.Manager_position;
	}
	Manager & operator=(const Manager &man)
	{
		if(this!=&man)
		{
			Manager_id=man.Manager_id;
			Manager_pwd=man.Manager_pwd;
			Manager_name=man.Manager_name;
			Manager_position=man.Manager_position;
		}
		return *this;
	}
	~Manager(){}
	///////////////////////////////////////////////
	int select_Unreturn(string &date,Chaxun & se);//未归还书本查询
	int select_Unreturn_now(Chaxun & se);//超期未还查询
	int item_Chang(Chaxun & se);//修改图书信息 
	int select_Library_one(Chaxun & se);//查询图书信息
	int select_Library_all(Chaxun & se);//图书馆书籍总查询
	int return_Book(Chaxun & se);//还书操作
	int lend_Book(Chaxun & se);//借书操作
	int pwd_Chang(Chaxun & se);//更改密码操作
	int report_Lost(Chaxun & se);//图书挂失
	int return_Lost(Chaxun & se);//挂失图书归还 
	int process_reserva_Book(Chaxun & se);//处理读者预约
};


class SuManager:public Manager
{
private:
	string SuManager_id;
	string SuManager_pwd;
	string SuManager_name;
	string SuManager_position;
public:
	SuManager(string id,string pwd,string name,string position):SuManager_id(id),SuManager_pwd(pwd),SuManager_name(name),SuManager_position(position){}
	~SuManager(){}
	int Add_Member(int i,Chaxun & se);//增加管理员  增加图书   增加学生 
	int Del_Member(int i,Chaxun & se);//去除管理员  修改图书   去除学生  
	int Show_News(int i,Chaxun & se);//显示所有学生信息  显示所有管理员信息  显示所有图书信息   管理员操作查询   借还书记录总查询 
};
#endif