#ifndef _ITEMS_H
#define _ITEMS_H
#include <stdlib.h>
#include "appoint.h"
#include "Mysql_select.h"
#include "ways.h"

class Items
{
private:
	string ISBN;
	string book_name;
	string writer;
	string publish;
	string publish_time;
	float price;
	int	maxbook;
	int number;
public:
	Ways *way;
	Items():ISBN("0"),book_name("0"),writer("0"),publish("0"),publish_time("0"),price(0),maxbook(0),number(0){}
	Items(string isbn,string name,string writ,string pub,string time,float pr,int max,int num)
		:ISBN(isbn),book_name(name),writer(writ),publish(pub),publish_time(time),price(pr),maxbook(max),number(num){}
	Items(const Items & item)
	{
		ISBN=item.ISBN;
		book_name=item.book_name;
		writer=item.writer;
		publish=item.publish;
		publish_time=item.publish_time;
		price=item.price;
		maxbook=item.maxbook;
		number=item.number;
	}
	Items(string & aa)
	{
		int i=aa.find('|',0);
		int j=0;
		ISBN=aa.substr(0,i-j);
		j=i+1;
		i=aa.find('|',i+1);
		book_name=aa.substr(j,i-j);
		j=i+1;
		i=aa.find('|',i+1);
		writer=aa.substr(j,i-j);
		j=i+1;
		i=aa.find('|',i+1);
		publish=aa.substr(j,i-j);
		j=i+1;
		i=aa.find('|',i+1);
		publish_time=aa.substr(j,i-j);
		j=i+1;
		i=aa.find('|',i+1);
		price=atof((aa.substr(j,i-j)).c_str());
		j=i+1;
		i=aa.find('|',i+1);
		maxbook=atoi((aa.substr(j,i-j)).c_str());
		j=i+1;
		i=aa.find('|',i+1);
		number=atoi((aa.substr(j,i-j)).c_str());
	}
	Items & operator=(const Items & item)
	{
		if(this!=&item)
		{
			ISBN=item.ISBN;
			book_name=item.book_name;
			writer=item.writer;
			publish=item.publish;
			publish_time=item.publish_time;
			price=item.price;
			maxbook=item.maxbook;
			number=item.number;
		}
		return *this;
	}
	~Items(){}
	////////////////////////////////////////////////////
	int Get_item_news(string &isbn,Chaxun & se)
	{
		isbn="select * from items where ISBN = '"+isbn+"';";
		se.Demand_str(isbn.c_str());
		string news(se.data);
		try
		{
			mtoi(news);
		}
		catch (...)
		{
			return 1;
		}
		return 0;
	}

	void Delete_item(string &isbn,Chaxun &se)
	{
		isbn="delete from items where ISBN= '"+isbn+"';";
		int i=se.Run(isbn.c_str());
		way->Show_judge(i);
	}

	void Input_item(Chaxun &se)
	{
		string item="insert into items values ( '"+ISBN+"','"+book_name+"','"+writer+"','"+publish+"','"+publish_time+"','"+way->ftos(price)+"','"+way->ftos(maxbook)+"','"+way->ftos(number)+"');";
		int i=se.Run(item.c_str());
		way->Show_judge(i);
	}

	string Get_ISBN()
	{
		return ISBN;
	}
	void Set_ISBN(string &aa)
	{
		ISBN=aa;
	}
	void mtoi(string &aa)
	{
		int i=aa.find('|',0),j=0;
		ISBN=aa.substr(0,i-j);
		j=i+1;
		i=aa.find('|',i+1);
		book_name=aa.substr(j,i-j);
		j=i+1;
		i=aa.find('|',i+1);
		writer=aa.substr(j,i-j);
		j=i+1;
		i=aa.find('|',i+1);
		publish=aa.substr(j,i-j);
		j=i+1;
		i=aa.find('|',i+1);
		publish_time=aa.substr(j,i-j);
		j=i+1;
		i=aa.find('|',i+1);
		price=atof((aa.substr(j,i-j)).c_str());
		j=i+1;
		i=aa.find('|',i+1);
		maxbook=atoi((aa.substr(j,i-j)).c_str());
		j=i+1;
		i=aa.find('|',i+1);
		number=atoi((aa.substr(j,i-j)).c_str());
	}

	string Get_name()
	{
		return book_name;
	}
	string Get_writer()
	{
		return writer;
	}
	string Get_publish()
	{
		return publish;
	}
	string Get_pub_time()
	{
		return publish_time;
	}
	float Get_price()
	{
		return price;
	}
	int	Get_max()
	{
		return maxbook;
	}
	int Get_num()
	{
		return number;
	}


	void Set_name(string &name)
	{
		 book_name=name;
	}
	void Set_writer(string &wr)
	{
		 writer=wr;
	}
	void Set_publish(string &pu)
	{
		 publish=pu;
	}
	void Set_pub_time(string & cd)
	{
		 publish_time=cd;
	}
	void Set_price(float &pr)
	{
		 price=pr;
	}
	void Set_max(int &ma)
	{
		 maxbook=ma;
	}
	void Set_num(int & num)
	{
		 number=num;
	}

	void Change_item_news(int i=10)
	{
		int j=1;
		while(i!=0)
		{
			cout<<"*************************************"<<endl;
			cout<<"*        请重新输入图书信息         *"<<endl;
			if(i==10)
			{
				cout<<"*-----------------------------------*"<<endl;
				cout<<"*    1.ISBN     2.图书名    3.作者  *"<<endl;
				cout<<"*    4.出版社   5.出版日期  6.价格  *"<<endl;
				cout<<"*    7.图书总数 8.现借量    0.退出  *"<<endl;
				cout<<"*-----------------------------------*"<<endl;
				cout<<"*          请输入修改参数           *"<<endl;	
				cout<<"*************************************"<<endl;
				cin>>i;
				j=0;
			}
			if(i==1)
			{
				cout<<"*    ISBN:";
				cin>>ISBN;
			}
			if(i==2)
			{
				cout<<endl<<"*    图书名:";
				cin>>book_name;
			}
			if(i==3)
			{
				cout<<endl<<"*    作者:";
				cin>>writer;
			}
			if(i==4)
			{
				cout<<endl<<"*    出版社:";
				cin>>publish;
			}
			if(i==5)
			{
				cout<<endl<<"*    出版时间:  年--月--日";
				int a,b,c;
				cin>>a>>b>>c;
				publish_time="";
				publish_time=way->itos(a)+"-"+way->itos(b)+"-"+way->itos(c);
			}
			if(i==6)
			{
				cout<<endl<<"*    价格:";
				cin>>price;
			}
			if(i==7)
			{
				cout<<endl<<"*   该类图书数目:";
				cin>>maxbook;
			}
			if(i==8)
			{
				cout<<endl<<"*   现已借出本数:";
				cin>>number;
			}
			if(j==1)
				i=0;
		}
		
}
};
#endif