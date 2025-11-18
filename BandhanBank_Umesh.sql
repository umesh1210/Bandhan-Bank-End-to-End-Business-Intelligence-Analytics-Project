
/***************************************************************************************
Project Name : Bandhan Bank
Module		 : Loan Module
Purpose		 : This Bandhan Bank database is designed to manage All the accounts and details of every individual customer
			   of the group, who are taking the loans for their Small scale Business purpose.
Created by	 : Umesh Kumar
Date		 : June 24th, 2025

****************************************************************************************
SLNO		 Created By			Details				   Remarks				  Date
-----------------------------------------------------------------------------------
1			Umesh Kumar		  Fresh Data			Tables Development		June 24,2025
2			Umesh Kumar		  Fresh Data		Inserted some more Data     July 02,2025
3			Umesh Kumar       Fresh Data        Updated some Data           July 05,2025
****************************************************************************************/
------Create a database Bandhan_Bank
Create   Database Bandhan_Bank
go
--Use DataBase
use Bandhan_Bank
Go 

--Creating a Groups Table which contains columns like : GroupID,GroupName,AgeLimit,TotalGroupMembers.
Create Table Groups
(
		GroupID				Int				Primary Key,
		GroupName			Varchar(100)	Not Null,
		AgeLimit			SmallInt		Not Null Check(AgeLimit>18 and AgeLimit<65),
		TotalGroupMembers	int				Not Null,
		GroupCreated		date			Not Null
)
Go

-- Creating a Branch Table which contains columns like : BRID,BranchName,BranchManagerName,BranchAddress,BranchState.

Create Table Branch
(
		BRID				char(11) 			Primary Key,
		BranchName			Varchar(20)		Not Null,
		BranchManagerName	Varchar(50)		Not Null,
		BranchAddress		Varchar(80)		Not Null,
		BranchState			Varchar(20)		Not Null
)
Go
 
-- Creating a Customer Table which contains the columns like : CustomerID,BRID,Customers name and other details.

Create table CustomerTable
(
		CustomerID				Int				Primary	Key,
		BRID					char(11)		Not Null Foreign Key References Branch(BRID) ,
		CustomerFirstName		Varchar(30)		Not null,
		CustomerLastName		Varchar(20)		Not Null,
		CustomerDateOfBirth		Date		Not Null,
		CustomerGender			char(6)			Not Null Check(CustomerGender in ('Male','Female')),
		CustomerMaritalStatus	Varchar(10)		Not Null,
		CustomerAddress			Varchar	(100)	Not Null,
		CustomerOccupation		Varchar(20)		Null,
		CustomerState			Varchar(50)		Not Null,
		CustomerIncomeLevel		Money			Null,
		CustomerMobileNo		Char(10)		Not Null,
		CustomerAadhaarNo		Char(12)		Not NuLL,
		CustomerPanNo			Char(10)		Null,
		GroupID					Int				Foreign Key References Groups(GroupID)
)
Go
 --Creating a Loans Type Table which contains the columns like : LoanTypeID,LoanTypeName,MinAmount,MaxAmount.

create table LoansType(
		LoanTypeID		Int			Primary Key,
		LoanTypeName	Varchar(50)	Not Null,
		MinAmount		Numeric		Not Null,
		MaxAmount		Numeric		Not Null
)
Go
--Creating Loans Table which contains the columns like :  LoanID,CustomerID,LoanTypeID,LoanAmount and other details regarding loans.

Create table Loans(
		LoanID				Int			Primary Key ,
		CustomerID			Int			Foreign Key References CustomerTable(CustomerID),
		LoanTypeID			Int			Foreign Key References LoansType(LoanTypeID),
		LoanAmount			Int			Not Null,
		LoanInterestRate    Numeric		Not Null Check(LoanInterestRate>0 and LoanInterestRate<25),
		TenureInMonth		int			Not Null,
		LoanStartDate		Date		Not Null,
		LoanEndDate			Date		Not Null,
		LoanStatus			Varchar(10) Not Null
)
Go

--Creating a Repayment Table that shows customers Payment details that includes : RepaymentID,LoanID,PaymentsDate,LoanAmountPaid,PaymentMode.
create table Repayments(
		RepaymentID		Int				Identity(1,1) Primary Key,
		LoanID			Int				Foreign Key references Loans(LoanID) ,
		PaymentsDate	Date		Not Null,
		LoanAmountPaid	Money			Not Null ,
		PaymentMode		Varchar(20)		Not Null
)
Go

--Creating a Customer Feedback Table in which the customers use to give Reviews and Ratings to the Bank.
Create  Table Feedback
(
		Customer_FeedbackID		Int					Primary Key,
		CustomerID				Int					Foreign Key References CustomerTable(CustomerID),
		Feedback				Varchar(200)		Not Null,
		Rating					TinyInt				Not Null Check (Rating >0 and Rating<6)
)
Go


------------------------------          Inserting the DATA		    --------------------------------------------------

-- Inserting data into Groups Table

-- Group created :											  
Insert Into Groups Values (1,'Microfinance Loan Group',26,10,'2022-01-01');
Insert Into Groups Values (2,'Housing Loan Group',26,5,'2023-02-01');
Insert Into Groups Values (3,'Two-Wheeler Loan',26,6,'2021-03-01');
Insert Into Groups Values (4,'Education Loan Group',26,10,'2022-02-01'); 
Insert Into Groups Values (5,'4-Wheeler Loan',26,5,'2021-01-01'); 
Insert Into Groups Values (6,'Bazaar Loan',26,10,'2021-05-01'); 
Insert Into Groups Values (7,'Personal  Loan Group',26,10,'2020-03-01'); 
Insert Into Groups Values (8,'Agriculture  Loan Group',26,9,'2020-01-01'); 

--select *  from  groups 


-- Inserting data into Branch Table:
Insert Into Branch Values ('BR1','Anakapalli','Kuber Singh', 'Main Road, Gavarapalem','Andhra Pradesh '); --1,2,3
Insert Into Branch Values ('BR2','Visakhapatnam','Vinod Khan', 'Opp. RTC Complex','Andhra Pradesh ');  --4.5
Insert Into Branch Values ('BR3','Nallakunta','Rahul Kumar', 'Hyderabad, Telangana 500001, India','Telangana');  --6,7
Insert Into Branch Values ('BR4','Eluru','Swaraj', ' 9-4-123, Balaji Nagar, Eluru','Andhra Pradesh ');--8

/*
Insert Into Branch Values ('BR5',' Krishna','Shyam Kumar', 'Venkateswara Apartments, Poranki','Andhra Pradesh ');
Insert Into Branch Values ('BR6','Guntur','Vibhav Kiran', 'Door No. 7-12-45, Arundelpet, Guntur','Andhra Pradesh ');
Insert Into Branch Values ('BR7','Abids','Deepak', 'Abids Road, Sultan Bazar, Abids','Telangana');
Insert Into Branch Values ('BR8','Nellore','Chandra Sekhar', 'D.No. 6-4-22, Pogathota, Nellore','Andhra Pradesh ');
Insert Into Branch Values ('BR9','Chittoor','Vinaod Chahal', 'Plot No. 11, Bairagi Patteda, Chittoor','Andhra Pradesh ');
Insert Into Branch Values ('BR10','Jubilee Hills','Kabir Singh', 'near Metro station Check post, Jubilee Hills','Telangana');
*/
--select * from Branch

-- Inserting data into Customer Table:
Insert Into CustomerTable Values (1,'BR1','Riya','Singh','2001-05-5','Female','Unmarried','Door No. 7-12-45, Arundelpet, Guntur' ,'Pot Maker','Andhra Pradesh ','3000','8856412561','245896542351','ASDDE1234F',1);
Insert Into CustomerTable Values (2,'BR1','Samridhhi','Sharma','2002-03-15','Female','married','D.No. 5-112, Lakshmi Nagar, Gajuwaka, Visakhapatnam ' ,' Vegetable Selling','Andhra Pradesh ','2000','8854625312','245526542351','ABCD12L34F',1);
Insert Into CustomerTable Values (3,'BR1','Ayushi','Mourya','2000-02-25','Female','Unmarried','Plot No. 12, Sri Sai Colony, Anakapalli' ,'Fruit Selling','Andhra Pradesh ','5000','9985642513','245896542351','ABCSD1534F',1);
Insert Into CustomerTable Values (4,'BR1','Shree','Singh','1991-06-23','Female','married','Flat No. 101, Venkata Residency, Ongole, Prakasam' ,'Livestock Rearing','Andhra Pradesh ','1000','9856412562','525896542351','ABCCV1254F',1);
Insert Into CustomerTable Values (5,'BR1','Anuskha','Sharma','2002-02-19','Female','Unmarried','Flat No. 101, Vamsi Residency, Brodipet, Guntur ' ,' Kirana Store','Andhra Pradesh ','7000','9856478512','215896542351','XUCDE1284F',1);
Insert Into CustomerTable Values (6,'BR1','Preeti','Khan','1998-01-15','Female','Unmarried','H.No. 4-9, Railway Station Road, Ongole' ,'Home-based Food ','Andhra Pradesh ','5000','9985642563','526156542351','ABCDF5234F',1);
Insert Into CustomerTable Values (7,'BR1','Priya','Kiran','2001-02-25','Female','married','Plot No. 37, Sri Ram Nagar, Pogathota, Nellore ', 'Cloths Selling','Andhra Pradesh ','2000','8856412561','9856425642','ABCVF5214F',1);
Insert Into CustomerTable Values (8,'BR1','Raveena','Tagore','2002-08-16','Female','Unmarried','D.No. 2-12, Near RTC Bus Stand, Srikalahasti ' ,'Detergent Production','Andhra Pradesh ','3000','9356248562','245896556485','ABCBG1254F',1);
Insert Into CustomerTable Values (9,'BR1','Rashmi','Khanna','2003-08-26','Female','Unmarried','H.No. 6-98, Near Shiva Temple, Adoni','Snacks Business','Andhra Pradesh ','4000','9875648521','245895462859','ABCBG1534F',1);
Insert Into CustomerTable Values (10,'BR1','Vinodhini','Sharma','2002-09-29','Female','married','Door No. 1-22, Vinayaka Nagar, Proddatur' ,'Poultry Farming','Andhra Pradesh ','5000','9875684598','245851622351','ASDFE1234F',1);
Insert Into CustomerTable Values (11,'BR1','Priya','Agarwal','2003-12-16','Female','Unmarried','D.No. 7-4-29, Ambedkar Nagar, Palasa' ,'Homemade Pickles ','Andhra Pradesh ','5000','9988556654','512656542351','ABSDD5534F',2);
Insert Into CustomerTable Values (12,'BR1','Navya','Sekhar','2004-09-21','Female','Unmarried','Door No. 2-76, Relli Veedhi, Bobbili ' ,'Home Tuition ','Andhra Pradesh ','4000','8569456523','245896545264','ABDFG5654F',2);
Insert Into CustomerTable Values (13,'BR1','Vinodhini','Ammi','2004-09-22','Female','married','Flat No. 202, Sai Krupa Apartments, Benz Circle, Vijayawada' ,'Homemade Papads  ','Andhra Pradesh ','2000','9987564852','125696542351','ABCCD1254F',2);
Insert Into CustomerTable Values (14,'BR1','Anjana','Anand','2001-07-27','Female','married','H.No. 3-5-88, Gandhi Nagar, Hindupur' ,'Homemade Masalas','Andhra Pradesh ','3000','9856485216','245812562351','ABCCC6664F',2);
Insert Into CustomerTable Values (15,'BR1','Deeksha','Sinha','2002-09-23','Female','Unmarried','D.No. 5-42, Kottapeta, Nandyal ' ,'Fruit Selling','Andhra Pradesh ','6000','9985684598','245892564551','ADCFV5644F',2);
Insert Into CustomerTable Values (16,'BR1','Riya','Bhagwat','2003-12-3','Female','Unmarried','D.No. 10-2-55, Nehru Nagar, Renigunta, Tirupati' ,'Kirana Store','Andhra Pradesh ','1000','9562154623','245896542255','ABFVG1564F',3);
Insert Into CustomerTable Values (17,'BR1','Priya','Varma','2000-01-2','Female','Unmarried','H.No. 6-3-17, Ramalayam Street, Bapatla' ,'Snacks Business','Andhra Pradesh ','4000','9568459826','245896213456','ABCDE7234F',3);
Insert Into CustomerTable Values (18,'BR1','Kanya','Kumari','1999-09-18','Female','married','Flat No. 105, Lakshmi Residency, Ibrahimpatnam, NTR District' ,'Cloths Selling','Andhra Pradesh ','5000','9568452651','245526342351','ABDCF1234F',3);
Insert Into CustomerTable Values (19,'BR1','Samriddhi','Sekhar','2000-09-12','Female','Unmarried','Door No. 4-7-33, Powerpet, Eluru', 'Pot Maker','Andhra Pradesh ','3000','9586452653','245456215351','ABCRF5984F',3);
Insert Into CustomerTable Values (20,'BR1','Vijaya','Laxmi','2004-11-5','Female','married','D.No. 12-5-44, Sarpavaram Junction, Kakinada' ,'Kirana Store','Andhra Pradesh ','1000','9854857854','245896234565','ABRFV1534F',3);
Insert Into CustomerTable Values (21,'BR1','Sony','Verma','1999-03-5','Female','Unmarried','H.No. 3-29, Main Street, Amalapuram' ,'Pot Maker','Andhra Pradesh ','2000','9854685952','245896541254','ABCRF78DF5',3);

Insert Into CustomerTable Values (22,'BR2','Maha','Lakshmi','2000-09-19','Female','Unmarried','Plot No. 8, Vidya Nagar, Puttaparthi' ,'Homemade Papads','Andhra Pradesh ','4000','9856423125','245896545285','ABCDRF748D',4);
Insert Into CustomerTable Values (23,'BR2','Riya','Agarwal','2000-08-26','Female','married','D.No. 7-2-116, Mylavaram Main Road, Mylavaram' ,'Pot Maker','Andhra Pradesh ','2000','9856422652','245825645351','ABCRF785DF',4);
Insert Into CustomerTable Values (24,'BR2','Bhavani','Kumari','2002-07-14','Female','Unmarried','H.No. 1-4-17, Gandhi Chowk, Parvathipuram' ,'Homemade Papads','Andhra Pradesh ','6000','9856845625','245852542351','ABCDD8E85F',4);
Insert Into CustomerTable Values (25,'BR2','Hema','Singh','2002-07-14','Female','Unmarried','D.No. 2-9, Near Primary School, Rampachodavaram','Pot Maker','Andhra Pradesh ','3000','8856482561','245896541256','ABCEDR58D4',4);
Insert Into CustomerTable Values (26,'BR2','Siddharth ','Singh','2000-06-5','Male','Unmarried',		'Plot No. 54, Main Road, Visakhapatnam' ,'Pot Maker','Andhra Pradesh ','3000','8856740561','245896542351','ASD5E1234F',4);
Insert Into CustomerTable Values (27,'BR2','Yash ','Sharma','2001-04-15','Male','married',			'Flat No. 301, Green Park Apartments, Vijayawada' ,' Vegetable Selling','Andhra Pradesh ','2000','8854225312','244526542351','ALCD12L34F',4);
Insert Into CustomerTable Values (28,'BR2','Aadhya','Mourya','2001-01-25','Female','Unmarried',		'H.No. 12-34-56, Near Bus Stand, Guntur' ,'Fruit Selling','Andhra Pradesh ','5000','9985042513','245890542351','ABLSD1534F',4);
Insert Into CustomerTable Values (29,'BR2','Dhruv ','Singh','1995-05-23','Male','married',			'House No. 8-9-101, MG Road, Nellore' ,'Livestock Rearing','Andhra Pradesh ','1000','9856012562','520896542351','ABKCV1254F',4);
Insert Into CustomerTable Values (30,'BR2','Kiara','Sharma','2001-08-19','Female','Unmarried',		'10-45-29, Lakshmi Nagar, Rajamahendravaram' ,' Kirana Store','Andhra Pradesh','7000','9856470512','215890542351','XOCDE1284F',4);
Insert Into CustomerTable Values (31,'BR2','Arjun ','Khan','1999-02-15','Male','married',			'4-2-100, Lakshmi Nagar, Rajamahendravaram' ,'Home-based Food ','Andhra Pradesh','5000','9985640563','526150542351','ABCDO5234F',4);
Insert Into CustomerTable Values (32,'BR2','Aashna','Kiran','2002-03-25','Female','married',		'Flat No. 301, Green Park Apartments, Vijayawada', 'Cloths Selling','Andhra Pradesh','2000','8856402561','9856025642','ABCPF5214F',5);
Insert Into CustomerTable Values (33,'BR2','Ishaan ','Tagore','2002-05-16','Male','Unmarried',		'H.No. 12-34-56, Near Bus Stand, Guntur','Detergent Production','Andhra Pradesh','3000','9356048562','245096556485','ABCBP1254F',5);
Insert Into CustomerTable Values (34,'BR2','Mansi','Khanna','2001-01-26','Female','Unmarried',		'House No. 8-9-101, MG Road, Nellore' ,'Homemade Masalas','Andhra Pradesh','4000','9875048521','245895460859','KBCBG1534F',5);
Insert Into CustomerTable Values (35,'BR2','Advik ','Sharma','2000-03-29','Male','married',			'Plot No. 18, Street No. 4, Karimnagar' ,'Poultry Farming','Andhra Pradesh','5000','9875680598','245801622351','ASDPE1234F',5);
Insert Into CustomerTable Values (36,'BR2','Pranav ','Agarwal','2003-11-16','Male','Unmarried',		'Plot No. 54, Main Road, Warangal' ,'Homemade Pickles ','Andhra Pradesh','5000','9988506654','512656042351','ABSID5534F',5);

Insert Into CustomerTable Values (37,'BR3','Ayaan ','Sekhar','2004-08-21','Male','Unmarried',		'Shop No. 7, Jubilee Hills Commercial Complex, Hyderabad' ,'Home Tuition ','Telangana','4000','8560456523','245096545264','ALDFG5654F',6);
Insert Into CustomerTable Values (38,'BR3','Anita','Ammi','2002-04-22','Female','married',			'22-5-1, Street No. 12, Lingampally, Hyderabad' ,'Homemade Papads  ','Telangana','2000','9987504852','125696042351','ABUCD1254F',6);
Insert Into CustomerTable Values (39,'BR3','Tanmay ','Anand','2006-02-27','Male','married',			'House No. 8-9-101, MG Road, Nellore' ,'Homemade Masalas','Telangana','3000','9856480216','240082562351','ABCUC6664F',6);
Insert Into CustomerTable Values (40,'BR3','Deeksha','Sinha','2002-01-23','Female','Unmarried',		'House No. 8-10-15, Rajeev Nagar, Warangal' ,'Fruit Selling','Telangana','6000','9985684098','245892064551','ADCMV5644F',6);
Insert Into CustomerTable Values (41,'BR3','Raghav ','sohan','2001-1-3','Male','married',			'4-2-100, Road No. 5, Banjara Hills, Hyderabad' ,'Kirana Store','Telangana','1000','9562150623','240896542255','ABFVG5564F',6);
Insert Into CustomerTable Values (42,'BR3','Komal','Varma','2002-01-2','Female','Unmarried',		'H.No. 6-3-17, Ramalayam Street, Bapatla' ,'Snacks Business','Telangana','4000','9568409826','245896203456','ABCD97234F',6);
Insert Into CustomerTable Values (43,'BR3','Manav ','Kumar','1998-03-18','Male','married',			'22-5-1, Street No. 12, Lingampally, Hyderabad' ,'Cloths Selling','Telangana','5000','9560452651','245026342351','ABDCF0234F',6);
Insert Into CustomerTable Values (44,'BR3','Komali','Sekhar','2001-09-12','Female','married',		'Shop No. 7, Jubilee Hills Commercial Complex, Hyderabad','Cloths Selling','Telangana','3000','9586052653','245456205351','ABCPF5984F',6);
Insert Into CustomerTable Values (45,'BR3','Vedant ','Lohi','2002-10-5','Male','married',			'House No. 8-10-15, Rajeev Nagar, Warangal' ,'Kirana Store','Telangana','1000','9854807854','245096234565','ABRFV1504F',6);
Insert Into CustomerTable Values (46,'BR3','Sumali','Verma','1995-02-5','Female','married',			'Plot No. 18, Street No. 4, Karimnagar' ,'Pot Maker','Telangana','2000','9854680952','245806541254','ABCRF70DF5',6);

Insert Into CustomerTable Values (47,'BR3','Neil ','varma','2001-09-19','Male','Unmarried',			'5-10-22, Gandhi Nagar, Anantapur' ,'Homemade Papads','Telangana','4000','9856423025','245896545285','ABCDRF7485',7);
Insert Into CustomerTable Values (48,'BR3','Samar ','Agarwal','2001-08-26','Male','married',		'D.No 12-2-18, M.G Road, Kurnool' ,'Pot Maker','Telangana','2000','9856402652','245825045351','ABCRF7850F',7);
Insert Into CustomerTable Values (49,'BR3','Rishi ','Kumar','2002-08-14','Male','Unmarried',		'H.No. 8-2-66, Beside Railway Station, Ongole' ,'Homemade Papads','Telangana','6000','9806845625','245052542351','ABCOD8E85F',7);
Insert Into CustomerTable Values (50,'BR3','Himadri','Singh','2001-07-14','Female','married',		'H.No. 7-12-35, Street No. 9, Himayat Nagar, Hyderabad','Pot Maker','Telangana','3000','8856482061','245896540256','ABCLDR58D4',7);
Insert Into CustomerTable Values (51,'BR3','Siddharth ','Singh','2000-06-5','Male','Unmarried',		'Plot No. 54, Main Road, Visakhapatnam' ,'Pot Maker','Telangana','3000','8856702561','245896542351','ASD5E1234F',7);
Insert Into CustomerTable Values (52,'BR3','Yash ','Sharma','2001-04-15','Male','married',			'Flat No. 301, Green Park Apartments, Vijayawada' ,' Vegetable Selling','Telangana','2000','8854225312','244526542351','ALCD12L34F',7);
Insert Into CustomerTable Values (53,'BR3','Aadhya','Mourya','2001-01-25','Female','Unmarried',		'H.No. 12-34-56, Near Bus Stand, Guntur' ,'Fruit Selling','Telangana','5000','9985042513','245890542351','ABLSD1534F',7);
Insert Into CustomerTable Values (54,'BR3','Dhruv ','Singh','1995-05-23','Male','married',			'House No. 8-9-101, MG Road, Nellore' ,'Livestock Rearing','Telangana','1000','9856012562','520896542351','ABKCV1254F',7);
Insert Into CustomerTable Values (55,'BR3','Kiara','Sharma','2001-08-19','Female','Unmarried',		'10-45-29, Lakshmi Nagar, Rajamahendravaram' ,' Kirana Store','Telangana','7000','9856470512','215890542351','XOCDE1284F',7);
Insert Into CustomerTable Values (56,'BR3','Arjun ','Khan','1999-02-15','Male','married',			'4-2-100, Road No. 5, Banjara Hills, Hyderabad' ,'Home-based Food ','Telangana','5000','9985640563','526150542351','ABCDO5234F',7);

Insert Into CustomerTable Values (57,'BR4','Aashna','Kiran','2002-03-25','Female','married',		'D.No. 15-2-60, Nehru Nagar, Renigunta, Tirupati', 'Cloths Selling','Andhra Pradesh','2000','8856402561','9856025642','ABCPF5214F',8);
Insert Into CustomerTable Values (58,'BR4','Ishaan ','Tagore','2002-05-16','Male','Unmarried',		'Flat No. 105, Vamsi Residency, Brodipet, Guntur' ,'Detergent Production','Andhra Pradesh','3000','9356048562','245096556485','ABCBP1254F',8);
Insert Into CustomerTable Values (59,'BR4','Mansi','Khanna','2001-01-26','Female','Unmarried',		'D.No. 10-2-55, Nehru Nagar, Renigunta, Tirupati','Snacks Business','Andhra Pradesh','4000','9875048521','245895460859','KBCBG1534F',8);
Insert Into CustomerTable Values (60,'BR4','Advik ','Sharma','2000-03-29','Male','married',			'Flat No. 101, Vamsi Residency, Brodipet, Guntur' ,'Poultry Farming','Andhra Pradesh','5000','9875680598','245801622351','ASDPE1234F',8);
Insert Into CustomerTable Values (61,'BR4','Pranav ','Agarwal','2003-11-16','Male','Unmarried',		'Plot No. 12, Sri Sai Colony, Anakapalli' ,'Homemade Pickles ','Andhra Pradesh','5000','9988506654','512656042351','ABSID5534F',8);
Insert Into CustomerTable Values (62,'BR4','Ayaan ','Sekhar','2004-08-21','Male','Unmarried',		'Flat No. 301, Green Park Apartments, Vijayawada' ,'Home Tuition ','Andhra Pradesh','4000','8560456523','245096545264','ALDFG5654F',8);
Insert Into CustomerTable Values (63,'BR4','Anita','Ammi','2002-04-22','Female','married',			'H.No. 12-34-56, Near Bus Stand, Guntur' ,'Homemade Papads  ','Andhra Pradesh','2000','9987504852','125696042351','ABUCD1254F',8);
Insert Into CustomerTable Values (64,'BR4','Tanmay ','Anand','2006-02-27','Male','married',			'House No. 8-9-101, MG Road, Nellore' ,'Homemade Masalas','Andhra Pradesh','3000','9856480216','240081262351','ABCUC6664F',8);
Insert Into CustomerTable Values (65,'BR4','Deeksha','Sinha','2002-01-23','Female','Unmarried',		'10-45-29, Lakshmi Nagar, Rajamahendravaram' ,'Fruit Selling','Andhra Pradesh','6000','9985684098','245892064551','ADCMV5644F',8);

-- Inserting data into LoansType Table
--						LoanTypeID,LoanTypeName,MinAmount,MaxAmount
Insert Into LoansType Values (1,'Weekly Loan',5000,10000);---M
Insert Into LoansType Values (2,'Monthly Loan',10000,25000);	---W
Insert Into LoansType Values (3,'Personal Loan',25000,70000);--Y

-- Inserting data into LoansTable				{PrincipalAmount=LoanAmount} and {InterestRate=LoanInterestRate}
Insert Into Loans (LoanID, CustomerID, LoanTypeID, LoanAmount, LoanInterestRate, TenureInMonth, LoanStartDate, LoanEndDate, LoanStatus) Values
(101, 1, 3, 19000, 14, 12, '2020-01-09', '2021-01-09', 'Completed'),
(102, 2, 1, 41000, 16, 36, '2022-02-25', '2025-02-25', 'Active'),
(103, 3, 3, 64000, 16, 36, '2023-07-09', '2026-07-09', 'Completed'),
(104, 4, 1, 42000, 16, 36, '2024-02-27', '2027-02-27', 'Active'),
(105, 5, 3, 27000, 14, 12, '2025-01-13', '2026-01-13', 'Active'),
(106, 6, 2, 35000, 16, 36, '2020-09-18', '2023-09-18', 'Completed'),
(107, 7, 2, 52000, 16, 36, '2022-06-11', '2025-06-11', 'Active'),
(108, 8, 3, 21000, 14, 12, '2023-01-06', '2024-01-06', 'Active'),
(109, 9, 3, 12000, 14, 12, '2024-03-11', '2025-03-11', 'Completed'),
(110, 10, 3, 23000, 14, 12, '2025-09-11', '2026-09-11', 'Active'),
(111, 11, 2, 23000, 14, 12, '2020-12-08', '2021-12-08', 'Active'),
(112, 12, 1, 6000, 12, 6, '2022-03-01', '2022-09-01', 'Completed'),
(113, 13, 1, 10000, 12, 6, '2023-07-25', '2024-01-25', 'Active'),
(114, 14, 3, 22000, 14, 12, '2024-02-20', '2025-02-20', 'Completed'),
(115, 15, 3, 19000, 14, 12, '2025-07-03', '2026-07-03', 'Active'),
(116, 16, 2, 6000, 12, 6, '2020-01-11', '2020-07-11', 'Active'),
(117, 17, 3, 40000, 16, 36, '2022-12-15', '2025-12-15', 'Completed'),
(118, 18, 2, 13000, 14, 12, '2023-02-02', '2024-02-02', 'Active'),
(119, 19, 3, 31000, 16, 36, '2024-02-22', '2027-02-22', 'Active'),
(120, 20, 1, 9000, 12, 6, '2025-03-05', '2025-09-05', 'Completed'),
(121, 21, 2, 18000, 14, 12, '2020-01-10', '2021-01-10', 'Active'),
(122, 22, 2, 33000, 16, 36, '2022-07-19', '2025-07-19', 'Completed'),
(123, 23, 1, 10000, 12, 6, '2023-08-09', '2024-02-09', 'Active'),
(124, 24, 1, 8000, 12, 6, '2024-08-27', '2025-02-27', 'Active'),
(125, 25, 3, 62000, 16, 36, '2025-01-25', '2028-01-25', 'Completed'),
(126, 26, 1, 8000, 12, 6, '2020-05-11', '2020-11-11', 'Active'),
(127, 27, 2, 31000, 16, 36, '2022-09-26', '2025-09-26', 'Completed'),
(128, 28, 3, 13000, 14, 12, '2023-08-18', '2024-08-18', 'Active'),
(129, 29, 1, 9000, 12, 6, '2024-06-05', '2024-12-05', 'Active'),
(130, 30, 3, 22000, 14, 12, '2025-10-23', '2026-10-23', 'Completed'),
(131, 31, 2, 13000, 14, 12, '2020-02-07', '2021-02-07', 'Active'),
(132, 32, 3, 14000, 14, 12, '2022-03-30', '2023-03-30', 'Active'),
(133, 33, 1, 6000, 12, 6, '2023-01-09', '2023-07-09', 'Completed'),
(134, 34, 2, 29000, 16, 36, '2024-05-24', '2027-05-24', 'Active'),
(135, 35, 2, 33000, 16, 36, '2025-04-14', '2028-04-14', 'Completed'),
(136, 36, 1, 11000, 12, 12, '2020-06-10', '2021-06-10', 'Active'),
(137, 37, 3, 31000, 16, 36, '2022-07-28', '2025-07-28', 'Completed'),
(138, 38, 3, 20000, 14, 12, '2023-09-16', '2024-09-16', 'Active'),
(139, 39, 2, 31000, 16, 36, '2024-10-10', '2027-10-10', 'Active'),
(140, 40, 1, 13000, 12, 12, '2025-11-22', '2026-11-22', 'Completed'),
(141, 41, 2, 30000, 16, 36, '2020-05-12', '2023-05-12', 'Active'),
(142, 42, 3, 18000, 14, 12, '2022-08-21', '2023-08-21', 'Completed'),
(143, 43, 1, 7000, 12, 6, '2023-12-03', '2024-06-03', 'Active'),
(144, 44, 3, 20000, 14, 12, '2024-11-05', '2025-11-05', 'Completed'),
(145, 45, 2, 22000, 14, 12, '2025-02-12', '2026-02-12', 'Active'),
(146, 46, 1, 13000, 12, 12, '2020-03-19', '2021-03-19', 'Completed'),
(147, 47, 2, 31000, 16, 36, '2022-04-16', '2025-04-16', 'Active'),
(148, 48, 3, 10000, 12, 6, '2023-05-22', '2023-11-22', 'Completed'),
(149, 49, 1, 31000, 16, 36, '2024-06-21', '2027-06-21', 'Active'),
(150, 50, 2, 18000, 14, 12, '2025-10-09', '2026-10-09', 'Completed'),
(151, 51, 3, 14000, 14, 12, '2020-08-24', '2021-08-24', 'Active'),
(152, 52, 1, 23000, 14, 12, '2022-11-30', '2023-11-30', 'Completed'),
(153, 53, 2, 19000, 14, 12, '2023-12-06', '2024-12-06', 'Active'),
(154, 54, 3, 14000, 14, 12, '2024-04-06', '2025-04-06', 'Active'),
(155, 55, 1, 15000, 14, 12, '2025-07-01', '2026-07-01', 'Completed'),
(156, 56, 2, 11000, 12, 12, '2020-06-16', '2021-06-16', 'Active'),
(157, 57, 3, 18000, 14, 12, '2022-01-08', '2023-01-08', 'Completed'),
(158, 58, 1, 24000, 14, 12, '2023-03-17', '2024-03-17', 'Active'),
(159, 59, 2, 26000, 14, 12, '2024-05-04', '2025-05-04', 'Completed'),
(160, 60, 3, 30000, 16, 36, '2025-09-08', '2028-09-08', 'Active'),
(161, 61, 1, 12000, 14, 12, '2020-10-03', '2021-10-03', 'Completed'),
(162, 62, 2, 13000, 14, 12, '2022-09-25', '2023-09-25', 'Active'),
(163, 63, 3, 15000, 14, 12, '2023-07-16', '2024-07-16', 'Completed'),
(164, 64, 1, 17000, 14, 12, '2024-12-24', '2025-12-24', 'Active'),
(165, 65, 2, 20000, 14, 12, '2025-09-25', '2026-09-25', 'Completed');

--select * from Loans

--- >>   RepaymentID,LoanID,PaymentsDate,LoanAmountPaid,PaymentMode	 
-- Inserting data into Repayments Table:		
Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(101, '2020-01-09', 1583.33, 'NET BANKING'),
(101, '2020-02-09', 1583.33, 'UPI'),
(101, '2020-03-09', 1583.33, 'CHEQUE'),
(101, '2020-04-09', 1583.33, 'NET BANKING'),
(101, '2020-05-09', 1583.33, 'UPI'),
(101, '2020-06-09', 1583.33, 'CHEQUE'),
(101, '2020-07-09', 1583.33, 'NET BANKING'),
(101, '2020-08-09', 1583.33, 'UPI'),
(101, '2020-09-09', 1583.33, 'CHEQUE'),
(101, '2020-10-09', 1583.33, 'NET BANKING'),
(101, '2020-11-09', 1583.33, 'UPI'),
(101, '2020-12-09', 1583.33, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(102, '2022-02-25', 1138.89, 'NET BANKING'),
(102, '2022-03-25', 1138.89, 'UPI'),
(102, '2022-04-25', 1138.89, 'CHEQUE'),
(102, '2022-05-25', 1138.89, 'NET BANKING'),
(102, '2022-06-25', 1138.89, 'UPI'),
(102, '2022-07-25', 1138.89, 'CHEQUE'),
(102, '2022-08-25', 1138.89, 'NET BANKING'),
(102, '2022-09-25', 1138.89, 'UPI'),
(102, '2022-10-25', 1138.89, 'CHEQUE'),
(102, '2022-11-25', 1138.89, 'NET BANKING'),
(102, '2022-12-25', 1138.89, 'UPI'),
(102, '2023-01-25', 1138.89, 'CHEQUE'),
(102, '2023-02-25', 1138.89, 'NET BANKING'),
(102, '2023-03-25', 1138.89, 'UPI'),
(102, '2023-04-25', 1138.89, 'CHEQUE'),
(102, '2023-05-25', 1138.89, 'NET BANKING'),
(102, '2023-06-25', 1138.89, 'UPI'),
(102, '2023-07-25', 1138.89, 'CHEQUE'),
(102, '2023-08-25', 1138.89, 'NET BANKING'),
(102, '2023-09-25', 1138.89, 'UPI'),
(102, '2023-10-25', 1138.89, 'CHEQUE'),
(102, '2023-11-25', 1138.89, 'NET BANKING'),
(102, '2023-12-25', 1138.89, 'UPI'),
(102, '2024-01-25', 1138.89, 'CHEQUE'),
(102, '2024-02-25', 1138.89, 'NET BANKING'),
(102, '2024-03-25', 1138.89, 'UPI'),
(102, '2024-04-25', 1138.89, 'CHEQUE'),
(102, '2024-05-25', 1138.89, 'NET BANKING'),
(102, '2024-06-25', 1138.89, 'UPI'),
(102, '2024-07-25', 1138.89, 'CHEQUE'),
(102, '2024-08-25', 1138.89, 'NET BANKING'),
(102, '2024-09-25', 1138.89, 'UPI'),
(102, '2024-10-25', 1138.89, 'CHEQUE'),
(102, '2024-11-25', 1138.89, 'NET BANKING'),
(102, '2024-12-25', 1138.89, 'UPI'),
(102, '2025-01-25', 1138.89, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(103, '2023-07-09', 1777.78, 'NET BANKING'),
(103, '2023-08-09', 1777.78, 'UPI'),
(103, '2023-09-09', 1777.78, 'CHEQUE'),
(103, '2023-10-09', 1777.78, 'NET BANKING'),
(103, '2023-11-09', 1777.78, 'UPI'),
(103, '2023-12-09', 1777.78, 'CHEQUE'),
(103, '2024-01-09', 1777.78, 'NET BANKING'),
(103, '2024-02-09', 1777.78, 'UPI'),
(103, '2024-03-09', 1777.78, 'CHEQUE'),
(103, '2024-04-09', 1777.78, 'NET BANKING'),
(103, '2024-05-09', 1777.78, 'UPI'),
(103, '2024-06-09', 1777.78, 'CHEQUE'),
(103, '2024-07-09', 1777.78, 'NET BANKING'),
(103, '2024-08-09', 1777.78, 'UPI'),
(103, '2024-09-09', 1777.78, 'CHEQUE'),
(103, '2024-10-09', 1777.78, 'NET BANKING'),
(103, '2024-11-09', 1777.78, 'UPI'),
(103, '2024-12-09', 1777.78, 'CHEQUE'),
(103, '2025-01-09', 1777.78, 'NET BANKING'),
(103, '2025-02-09', 1777.78, 'UPI'),
(103, '2025-03-09', 1777.78, 'CHEQUE'),
(103, '2025-04-09', 1777.78, 'NET BANKING'),
(103, '2025-05-09', 1777.78, 'UPI'),
(103, '2025-06-09', 1777.78, 'CHEQUE'),
(103, '2025-07-09', 1777.78, 'NET BANKING'),
(103, '2025-08-09', 1777.78, 'UPI'),
(103, '2025-09-09', 1777.78, 'CHEQUE'),
(103, '2025-10-09', 1777.78, 'NET BANKING'),
(103, '2025-11-09', 1777.78, 'UPI'),
(103, '2025-12-09', 1777.78, 'CHEQUE'),
(103, '2026-01-09', 1777.78, 'NET BANKING'),
(103, '2026-02-09', 1777.78, 'UPI'),
(103, '2026-03-09', 1777.78, 'CHEQUE'),
(103, '2026-04-09', 1777.78, 'NET BANKING'),
(103, '2026-05-09', 1777.78, 'UPI'),
(103, '2026-06-09', 1777.78, 'CHEQUE');

Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(104, '2024-02-27', 1166.67, 'NET BANKING'),
(104, '2024-03-27', 1166.67, 'UPI'),
(104, '2024-04-27', 1166.67, 'CHEQUE'),
(104, '2024-05-27', 1166.67, 'NET BANKING'),
(104, '2024-06-27', 1166.67, 'UPI'),
(104, '2024-07-27', 1166.67, 'CHEQUE'),
(104, '2024-08-27', 1166.67, 'NET BANKING'),
(104, '2024-09-27', 1166.67, 'UPI'),
(104, '2024-10-27', 1166.67, 'CHEQUE'),
(104, '2024-11-27', 1166.67, 'NET BANKING'),
(104, '2024-12-27', 1166.67, 'UPI'),
(104, '2025-01-27', 1166.67, 'CHEQUE'),
(104, '2025-02-27', 1166.67, 'NET BANKING'),
(104, '2025-03-27', 1166.67, 'UPI'),
(104, '2025-04-27', 1166.67, 'CHEQUE'),
(104, '2025-05-27', 1166.67, 'NET BANKING'),
(104, '2025-06-27', 1166.67, 'UPI'),
(104, '2025-07-27', 1166.67, 'CHEQUE'),
(104, '2025-08-27', 1166.67, 'NET BANKING'),
(104, '2025-09-27', 1166.67, 'UPI'),
(104, '2025-10-27', 1166.67, 'CHEQUE'),
(104, '2025-11-27', 1166.67, 'NET BANKING'),
(104, '2025-12-27', 1166.67, 'UPI'),
(104, '2026-01-27', 1166.67, 'CHEQUE'),
(104, '2026-02-27', 1166.67, 'NET BANKING'),
(104, '2026-03-27', 1166.67, 'UPI'),
(104, '2026-04-27', 1166.67, 'CHEQUE'),
(104, '2026-05-27', 1166.67, 'NET BANKING'),
(104, '2026-06-27', 1166.67, 'UPI'),
(104, '2026-07-27', 1166.67, 'CHEQUE'),
(104, '2026-08-27', 1166.67, 'NET BANKING'),
(104, '2026-09-27', 1166.67, 'UPI'),
(104, '2026-10-27', 1166.67, 'CHEQUE'),
(104, '2026-11-27', 1166.67, 'NET BANKING'),
(104, '2026-12-27', 1166.67, 'UPI'),
(104, '2027-01-27', 1166.67, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(105, '2025-01-13', 2250.0, 'NET BANKING'),
(105, '2025-02-13', 2250.0, 'UPI'),
(105, '2025-03-13', 2250.0, 'CHEQUE'),
(105, '2025-04-13', 2250.0, 'NET BANKING'),
(105, '2025-05-13', 2250.0, 'UPI'),
(105, '2025-06-13', 2250.0, 'CHEQUE'),
(105, '2025-07-13', 2250.0, 'NET BANKING'),
(105, '2025-08-13', 2250.0, 'UPI'),
(105, '2025-09-13', 2250.0, 'CHEQUE'),
(105, '2025-10-13', 2250.0, 'NET BANKING'),
(105, '2025-11-13', 2250.0, 'UPI'),
(105, '2025-12-13', 2250.0, 'CHEQUE');

 
Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(106, '2020-09-18', 972.22, 'NET BANKING'),
(106, '2020-10-18', 972.22, 'UPI'),
(106, '2020-11-18', 972.22, 'CHEQUE'),
(106, '2020-12-18', 972.22, 'NET BANKING'),
(106, '2021-01-18', 972.22, 'UPI'),
(106, '2021-02-18', 972.22, 'CHEQUE'),
(106, '2021-03-18', 972.22, 'NET BANKING'),
(106, '2021-04-18', 972.22, 'UPI'),
(106, '2021-05-18', 972.22, 'CHEQUE'),
(106, '2021-06-18', 972.22, 'NET BANKING'),
(106, '2021-07-18', 972.22, 'UPI'),
(106, '2021-08-18', 972.22, 'CHEQUE'),
(106, '2021-09-18', 972.22, 'NET BANKING'),
(106, '2021-10-18', 972.22, 'UPI'),
(106, '2021-11-18', 972.22, 'CHEQUE'),
(106, '2021-12-18', 972.22, 'NET BANKING'),
(106, '2022-01-18', 972.22, 'UPI'),
(106, '2022-02-18', 972.22, 'CHEQUE'),
(106, '2022-03-18', 972.22, 'NET BANKING'),
(106, '2022-04-18', 972.22, 'UPI'),
(106, '2022-05-18', 972.22, 'CHEQUE'),
(106, '2022-06-18', 972.22, 'NET BANKING'),
(106, '2022-07-18', 972.22, 'UPI'),
(106, '2022-08-18', 972.22, 'CHEQUE'),
(106, '2022-09-18', 972.22, 'NET BANKING'),
(106, '2022-10-18', 972.22, 'UPI'),
(106, '2022-11-18', 972.22, 'CHEQUE'),
(106, '2022-12-18', 972.22, 'NET BANKING'),
(106, '2023-01-18', 972.22, 'UPI'),
(106, '2023-02-18', 972.22, 'CHEQUE'),
(106, '2023-03-18', 972.22, 'NET BANKING'),
(106, '2023-04-18', 972.22, 'UPI'),
(106, '2023-05-18', 972.22, 'CHEQUE'),
(106, '2023-06-18', 972.22, 'NET BANKING'),
(106, '2023-07-18', 972.22, 'UPI'),
(106, '2023-08-18', 972.22, 'CHEQUE');

Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(107, '2022-06-11', 1444.44, 'NET BANKING'),
(107, '2022-07-11', 1444.44, 'UPI'),
(107, '2022-08-11', 1444.44, 'CHEQUE'),
(107, '2022-09-11', 1444.44, 'NET BANKING'),
(107, '2022-10-11', 1444.44, 'UPI'),
(107, '2022-11-11', 1444.44, 'CHEQUE'),
(107, '2022-12-11', 1444.44, 'NET BANKING'),
(107, '2023-01-11', 1444.44, 'UPI'),
(107, '2023-02-11', 1444.44, 'CHEQUE'),
(107, '2023-03-11', 1444.44, 'NET BANKING'),
(107, '2023-04-11', 1444.44, 'UPI'),
(107, '2023-05-11', 1444.44, 'CHEQUE'),
(107, '2023-06-11', 1444.44, 'NET BANKING'),
(107, '2023-07-11', 1444.44, 'UPI'),
(107, '2023-08-11', 1444.44, 'CHEQUE'),
(107, '2023-09-11', 1444.44, 'NET BANKING'),
(107, '2023-10-11', 1444.44, 'UPI'),
(107, '2023-11-11', 1444.44, 'CHEQUE'),
(107, '2023-12-11', 1444.44, 'NET BANKING'),
(107, '2024-01-11', 1444.44, 'UPI'),
(107, '2024-02-11', 1444.44, 'CHEQUE'),
(107, '2024-03-11', 1444.44, 'NET BANKING'),
(107, '2024-04-11', 1444.44, 'UPI'),
(107, '2024-05-11', 1444.44, 'CHEQUE'),
(107, '2024-06-11', 1444.44, 'NET BANKING'),
(107, '2024-07-11', 1444.44, 'UPI'),
(107, '2024-08-11', 1444.44, 'CHEQUE'),
(107, '2024-09-11', 1444.44, 'NET BANKING'),
(107, '2024-10-11', 1444.44, 'UPI'),
(107, '2024-11-11', 1444.44, 'CHEQUE'),
(107, '2024-12-11', 1444.44, 'NET BANKING'),
(107, '2025-01-11', 1444.44, 'UPI'),
(107, '2025-02-11', 1444.44, 'CHEQUE'),
(107, '2025-03-11', 1444.44, 'NET BANKING'),
(107, '2025-04-11', 1444.44, 'UPI'),
(107, '2025-05-11', 1444.44, 'CHEQUE');

Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(108, '2023-01-06', 1750.0, 'NET BANKING'),
(108, '2023-02-06', 1750.0, 'UPI'),
(108, '2023-03-06', 1750.0, 'CHEQUE'),
(108, '2023-04-06', 1750.0, 'NET BANKING'),
(108, '2023-05-06', 1750.0, 'UPI'),
(108, '2023-06-06', 1750.0, 'CHEQUE'),
(108, '2023-07-06', 1750.0, 'NET BANKING'),
(108, '2023-08-06', 1750.0, 'UPI'),
(108, '2023-09-06', 1750.0, 'CHEQUE'),
(108, '2023-10-06', 1750.0, 'NET BANKING'),
(108, '2023-11-06', 1750.0, 'UPI'),
(108, '2023-12-06', 1750.0, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(109, '2024-03-11', 1000.0, 'NET BANKING'),
(109, '2024-04-11', 1000.0, 'UPI'),
(109, '2024-05-11', 1000.0, 'CHEQUE'),
(109, '2024-06-11', 1000.0, 'NET BANKING'),
(109, '2024-07-11', 1000.0, 'UPI'),
(109, '2024-08-11', 1000.0, 'CHEQUE'),
(109, '2024-09-11', 1000.0, 'NET BANKING'),
(109, '2024-10-11', 1000.0, 'UPI'),
(109, '2024-11-11', 1000.0, 'CHEQUE'),
(109, '2024-12-11', 1000.0, 'NET BANKING'),
(109, '2025-01-11', 1000.0, 'UPI'),
(109, '2025-02-11', 1000.0, 'CHEQUE');

Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(110, '2025-09-11', 1916.67, 'NET BANKING'),
(110, '2025-10-11', 1916.67, 'UPI'),
(110, '2025-11-11', 1916.67, 'CHEQUE'),
(110, '2025-12-11', 1916.67, 'NET BANKING'),
(110, '2026-01-11', 1916.67, 'UPI'),
(110, '2026-02-11', 1916.67, 'CHEQUE'),
(110, '2026-03-11', 1916.67, 'NET BANKING'),
(110, '2026-04-11', 1916.67, 'UPI'),
(110, '2026-05-11', 1916.67, 'CHEQUE'),
(110, '2026-06-11', 1916.67, 'NET BANKING'),
(110, '2026-07-11', 1916.67, 'UPI'),
(110, '2026-08-11', 1916.67, 'CHEQUE');

Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(111, '2020-12-08', 1916.67, 'NET BANKING'),
(111, '2021-01-08', 1916.67, 'UPI'),
(111, '2021-02-08', 1916.67, 'CHEQUE'),
(111, '2021-03-08', 1916.67, 'NET BANKING'),
(111, '2021-04-08', 1916.67, 'UPI'),
(111, '2021-05-08', 1916.67, 'CHEQUE'),
(111, '2021-06-08', 1916.67, 'NET BANKING'),
(111, '2021-07-08', 1916.67, 'UPI'),
(111, '2021-08-08', 1916.67, 'CHEQUE'),
(111, '2021-09-08', 1916.67, 'NET BANKING'),
(111, '2021-10-08', 1916.67, 'UPI'),
(111, '2021-11-08', 1916.67, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(112, '2022-03-01', 1000.0, 'NET BANKING'),
(112, '2022-04-01', 1000.0, 'UPI'),
(112, '2022-05-01', 1000.0, 'CHEQUE'),
(112, '2022-06-01', 1000.0, 'NET BANKING'),
(112, '2022-07-01', 1000.0, 'UPI'),
(112, '2022-08-01', 1000.0, 'CHEQUE');

Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(113, '2023-07-25', 1666.67, 'NET BANKING'),
(113, '2023-08-25', 1666.67, 'UPI'),
(113, '2023-09-25', 1666.67, 'CHEQUE'),
(113, '2023-10-25', 1666.67, 'NET BANKING'),
(113, '2023-11-25', 1666.67, 'UPI'),
(113, '2023-12-25', 1666.67, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(114, '2025-06-03', 2916.67, 'NET BANKING'),
(114, '2025-07-03', 2916.67, 'UPI'),
(114, '2025-08-03', 2916.67, 'CHEQUE'),
(114, '2025-09-03', 2916.67, 'NET BANKING'),
(114, '2025-10-03', 2916.67, 'UPI'),
(114, '2025-11-03', 2916.67, 'CHEQUE'),
(114, '2025-12-03', 2916.67, 'NET BANKING'),
(114, '2026-01-03', 2916.67, 'UPI'),
(114, '2026-02-03', 2916.67, 'CHEQUE'),
(114, '2026-03-03', 2916.67, 'NET BANKING'),
(114, '2026-04-03', 2916.67, 'UPI'),
(114, '2026-05-03', 2916.67, 'CHEQUE');

Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(115, '2021-12-08', 2666.67, 'NET BANKING'),
(115, '2022-01-08', 2666.67, 'UPI'),
(115, '2022-02-08', 2666.67, 'CHEQUE'),
(115, '2022-03-08', 2666.67, 'NET BANKING'),
(115, '2022-04-08', 2666.67, 'UPI'),
(115, '2022-05-08', 2666.67, 'CHEQUE'),
(115, '2022-06-08', 2666.67, 'NET BANKING'),
(115, '2022-07-08', 2666.67, 'UPI'),
(115, '2022-08-08', 2666.67, 'CHEQUE'),
(115, '2022-09-08', 2666.67, 'NET BANKING'),
(115, '2022-10-08', 2666.67, 'UPI'),
(115, '2022-11-08', 2666.67, 'CHEQUE');

Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(116, '2024-09-19', 833.33, 'NET BANKING'),
(116, '2024-10-19', 833.33, 'UPI'),
(116, '2024-11-19', 833.33, 'CHEQUE'),
(116, '2024-12-19', 833.33, 'NET BANKING'),
(116, '2025-01-19', 833.33, 'UPI'),
(116, '2025-02-19', 833.33, 'CHEQUE'),
(116, '2025-03-19', 833.33, 'NET BANKING'),
(116, '2025-04-19', 833.33, 'UPI'),
(116, '2025-05-19', 833.33, 'CHEQUE'),
(116, '2025-06-19', 833.33, 'NET BANKING'),
(116, '2025-07-19', 833.33, 'UPI'),
(116, '2025-08-19', 833.33, 'CHEQUE'),
(116, '2025-09-19', 833.33, 'NET BANKING'),
(116, '2025-10-19', 833.33, 'UPI'),
(116, '2025-11-19', 833.33, 'CHEQUE'),
(116, '2025-12-19', 833.33, 'NET BANKING'),
(116, '2026-01-19', 833.33, 'UPI'),
(116, '2026-02-19', 833.33, 'CHEQUE'),
(116, '2026-03-19', 833.33, 'NET BANKING'),
(116, '2026-04-19', 833.33, 'UPI'),
(116, '2026-05-19', 833.33, 'CHEQUE'),
(116, '2026-06-19', 833.33, 'NET BANKING'),
(116, '2026-07-19', 833.33, 'UPI'),
(116, '2026-08-19', 833.33, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(117, '2025-03-30', 2500.0, 'NET BANKING'),
(117, '2025-04-30', 2500.0, 'UPI'),
(117, '2025-05-30', 2500.0, 'CHEQUE'),
(117, '2025-06-30', 2500.0, 'NET BANKING'),
(117, '2025-07-30', 2500.0, 'UPI'),
(117, '2025-08-30', 2500.0, 'CHEQUE'),
(117, '2025-09-30', 2500.0, 'NET BANKING'),
(117, '2025-10-30', 2500.0, 'UPI'),
(117, '2025-11-30', 2500.0, 'CHEQUE'),
(117, '2025-12-30', 2500.0, 'NET BANKING'),
(117, '2026-01-30', 2500.0, 'UPI'),
(117, '2026-02-28', 2500.0, 'CHEQUE');

Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(118, '2025-04-18', 1750.0, 'NET BANKING'),
(118, '2025-05-18', 1750.0, 'UPI'),
(118, '2025-06-18', 1750.0, 'CHEQUE'),
(118, '2025-07-18', 1750.0, 'NET BANKING'),
(118, '2025-08-18', 1750.0, 'UPI'),
(118, '2025-09-18', 1750.0, 'CHEQUE'),
(118, '2025-10-18', 1750.0, 'NET BANKING'),
(118, '2025-11-18', 1750.0, 'UPI'),
(118, '2025-12-18', 1750.0, 'CHEQUE'),
(118, '2026-01-18', 1750.0, 'NET BANKING'),
(118, '2026-02-18', 1750.0, 'UPI'),
(118, '2026-03-18', 1750.0, 'CHEQUE'),
(118, '2026-04-18', 1750.0, 'NET BANKING'),
(118, '2026-05-18', 1750.0, 'UPI'),
(118, '2026-06-18', 1750.0, 'CHEQUE'),
(118, '2026-07-18', 1750.0, 'NET BANKING'),
(118, '2026-08-18', 1750.0, 'UPI'),
(118, '2026-09-18', 1750.0, 'CHEQUE'),
(118, '2026-10-18', 1750.0, 'NET BANKING'),
(118, '2026-11-18', 1750.0, 'UPI'),
(118, '2026-12-18', 1750.0, 'CHEQUE'),
(118, '2027-01-18', 1750.0, 'NET BANKING'),
(118, '2027-02-18', 1750.0, 'UPI'),
(118, '2027-03-18', 1750.0, 'CHEQUE');

Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(119, '2024-02-16', 1166.67, 'NET BANKING'),
(119, '2024-03-16', 1166.67, 'UPI'),
(119, '2024-04-16', 1166.67, 'CHEQUE'),
(119, '2024-05-16', 1166.67, 'NET BANKING'),
(119, '2024-06-16', 1166.67, 'UPI'),
(119, '2024-07-16', 1166.67, 'CHEQUE'),
(119, '2024-08-16', 1166.67, 'NET BANKING'),
(119, '2024-09-16', 1166.67, 'UPI'),
(119, '2024-10-16', 1166.67, 'CHEQUE'),
(119, '2024-11-16', 1166.67, 'NET BANKING'),
(119, '2024-12-16', 1166.67, 'UPI'),
(119, '2025-01-16', 1166.67, 'CHEQUE'),
(119, '2025-02-16', 1166.67, 'NET BANKING'),
(119, '2025-03-16', 1166.67, 'UPI'),
(119, '2025-04-16', 1166.67, 'CHEQUE'),
(119, '2025-05-16', 1166.67, 'NET BANKING'),
(119, '2025-06-16', 1166.67, 'UPI'),
(119, '2025-07-16', 1166.67, 'CHEQUE'),
(119, '2025-08-16', 1166.67, 'NET BANKING'),
(119, '2025-09-16', 1166.67, 'UPI'),
(119, '2025-10-16', 1166.67, 'CHEQUE'),
(119, '2025-11-16', 1166.67, 'NET BANKING'),
(119, '2025-12-16', 1166.67, 'UPI'),
(119, '2026-01-16', 1166.67, 'CHEQUE');

Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(120, '2025-05-01', 1333.33, 'NET BANKING'),
(120, '2025-06-01', 1333.33, 'UPI'),
(120, '2025-07-01', 1333.33, 'CHEQUE'),
(120, '2025-08-01', 1333.33, 'NET BANKING'),
(120, '2025-09-01', 1333.33, 'UPI'),
(120, '2025-10-01', 1333.33, 'CHEQUE'),
(120, '2025-11-01', 1333.33, 'NET BANKING'),
(120, '2025-12-01', 1333.33, 'UPI'),
(120, '2026-01-01', 1333.33, 'CHEQUE'),
(120, '2026-02-01', 1333.33, 'NET BANKING'),
(120, '2026-03-01', 1333.33, 'UPI'),
(120, '2026-04-01', 1333.33, 'CHEQUE');

Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(121, '2023-06-10', 1722.22, 'NET BANKING'),
(121, '2023-07-10', 1722.22, 'UPI'),
(121, '2023-08-10', 1722.22, 'CHEQUE'),
(121, '2023-09-10', 1722.22, 'NET BANKING'),
(121, '2023-10-10', 1722.22, 'UPI'),
(121, '2023-11-10', 1722.22, 'CHEQUE'),
(121, '2023-12-10', 1722.22, 'NET BANKING'),
(121, '2024-01-10', 1722.22, 'UPI'),
(121, '2024-02-10', 1722.22, 'CHEQUE'),
(121, '2024-03-10', 1722.22, 'NET BANKING'),
(121, '2024-04-10', 1722.22, 'UPI'),
(121, '2024-05-10', 1722.22, 'CHEQUE'),
(121, '2024-06-10', 1722.22, 'NET BANKING'),
(121, '2024-07-10', 1722.22, 'UPI'),
(121, '2024-08-10', 1722.22, 'CHEQUE'),
(121, '2024-09-10', 1722.22, 'NET BANKING'),
(121, '2024-10-10', 1722.22, 'UPI'),
(121, '2024-11-10', 1722.22, 'CHEQUE');
 
Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(122, '2024-10-23', 600.0, 'NET BANKING'),
(122, '2024-11-23', 600.0, 'UPI'),
(122, '2024-12-23', 600.0, 'CHEQUE'),
(122, '2025-01-23', 600.0, 'NET BANKING'),
(122, '2025-02-23', 600.0, 'UPI'),
(122, '2025-03-23', 600.0, 'CHEQUE'),
(122, '2025-04-23', 600.0, 'NET BANKING'),
(122, '2025-05-23', 600.0, 'UPI'),
(122, '2025-06-23', 600.0, 'CHEQUE'),
(122, '2025-07-23', 600.0, 'NET BANKING'),
(122, '2025-08-23', 600.0, 'UPI'),
(122, '2025-09-23', 600.0, 'CHEQUE'),
(122, '2025-10-23', 600.0, 'NET BANKING'),
(122, '2025-11-23', 600.0, 'UPI'),
(122, '2025-12-23', 600.0, 'CHEQUE'),
(122, '2026-01-23', 600.0, 'NET BANKING'),
(122, '2026-02-23', 600.0, 'UPI'),
(122, '2026-03-23', 600.0, 'CHEQUE'),
(122, '2026-04-23', 600.0, 'NET BANKING'),
(122, '2026-05-23', 600.0, 'UPI'),
(122, '2026-06-23', 600.0, 'CHEQUE'),
(122, '2026-07-23', 600.0, 'NET BANKING'),
(122, '2026-08-23', 600.0, 'UPI'),
(122, '2026-09-23', 600.0, 'CHEQUE'),
(122, '2026-10-23', 600.0, 'NET BANKING'),
(122, '2026-11-23', 600.0, 'UPI'),
(122, '2026-12-23', 600.0, 'CHEQUE'),
(122, '2027-01-23', 600.0, 'NET BANKING'),
(122, '2027-02-23', 600.0, 'UPI'),
(122, '2027-03-23', 600.0, 'CHEQUE');

Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(123, '2024-06-09', 1166.67, 'NET BANKING'),
(123, '2024-07-09', 1166.67, 'UPI'),
(123, '2024-08-09', 1166.67, 'CHEQUE'),
(123, '2024-09-09', 1166.67, 'NET BANKING'),
(123, '2024-10-09', 1166.67, 'UPI'),
(123, '2024-11-09', 1166.67, 'CHEQUE'),
(123, '2024-12-09', 1166.67, 'NET BANKING'),
(123, '2025-01-09', 1166.67, 'UPI'),
(123, '2025-02-09', 1166.67, 'CHEQUE'),
(123, '2025-03-09', 1166.67, 'NET BANKING'),
(123, '2025-04-09', 1166.67, 'UPI'),
(123, '2025-05-09', 1166.67, 'CHEQUE');

Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(124, '2025-01-02', 1125.0, 'NET BANKING'),
(124, '2025-02-02', 1125.0, 'UPI'),
(124, '2025-03-02', 1125.0, 'CHEQUE'),
(124, '2025-04-02', 1125.0, 'NET BANKING'),
(124, '2025-05-02', 1125.0, 'UPI'),
(124, '2025-06-02', 1125.0, 'CHEQUE'),
(124, '2025-07-02', 1125.0, 'NET BANKING'),
(124, '2025-08-02', 1125.0, 'UPI'),
(124, '2025-09-02', 1125.0, 'CHEQUE'),
(124, '2025-10-02', 1125.0, 'NET BANKING'),
(124, '2025-11-02', 1125.0, 'UPI'),
(124, '2025-12-02', 1125.0, 'CHEQUE'),
(124, '2026-01-02', 1125.0, 'NET BANKING'),
(124, '2026-02-02', 1125.0, 'UPI'),
(124, '2026-03-02', 1125.0, 'CHEQUE'),
(124, '2026-04-02', 1125.0, 'NET BANKING'),
(124, '2026-05-02', 1125.0, 'UPI'),
(124, '2026-06-02', 1125.0, 'CHEQUE'),
(124, '2026-07-02', 1125.0, 'NET BANKING'),
(124, '2026-08-02', 1125.0, 'UPI'),
(124, '2026-09-02', 1125.0, 'CHEQUE'),
(124, '2026-10-02', 1125.0, 'NET BANKING'),
(124, '2026-11-02', 1125.0, 'UPI'),
(124, '2026-12-02', 1125.0, 'CHEQUE');
 
 
Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(125, '2023-07-10', 1583.33, 'NET BANKING'),
(125, '2023-08-10', 1583.33, 'UPI'),
(125, '2023-09-10', 1583.33, 'CHEQUE'),
(125, '2023-10-10', 1583.33, 'NET BANKING'),
(125, '2023-11-10', 1583.33, 'UPI'),
(125, '2023-12-10', 1583.33, 'CHEQUE'),
(125, '2024-01-10', 1583.33, 'NET BANKING'),
(125, '2024-02-10', 1583.33, 'UPI'),
(125, '2024-03-10', 1583.33, 'CHEQUE'),
(125, '2024-04-10', 1583.33, 'NET BANKING'),
(125, '2024-05-10', 1583.33, 'UPI'),
(125, '2024-06-10', 1583.33, 'CHEQUE'),
(125, '2024-07-10', 1583.33, 'NET BANKING'),
(125, '2024-08-10', 1583.33, 'UPI'),
(125, '2024-09-10', 1583.33, 'CHEQUE'),
(125, '2024-10-10', 1583.33, 'NET BANKING'),
(125, '2024-11-10', 1583.33, 'UPI'),
(125, '2024-12-10', 1583.33, 'CHEQUE'),
(125, '2025-01-10', 1583.33, 'NET BANKING'),
(125, '2025-02-10', 1583.33, 'UPI'),
(125, '2025-03-10', 1583.33, 'CHEQUE'),
(125, '2025-04-10', 1583.33, 'NET BANKING'),
(125, '2025-05-10', 1583.33, 'UPI'),
(125, '2025-06-10', 1583.33, 'CHEQUE');

Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(126, '2022-08-15', 722.22, 'NET BANKING'),
(126, '2022-09-15', 722.22, 'UPI'),
(126, '2022-10-15', 722.22, 'CHEQUE'),
(126, '2022-11-15', 722.22, 'NET BANKING'),
(126, '2022-12-15', 722.22, 'UPI'),
(126, '2023-01-15', 722.22, 'CHEQUE'),
(126, '2023-02-15', 722.22, 'NET BANKING'),
(126, '2023-03-15', 722.22, 'UPI'),
(126, '2023-04-15', 722.22, 'CHEQUE'),
(126, '2023-05-15', 722.22, 'NET BANKING'),
(126, '2023-06-15', 722.22, 'UPI'),
(126, '2023-07-15', 722.22, 'CHEQUE'),
(126, '2023-08-15', 722.22, 'NET BANKING'),
(126, '2023-09-15', 722.22, 'UPI'),
(126, '2023-10-15', 722.22, 'CHEQUE'),
(126, '2023-11-15', 722.22, 'NET BANKING'),
(126, '2023-12-15', 722.22, 'UPI'),
(126, '2024-01-15', 722.22, 'CHEQUE'),
(126, '2024-02-15', 722.22, 'NET BANKING'),
(126, '2024-03-15', 722.22, 'UPI'),
(126, '2024-04-15', 722.22, 'CHEQUE'),
(126, '2024-05-15', 722.22, 'NET BANKING'),
(126, '2024-06-15', 722.22, 'UPI'),
(126, '2024-07-15', 722.22, 'CHEQUE'),
(126, '2024-08-15', 722.22, 'NET BANKING'),
(126, '2024-09-15', 722.22, 'UPI'),
(126, '2024-10-15', 722.22, 'CHEQUE'),
(126, '2024-11-15', 722.22, 'NET BANKING'),
(126, '2024-12-15', 722.22, 'UPI'),
(126, '2025-01-15', 722.22, 'CHEQUE'),
(126, '2025-02-15', 722.22, 'NET BANKING'),
(126, '2025-03-15', 722.22, 'UPI'),
(126, '2025-04-15', 722.22, 'CHEQUE'),
(126, '2025-05-15', 722.22, 'NET BANKING'),
(126, '2025-06-15', 722.22, 'UPI'),
(126, '2025-07-15', 722.22, 'CHEQUE');

Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(127, '2023-05-19', 1333.33, 'NET BANKING'),
(127, '2023-06-19', 1333.33, 'UPI'),
(127, '2023-07-19', 1333.33, 'CHEQUE'),
(127, '2023-08-19', 1333.33, 'NET BANKING'),
(127, '2023-09-19', 1333.33, 'UPI'),
(127, '2023-10-19', 1333.33, 'CHEQUE'),
(127, '2023-11-19', 1333.33, 'NET BANKING'),
(127, '2023-12-19', 1333.33, 'UPI'),
(127, '2024-01-19', 1333.33, 'CHEQUE'),
(127, '2024-02-19', 1333.33, 'NET BANKING'),
(127, '2024-03-19', 1333.33, 'UPI'),
(127, '2024-04-19', 1333.33, 'CHEQUE'),
(127, '2024-05-19', 1333.33, 'NET BANKING'),
(127, '2024-06-19', 1333.33, 'UPI'),
(127, '2024-07-19', 1333.33, 'CHEQUE'),
(127, '2024-08-19', 1333.33, 'NET BANKING'),
(127, '2024-09-19', 1333.33, 'UPI'),
(127, '2024-10-19', 1333.33, 'CHEQUE');

Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(128, '2024-12-05', 2083.33, 'NET BANKING'),
(128, '2025-01-05', 2083.33, 'UPI'),
(128, '2025-02-05', 2083.33, 'CHEQUE'),
(128, '2025-03-05', 2083.33, 'NET BANKING'),
(128, '2025-04-05', 2083.33, 'UPI'),
(128, '2025-05-05', 2083.33, 'CHEQUE'),
(128, '2025-06-05', 2083.33, 'NET BANKING'),
(128, '2025-07-05', 2083.33, 'UPI'),
(128, '2025-08-05', 2083.33, 'CHEQUE'),
(128, '2025-09-05', 2083.33, 'NET BANKING'),
(128, '2025-10-05', 2083.33, 'UPI'),
(128, '2025-11-05', 2083.33, 'CHEQUE');

Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(129, '2023-03-04', 805.56, 'NET BANKING'),
(129, '2023-04-04', 805.56, 'UPI'),
(129, '2023-05-04', 805.56, 'CHEQUE'),
(129, '2023-06-04', 805.56, 'NET BANKING'),
(129, '2023-07-04', 805.56, 'UPI'),
(129, '2023-08-04', 805.56, 'CHEQUE'),
(129, '2023-09-04', 805.56, 'NET BANKING'),
(129, '2023-10-04', 805.56, 'UPI'),
(129, '2023-11-04', 805.56, 'CHEQUE'),
(129, '2023-12-04', 805.56, 'NET BANKING'),
(129, '2024-01-04', 805.56, 'UPI'),
(129, '2024-02-04', 805.56, 'CHEQUE'),
(129, '2024-03-04', 805.56, 'NET BANKING'),
(129, '2024-04-04', 805.56, 'UPI'),
(129, '2024-05-04', 805.56, 'CHEQUE'),
(129, '2024-06-04', 805.56, 'NET BANKING'),
(129, '2024-07-04', 805.56, 'UPI'),
(129, '2024-08-04', 805.56, 'CHEQUE'),
(129, '2024-09-04', 805.56, 'NET BANKING'),
(129, '2024-10-04', 805.56, 'UPI'),
(129, '2024-11-04', 805.56, 'CHEQUE'),
(129, '2024-12-04', 805.56, 'NET BANKING'),
(129, '2025-01-04', 805.56, 'UPI'),
(129, '2025-02-04', 805.56, 'CHEQUE'),
(129, '2025-03-04', 805.56, 'NET BANKING'),
(129, '2025-04-04', 805.56, 'UPI'),
(129, '2025-05-04', 805.56, 'CHEQUE'),
(129, '2025-06-04', 805.56, 'NET BANKING'),
(129, '2025-07-04', 805.56, 'UPI'),
(129, '2025-08-04', 805.56, 'CHEQUE'),
(129, '2025-09-04', 805.56, 'NET BANKING'),
(129, '2025-10-04', 805.56, 'UPI'),
(129, '2025-11-04', 805.56, 'CHEQUE'),
(129, '2025-12-04', 805.56, 'NET BANKING'),
(129, '2026-01-04', 805.56, 'UPI'),
(129, '2026-02-04', 805.56, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(130, '2024-01-17', 1333.33, 'NET BANKING'),
(130, '2024-02-17', 1333.33, 'UPI'),
(130, '2024-03-17', 1333.33, 'CHEQUE'),
(130, '2024-04-17', 1333.33, 'NET BANKING'),
(130, '2024-05-17', 1333.33, 'UPI'),
(130, '2024-06-17', 1333.33, 'CHEQUE'),
(130, '2024-07-17', 1333.33, 'NET BANKING'),
(130, '2024-08-17', 1333.33, 'UPI'),
(130, '2024-09-17', 1333.33, 'CHEQUE'),
(130, '2024-10-17', 1333.33, 'NET BANKING'),
(130, '2024-11-17', 1333.33, 'UPI'),
(130, '2024-12-17', 1333.33, 'CHEQUE'),
(130, '2025-01-17', 1333.33, 'NET BANKING'),
(130, '2025-02-17', 1333.33, 'UPI'),
(130, '2025-03-17', 1333.33, 'CHEQUE'),
(130, '2025-04-17', 1333.33, 'NET BANKING'),
(130, '2025-05-17', 1333.33, 'UPI'),
(130, '2025-06-17', 1333.33, 'CHEQUE'),
(130, '2025-07-17', 1333.33, 'NET BANKING'),
(130, '2025-08-17', 1333.33, 'UPI'),
(130, '2025-09-17', 1333.33, 'CHEQUE'),
(130, '2025-10-17', 1333.33, 'NET BANKING'),
(130, '2025-11-17', 1333.33, 'UPI'),
(130, '2025-12-17', 1333.33, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(131, '2023-11-11', 1166.67, 'NET BANKING'),
(131, '2023-12-11', 1166.67, 'UPI'),
(131, '2024-01-11', 1166.67, 'CHEQUE'),
(131, '2024-02-11', 1166.67, 'NET BANKING'),
(131, '2024-03-11', 1166.67, 'UPI'),
(131, '2024-04-11', 1166.67, 'CHEQUE'),
(131, '2024-05-11', 1166.67, 'NET BANKING'),
(131, '2024-06-11', 1166.67, 'UPI'),
(131, '2024-07-11', 1166.67, 'CHEQUE'),
(131, '2024-08-11', 1166.67, 'NET BANKING'),
(131, '2024-09-11', 1166.67, 'UPI'),
(131, '2024-10-11', 1166.67, 'CHEQUE'),
(131, '2024-11-11', 1166.67, 'NET BANKING'),
(131, '2024-12-11', 1166.67, 'UPI'),
(131, '2025-01-11', 1166.67, 'CHEQUE'),
(131, '2025-02-11', 1166.67, 'NET BANKING'),
(131, '2025-03-11', 1166.67, 'UPI'),
(131, '2025-04-11', 1166.67, 'CHEQUE');



Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(132, '2025-05-03', 916.67, 'NET BANKING'),
(132, '2025-06-03', 916.67, 'UPI'),
(132, '2025-07-03', 916.67, 'CHEQUE'),
(132, '2025-08-03', 916.67, 'NET BANKING'),
(132, '2025-09-03', 916.67, 'UPI'),
(132, '2025-10-03', 916.67, 'CHEQUE'),
(132, '2025-11-03', 916.67, 'NET BANKING'),
(132, '2025-12-03', 916.67, 'UPI'),
(132, '2026-01-03', 916.67, 'CHEQUE'),
(132, '2026-02-03', 916.67, 'NET BANKING'),
(132, '2026-03-03', 916.67, 'UPI'),
(132, '2026-04-03', 916.67, 'CHEQUE'),
(132, '2026-05-03', 916.67, 'NET BANKING'),
(132, '2026-06-03', 916.67, 'UPI'),
(132, '2026-07-03', 916.67, 'CHEQUE'),
(132, '2026-08-03', 916.67, 'NET BANKING'),
(132, '2026-09-03', 916.67, 'UPI'),
(132, '2026-10-03', 916.67, 'CHEQUE'),
(132, '2026-11-03', 916.67, 'NET BANKING'),
(132, '2026-12-03', 916.67, 'UPI'),
(132, '2027-01-03', 916.67, 'CHEQUE'),
(132, '2027-02-03', 916.67, 'NET BANKING'),
(132, '2027-03-03', 916.67, 'UPI'),
(132, '2027-04-03', 916.67, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(133, '2025-03-11', 1033.33, 'NET BANKING'),
(133, '2025-04-11', 1033.33, 'UPI'),
(133, '2025-05-11', 1033.33, 'CHEQUE'),
(133, '2025-06-11', 1033.33, 'NET BANKING'),
(133, '2025-07-11', 1033.33, 'UPI'),
(133, '2025-08-11', 1033.33, 'CHEQUE'),
(133, '2025-09-11', 1033.33, 'NET BANKING'),
(133, '2025-10-11', 1033.33, 'UPI'),
(133, '2025-11-11', 1033.33, 'CHEQUE'),
(133, '2025-12-11', 1033.33, 'NET BANKING'),
(133, '2026-01-11', 1033.33, 'UPI'),
(133, '2026-02-11', 1033.33, 'CHEQUE'),
(133, '2026-03-11', 1033.33, 'NET BANKING'),
(133, '2026-04-11', 1033.33, 'UPI'),
(133, '2026-05-11', 1033.33, 'CHEQUE'),
(133, '2026-06-11', 1033.33, 'NET BANKING'),
(133, '2026-07-11', 1033.33, 'UPI'),
(133, '2026-08-11', 1033.33, 'CHEQUE'),
(133, '2026-09-11', 1033.33, 'NET BANKING'),
(133, '2026-10-11', 1033.33, 'UPI'),
(133, '2026-11-11', 1033.33, 'CHEQUE'),
(133, '2026-12-11', 1033.33, 'NET BANKING'),
(133, '2027-01-11', 1033.33, 'UPI'),
(133, '2027-02-11', 1033.33, 'CHEQUE'),
(133, '2027-03-11', 1033.33, 'NET BANKING'),
(133, '2027-04-11', 1033.33, 'UPI'),
(133, '2027-05-11', 1033.33, 'CHEQUE'),
(133, '2027-06-11', 1033.33, 'NET BANKING'),
(133, '2027-07-11', 1033.33, 'UPI'),
(133, '2027-08-11', 1033.33, 'CHEQUE');

Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(134, '2024-07-21', 958.33, 'NET BANKING'),
(134, '2024-08-21', 958.33, 'UPI'),
(134, '2024-09-21', 958.33, 'CHEQUE'),
(134, '2024-10-21', 958.33, 'NET BANKING'),
(134, '2024-11-21', 958.33, 'UPI'),
(134, '2024-12-21', 958.33, 'CHEQUE'),
(134, '2025-01-21', 958.33, 'NET BANKING'),
(134, '2025-02-21', 958.33, 'UPI'),
(134, '2025-03-21', 958.33, 'CHEQUE'),
(134, '2025-04-21', 958.33, 'NET BANKING'),
(134, '2025-05-21', 958.33, 'UPI'),
(134, '2025-06-21', 958.33, 'CHEQUE'),
(134, '2025-07-21', 958.33, 'NET BANKING'),
(134, '2025-08-21', 958.33, 'UPI'),
(134, '2025-09-21', 958.33, 'CHEQUE'),
(134, '2025-10-21', 958.33, 'NET BANKING'),
(134, '2025-11-21', 958.33, 'UPI'),
(134, '2025-12-21', 958.33, 'CHEQUE'),
(134, '2026-01-21', 958.33, 'NET BANKING'),
(134, '2026-02-21', 958.33, 'UPI'),
(134, '2026-03-21', 958.33, 'CHEQUE'),
(134, '2026-04-21', 958.33, 'NET BANKING'),
(134, '2026-05-21', 958.33, 'UPI'),
(134, '2026-06-21', 958.33, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(135, '2023-08-29', 1555.56, 'NET BANKING'),
(135, '2023-09-29', 1555.56, 'UPI'),
(135, '2023-10-29', 1555.56, 'CHEQUE'),
(135, '2023-11-29', 1555.56, 'NET BANKING'),
(135, '2023-12-29', 1555.56, 'UPI'),
(135, '2024-01-29', 1555.56, 'CHEQUE'),
(135, '2024-02-29', 1555.56, 'NET BANKING'),
(135, '2024-03-29', 1555.56, 'UPI'),
(135, '2024-04-29', 1555.56, 'CHEQUE'),
(135, '2024-05-29', 1555.56, 'NET BANKING'),
(135, '2024-06-29', 1555.56, 'UPI'),
(135, '2024-07-29', 1555.56, 'CHEQUE'),
(135, '2024-08-29', 1555.56, 'NET BANKING'),
(135, '2024-09-29', 1555.56, 'UPI'),
(135, '2024-10-29', 1555.56, 'CHEQUE'),
(135, '2024-11-29', 1555.56, 'NET BANKING'),
(135, '2024-12-29', 1555.56, 'UPI'),
(135, '2025-01-29', 1555.56, 'CHEQUE');

Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(136, '2024-03-15', 708.33, 'NET BANKING'),
(136, '2024-04-15', 708.33, 'UPI'),
(136, '2024-05-15', 708.33, 'CHEQUE'),
(136, '2024-06-15', 708.33, 'NET BANKING'),
(136, '2024-07-15', 708.33, 'UPI'),
(136, '2024-08-15', 708.33, 'CHEQUE'),
(136, '2024-09-15', 708.33, 'NET BANKING'),
(136, '2024-10-15', 708.33, 'UPI'),
(136, '2024-11-15', 708.33, 'CHEQUE'),
(136, '2024-12-15', 708.33, 'NET BANKING'),
(136, '2025-01-15', 708.33, 'UPI'),
(136, '2025-02-15', 708.33, 'CHEQUE'),
(136, '2025-03-15', 708.33, 'NET BANKING'),
(136, '2025-04-15', 708.33, 'UPI'),
(136, '2025-05-15', 708.33, 'CHEQUE'),
(136, '2025-06-15', 708.33, 'NET BANKING'),
(136, '2025-07-15', 708.33, 'UPI'),
(136, '2025-08-15', 708.33, 'CHEQUE'),
(136, '2025-09-15', 708.33, 'NET BANKING'),
(136, '2025-10-15', 708.33, 'UPI'),
(136, '2025-11-15', 708.33, 'CHEQUE'),
(136, '2025-12-15', 708.33, 'NET BANKING'),
(136, '2026-01-15', 708.33, 'UPI'),
(136, '2026-02-15', 708.33, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(137, '2025-01-15', 1388.89, 'NET BANKING'),
(137, '2025-02-15', 1388.89, 'UPI'),
(137, '2025-03-15', 1388.89, 'CHEQUE'),
(137, '2025-04-15', 1388.89, 'NET BANKING'),
(137, '2025-05-15', 1388.89, 'UPI'),
(137, '2025-06-15', 1388.89, 'CHEQUE'),
(137, '2025-07-15', 1388.89, 'NET BANKING'),
(137, '2025-08-15', 1388.89, 'UPI'),
(137, '2025-09-15', 1388.89, 'CHEQUE'),
(137, '2025-10-15', 1388.89, 'NET BANKING'),
(137, '2025-11-15', 1388.89, 'UPI'),
(137, '2025-12-15', 1388.89, 'CHEQUE'),
(137, '2026-01-15', 1388.89, 'NET BANKING'),
(137, '2026-02-15', 1388.89, 'UPI'),
(137, '2026-03-15', 1388.89, 'CHEQUE'),
(137, '2026-04-15', 1388.89, 'NET BANKING'),
(137, '2026-05-15', 1388.89, 'UPI'),
(137, '2026-06-15', 1388.89, 'CHEQUE');

Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(138, '2024-04-10', 1000.0, 'NET BANKING'),
(138, '2024-05-10', 1000.0, 'UPI'),
(138, '2024-06-10', 1000.0, 'CHEQUE'),
(138, '2024-07-10', 1000.0, 'NET BANKING'),
(138, '2024-08-10', 1000.0, 'UPI'),
(138, '2024-09-10', 1000.0, 'CHEQUE'),
(138, '2024-10-10', 1000.0, 'NET BANKING'),
(138, '2024-11-10', 1000.0, 'UPI'),
(138, '2024-12-10', 1000.0, 'CHEQUE'),
(138, '2025-01-10', 1000.0, 'NET BANKING'),
(138, '2025-02-10', 1000.0, 'UPI'),
(138, '2025-03-10', 1000.0, 'CHEQUE'),
(138, '2025-04-10', 1000.0, 'NET BANKING'),
(138, '2025-05-10', 1000.0, 'UPI'),
(138, '2025-06-10', 1000.0, 'CHEQUE'),
(138, '2025-07-10', 1000.0, 'NET BANKING'),
(138, '2025-08-10', 1000.0, 'UPI'),
(138, '2025-09-10', 1000.0, 'CHEQUE'),
(138, '2025-10-10', 1000.0, 'NET BANKING'),
(138, '2025-11-10', 1000.0, 'UPI'),
(138, '2025-12-10', 1000.0, 'CHEQUE'),
(138, '2026-01-10', 1000.0, 'NET BANKING'),
(138, '2026-02-10', 1000.0, 'UPI'),
(138, '2026-03-10', 1000.0, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(139, '2024-09-01', 1583.33, 'NET BANKING'),
(139, '2024-10-01', 1583.33, 'UPI'),
(139, '2024-11-01', 1583.33, 'CHEQUE'),
(139, '2024-12-01', 1583.33, 'NET BANKING'),
(139, '2025-01-01', 1583.33, 'UPI'),
(139, '2025-02-01', 1583.33, 'CHEQUE'),
(139, '2025-03-01', 1583.33, 'NET BANKING'),
(139, '2025-04-01', 1583.33, 'UPI'),
(139, '2025-05-01', 1583.33, 'CHEQUE'),
(139, '2025-06-01', 1583.33, 'NET BANKING'),
(139, '2025-07-01', 1583.33, 'UPI'),
(139, '2025-08-01', 1583.33, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(140, '2025-06-22', 866.67, 'NET BANKING'),
(140, '2025-07-22', 866.67, 'UPI'),
(140, '2025-08-22', 866.67, 'CHEQUE'),
(140, '2025-09-22', 866.67, 'NET BANKING'),
(140, '2025-10-22', 866.67, 'UPI'),
(140, '2025-11-22', 866.67, 'CHEQUE'),
(140, '2025-12-22', 866.67, 'NET BANKING'),
(140, '2026-01-22', 866.67, 'UPI'),
(140, '2026-02-22', 866.67, 'CHEQUE'),
(140, '2026-03-22', 866.67, 'NET BANKING'),
(140, '2026-04-22', 866.67, 'UPI'),
(140, '2026-05-22', 866.67, 'CHEQUE'),
(140, '2026-06-22', 866.67, 'NET BANKING'),
(140, '2026-07-22', 866.67, 'UPI'),
(140, '2026-08-22', 866.67, 'CHEQUE'),
(140, '2026-09-22', 866.67, 'NET BANKING'),
(140, '2026-10-22', 866.67, 'UPI'),
(140, '2026-11-22', 866.67, 'CHEQUE'),
(140, '2026-12-22', 866.67, 'NET BANKING'),
(140, '2027-01-22', 866.67, 'UPI'),
(140, '2027-02-22', 866.67, 'CHEQUE'),
(140, '2027-03-22', 866.67, 'NET BANKING'),
(140, '2027-04-22', 866.67, 'UPI'),
(140, '2027-05-22', 866.67, 'CHEQUE'),
(140, '2027-06-22', 866.67, 'NET BANKING'),
(140, '2027-07-22', 866.67, 'UPI'),
(140, '2027-08-22', 866.67, 'CHEQUE'),
(140, '2027-09-22', 866.67, 'NET BANKING'),
(140, '2027-10-22', 866.67, 'UPI'),
(140, '2027-11-22', 866.67, 'CHEQUE');

Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(141, '2023-10-30', 1166.67, 'NET BANKING'),
(141, '2023-11-30', 1166.67, 'UPI'),
(141, '2023-12-30', 1166.67, 'CHEQUE'),
(141, '2024-01-30', 1166.67, 'NET BANKING'),
(141, '2024-02-29', 1166.67, 'UPI'),
(141, '2024-03-30', 1166.67, 'CHEQUE'),
(141, '2024-04-30', 1166.67, 'NET BANKING'),
(141, '2024-05-30', 1166.67, 'UPI'),
(141, '2024-06-30', 1166.67, 'CHEQUE'),
(141, '2024-07-30', 1166.67, 'NET BANKING'),
(141, '2024-08-30', 1166.67, 'UPI'),
(141, '2024-09-30', 1166.67, 'CHEQUE'),
(141, '2024-10-30', 1166.67, 'NET BANKING'),
(141, '2024-11-30', 1166.67, 'UPI'),
(141, '2024-12-30', 1166.67, 'CHEQUE'),
(141, '2025-01-30', 1166.67, 'NET BANKING'),
(141, '2025-02-28', 1166.67, 'UPI'),
(141, '2025-03-30', 1166.67, 'CHEQUE'),
(141, '2025-04-30', 1166.67, 'NET BANKING'),
(141, '2025-05-30', 1166.67, 'UPI'),
(141, '2025-06-30', 1166.67, 'CHEQUE'),
(141, '2025-07-30', 1166.67, 'NET BANKING'),
(141, '2025-08-30', 1166.67, 'UPI'),
(141, '2025-09-30', 1166.67, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(142, '2025-02-18', 1666.67, 'NET BANKING'),
(142, '2025-03-18', 1666.67, 'UPI'),
(142, '2025-04-18', 1666.67, 'CHEQUE'),
(142, '2025-05-18', 1666.67, 'NET BANKING'),
(142, '2025-06-18', 1666.67, 'UPI'),
(142, '2025-07-18', 1666.67, 'CHEQUE'),
(142, '2025-08-18', 1666.67, 'NET BANKING'),
(142, '2025-09-18', 1666.67, 'UPI'),
(142, '2025-10-18', 1666.67, 'CHEQUE'),
(142, '2025-11-18', 1666.67, 'NET BANKING'),
(142, '2025-12-18', 1666.67, 'UPI'),
(142, '2026-01-18', 1666.67, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(143, '2024-10-10', 1750.0, 'NET BANKING'),
(143, '2024-11-10', 1750.0, 'UPI'),
(143, '2024-12-10', 1750.0, 'CHEQUE'),
(143, '2025-01-10', 1750.0, 'NET BANKING'),
(143, '2025-02-10', 1750.0, 'UPI'),
(143, '2025-03-10', 1750.0, 'CHEQUE'),
(143, '2025-04-10', 1750.0, 'NET BANKING'),
(143, '2025-05-10', 1750.0, 'UPI'),
(143, '2025-06-10', 1750.0, 'CHEQUE'),
(143, '2025-07-10', 1750.0, 'NET BANKING'),
(143, '2025-08-10', 1750.0, 'UPI'),
(143, '2025-09-10', 1750.0, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(144, '2024-08-12', 1083.33, 'NET BANKING'),
(144, '2024-09-12', 1083.33, 'UPI'),
(144, '2024-10-12', 1083.33, 'CHEQUE'),
(144, '2024-11-12', 1083.33, 'NET BANKING'),
(144, '2024-12-12', 1083.33, 'UPI'),
(144, '2025-01-12', 1083.33, 'CHEQUE'),
(144, '2025-02-12', 1083.33, 'NET BANKING'),
(144, '2025-03-12', 1083.33, 'UPI'),
(144, '2025-04-12', 1083.33, 'CHEQUE'),
(144, '2025-05-12', 1083.33, 'NET BANKING'),
(144, '2025-06-12', 1083.33, 'UPI'),
(144, '2025-07-12', 1083.33, 'CHEQUE'),
(144, '2025-08-12', 1083.33, 'NET BANKING'),
(144, '2025-09-12', 1083.33, 'UPI'),
(144, '2025-10-12', 1083.33, 'CHEQUE'),
(144, '2025-11-12', 1083.33, 'NET BANKING'),
(144, '2025-12-12', 1083.33, 'UPI'),
(144, '2026-01-12', 1083.33, 'CHEQUE'),
(144, '2026-02-12', 1083.33, 'NET BANKING'),
(144, '2026-03-12', 1083.33, 'UPI'),
(144, '2026-04-12', 1083.33, 'CHEQUE'),
(144, '2026-05-12', 1083.33, 'NET BANKING'),
(144, '2026-06-12', 1083.33, 'UPI'),
(144, '2026-07-12', 1083.33, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(145, '2024-06-08', 638.89, 'NET BANKING'),
(145, '2024-07-08', 638.89, 'UPI'),
(145, '2024-08-08', 638.89, 'CHEQUE'),
(145, '2024-09-08', 638.89, 'NET BANKING'),
(145, '2024-10-08', 638.89, 'UPI'),
(145, '2024-11-08', 638.89, 'CHEQUE'),
(145, '2024-12-08', 638.89, 'NET BANKING'),
(145, '2025-01-08', 638.89, 'UPI'),
(145, '2025-02-08', 638.89, 'CHEQUE'),
(145, '2025-03-08', 638.89, 'NET BANKING'),
(145, '2025-04-08', 638.89, 'UPI'),
(145, '2025-05-08', 638.89, 'CHEQUE'),
(145, '2025-06-08', 638.89, 'NET BANKING'),
(145, '2025-07-08', 638.89, 'UPI'),
(145, '2025-08-08', 638.89, 'CHEQUE'),
(145, '2025-09-08', 638.89, 'NET BANKING'),
(145, '2025-10-08', 638.89, 'UPI'),
(145, '2025-11-08', 638.89, 'CHEQUE'),
(145, '2025-12-08', 638.89, 'NET BANKING'),
(145, '2026-01-08', 638.89, 'UPI'),
(145, '2026-02-08', 638.89, 'CHEQUE'),
(145, '2026-03-08', 638.89, 'NET BANKING'),
(145, '2026-04-08', 638.89, 'UPI'),
(145, '2026-05-08', 638.89, 'CHEQUE'),
(145, '2026-06-08', 638.89, 'NET BANKING'),
(145, '2026-07-08', 638.89, 'UPI'),
(145, '2026-08-08', 638.89, 'CHEQUE'),
(145, '2026-09-08', 638.89, 'NET BANKING'),
(145, '2026-10-08', 638.89, 'UPI'),
(145, '2026-11-08', 638.89, 'CHEQUE'),
(145, '2026-12-08', 638.89, 'NET BANKING'),
(145, '2027-01-08', 638.89, 'UPI'),
(145, '2027-02-08', 638.89, 'CHEQUE'),
(145, '2027-03-08', 638.89, 'NET BANKING'),
(145, '2027-04-08', 638.89, 'UPI'),
(145, '2027-05-08', 638.89, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(146, '2025-01-05', 916.67, 'NET BANKING'),
(146, '2025-02-05', 916.67, 'UPI'),
(146, '2025-03-05', 916.67, 'CHEQUE'),
(146, '2025-04-05', 916.67, 'NET BANKING'),
(146, '2025-05-05', 916.67, 'UPI'),
(146, '2025-06-05', 916.67, 'CHEQUE'),
(146, '2025-07-05', 916.67, 'NET BANKING'),
(146, '2025-08-05', 916.67, 'UPI'),
(146, '2025-09-05', 916.67, 'CHEQUE'),
(146, '2025-10-05', 916.67, 'NET BANKING'),
(146, '2025-11-05', 916.67, 'UPI'),
(146, '2025-12-05', 916.67, 'CHEQUE'),
(146, '2026-01-05', 916.67, 'NET BANKING'),
(146, '2026-02-05', 916.67, 'UPI'),
(146, '2026-03-05', 916.67, 'CHEQUE'),
(146, '2026-04-05', 916.67, 'NET BANKING'),
(146, '2026-05-05', 916.67, 'UPI'),
(146, '2026-06-05', 916.67, 'CHEQUE'),
(146, '2026-07-05', 916.67, 'NET BANKING'),
(146, '2026-08-05', 916.67, 'UPI'),
(146, '2026-09-05', 916.67, 'CHEQUE'),
(146, '2026-10-05', 916.67, 'NET BANKING'),
(146, '2026-11-05', 916.67, 'UPI'),
(146, '2026-12-05', 916.67, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(147, '2023-06-25', 666.67, 'NET BANKING'),
(147, '2023-07-25', 666.67, 'UPI'),
(147, '2023-08-25', 666.67, 'CHEQUE'),
(147, '2023-09-25', 666.67, 'NET BANKING'),
(147, '2023-10-25', 666.67, 'UPI'),
(147, '2023-11-25', 666.67, 'CHEQUE'),
(147, '2023-12-25', 666.67, 'NET BANKING'),
(147, '2024-01-25', 666.67, 'UPI'),
(147, '2024-02-25', 666.67, 'CHEQUE'),
(147, '2024-03-25', 666.67, 'NET BANKING'),
(147, '2024-04-25', 666.67, 'UPI'),
(147, '2024-05-25', 666.67, 'CHEQUE'),
(147, '2024-06-25', 666.67, 'NET BANKING'),
(147, '2024-07-25', 666.67, 'UPI'),
(147, '2024-08-25', 666.67, 'CHEQUE'),
(147, '2024-09-25', 666.67, 'NET BANKING'),
(147, '2024-10-25', 666.67, 'UPI'),
(147, '2024-11-25', 666.67, 'CHEQUE'),
(147, '2024-12-25', 666.67, 'NET BANKING'),
(147, '2025-01-25', 666.67, 'UPI'),
(147, '2025-02-25', 666.67, 'CHEQUE'),
(147, '2025-03-25', 666.67, 'NET BANKING'),
(147, '2025-04-25', 666.67, 'UPI'),
(147, '2025-05-25', 666.67, 'CHEQUE'),
(147, '2025-06-25', 666.67, 'NET BANKING'),
(147, '2025-07-25', 666.67, 'UPI'),
(147, '2025-08-25', 666.67, 'CHEQUE'),
(147, '2025-09-25', 666.67, 'NET BANKING'),
(147, '2025-10-25', 666.67, 'UPI'),
(147, '2025-11-25', 666.67, 'CHEQUE'),
(147, '2025-12-25', 666.67, 'NET BANKING'),
(147, '2026-01-25', 666.67, 'UPI'),
(147, '2026-02-25', 666.67, 'CHEQUE'),
(147, '2026-03-25', 666.67, 'NET BANKING'),
(147, '2026-04-25', 666.67, 'UPI'),
(147, '2026-05-25', 666.67, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(148, '2025-04-22', 750.0, 'NET BANKING'),
(148, '2025-05-22', 750.0, 'UPI'),
(148, '2025-06-22', 750.0, 'CHEQUE'),
(148, '2025-07-22', 750.0, 'NET BANKING'),
(148, '2025-08-22', 750.0, 'UPI'),
(148, '2025-09-22', 750.0, 'CHEQUE'),
(148, '2025-10-22', 750.0, 'NET BANKING'),
(148, '2025-11-22', 750.0, 'UPI'),
(148, '2025-12-22', 750.0, 'CHEQUE'),
(148, '2026-01-22', 750.0, 'NET BANKING'),
(148, '2026-02-22', 750.0, 'UPI'),
(148, '2026-03-22', 750.0, 'CHEQUE'),
(148, '2026-04-22', 750.0, 'NET BANKING'),
(148, '2026-05-22', 750.0, 'UPI'),
(148, '2026-06-22', 750.0, 'CHEQUE'),
(148, '2026-07-22', 750.0, 'NET BANKING'),
(148, '2026-08-22', 750.0, 'UPI'),
(148, '2026-09-22', 750.0, 'CHEQUE'),
(148, '2026-10-22', 750.0, 'NET BANKING'),
(148, '2026-11-22', 750.0, 'UPI'),
(148, '2026-12-22', 750.0, 'CHEQUE'),
(148, '2027-01-22', 750.0, 'NET BANKING'),
(148, '2027-02-22', 750.0, 'UPI'),
(148, '2027-03-22', 750.0, 'CHEQUE'),
(148, '2027-04-22', 750.0, 'NET BANKING'),
(148, '2027-05-22', 750.0, 'UPI'),
(148, '2027-06-22', 750.0, 'CHEQUE'),
(148, '2027-07-22', 750.0, 'NET BANKING'),
(148, '2027-08-22', 750.0, 'UPI'),
(148, '2027-09-22', 750.0, 'CHEQUE'),
(148, '2027-10-22', 750.0, 'NET BANKING'),
(148, '2027-11-22', 750.0, 'UPI'),
(148, '2027-12-22', 750.0, 'CHEQUE'),
(148, '2028-01-22', 750.0, 'NET BANKING'),
(148, '2028-02-22', 750.0, 'UPI'),
(148, '2028-03-22', 750.0, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(149, '2024-11-14', 2083.33, 'NET BANKING'),
(149, '2024-12-14', 2083.33, 'UPI'),
(149, '2025-01-14', 2083.33, 'CHEQUE'),
(149, '2025-02-14', 2083.33, 'NET BANKING'),
(149, '2025-03-14', 2083.33, 'UPI'),
(149, '2025-04-14', 2083.33, 'CHEQUE'),
(149, '2025-05-14', 2083.33, 'NET BANKING'),
(149, '2025-06-14', 2083.33, 'UPI'),
(149, '2025-07-14', 2083.33, 'CHEQUE'),
(149, '2025-08-14', 2083.33, 'NET BANKING'),
(149, '2025-09-14', 2083.33, 'UPI'),
(149, '2025-10-14', 2083.33, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(150, '2023-12-01', 1555.56, 'NET BANKING'),
(150, '2024-01-01', 1555.56, 'UPI'),
(150, '2024-02-01', 1555.56, 'CHEQUE'),
(150, '2024-03-01', 1555.56, 'NET BANKING'),
(150, '2024-04-01', 1555.56, 'UPI'),
(150, '2024-05-01', 1555.56, 'CHEQUE'),
(150, '2024-06-01', 1555.56, 'NET BANKING'),
(150, '2024-07-01', 1555.56, 'UPI'),
(150, '2024-08-01', 1555.56, 'CHEQUE'),
(150, '2024-09-01', 1555.56, 'NET BANKING'),
(150, '2024-10-01', 1555.56, 'UPI'),
(150, '2024-11-01', 1555.56, 'CHEQUE'),
(150, '2024-12-01', 1555.56, 'NET BANKING'),
(150, '2025-01-01', 1555.56, 'UPI'),
(150, '2025-02-01', 1555.56, 'CHEQUE'),
(150, '2025-03-01', 1555.56, 'NET BANKING'),
(150, '2025-04-01', 1555.56, 'UPI'),
(150, '2025-05-01', 1555.56, 'CHEQUE');

---------------------------------------------------------------------------------------------------------------------
Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(151, '2024-01-20', 1583.33, 'NET BANKING'),
(151, '2024-02-20', 1583.33, 'UPI'),
(151, '2024-03-20', 1583.33, 'CHEQUE'),
(151, '2024-04-20', 1583.33, 'NET BANKING'),
(151, '2024-05-20', 1583.33, 'UPI'),
(151, '2024-06-20', 1583.33, 'CHEQUE'),
(151, '2024-07-20', 1583.33, 'NET BANKING'),
(151, '2024-08-20', 1583.33, 'UPI'),
(151, '2024-09-20', 1583.33, 'CHEQUE'),
(151, '2024-10-20', 1583.33, 'NET BANKING'),
(151, '2024-11-20', 1583.33, 'UPI'),
(151, '2024-12-20', 1583.33, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(152, '2024-03-15', 750.0, 'NET BANKING'),
(152, '2024-04-15', 750.0, 'UPI'),
(152, '2024-05-15', 750.0, 'CHEQUE'),
(152, '2024-06-15', 750.0, 'NET BANKING'),
(152, '2024-07-15', 750.0, 'UPI'),
(152, '2024-08-15', 750.0, 'CHEQUE'),
(152, '2024-09-15', 750.0, 'NET BANKING'),
(152, '2024-10-15', 750.0, 'UPI'),
(152, '2024-11-15', 750.0, 'CHEQUE'),
(152, '2024-12-15', 750.0, 'NET BANKING'),
(152, '2025-01-15', 750.0, 'UPI'),
(152, '2025-02-15', 750.0, 'CHEQUE'),
(152, '2025-03-15', 750.0, 'NET BANKING'),
(152, '2025-04-15', 750.0, 'UPI'),
(152, '2025-05-15', 750.0, 'CHEQUE'),
(152, '2025-06-15', 750.0, 'NET BANKING'),
(152, '2025-07-15', 750.0, 'UPI'),
(152, '2025-08-15', 750.0, 'CHEQUE'),
(152, '2025-09-15', 750.0, 'NET BANKING'),
(152, '2025-10-15', 750.0, 'UPI'),
(152, '2025-11-15', 750.0, 'CHEQUE'),
(152, '2025-12-15', 750.0, 'NET BANKING'),
(152, '2026-01-15', 750.0, 'UPI'),
(152, '2026-02-15', 750.0, 'CHEQUE'),
(152, '2026-03-15', 750.0, 'NET BANKING'),
(152, '2026-04-15', 750.0, 'UPI'),
(152, '2026-05-15', 750.0, 'CHEQUE'),
(152, '2026-06-15', 750.0, 'NET BANKING'),
(152, '2026-07-15', 750.0, 'UPI'),
(152, '2026-08-15', 750.0, 'CHEQUE'),
(152, '2026-09-15', 750.0, 'NET BANKING'),
(152, '2026-10-15', 750.0, 'UPI'),
(152, '2026-11-15', 750.0, 'CHEQUE'),
(152, '2026-12-15', 750.0, 'NET BANKING'),
(152, '2027-01-15', 750.0, 'UPI'),
(152, '2027-02-15', 750.0, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(153, '2024-02-19', 1472.22, 'NET BANKING'),
(153, '2024-03-19', 1472.22, 'UPI'),
(153, '2024-04-19', 1472.22, 'CHEQUE'),
(153, '2024-05-19', 1472.22, 'NET BANKING'),
(153, '2024-06-19', 1472.22, 'UPI'),
(153, '2024-07-19', 1472.22, 'CHEQUE'),
(153, '2024-08-19', 1472.22, 'NET BANKING'),
(153, '2024-09-19', 1472.22, 'UPI'),
(153, '2024-10-19', 1472.22, 'CHEQUE'),
(153, '2024-11-19', 1472.22, 'NET BANKING'),
(153, '2024-12-19', 1472.22, 'UPI'),
(153, '2025-01-19', 1472.22, 'CHEQUE'),
(153, '2025-02-19', 1472.22, 'NET BANKING'),
(153, '2025-03-19', 1472.22, 'UPI'),
(153, '2025-04-19', 1472.22, 'CHEQUE'),
(153, '2025-05-19', 1472.22, 'NET BANKING'),
(153, '2025-06-19', 1472.22, 'UPI'),
(153, '2025-07-19', 1472.22, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(154, '2025-07-01', 1875.0, 'NET BANKING'),
(154, '2025-08-01', 1875.0, 'UPI'),
(154, '2025-09-01', 1875.0, 'CHEQUE'),
(154, '2025-10-01', 1875.0, 'NET BANKING'),
(154, '2025-11-01', 1875.0, 'UPI'),
(154, '2025-12-01', 1875.0, 'CHEQUE'),
(154, '2026-01-01', 1875.0, 'NET BANKING'),
(154, '2026-02-01', 1875.0, 'UPI'),
(154, '2026-03-01', 1875.0, 'CHEQUE'),
(154, '2026-04-01', 1875.0, 'NET BANKING'),
(154, '2026-05-01', 1875.0, 'UPI'),
(154, '2026-06-01', 1875.0, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(155, '2025-01-30', 933.33, 'NET BANKING'),
(155, '2025-02-28', 933.33, 'UPI'),
(155, '2025-03-30', 933.33, 'CHEQUE'),
(155, '2025-04-30', 933.33, 'NET BANKING'),
(155, '2025-05-30', 933.33, 'UPI'),
(155, '2025-06-30', 933.33, 'CHEQUE'),
(155, '2025-07-30', 933.33, 'NET BANKING'),
(155, '2025-08-30', 933.33, 'UPI'),
(155, '2025-09-30', 933.33, 'CHEQUE'),
(155, '2025-10-30', 933.33, 'NET BANKING'),
(155, '2025-11-30', 933.33, 'UPI'),
(155, '2025-12-30', 933.33, 'CHEQUE'),
(155, '2026-01-30', 933.33, 'NET BANKING'),
(155, '2026-02-28', 933.33, 'UPI'),
(155, '2026-03-30', 933.33, 'CHEQUE'),
(155, '2026-04-30', 933.33, 'NET BANKING'),
(155, '2026-05-30', 933.33, 'UPI'),
(155, '2026-06-30', 933.33, 'CHEQUE'),
(155, '2026-07-30', 933.33, 'NET BANKING'),
(155, '2026-08-30', 933.33, 'UPI'),
(155, '2026-09-30', 933.33, 'CHEQUE'),
(155, '2026-10-30', 933.33, 'NET BANKING'),
(155, '2026-11-30', 933.33, 'UPI'),
(155, '2026-12-30', 933.33, 'CHEQUE'),
(155, '2027-01-30', 933.33, 'NET BANKING'),
(155, '2027-02-28', 933.33, 'UPI'),
(155, '2027-03-30', 933.33, 'CHEQUE'),
(155, '2027-04-30', 933.33, 'NET BANKING'),
(155, '2027-05-30', 933.33, 'UPI'),
(155, '2027-06-30', 933.33, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(156, '2023-07-16', 805.56, 'NET BANKING'),
(156, '2023-08-16', 805.56, 'UPI'),
(156, '2023-09-16', 805.56, 'CHEQUE'),
(156, '2023-10-16', 805.56, 'NET BANKING'),
(156, '2023-11-16', 805.56, 'UPI'),
(156, '2023-12-16', 805.56, 'CHEQUE'),
(156, '2024-01-16', 805.56, 'NET BANKING'),
(156, '2024-02-16', 805.56, 'UPI'),
(156, '2024-03-16', 805.56, 'CHEQUE'),
(156, '2024-04-16', 805.56, 'NET BANKING'),
(156, '2024-05-16', 805.56, 'UPI'),
(156, '2024-06-16', 805.56, 'CHEQUE'),
(156, '2024-07-16', 805.56, 'NET BANKING'),
(156, '2024-08-16', 805.56, 'UPI'),
(156, '2024-09-16', 805.56, 'CHEQUE'),
(156, '2024-10-16', 805.56, 'NET BANKING'),
(156, '2024-11-16', 805.56, 'UPI'),
(156, '2024-12-16', 805.56, 'CHEQUE'),
(156, '2025-01-16', 805.56, 'NET BANKING'),
(156, '2025-02-16', 805.56, 'UPI'),
(156, '2025-03-16', 805.56, 'CHEQUE'),
(156, '2025-04-16', 805.56, 'NET BANKING'),
(156, '2025-05-16', 805.56, 'UPI'),
(156, '2025-06-16', 805.56, 'CHEQUE'),
(156, '2025-07-16', 805.56, 'NET BANKING'),
(156, '2025-08-16', 805.56, 'UPI'),
(156, '2025-09-16', 805.56, 'CHEQUE'),
(156, '2025-10-16', 805.56, 'NET BANKING'),
(156, '2025-11-16', 805.56, 'UPI'),
(156, '2025-12-16', 805.56, 'CHEQUE'),
(156, '2026-01-16', 805.56, 'NET BANKING'),
(156, '2026-02-16', 805.56, 'UPI'),
(156, '2026-03-16', 805.56, 'CHEQUE'),
(156, '2026-04-16', 805.56, 'NET BANKING'),
(156, '2026-05-16', 805.56, 'UPI'),
(156, '2026-06-16', 805.56, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(157, '2025-03-20', 958.33, 'NET BANKING'),
(157, '2025-04-20', 958.33, 'UPI'),
(157, '2025-05-20', 958.33, 'CHEQUE'),
(157, '2025-06-20', 958.33, 'NET BANKING'),
(157, '2025-07-20', 958.33, 'UPI'),
(157, '2025-08-20', 958.33, 'CHEQUE'),
(157, '2025-09-20', 958.33, 'NET BANKING'),
(157, '2025-10-20', 958.33, 'UPI'),
(157, '2025-11-20', 958.33, 'CHEQUE'),
(157, '2025-12-20', 958.33, 'NET BANKING'),
(157, '2026-01-20', 958.33, 'UPI'),
(157, '2026-02-20', 958.33, 'CHEQUE'),
(157, '2026-03-20', 958.33, 'NET BANKING'),
(157, '2026-04-20', 958.33, 'UPI'),
(157, '2026-05-20', 958.33, 'CHEQUE'),
(157, '2026-06-20', 958.33, 'NET BANKING'),
(157, '2026-07-20', 958.33, 'UPI'),
(157, '2026-08-20', 958.33, 'CHEQUE'),
(157, '2026-09-20', 958.33, 'NET BANKING'),
(157, '2026-10-20', 958.33, 'UPI'),
(157, '2026-11-20', 958.33, 'CHEQUE'),
(157, '2026-12-20', 958.33, 'NET BANKING'),
(157, '2027-01-20', 958.33, 'UPI'),
(157, '2027-02-20', 958.33, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(158, '2024-05-10', 850.0, 'NET BANKING'),
(158, '2024-06-10', 850.0, 'UPI'),
(158, '2024-07-10', 850.0, 'CHEQUE'),
(158, '2024-08-10', 850.0, 'NET BANKING'),
(158, '2024-09-10', 850.0, 'UPI'),
(158, '2024-10-10', 850.0, 'CHEQUE'),
(158, '2024-11-10', 850.0, 'NET BANKING'),
(158, '2024-12-10', 850.0, 'UPI'),
(158, '2025-01-10', 850.0, 'CHEQUE'),
(158, '2025-02-10', 850.0, 'NET BANKING'),
(158, '2025-03-10', 850.0, 'UPI'),
(158, '2025-04-10', 850.0, 'CHEQUE'),
(158, '2025-05-10', 850.0, 'NET BANKING'),
(158, '2025-06-10', 850.0, 'UPI'),
(158, '2025-07-10', 850.0, 'CHEQUE'),
(158, '2025-08-10', 850.0, 'NET BANKING'),
(158, '2025-09-10', 850.0, 'UPI'),
(158, '2025-10-10', 850.0, 'CHEQUE'),
(158, '2025-11-10', 850.0, 'NET BANKING'),
(158, '2025-12-10', 850.0, 'UPI'),
(158, '2026-01-10', 850.0, 'CHEQUE'),
(158, '2026-02-10', 850.0, 'NET BANKING'),
(158, '2026-03-10', 850.0, 'UPI'),
(158, '2026-04-10', 850.0, 'CHEQUE'),
(158, '2026-05-10', 850.0, 'NET BANKING'),
(158, '2026-06-10', 850.0, 'UPI'),
(158, '2026-07-10', 850.0, 'CHEQUE'),
(158, '2026-08-10', 850.0, 'NET BANKING'),
(158, '2026-09-10', 850.0, 'UPI'),
(158, '2026-10-10', 850.0, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(159, '2023-11-07', 979.17, 'NET BANKING'),
(159, '2023-12-07', 979.17, 'UPI'),
(159, '2024-01-07', 979.17, 'CHEQUE'),
(159, '2024-02-07', 979.17, 'NET BANKING'),
(159, '2024-03-07', 979.17, 'UPI'),
(159, '2024-04-07', 979.17, 'CHEQUE'),
(159, '2024-05-07', 979.17, 'NET BANKING'),
(159, '2024-06-07', 979.17, 'UPI'),
(159, '2024-07-07', 979.17, 'CHEQUE'),
(159, '2024-08-07', 979.17, 'NET BANKING'),
(159, '2024-09-07', 979.17, 'UPI'),
(159, '2024-10-07', 979.17, 'CHEQUE'),
(159, '2024-11-07', 979.17, 'NET BANKING'),
(159, '2024-12-07', 979.17, 'UPI'),
(159, '2025-01-07', 979.17, 'CHEQUE'),
(159, '2025-02-07', 979.17, 'NET BANKING'),
(159, '2025-03-07', 979.17, 'UPI'),
(159, '2025-04-07', 979.17, 'CHEQUE'),
(159, '2025-05-07', 979.17, 'NET BANKING'),
(159, '2025-06-07', 979.17, 'UPI'),
(159, '2025-07-07', 979.17, 'CHEQUE'),
(159, '2025-08-07', 979.17, 'NET BANKING'),
(159, '2025-09-07', 979.17, 'UPI'),
(159, '2025-10-07', 979.17, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(160, '2024-06-18', 1361.11, 'NET BANKING'),
(160, '2024-07-18', 1361.11, 'UPI'),
(160, '2024-08-18', 1361.11, 'CHEQUE'),
(160, '2024-09-18', 1361.11, 'NET BANKING'),
(160, '2024-10-18', 1361.11, 'UPI'),
(160, '2024-11-18', 1361.11, 'CHEQUE'),
(160, '2024-12-18', 1361.11, 'NET BANKING'),
(160, '2025-01-18', 1361.11, 'UPI'),
(160, '2025-02-18', 1361.11, 'CHEQUE'),
(160, '2025-03-18', 1361.11, 'NET BANKING'),
(160, '2025-04-18', 1361.11, 'UPI'),
(160, '2025-05-18', 1361.11, 'CHEQUE'),
(160, '2025-06-18', 1361.11, 'NET BANKING'),
(160, '2025-07-18', 1361.11, 'UPI'),
(160, '2025-08-18', 1361.11, 'CHEQUE'),
(160, '2025-09-18', 1361.11, 'NET BANKING'),
(160, '2025-10-18', 1361.11, 'UPI'),
(160, '2025-11-18', 1361.11, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(161, '2023-12-05', 916.67, 'NET BANKING'),
(161, '2024-01-05', 916.67, 'UPI'),
(161, '2024-02-05', 916.67, 'CHEQUE'),
(161, '2024-03-05', 916.67, 'NET BANKING'),
(161, '2024-04-05', 916.67, 'UPI'),
(161, '2024-05-05', 916.67, 'CHEQUE'),
(161, '2024-06-05', 916.67, 'NET BANKING'),
(161, '2024-07-05', 916.67, 'UPI'),
(161, '2024-08-05', 916.67, 'CHEQUE'),
(161, '2024-09-05', 916.67, 'NET BANKING'),
(161, '2024-10-05', 916.67, 'UPI'),
(161, '2024-11-05', 916.67, 'CHEQUE'),
(161, '2024-12-05', 916.67, 'NET BANKING'),
(161, '2025-01-05', 916.67, 'UPI'),
(161, '2025-02-05', 916.67, 'CHEQUE'),
(161, '2025-03-05', 916.67, 'NET BANKING'),
(161, '2025-04-05', 916.67, 'UPI'),
(161, '2025-05-05', 916.67, 'CHEQUE'),
(161, '2025-06-05', 916.67, 'NET BANKING'),
(161, '2025-07-05', 916.67, 'UPI'),
(161, '2025-08-05', 916.67, 'CHEQUE'),
(161, '2025-09-05', 916.67, 'NET BANKING'),
(161, '2025-10-05', 916.67, 'UPI'),
(161, '2025-11-05', 916.67, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(162, '2024-01-22', 1000.0, 'NET BANKING'),
(162, '2024-02-22', 1000.0, 'UPI'),
(162, '2024-03-22', 1000.0, 'CHEQUE'),
(162, '2024-04-22', 1000.0, 'NET BANKING'),
(162, '2024-05-22', 1000.0, 'UPI'),
(162, '2024-06-22', 1000.0, 'CHEQUE'),
(162, '2024-07-22', 1000.0, 'NET BANKING'),
(162, '2024-08-22', 1000.0, 'UPI'),
(162, '2024-09-22', 1000.0, 'CHEQUE'),
(162, '2024-10-22', 1000.0, 'NET BANKING'),
(162, '2024-11-22', 1000.0, 'UPI'),
(162, '2024-12-22', 1000.0, 'CHEQUE'),
(162, '2025-01-22', 1000.0, 'NET BANKING'),
(162, '2025-02-22', 1000.0, 'UPI'),
(162, '2025-03-22', 1000.0, 'CHEQUE'),
(162, '2025-04-22', 1000.0, 'NET BANKING'),
(162, '2025-05-22', 1000.0, 'UPI'),
(162, '2025-06-22', 1000.0, 'CHEQUE'),
(162, '2025-07-22', 1000.0, 'NET BANKING'),
(162, '2025-08-22', 1000.0, 'UPI'),
(162, '2025-09-22', 1000.0, 'CHEQUE'),
(162, '2025-10-22', 1000.0, 'NET BANKING'),
(162, '2025-11-22', 1000.0, 'UPI'),
(162, '2025-12-22', 1000.0, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(163, '2024-04-17', 708.33, 'NET BANKING'),
(163, '2024-05-17', 708.33, 'UPI'),
(163, '2024-06-17', 708.33, 'CHEQUE'),
(163, '2024-07-17', 708.33, 'NET BANKING'),
(163, '2024-08-17', 708.33, 'UPI'),
(163, '2024-09-17', 708.33, 'CHEQUE'),
(163, '2024-10-17', 708.33, 'NET BANKING'),
(163, '2024-11-17', 708.33, 'UPI'),
(163, '2024-12-17', 708.33, 'CHEQUE'),
(163, '2025-01-17', 708.33, 'NET BANKING'),
(163, '2025-02-17', 708.33, 'UPI'),
(163, '2025-03-17', 708.33, 'CHEQUE'),
(163, '2025-04-17', 708.33, 'NET BANKING'),
(163, '2025-05-17', 708.33, 'UPI'),
(163, '2025-06-17', 708.33, 'CHEQUE'),
(163, '2025-07-17', 708.33, 'NET BANKING'),
(163, '2025-08-17', 708.33, 'UPI'),
(163, '2025-09-17', 708.33, 'CHEQUE'),
(163, '2025-10-17', 708.33, 'NET BANKING'),
(163, '2025-11-17', 708.33, 'UPI'),
(163, '2025-12-17', 708.33, 'CHEQUE'),
(163, '2026-01-17', 708.33, 'NET BANKING'),
(163, '2026-02-17', 708.33, 'UPI'),
(163, '2026-03-17', 708.33, 'CHEQUE'),
(163, '2026-04-17', 708.33, 'NET BANKING'),
(163, '2026-05-17', 708.33, 'UPI'),
(163, '2026-06-17', 708.33, 'CHEQUE'),
(163, '2026-07-17', 708.33, 'NET BANKING'),
(163, '2026-08-17', 708.33, 'UPI'),
(163, '2026-09-17', 708.33, 'CHEQUE'),
(163, '2026-10-17', 708.33, 'NET BANKING'),
(163, '2026-11-17', 708.33, 'UPI'),
(163, '2026-12-17', 708.33, 'CHEQUE'),
(163, '2027-01-17', 708.33, 'NET BANKING'),
(163, '2027-02-17', 708.33, 'UPI'),
(163, '2027-03-17', 708.33, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(164, '2024-05-01', 1020.83, 'NET BANKING'),
(164, '2024-06-01', 1020.83, 'UPI'),
(164, '2024-07-01', 1020.83, 'CHEQUE'),
(164, '2024-08-01', 1020.83, 'NET BANKING'),
(164, '2024-09-01', 1020.83, 'UPI'),
(164, '2024-10-01', 1020.83, 'CHEQUE'),
(164, '2024-11-01', 1020.83, 'NET BANKING'),
(164, '2024-12-01', 1020.83, 'UPI'),
(164, '2025-01-01', 1020.83, 'CHEQUE'),
(164, '2025-02-01', 1020.83, 'NET BANKING'),
(164, '2025-03-01', 1020.83, 'UPI'),
(164, '2025-04-01', 1020.83, 'CHEQUE'),
(164, '2025-05-01', 1020.83, 'NET BANKING'),
(164, '2025-06-01', 1020.83, 'UPI'),
(164, '2025-07-01', 1020.83, 'CHEQUE'),
(164, '2025-08-01', 1020.83, 'NET BANKING'),
(164, '2025-09-01', 1020.83, 'UPI'),
(164, '2025-10-01', 1020.83, 'CHEQUE'),
(164, '2025-11-01', 1020.83, 'NET BANKING'),
(164, '2025-12-01', 1020.83, 'UPI'),
(164, '2026-01-01', 1020.83, 'CHEQUE'),
(164, '2026-02-01', 1020.83, 'NET BANKING'),
(164, '2026-03-01', 1020.83, 'UPI'),
(164, '2026-04-01', 1020.83, 'CHEQUE');


Insert Into Repayments (LoanID, PaymentsDate, LoanAmountPaid, PaymentMode) Values
(165, '2024-03-05', 1083.33, 'NET BANKING'),
(165, '2024-04-05', 1083.33, 'UPI'),
(165, '2024-05-05', 1083.33, 'CHEQUE'),
(165, '2024-06-05', 1083.33, 'NET BANKING'),
(165, '2024-07-05', 1083.33, 'UPI'),
(165, '2024-08-05', 1083.33, 'CHEQUE'),
(165, '2024-09-05', 1083.33, 'NET BANKING'),
(165, '2024-10-05', 1083.33, 'UPI'),
(165, '2024-11-05', 1083.33, 'CHEQUE'),
(165, '2024-12-05', 1083.33, 'NET BANKING'),
(165, '2025-01-05', 1083.33, 'UPI'),
(165, '2025-02-05', 1083.33, 'CHEQUE'),
(165, '2025-03-05', 1083.33, 'NET BANKING'),
(165, '2025-04-05', 1083.33, 'UPI'),
(165, '2025-05-05', 1083.33, 'CHEQUE'),
(165, '2025-06-05', 1083.33, 'NET BANKING'),
(165, '2025-07-05', 1083.33, 'UPI'),
(165, '2025-08-05', 1083.33, 'CHEQUE'),
(165, '2025-09-05', 1083.33, 'NET BANKING'),
(165, '2025-10-05', 1083.33, 'UPI'),
(165, '2025-11-05', 1083.33, 'CHEQUE'),
(165, '2025-12-05', 1083.33, 'NET BANKING'),
(165, '2026-01-05', 1083.33, 'UPI'),
(165, '2026-02-05', 1083.33, 'CHEQUE');

--select * from Repayments

-- Inserting data into Feedback
Insert Into Feedback Values (1,1,'Satisfied ',4);
Insert Into Feedback Values (2,2,'UnSatisfied ',3);
Insert Into Feedback Values (3,3,'UnSatisfied ',2);
Insert Into Feedback Values (4,4,'Satisfied ',4);
Insert Into Feedback Values (5,5,'UnSatisfied ',2);
Insert Into Feedback Values (6,6,'Satisfied ',4);
Insert Into Feedback Values (7,7,'Satisfied ',4);
Insert Into Feedback Values (8,8,'UnSatisfied ',2);
Insert Into Feedback Values (9,9,'Satisfied ',4);
Insert Into Feedback Values (10,10,'UnSatisfied ',3);
Insert Into Feedback Values (11,11,'Satisfied ',4);
Insert Into Feedback Values (12,12,'Satisfied ',4);
Insert Into Feedback Values (13,13,'UnSatisfied ',3);
Insert Into Feedback Values (14,14,'Satisfied ',5);
Insert Into Feedback Values (15,15,'Satisfied ',5);
Insert Into Feedback Values (16,16,'UnSatisfied ',4);
Insert Into Feedback Values (17,17,'Satisfied ',4);
Insert Into Feedback Values (18,18,'UnSatisfied ',4);
Insert Into Feedback Values (19,19,'Satisfied ',5);
Insert Into Feedback Values (20,20,'UnSatisfied ',2);
Insert Into Feedback Values (21,21,'Satisfied ',1);
Insert Into Feedback Values (22,22,'UnSatisfied ',3);
Insert Into Feedback Values (23,23,'Satisfied ',2);
Insert Into Feedback Values (24,24,'UnSatisfied ',2);
Insert Into Feedback Values (25,25,'Satisfied ',5);
Insert Into Feedback Values (26,26,'UnSatisfied ',5);
Insert Into Feedback Values (27,27,'Satisfied ',1);
Insert Into Feedback Values (28,28,'UnSatisfied ',2);
Insert Into Feedback Values (29,29,'Satisfied ',3);
Insert Into Feedback Values (30,30,'UnSatisfied ',3);
Insert Into Feedback Values (31,31,'Satisfied ',5);
Insert Into Feedback Values (32,32,'UnSatisfied ',3);
Insert Into Feedback Values (33,33,'Satisfied ',3);
Insert Into Feedback Values (34,34,'UnSatisfied ',3);
Insert Into Feedback Values (35,35,'Satisfied ',2);
Insert Into Feedback Values (36,36,'UnSatisfied ',2);
Insert Into Feedback Values (37,37,'Satisfied ',1);
Insert Into Feedback Values (38,38,'UnSatisfied ',5);
Insert Into Feedback Values (39,39,'Satisfied ',5);
Insert Into Feedback Values (40,40,'UnSatisfied ',2);
Insert Into Feedback Values (41,41,'Satisfied ',1);
Insert Into Feedback Values (42,42,'UnSatisfied ',2);
Insert Into Feedback Values (43,43,'Satisfied ',4);
Insert Into Feedback Values (44,44,'UnSatisfied ',3);
Insert Into Feedback Values (45,45,'Satisfied ',5);
Insert Into Feedback Values (46,46,'UnSatisfied ',2);
Insert Into Feedback Values (47,47,'Satisfied ',1);
Insert Into Feedback Values (48,48,'UnSatisfied ',3);
Insert Into Feedback Values (49,49,'Satisfied ',2);
Insert Into Feedback Values (50,50,'UnSatisfied ',1);
Insert Into Feedback Values (51,51,'Satisfied ',5);
Insert Into Feedback Values (52,52,'UnSatisfied ',4);
Insert Into Feedback Values (53,53,'Satisfied ',3);
Insert Into Feedback Values (54,54,'UnSatisfied ',1);
Insert Into Feedback Values (55,55,'Satisfied ',5);
Insert Into Feedback Values (56,56,'UnSatisfied ',5);
Insert Into Feedback Values (57,57,'Satisfied ',2);
Insert Into Feedback Values (58,58,'UnSatisfied ',1);
Insert Into Feedback Values (59,59,'Satisfied ',2);
Insert Into Feedback Values (60,60,'UnSatisfied ',3);
Insert Into Feedback Values (61,61,'Satisfied ',5);
Insert Into Feedback Values (62,62,'UnSatisfied ',1);
Insert Into Feedback Values (63,63,'Satisfied ',4);
Insert Into Feedback Values (64,64,'UnSatisfied ',2);
Insert Into Feedback Values (65,65,'Satisfied ',1);
--ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
--For DimDate
-- Create the Date Dimension Table
if exists(select * from sys.tables where name='dbo.DimDate')
drop table dbo.DimDate

-- Drop if already exists
IF OBJECT_ID('dbo.DimDate', 'U') IS NOT NULL
    DROP TABLE dbo.DimDate;
GO
CREATE TABLE dbo.DimDate (
    TimeID INT PRIMARY KEY,              -- YYYYMMDD format
    [Date] DATE NOT NULL,
    YearID INT NOT NULL,
	SemesterID INT NOT NULL,
    QuarterID INT NOT NULL,
    MonthID INT NOT NULL,
    MonthName VARCHAR(20) NOT NULL,
    [Week] INT NOT NULL,
    [Day] INT NOT NULL,
    DayName VARCHAR(20) NOT NULL,
    IsWeekDay BIT NOT NULL,
    DaysOfYear INT NOT NULL
);
GO

-- Populate DimDate
WITH DateSequence AS (
    SELECT CAST('1991-01-01' AS DATE) AS Dt
    UNION ALL
    SELECT DATEADD(DAY, 1, Dt)
    FROM DateSequence
    WHERE Dt < '2030-01-01'
)
INSERT INTO dbo.DimDate (
    TimeID, [Date], YearID,SemesterID, QuarterID, MonthID, MonthName,
    [Week], [Day], DayName, IsWeekDay, DaysOfYear
)
SELECT
    CONVERT(INT, FORMAT(Dt, 'yyyyMMdd')) AS TimeID,
    Dt AS [Date],
    YEAR(Dt) AS YearID,
	CASE WHEN MONTH(Dt) BETWEEN 1 AND 6 THEN 1 ELSE 2 END AS SemesterID,
    DATEPART(QUARTER, Dt) AS QuarterID,
    MONTH(Dt) AS MonthID,
    DATENAME(MONTH, Dt) AS MonthName,
    DATEPART(WEEK, Dt) AS [Week],
    DAY(Dt) AS [Day],
    DATENAME(WEEKDAY, Dt) AS DayName,
    CASE WHEN DATENAME(WEEKDAY, Dt) IN ('Saturday', 'Sunday') THEN 0 ELSE 1 END AS IsWeekDay,
    DATEPART(DAYOFYEAR, Dt) AS DaysOfYear
FROM DateSequence
OPTION (MAXRECURSION 0);

--SELECT * FROM DimDate
--#################################################################################################################################
--###################################################		END		###############################################################
--#################################################################################################################################
select min(GroupCreated)minimum,max(GroupCreated)maximum_for_group_created  from [dbo].[Groups]
 
select min(LoanStartDate)MIN_Loan_Start_Date,max(LoanStartDate)MAX_Loan_Start_Date,min(LoanEndDate)MIN_loan_EndD_Date_For_loads,max(LoanEndDate)MAX_loan_EndD_Date_For_loads from [dbo].[Loans]

select min(PaymentsDate)minDate_for_Repayments from [dbo].[Repayments]

select min(CustomerDateOfBirth)min_BirthDate,max(CustomerDateOfBirth)max_BirthDate from [dbo].[CustomerTable]

 
--1. LoanAmount means Principal Loan Amount only


--All Tables:-
SELECT * FROM Groups
SELECT * FROM Branch
SELECT * FROM CustomerTable
SELECT * FROM Loans
SELECT * FROM LoansType
SELECT * FROM Repayments
SELECT * FROM Feedback						 
SELECT * FROM dbo.DimDate

SELECT * FROM Repayments
SELECT * FROM Loans
 SELECT LoanID,LoanAmountPaid,count(*)tenure FROM Repayments
 group by LoanID,LoanAmountPaid
 order by LoanID asc

----------------------------------------------------------------------------------
--Rough
 SELECT LoanID,LoanAmountPaid,count(*)tenure FROM Repayments
 group by LoanID,LoanAmountPaid
 order by LoanID asc

SELECT * FROM CustomerTable
SELECT * FROM Loans 
SELECT * FROM Repayments
 
SELECT  C.CustomerID,CustomerIncomeLevel,LoanAmount as PrincipalLoanAmount,LoanInterestRate,TenureInMonth,LoanAmountPaid,count(*)tenure
FROM Loans L 
join Repayments R on l.LoanID=r.LoanID 
join CustomerTable C on l.CustomerID=c.CustomerID
group by C.CustomerID,CustomerIncomeLevel,LoanAmount,LoanInterestRate,TenureInMonth,LoanAmountPaid



 --correct data 
 CustomerID	CustomerIncomeLevel	PrincipalLoanAmount	LoanInterestRate	TenureInMonth	MonthlyInstallments
	1	3000	19000	10	12	1670.4
	2	2000	41000	9	36	1303.79
	3	5000	64000	9	36	2035.18
	4	1000	42000	9	36	1335.59
	5	7000	27000	10	12	2373.73
	6	5000	35000	9	36	1112.99
	7	2000	52000	9	36	1653.59
	8	3000	21000	10	12	1846.23
	9	4000	12000	10	12	1054.99
	10	5000	23000	10	12	2022.07
	11	5000	23000	10	12	2022.07
	12	4000	6000	8	6	1023.46
	13	2000	10000	8	6	1705.77
	14	3000	22000	10	12	1934.15
	15	6000	19000	10	12	1670.4
	16	1000	6000	8	6	1023.46
	17	4000	40000	9	36	1271.99
	18	5000	13000	10	12	1142.91
	19	3000	31000	9	36	985.79
	20	1000	9000	8	6	1535.19
	21	2000	18000	10	12	1582.49
	22	4000	33000	9	36	1049.39
	23	2000	10000	8	6	1705.77
	24	6000	8000	8	6	1364.62
	25	3000	62000	9	36	1971.58
	26	3000	8000	8	6	1364.62
	27	2000	31000	9	36	985.79
	28	5000	13000	10	12	1142.91
	29	1000	9000	8	6	1535.19
	30	7000	22000	10	12	1934.15
	31	5000	13000	10	12	1142.91
	32	2000	14000	10	12	1230.82
	33	3000	6000	8	6	1023.46
	34	4000	29000	9	36	922.19
	35	5000	33000	9	36	1049.39
	36	5000	11000	8	12	956.87
	37	4000	31000	9	36	985.79
	38	2000	20000	10	12	1758.32
	39	3000	31000	9	36	985.79
	40	6000	13000	8	12	1130.85
	41	1000	30000	9	36	953.99
	42	4000	18000	10	12	1582.49
	43	5000	7000	8	6	1194.04
	44	3000	20000	10	12	1758.32
	45	1000	22000	10	12	1934.15
	46	2000	13000	8	12	1130.85
	47	4000	31000	9	36	985.79
	48	2000	10000	8	6	1705.77
	49	6000	31000	9	36	985.79
	50	3000	18000	10	12	1582.49
	51	3000	14000	10	12	1230.82
	52	2000	23000	10	12	2022.07
	53	5000	19000	10	12	1670.4
	54	1000	14000	10	12	1230.82
	55	7000	15000	10	12	1318.74
	56	5000	11000	8	12	956.87
	57	2000	18000	10	12	1582.49
	58	3000	24000	10	12	2109.98
	59	4000	26000	10	12	2285.81
	60	5000	30000	10	12	2637.48
	61	5000	12000	10	12	1054.99
	62	4000	13000	9	36	413.4
	63	2000	15000	10	12	1318.74
	64	3000	17000	10	12	1494.57
	65	6000	20000	10	12	1758.32
 
  /*
  wrong Data 						
	 CustomerID	CustomerIncomeLevel	PrincipalLoanAmount	LoanInterestRate	TenureInMonth	MonthlyInstallments
	1	3000	19000	14	12	1583.33
	2	2000	41000	16	36	1138.89
	3	5000	64000	16	36	1777.78
	4	1000	42000	16	36	1166.67
	5	7000	27000	14	12	2250
	6	5000	35000	16	36	972.22
	7	2000	52000	16	36	1444.44
	8	3000	21000	14	12	1750
	9	4000	12000	14	12	1000
	10	5000	23000	14	12	1916.67
						

  */



















  ALTER AUTHORIZATION ON DATABASE::[Bandhan_Bank]
TO [DESKTOP-IR63RJ5\DELL];

