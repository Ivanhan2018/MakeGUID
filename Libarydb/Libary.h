#ifndef _LIBARY_H
#define _LIBARY_H

#include <stdlib.h>
#include "appoint.h"
#include "Manager.h"
#include "Mysql_select.h"
#include "Reader.h"
#include "ways.h"

class Libary
{
private:
	Chaxun se;
	Manager * manager;
	Reader * read;
	SuManager * sumanag;
public:
	Ways *way;
	Libary(string ip="192.168.1.166",string id="root",string pwd="mysql55",string db="Libarydb",int port=3306):se(ip.c_str(),id.c_str(),pwd.c_str(),db.c_str(),port),manager(NULL),read(NULL),sumanag(NULL){}
	~Libary(){}
	void Lib_Run(int i=3)
	{
	        Chaxun& se=this->se;
		MYSQL_RES *point;
		while(i!=0)
		{
			i=way->welcome_wind();
			if(i==1)
			{
				way->input_id_pwd_wind();
				string id,id1,pwd;
				cin>>id>>pwd;
				id1="select manage_pwd,manage_name,manage_position from manager where manage_id = '"+id+"';";
				se.Demand_str_one(id1.c_str(),0,0);
				if(se.data==NULL)
					return;
				if(pwd==string(se.data))
				{
					se.Demand_str_one(id1.c_str(),0,1);
					std::string name(se.data);
					se.Demand_str_one(id1.c_str(),0,2);
					string position(se.data);
					if(position=="超级管理员")
					{
						cout<<"       欢迎你超级管理员"<<name<<endl;
						sumanag=new SuManager(id,pwd,name,position);
						while(i!=0)
						{
							i=Ways::super_manager_wind();
							if(i==1)//增加管理员  
								sumanag->Add_Member(1,se);
							if(i==2)//增加图书     
								sumanag->Add_Member(2,se);
							if(i==3)//增加学生       
								sumanag->Add_Member(3,se);
							if(i==4)//去除管理员        
								sumanag->Del_Member(1,se);
							if(i==5)//修改图书         
								sumanag->Del_Member(2,se);
							if(i==6)//去除学生        
								sumanag->Del_Member(3,se);
							if(i==7)//显示所有学生信息  
								sumanag->Show_News(1,se);
							if(i==8)//显示所有管理员信息
								sumanag->Show_News(2,se);
							if(i==9)//显示所有图书信息  
								sumanag->Show_News(3,se);
							if(i==10)//管理员操作查询   
								sumanag->Show_News(4,se);
							if(i==11)//借还书记录总查询 
								sumanag->Show_News(5,se);
							if(i==12)//预约记录总查询 
								sumanag->Show_News(6,se);
						}
						if(i==0)
						{
							Lib_Run();
							delete sumanag;
						}
					}
					if(position=="管理员")
					{
						cout<<"       欢迎你管理员"<<name<<endl;
						manager=new Manager(id,pwd,name,position);
						while(i!=0)
						{
							i=Ways::manager_wind();
							if(i==1)//未归还书本查询
                                                        {  
								string str=Ways::input_time_wind();
								//manager->select_Unreturn(str,se);
                                                        }
							if(i==2)//超期未还查询    
								manager->select_Unreturn_now(se);
							if(i==3)//修改图书信息    
								manager->item_Chang(se);
							if(i==4)//图书馆书籍总查询
								manager->select_Library_all(se);
							if(i==5)//还书操作        
								manager->return_Book(se);
							if(i==6)//借书操作       
								manager->lend_Book(se);
							if(i==7)//更改密码操作    
								manager->pwd_Chang(se);
							if(i==8)//查询图书信息   
								manager->select_Library_one(se);
							if(i==9)//图书挂失        
								manager->report_Lost(se);
							if(i==10)//挂失图书归还  
								manager->return_Lost(se);
							if(i==11)//处理读者预约   
								manager->process_reserva_Book(se);
						}
						if(i==0)
						{
							Lib_Run();
							delete manager;
						}
					}
				}
			}
			if(i==2)
			{
				Ways::input_id_pwd_wind();
				string id,id1,pwd;
				cin>>id>>pwd;
				id1="select Read_pwd,Read_name,Read_type,number from reader where Read_id = '"+id+"';";
				//cout<<id1<<endl;
				se.Demand_str_one(id1.c_str(),0,0);
				if(pwd==string(se.data))
				{
					se.Demand_str_one(id1.c_str(),0,1);
					string name(se.data);
					se.Demand_str_one(id1.c_str(),0,2);
					string type(se.data);
					se.Demand_str_one(id1.c_str(),0,3);
					string snumber(se.data);
					read=new Reader(id,pwd,name,atoi(type.c_str()),atoi(snumber.c_str()));
					while(i!=0)
					{
						i=read->way->reader_wind();
						if(i==1)//丢失书本查询    
							read->select_Lost(se);
						if(i==2)//赔款书本查询    
							read->select_Compens(se);
						if(i==3)//图书馆在册书查询
							read->select_Library(se);
						if(i==4)//借阅历史查询   
							read->select_History(se);
						if(i==5)//现借书及情况查询
							read->select_Book_now(se);
						if(i==6)//更改密码操作    
							read->pwd_Change(se);
						if(i==7)//预定图书操作    
							read->reserva_Book(se);
						if(i==8)//取消预订图书操作
							read->cancel_reserva_Book(se);
						if(i==9)//预约情况查询  
							read->select_reserva_Book(se);
					}
					if(i==0)
					{
						Lib_Run();
						delete read;
					}
				}
			}
		}
	}
};
#endif