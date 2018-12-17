#include "Manager.h"
#include "items.h"

int Manager::select_Unreturn(string &date,Chaxun & se)//未归还书本查询
{
	MYSQL_RES * point;
	int bb[2]={14,14};
	string aa="select items.book_name as '书名', concat(concat(loans.ISBN,'-'),char(ascii(FLOOR(loans.number/10)))) as '书号'  from items,loans where items.ISBN=loans.ISBN and loans.return_time <= '";
	aa=aa+date+"' and (loans.number-FLOOR(loans.number/10)*10)=1;";
	point=se.Demand(aa.c_str());
	Ways::Show_data(point,bb);
	aa="insert into manager_do values ( '"+Manager_id+"','"+Ways::Now_time()+"','管理员查询未归还书本成功！');";
	//cout<<aa<<endl;
	Ways::Show_judge(se.Run(aa.c_str()));
	return 0;
}

int Manager::select_Unreturn_now(Chaxun & se)//超期未还查询
{
	//select_Unreturn(Ways::Now(),se);
	return 0;
}

int Manager::item_Chang(Chaxun & se)//修改图书信息 
{
	Items item;
	cout<<"**************************************"<<endl;
	cout<<"*    请输入你要修改的图书的ISBN号    *"<<endl;
	cout<<"*------------------------------------*"<<endl;
	string isbn;
	cin>>isbn;
	item.Get_item_news(isbn,se);
	item.Change_item_news();
	item.Delete_item(isbn,se);
	item.Input_item(se);
	isbn="insert into manager_do values ( '"+Manager_id+"','"+Ways::Now_time()+"','管理员修改图书"+isbn+"信息成功！');";
	Ways::Show_judge(se.Run(isbn.c_str()));
	cout<<"**************************************"<<endl;
 	return 0;
}

int Manager::select_Library_one(Chaxun & se)//查询图书信息
{
	cout<<"**************************************"<<endl;
	cout<<"*     请输入你要查询的图书的书名     *"<<endl;
	cout<<"*------------------------------------*"<<endl;
	string name;
	cin>>name;
	MYSQL_RES * point;
	int bb[7]={14,14,5,14,12,4,4};
	string aa="select book_name as '书名',ISBN,writer as '作者',publish as '出版社',publish_time as '出版日期', price as '价格',maxbook-number as '可借量' from items where book_name= '";
	aa=aa+name+"';";
	point=se.Demand(aa.c_str());
	Ways::Show_data(point,bb);
	aa="insert into manager_do values ( '"+Manager_id+"','"+Ways::Now_time()+"','管理员查询图书《"+name+"》信息成功！');";
	Ways::Show_judge(se.Run(aa.c_str()));
	return 0;
}

int Manager::select_Library_all(Chaxun & se)//图书馆书籍总查询
{
	MYSQL_RES * point;
	int bb[7]={14,14,5,14,12,4,4};
	string aa="select book_name as '书名',ISBN,writer as '作者',publish as '出版社',publish_time as '出版日期', price as '价格',maxbook-number as '可借量' from items";
	point=se.Demand(aa.c_str());
	Ways::Show_data(point,bb);
	aa="insert into manager_do values ( '"+Manager_id+"','"+Ways::Now_time()+"','管理员查询图书馆所有图书信息成功！');";
	Ways::Show_judge(se.Run(aa.c_str()));
	return 0;
}

int Manager::return_Book(Chaxun & se)//还书操作
{
	cout<<"**************************************"<<endl;
	cout<<"*           请输入书本编号           *"<<endl;
	cout<<"*------------------------------------*"<<endl;
	string id,id1;
	cin>>id;
	id1="select Read_id from loans where concat(concat(ISBN,'-'),char(ascii(FLOOR(number/10))))='"+id+"' and (number-FLOOR(number/10)*10)=1;";
	id="update loans set number = (FLOOR(number/10)*10 + 2) where concat(concat(ISBN,'-'),char(ascii(FLOOR(number/10))))='"+id+"' and (number-FLOOR(number/10)*10)=1;";
	int i=se.Run(id.c_str());
	Ways::Show_judge(i);
	se.Demand_str(id1.c_str());
	string id2(se.data);
	delete se.data;
	//cout<<id2<<endl;
	int ii=id2.find('|',0);
	id1=id2.substr(0,ii);
	//cout<<id1<<endl;
	id1="update reader set number = (number - 1) where read_id='"+id1+"';";
	ii=se.Run(id1.c_str());
	Ways::Show_judge(ii);
	id1="insert into manager_do values ( '"+Manager_id+"','"+Ways::Now_time()+"','管理员为读者"+id1+"还书成功！');";
	Ways::Show_judge(se.Run(id1.c_str()));
	return 0;
}

int Manager::lend_Book(Chaxun & se)//借书操作
{
	cout<<"**************************************"<<endl;
	cout<<"*     请输入借书学生学号及图书编号   *"<<endl;
	cout<<"*------------------------------------*"<<endl;
	string id,book_id,id1,id2;
	cin>>id>>book_id;
	id2=book_id;
	int i=book_id.rfind('-',book_id.length());
	id1="update reader set number = number + 1 where read_id = '"+id+"';";
	Ways::Show_judge(se.Run(id1.c_str()));
	id1="select read_type from reader where read_id= '"+id+"';";
	se.Demand_str(id1.c_str());
	string aaa(se.data);
	delete se.data;
	aaa.erase(aaa.find('|',0));
	int j=atoi(aaa.c_str());
	id1=id2;
	id1.erase(i);
	id2.erase(0,i+1);
	id1="insert into loans values ( '"+Manager_id+"','"+id+"','"+Ways::Now()+"','"+id1+"','"+id2+"1"+"','"+Ways::Now(0,1,0)+"');";
	Ways::Show_judge(se.Run(id1.c_str()));
	id1="insert into manager_do values ( '"+Manager_id+"','"+Ways::Now_time()+"','"+id+"借书"+book_id+"成功！');";
	Ways::Show_judge(se.Run(id1.c_str()));
	cout<<"借阅成功！"<<endl;
	return 0;
}

int Manager::pwd_Chang(Chaxun & se)//更改密码操作
{
	string pwd1,pwd2;
	cout<<"**************************************"<<endl;
	cout<<"*          请输入你的新密码          *"<<endl;
	cin>>pwd1;
	cout<<"*          请再次确认密码            *"<<endl;
	cin>>pwd2;
	if(pwd1==pwd2)
	{
		pwd1="update manager set manager_pwd = '" + pwd1 +"' where manage_id= '"+Manager_id+"';";
		Ways::Show_judge(se.Run(pwd1.c_str()));
		pwd1="input into manager_do values ( '"+Manager_id+"','"+pwd1+"','"+Ways::Now_time()+"','将密码改为:"+pwd1+"成功！');";
		Ways::Show_judge(se.Run(pwd1.c_str()));	
	}
	else
		pwd_Chang(se);
	return 0;
}

int Manager::report_Lost(Chaxun & se)//图书挂失
{
	cout<<"**************************************"<<endl;
	cout<<"*           请输入图书编号           *"<<endl;
	cout<<"*------------------------------------*"<<endl;
	string id,id1;
	cin>>id;
	id1=id;
	id="update loans set number= (FLOOR(number/10)*10 + 3) where concat(concat(ISBN,'-'),char(ascii(FLOOR(number/10))))='"+id+"' and (number-FLOOR(number/10)*10)=1;";
	Ways::Show_judge(se.Run(id.c_str()));
	id="input into manager_do values ( '"+Manager_id+"','"+Ways::Now_time()+"','完成图书:"+id1+"挂失成功！');";
	Ways::Show_judge(se.Run(id.c_str()));	
	return 0;
}

int Manager::return_Lost(Chaxun & se)//挂失图书归还 
{
	cout<<"**************************************"<<endl;
	cout<<"*           请输入图书编号           *"<<endl;
	cout<<"*------------------------------------*"<<endl;
	string id,id1,id2;
	cin>>id;
	id2=id;
	id1="select Read_id from loans where concat(concat(ISBN,'-'),char(ascii(FLOOR(number/10))))='"+id+"' and (number-FLOOR(number/10)*10)=1;";
	id="update loans set number= (FLOOR(number/10)*10 + 2) where concat(concat(ISBN,'-'),char(ascii(FLOOR(number/10))))='"+id+"' and floor(number - floor(number/10)*10)=3;";
	//cout<<id<<endl;
	Ways::Show_judge(se.Run(id.c_str()));
	se.Demand_str(id1.c_str());
	string id3(se.data);
	delete se.data;
	int ii=id3.find('|',0);
	id1=id3.substr(0,ii);
	id1="update reader set number = (number - 1) where read_id='"+id1+"';";
	se.Run(id1.c_str());
	id="insert into manager_do values ( '"+Manager_id+"','"+Ways::Now_time()+"','完成图书:"+id2+"挂失成功！');";
	Ways::Show_judge(se.Run(id.c_str()));	
	return 0;
}

int Manager::process_reserva_Book(Chaxun & se)//处理读者预约
{
	string id="select reader_id as '读者ID',book_name as '书名' from reserve where state=0;";
	MYSQL_RES *point;
	point=se.Demand(id.c_str());
	id="";
	long j = mysql_num_fields(point); 
	MYSQL_ROW row; 
	while( row = mysql_fetch_row(point)) 
	{ 
		for(int l=0 ; l< j;l++) 
		{ 
			if(row[l]==NULL || !strlen(row[l])) 
				cout<<"NULL"; 
			else 
			{
				if(l==0)
				{
					cout<<"*------------------------------------*"<<endl;
					cout<<"读者：";
					cout<<std::setw(14)<<row[l]<<"  ";
				}
				else if(l==1)
				{
					cout<<"预约图书《"<<row[l]<<"》-是否同意？"<<endl;
					cout<<"1.同意    2.不同意"<<endl;
					int i;
					cin>>i;
					if(i==2)
					{
						id=id+string(row[0])+"|"+string(row[1])+"@";
						id="insert into manager_do values ( '"+Manager_id+"','"+Ways::Now_time()+"','完成对读者:"+row[0]+"对图书《"+row[1]+"》的预约批准操作！');";
						Ways::Show_judge(se.Run(id.c_str()));
					}
					else
					{
						id="insert into manager_do values ( '"+Manager_id+"','"+Ways::Now_time()+"','完成对读者:"+row[0]+"对图书《"+row[1]+"》的预约未批准操作！');";
						Ways::Show_judge(se.Run(id.c_str()));
					}
				}
			}
		} 
	} 
	int k=0;
	while(k!=id.length())
	{
		int m,n;
		string str1,str2;
		n=id.find('@',k);
		string aa=id.substr(k,n-j);
		m=aa.find('|',k);
		str1=aa.substr(k,m-k);
		str2=aa.substr(m+1,n-m);
		k=n+1;
		str1="update reserve set state = 1,manager_id = '"+Manager_id+"' where reader_id = '"+str1+"' and book_name = '"+str2+"' and state = 0;";
		se.Run(str1.c_str());
		str1="update reserve set state = 2,manager_id = '"+Manager_id+"' where state = 0;";
		se.Run(str1.c_str());
	}
	return 0;
}

int SuManager::Add_Member(int i,Chaxun & se)//增加管理员  增加图书   增加学生 
{
	if(i==1)
	{
		cout<<"**************************************"<<endl;
		cout<<"*           请输入管理员信息         *"<<endl;
		cout<<"*    用户名    密码    姓名    职务：*"<<endl;
		string id,pwd,name,position;
		cin>>id>>pwd>>name>>position;
		id="insert into manager values ( '"+id+"','"+pwd+"','"+name+"','"+position+"');";
		Ways::Show_judge(se.Run(id.c_str()));
	}
	else if(i==2)
	{
		cout<<"**************************************"<<endl;
		cout<<"*           请输入图书信息           *"<<endl;
		cout<<"*  ISBN  书名  作者  出版社  出版时间*"<<endl;
		cout<<"*  价格  图书总数                    *"<<endl;
		string isbn,name,writer,pub,pub_tim;
		float pri;
		int num;
		cin>>isbn>>name>>writer>>pub>>pub_tim>>pri>>num;
		isbn="insert into items values ( '"+isbn+"','"+name+"','"+writer+"','"+pub+"','"+pub_tim+"','"+Ways::ftos(pri)+"','"+Ways::itos(num)+"','0');";
		Ways::Show_judge(se.Run(isbn.c_str()));
	}
	else
	{
		cout<<"**************************************"<<endl;
		cout<<"*           请输入读者信息           *"<<endl;
		cout<<"*    ID     密码     名字     类型   *"<<endl;
		cout<<"*  类型(1.本科生  2.博士生  3.研究生)*"<<endl;
		string id,pwd,name;
		int typ;
		cin>>id>>pwd>>name>>typ;
		if(typ==1)
			id="insert into reader values ( '"+id+"','"+pwd+"','"+name+"','1','10','0');";
		if(typ==2)
			id="insert into reader values ( '"+id+"','"+pwd+"','"+name+"','2','20','0');";
		if(typ==3)
			id="insert into reader values ( '"+id+"','"+pwd+"','"+name+"','3','30','0');";
		Ways::Show_judge(se.Run(id.c_str()));
	}
	return 0;
}
int SuManager::Del_Member(int i,Chaxun & se)//去除管理员  修改图书   去除学生 
{
	string id;
	if(i==1)
	{
		cout<<"**************************************"<<endl;
		cout<<"*         请输入管理员编号           *"<<endl;
		cin>>id;
		id="delete from manager where manage_id = ( '"+id+"');";
	}
	if(i==2)
	{
		cout<<"**************************************"<<endl;
		cout<<"*        请输入图书ISBN编号          *"<<endl;
		cin>>id;
		id="delete from items where  ISBN= ( '"+id+"');";
	}
	if(i==3)
	{
		cout<<"**************************************"<<endl;
		cout<<"*          请输入学生编号            *"<<endl;
		cin>>id;
		id="delete from reader where read_id = ( '"+id+"');";
	}
	Ways::Show_judge(se.Run(id.c_str()));
	return 0;
} 
int SuManager::Show_News(int i,Chaxun & se)//显示所有学生信息  显示所有管理员信息  显示所有图书信息   管理员操作查询   借还书记录总查询 
{
	string str;
	MYSQL_RES * point;
	if(i==1)
	{
		cout<<"**************************************"<<endl;
		cout<<"*           所有学生信息为：         *"<<endl;
		int bb[6]={10,6,6,8,10,4};
		str="select read_id as '读者编号',read_pwd as '密码',read_name as '姓名',read_type as '读者类型',lend_max as '最大借书量',number as '现借书量' from reader;";
		point=se.Demand(str.c_str());
		cout<<"读者类型说明:  1:本科生  2:研究生  3:博士生"<<endl;
		Ways::Show_data(point,bb);
	}
	if(i==2)
	{
		cout<<"**************************************"<<endl;
		cout<<"*          所有管理员信息为：        *"<<endl;
		int bb[4]={10,6,6,8};
		str="select manage_id as '管理员编号',manage_pwd as '密码',manage_name as '姓名',manage_position as '职务' from manager;";
		point=se.Demand(str.c_str());
		Ways::Show_data(point,bb);
	}
	if(i==3)
	{
		cout<<"**************************************"<<endl;
		cout<<"*           所有图书信息为：         *"<<endl;
		int bb[8]={15,15,6,15,12,4,4,4};
		str="select ISBN ,book_name as '书名',writer as '作者',publish as '出版社',publish_time as '出版时间',price as '价格',maxbook as '总数',number as '已借出' from items;";
		point=se.Demand(str.c_str());
		Ways::Show_data(point,bb);
	}
	if(i==4)
	{
		cout<<"**************************************"<<endl;
		cout<<"*        所有管理员操作信息为：      *"<<endl;
		int bb[3]={8,20,100};
		str="select manager_id as '管理员编号',time as '时间',things as '事件' from manager_do;";
		point=se.Demand(str.c_str());
		Ways::Show_data(point,bb);
	}
	if(i==5)
	{
		cout<<"**************************************"<<endl;
		cout<<"*        所有借还书记录信息为：      *"<<endl;
		int bb[6]={10,10,12,14,4,12};
		str="select manage_id as '管理员编号',read_id as '读者编号',lend_time as '借书时间',concat(concat(ISBN,'-'),char(ascii(FLOOR(number/10)))) as '书号',(number-FLOOR(number/10)*10) as '状态',return_time as '还书时间' from loans;";
		point=se.Demand(str.c_str());
		cout<<"状态值说明:  1:已借未还  2:已还  3:已挂失  4:已丢失  5.已赔款"<<endl;
		Ways::Show_data(point,bb);
	}
	if(i==6)
	{
		cout<<"**************************************"<<endl;
		cout<<"*         所有预约图书信息为：       *"<<endl;
		int bb[5]={10,15,20,10,4};
		str="select reader_id as '读者编号',book_name as '书名',time as '预约时间',manager_id as '管理员编号',state as '状态' from reserve;";
		point=se.Demand(str.c_str());
		cout<<"状态值说明:  0:未处理  1:已批准  2:未批准"<<endl;
		Ways::Show_data(point,bb);
	}
	return 0;
}