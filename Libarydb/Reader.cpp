#include "Reader.h"
#include "ways.h"

int Reader::select_Lost(Chaxun & se)//丢失书本查询
{
	MYSQL_RES * point;
	int bb[3]={14,18,12};
	string str="select items.book_name as '书名',concat(concat(loans.ISBN,'-'),char(ascii(FLOOR(loans.number/10)))) as '书号',lend_time as '借书时间' from items,loans where items.ISBN=loans.ISBN and (loans.number-FLOOR(loans.number/10)*10)=4";
	point=se.Demand(str.c_str());
	way->Show_data(point,bb);
	return 0;
}
int Reader::select_Compens(Chaxun & se)//赔款书本查询 
{
	MYSQL_RES * point;
	int bb[3]={14,18,12};
	string str="select items.book_name as '书名',concat(concat(loans.ISBN,'-'),char(ascii(FLOOR(loans.number/10)))) as '书号',lend_time as '借书时间' from items,loans where items.ISBN=loans.ISBN and (loans.number-FLOOR(loans.number/10)*10)=5";
	point=se.Demand(str.c_str());
	way->Show_data(point,bb);
	return 0;
}
int Reader::select_Library(Chaxun & se)//图书馆在册书查询
{
	MYSQL_RES * point;
	int bb[7]={14,14,5,14,12,4,4};
	string aa="select book_name as '书名',ISBN,writer as '作者',publish as '出版社',publish_time as '出版日期', price as '价格',maxbook-number as '可借量' from items";
	point=se.Demand(aa.c_str());
	way->Show_data(point,bb);
	return 0;
}
int Reader::select_History(Chaxun & se)//借阅历史查询
{
	MYSQL_RES * point;
	int bb[4]={14,18,12,4};
	string str="select items.book_name as '书名',concat(concat(loans.ISBN,'-'),char(ascii(FLOOR(loans.number/10)))) as '书号',lend_time as '借书时间',(loans.number-FLOOR(loans.number/10)*10) as '状态' from items,loans where items.ISBN=loans.ISBN";
	point=se.Demand(str.c_str());
	cout<<"状态值说明:  1:已借未还  2:已还  3:已挂失  4:已丢失  5.已赔款"<<endl;
	way->Show_data(point,bb);
	return 0;
}
int Reader::select_Book_now(Chaxun & se)//现借书及情况查询
{
	MYSQL_RES * point;
	int bb[3]={14,18,12};
	string str="select items.book_name as '书名',concat(concat(loans.ISBN,'-'),char(ascii(FLOOR(loans.number/10)))) as '书号',lend_time as '借书时间' from items,loans where items.ISBN=loans.ISBN and (loans.number-FLOOR(loans.number/10)*10)=1";
	point=se.Demand(str.c_str());
	way->Show_data(point,bb);
	return 0;
}
int Reader::pwd_Change(Chaxun & se)//更改密码操作 
{
	string pwd1,pwd2;
	cout<<"**************************************"<<endl;
	cout<<"*          请输入你的新密码          *"<<endl;
	cin>>pwd1;
	cout<<"*          请再次确认密码            *"<<endl;
	cin>>pwd2;
	if(pwd1==pwd2)
	{
		pwd1="update reader set read_pwd = '" + pwd1 +"' where read_id= '"+Reader_id+"';";
		int i=se.Run(pwd1.c_str());
		way->Show_judge(i);	
	}
	else
		pwd_Change(se);
	return 0;
}
int Reader::reserva_Book(Chaxun & se)//预定图书操作
{
	cout<<"**************************************"<<endl;
	cout<<"*        请输入你要预约的图书名      *"<<endl;
	string name;
	cin>>name;
	name="insert into reserve values ( '"+Reader_id+"','"+name+"','"+way->Now_time()+"','0','0');";
	way->Show_judge(se.Run(name.c_str()));
	return 0;
}
int Reader::cancel_reserva_Book(Chaxun & se)//取消预订图书操作
{
	cout<<"**************************************"<<endl;
	cout<<"*      请输入你要取消预约的图书名    *"<<endl;
	string name;
	cin>>name;
	name="delete from reserve where book_name = '"+name+"' and state = '0';";
	way->Show_judge(se.Run(name.c_str()));
	return 0;
}
int Reader::select_reserva_Book(Chaxun & se)//预约情况查询
{
	string str="select book_name as '书名',time as '预约时间',state as '结果' from reserve";
	MYSQL_RES * point;
	int bb[3]={14,12,4};
	point=se.Demand(str.c_str());
	cout<<"结果值说明:  0:未处理  1:已批准  2:未批准"<<endl;
	way->Show_data(point,bb);
	return 0;
}