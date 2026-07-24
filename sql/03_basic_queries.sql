/*
===================================================
Membership Upgrade Analysis
File: 02_basic_queries.sql
Purpose: Explore and validate the imported dataset.
===================================================
*/


-- Preview the first 10 records.
SELECT *
FROM transactions
LIMIT 10;


-- Count the total number of records.
SELECT COUNT(*)
FROM transactions;


-- Check the date range.
SELECT
    MIN(date),
    MAX(date)
FROM transactions;


-- Check the basket range.
SELECT
    MIN(basket_amount),
    MAX(basket_amount)
FROM transactions;


-- Check the upgrade fee range.
SELECT
    MIN(upgrade_fee),
    MAX(upgrade_fee)
FROM transactions;


-- Review promotion types.
SELECT DISTINCT promotion_type
FROM transactions;


-- Check the net upgrade cost range.
SELECT
    MIN(net_upgrade_cost),
    MAX(net_upgrade_cost)
FROM transactions;


-- Review age groups.
SELECT DISTINCT age_group
FROM transactions;


-- Review shopper types.
SELECT DISTINCT shopper_type
FROM transactions;


-- Review group sizes.
SELECT DISTINCT group_size
FROM transactions;



-- Review sales outcomes.
SELECT DISTINCT sales_outcome
FROM transactions;


-- Review refusal reasons.
SELECT DISTINCT refusal_reason
FROM transactions;


-- Review upgrade opportunities.
SELECT DISTINCT upgrade_opportunity
FROM transactions;
