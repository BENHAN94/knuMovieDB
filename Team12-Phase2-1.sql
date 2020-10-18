
-- DDLs

DROP TABLE Movie CASCADE;
DROP TABLE Director CASCADE;
DROP TABLE Genre CASCADE;
DROP TABLE Actor CASCADE;
DROP TABLE Director_of CASCADE;
DROP TABLE Playing_in CASCADE;
DROP TABLE Genre_of CASCADE;
DROP TABLE Episode CASCADE;
DROP TABLE Version CASCADE;
DROP TABLE Account CASCADE;
DROP TABLE Rating CASCADE;
DROP TABLE Admin CASCADE;
DROP TABLE Membership CASCADE;
DROP TABLE Subscribe CASCADE;
DROP TABLE Actor_of CASCADE;

CREATE TABLE Movie(
	Movie_id SERIAL PRIMARY KEY,
	Original_title VARCHAR(200) NOT NULL,
	Primary_title VARCHAR(200),
	Running_time NUMERIC(5,0),
	Start_year DATE,
	End_year DATE, 
	Type VARCHAR(20) NOT NULL,
	Is_adult BOOLEAN NOT NULL,
	Rating NUMERIC(3,1)
);

CREATE TABLE Director(
	Director_id SERIAL PRIMARY KEY,
	Director_name VARCHAR(50) NOT NULL,
	Birth_year NUMERIC(4,0),
	Death_year NUMERIC(4,0)
);

CREATE TABLE Director_of(
	mid INTEGER NOT NULL,
	did INTEGER NOT NULL,
	PRIMARY KEY (mid, did)
);

CREATE TABLE Genre(
	Genre_id SERIAL NOT NULL PRIMARY KEY,
	Genre VARCHAR(20) NOT NULL
);

CREATE TABLE Genre_of(
	mid INTEGER NOT NULL,
	gen INTEGER NOT NULL,
	PRIMARY KEY(mid, gen)
);

CREATE TABLE Actor(
	Actor_id SERIAL NOT NULL PRIMARY KEY,
	Actor_name VARCHAR(50) NOT NULL,
	Birth_year NUMERIC(4,0),
	Death_year NUMERIC(4,0)
);

CREATE TABLE Actor_of(
	aid INTEGER NOT NULL,
	mid INTEGER NOT NULL,
	Character VARCHAR(50),
	PRIMARY KEY(aid, mid)
);

CREATE TABLE Playing_in(
	mid SERIAL NOT NULL,
	aid SERIAL NOT NULL,
	PRIMARY KEY(mid, aid)
);

CREATE TABLE Episode(
	mid SERIAL NOT NULL,
	pid SERIAL NOT NULL,
	Episode_number INTEGER,
	Episode_season INTEGER,
	PRIMARY KEY (mid, pid)
);

CREATE TABLE Version(
	Version_id SERIAL NOT NULL PRIMARY KEY,
	Version_title VARCHAR(200) NOT NULL,
	Region VARCHAR(50),
	Language VARCHAR(50),
	mid SERIAL NOT NULL
);

CREATE TABLE Account(
	Account_id SERIAL NOT NULL PRIMARY KEY,
	Email_add VARCHAR(100) NOT NULL UNIQUE,
	First_name VARCHAR(100) NOT NULL,
	Last_name VARCHAR(100) NOT NULL,
	Birthday DATE,
	Sex VARCHAR(20),
	Password VARCHAR(50) NOT NULL,
	Phone VARCHAR(20),
	Address VARCHAR(100),
	Job VARCHAR(100)
);

CREATE TABLE Rating(
	Rating_id SERIAL NOT NULL PRIMARY KEY,
	Single_rating INTEGER NOT NULL,
	mid SERIAL NOT NULL,
	uid SERIAL NOT NULL
);

CREATE TABLE Admin(
	uid SERIAL NOT NULL
);

CREATE TABLE Membership(
	Membership_title VARCHAR(10) NOT NULL PRIMARY KEY
);

CREATE TABLE Subscribe(
	email VARCHAR(100) NOT NULL,
	mem VARCHAR(10) NOT NULL,
	PRIMARY KEY (email, mem)
);



