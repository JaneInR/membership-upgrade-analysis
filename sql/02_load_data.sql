/*
============================================================
Membership Upgrade Analysis
File: 02_load_data.sql
Purpose: Load transaction data into the transactions table.
============================================================
*/


-- Import data from a CSV file.
COPY transactions
FROM 'C:/Membership_Project/Data/transactions_sql.csv'
DELIMITER ','
CSV HEADER;