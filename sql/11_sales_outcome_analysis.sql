/*
======================================================
Membership Upgrade Analysis
File: 11_sales_outcome_analysis.sql
Purpose: Summarize the distribution of sales outcomes.
======================================================
*/


WITH sales_outcome_summary AS (

    -- Sales Outcome Summary
    SELECT
        sales_outcome,
        COUNT(*) AS count,

        ROUND(100.0 * COUNT(*)
            / (SELECT COUNT(*) FROM transactions),
            2
        ) AS percentage

    FROM transactions
    GROUP BY sales_outcome

    UNION ALL

    -- Overall
    SELECT
        'Overall' AS sales_outcome,
        COUNT(*) AS count,
        100.00 AS percentage

    FROM transactions
)

SELECT
    sales_outcome,
    count,
    percentage

FROM sales_outcome_summary

ORDER BY
    CASE
        WHEN sales_outcome = 'Accepted' THEN 1
        WHEN sales_outcome = 'Declined' THEN 2
        WHEN sales_outcome = 'Not_Presented' THEN 3
        WHEN sales_outcome = 'Overall' THEN 4
    END;