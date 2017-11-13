DROP TABLE IF EXISTS Medicine_Details;
CREATE TABLE Medicine_Details(
	MedID varchar(50),
	Salt tinytext,
	prescription varchar(1),
	PRIMARY KEY (MedID)
	);

DROP TABLE IF EXISTS Compartment;
CREATE TABLE Compartment(
	CID int,
	ShelfNo int,
	PRIMARY KEY(CID,ShelfNo)
	);
	
DROP TABLE IF EXISTS Product_details;
CREATE TABLE Product_details(
	Name varchar(50),
	Category varchar(50),
	CID int,
	ShelfNo int,
	Mfg_by varchar(50),
	Description text,
	MedID varchar(50),
	PRIMARY KEY (Name),
	FOREIGN KEY(CID,ShelfNo) REFERENCES Compartment(CID,ShelfNo),
	FOREIGN KEY(MedID) REFERENCES Medicine_Details(MedID)
	);

DROP TABLE IF EXISTS WholeSeller;
CREATE TABLE WholeSeller(
	WSID int,
	Name varchar(50),
	Address text,
	Email_ID varchar(50),
	Phone bigint,
	PRIMARY KEY(WSID)
	);
	
	
DROP TABLE IF EXISTS Purchase_Record;
CREATE TABLE Purchase_Record(
	PRID int AUTO_INCREMENT,
	WSID int,
	date DATE,
	TPrice FLOAT,
	Quantity int,
	PRIMARY KEY(PRID),
	FOREIGN KEY(WSID) REFERENCES WholeSeller(WSID)
	);
	
	
DROP TABLE IF EXISTS Batch_Details;
CREATE TABLE Batch_Details(
	BatchNo INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	Name varchar(50) NOT NULL,
	Whole_price FLOAT NOT NULL,
	Retail_price FLOAT NOT NULL,
	Mfg_date DATE NOT NULL,
	Exp_date DATE NOT NULL,
	Curr_quantity INT NOT NULL,
	PRID INT NOT NULL,
	FOREIGN KEY (PRID) REFERENCES Purchase_Record(PRID),
	FOREIGN KEY (Name) REFERENCES Product_details(Name)
	);

DROP TABLE IF EXISTS Repl_Record;
CREATE TABLE Repl_Record(
	RRID int AUTO_INCREMENT,
	BatchNo int,
	WSID int,
	Date DATE,
	Price FLOAT,
	Quantity int,
	PRIMARY KEY (RRID),
	FOREIGN KEY(BatchNo) REFERENCES Batch_Details(BatchNo),
	FOREIGN KEY(WSID) REFERENCES WholeSeller(WSID)
	);

DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer(	
	CustID varchar(50),
	Name varchar(50),
	DOB DATE,
	Email_ID varchar(50),
	Apt_Name varchar(50),
	Street_Name varchar(50),
	City varchar(50),
	State varchar(50),
	Zip int,
	Phone bigint,
	userid int,
	PRIMARY KEY(CustID),
	FOREIGN KEY(userid) REFERENCES auth_user(id)
	);

DROP TABLE IF EXISTS Feedback;
CREATE TABLE Feedback(
	FID int AUTO_INCREMENT,
	CustID varchar(50),
	Date DATE,
	Subject varchar(50),
	Content text,
	PRIMARY KEY(FID),
	FOREIGN KEY(CustID) REFERENCES Customer(CustID)
	);
	
DROP TABLE IF EXISTS Sale_Record;
CREATE TABLE Sale_Record(
	SRID int AUTO_INCREMENT,
	CustID varchar(50),
	Date DATE,
	Price FLOAT,
	Quantity int,
	On_Offline varchar(8),
	PRIMARY KEY(SRID),
	FOREIGN KEY(CustID) REFERENCES Customer(CustID)
	);

DROP TABLE IF EXISTS SR_Prod;
CREATE TABLE SR_Prod(
	SRID int,
	BatchNo int,
	PRIMARY KEY(SRID,BatchNo),
	FOREIGN KEY(SRID) REFERENCES Sale_Record(SRID),
	FOREIGN KEY(BatchNo) REFERENCES Batch_Details(BatchNo)
	);
		
DROP TABLE IF EXISTS Cart;
CREATE TABLE Cart(
	CustID varchar(50),
	BatchNo int,
	Quantity int,
	PRIMARY KEY(CustID,BatchNo),
	FOREIGN KEY(CustID) REFERENCES Customer(CustID),
	FOREIGN KEY(BatchNo) REFERENCES Batch_Details(BatchNo)
	);