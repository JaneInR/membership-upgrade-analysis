/*
===========================================
Membership Upgrade Analysis
File: 01_create_table.sql
Purpose: Create the transaction_sql table.
===========================================
*/


DROP TABLE IF EXISTS transactions;

CREATE TABLE transactions (
    date DATE,
    basket_amount NUMERIC,
    upgrade_fee NUMERIC,
    promotion_type CHARACTER VARYING,
    promotion_eligible CHARACTER VARYING,
    net_upgrade_cost NUMERIC,
    age_group CHARACTER VARYING,
    shopper_type CHARACTER VARYING,
    group_size CHARACTER VARYING,
    sales_outcome CHARACTER VARYING,
    refusal_reason CHARACTER VARYING,
    upgrade_opportunity CHARACTER VARYING);