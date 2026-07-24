/*
===========================================================
Membership Upgrade Analysis
File: 12_refusal_reason_analysis.sql
Purpose: Summarize refusal reasons among declined upgrades.
===========================================================
*/


WITH refusal_reason_summary AS (

    -- Refusal Reason Summary
    SELECT
        refusal_reason,
        COUNT(*) AS count,

        ROUND(100.0 * COUNT(*)
            /
			(SELECT COUNT(*)
                FROM transactions
                WHERE sales_outcome = 'Declined'
            ),
            2
        ) AS percentage_of_declined

    FROM transactions
    WHERE sales_outcome = 'Declined'
    GROUP BY refusal_reason

    UNION ALL

    -- Overall Declined
    SELECT
        'Overall' AS refusal_reason,
        COUNT(*) AS count,
        100.00 AS percentage_of_declined

    FROM transactions
    WHERE sales_outcome = 'Declined'
)

SELECT
    refusal_reason,
    count,
    percentage_of_declined

FROM refusal_reason_summary

ORDER BY
    CASE
        WHEN refusal_reason = 'Basket Below Promotion Threshold' THEN 1
        WHEN refusal_reason = 'Infrequent Shopper' THEN 2
        WHEN refusal_reason = 'Price Concern' THEN 3
        WHEN refusal_reason = 'Not Account Owner' THEN 4
        WHEN refusal_reason = 'Language Barrier' THEN 5
        WHEN refusal_reason = 'Lack of Premium Knowledge' THEN 6
        WHEN refusal_reason = 'Doesn''t Want Renewal Fee' THEN 7
        WHEN refusal_reason = 'Other' THEN 8
        WHEN refusal_reason = 'Overall' THEN 9
    END;