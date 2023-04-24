## Project Case Study: Data Migration Project for an SME

### Background:
An SME in the retail industry was planning to upgrade their existing Data Architecture to modern and more scalable technology. The upgrade required the migration of data from the old systems to the new ones. The project involved migrating large volumes of customer and transaction data while ensuring that data quality was maintained and business operations were not disrupted.

### Objectives:
The primary objective of the data migration project was to ensure a smooth transition from the old systems to the new ones without any loss of data or disruption to business operations. The project also aimed to;
  - Improve data quality,
  - Optimize the new systems' performance,
  - Analyze the data to identify the business KPIs,
  - Create an automated Dashboard to visualize business performance and
  - To design a an algorithm that predict future sales and customer performances.

### Approach:
To achieve the project objectives, the following steps were taken:

**Data Extraction**: The team extracted the data from the old systems using Excel funtions and tools that ensured data integrity. Since it was a single sheet of data, Three new sheets was created from the parent sheet they include;
   -  **Customer Table**: This include the details of the customers that have transacted with the business, it include details like; Age, Sex, Credit Score and Number of           years they have been transacting with the business.
   -  **Transaction Table**: It involve list and details of all transactions conducted with the business by the customers, it include number of products sales, Balance on           customer accounts and location of business.
   -  **Geography Table**: This is the list of all the location(Countries) where the business is operating.
    Each Column in the Parent table was matched to each table Using **INDEX**, **MATCH**, and **IF** Functions. The Details of the Extraction is Located in the [DM_Dataset](https://github.com/Kile-kun/Data-Migration/blob/main/DM%20Dataset.xlsx).
  
**Database Creation**: The Database for the project was initiated with the creation of an ENTITY RELATIONSHIP DIAGRAM which visualize the connection between the three tables(component of the database) extracted from the parent dataset. The ERD is attached [below](https://github.com/Kile-kun/Data-Migration/blob/main/DM%20ERD.png) ![alt text](https://github.com/Kile-kun/Data-Migration/blob/main/DM%20ERD.png). The Database DM_db was created an Primary Key and Foreign Key was assigned to deserving column of the different tables. The Database was created [here](https://github.com/Kile-kun/Data-Migration/blob/main/DM_db.sql)

**Data Loading**: The data was loaded into the new database using custom scripts that transformed and validated the data as it was loaded. The Database Loading was using the [INLINE](https://github.com/Kile-kun/Data-Migration/blob/main/DM_db.sql) Method.

**Data Analysis**: Insight from the data was generated to establish;
    - The frequency distribution of certain customer demography like age and gender 
    - Product purchase performance along the different demography,
    - Highlight Top customers based on certain conditions like volume of product purchased and Number of Years Patronizing the business
 The details of t
