DROP DATABASE IF EXISTS dm_db;
CREATE DATABASE dm_db;
USE dm_db;
DROP TABLE IF EXISTS customer;
CREATE TABLE customer (
    CustomerId INT,
    Surname VARCHAR(256),
    Gender ENUM('Male', 'Female'),
    Age INT,
    IsActiveMember ENUM('1', '0'),
    Tenure INT,
    HasCrCard ENUM('1', '0'),
    CreditScore INT,
    PRIMARY KEY (customerId)
);
CREATE TABLE Geography (
    GeoId VARCHAR(256),
    Country VARCHAR(256),
    PRIMARY KEY (GeoId)
);
CREATE TABLE Transaction (
    TransactionId INT,
    CustomerId INT,
    GeoId VARCHAR(256),
    NumOfProducts INT,
    Balance DECIMAL(10 , 2 ),
    FOREIGN KEY (CustomerId)
        REFERENCES Customer (CustomerId),
    FOREIGN KEY (GeoId)
        REFERENCES Geography (GeoId),
    PRIMARY KEY (TransactionId)
);
USE dm_db;
SET GLOBAL LOCAL_INFILE=true;
LOAD DATA LOCAL INFILE 'C:/Users/babat/OneDrive/Documents/Tech1M DA Bootcamp/Project/Data Migration Project/Customer.csv'
INTO TABLE customer
FIELDS TERMINATED BY ','
ENCLOSED BY '"' LINES
TERMINATED BY '\n'
IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE 'C:/Users/babat/OneDrive/Documents/Tech1M DA Bootcamp/Project/Data Migration Project/Geography.csv'
INTO TABLE geography
FIELDS TERMINATED BY ','
ENCLOSED BY '"' LINES
TERMINATED BY '\n'
IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE 'C:/Users/babat/OneDrive/Documents/Tech1M DA Bootcamp/Project/Data Migration Project/Transaction.csv'
INTO TABLE transaction
FIELDS TERMINATED BY ','
ENCLOSED BY '"' LINES
TERMINATED BY '\n'
IGNORE 1 ROWS;
