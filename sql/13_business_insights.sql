/*
============================================================================
Membership Upgrade Analysis
File: 13_business_insights.sql
Purpose: Identify key business insights from membership upgrade performance.
============================================================================
*/


-- Business Question 1:
-- Which month has the highest acceptance rate?

SELECT
    TO_CHAR(
        DATE_TRUNC('month', date),
        'Mon-YYYY'
    ) AS month,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE sales_outcome = 'Accepted'
        )
        /
		COUNT(*) FILTER (
			WHERE sales_outcome IN ('Accepted', 'Declined')
        	),
        	2
    ) AS acceptance_rate

FROM transactions
GROUP BY DATE_TRUNC('month', date)
ORDER BY acceptance_rate DESC
LIMIT 1;


-- Business Question 2:
-- Which promotion type has the highest acceptance rate?

SELECT
    promotion_type,
    ROUND(100.0 * COUNT(*) FILTER (
            WHERE sales_outcome = 'Accepted'
			)
        / 
		COUNT(*) FILTER (
			WHERE sales_outcome IN ('Accepted', 'Declined')
			),
			2
    ) AS acceptance_rate

FROM transactions
GROUP BY promotion_type
ORDER BY acceptance_rate DESC
LIMIT 1;



-- Business Question 3:
-- Which shopper type is most likely to upgrade?

SELECT
    shopper_type,
    COUNT(*) FILTER (
        WHERE sales_outcome = 'Accepted'
    ) AS accepted,

    ROUND(
        100.0 * COUNT(*) FILTER (
			WHERE sales_outcome = 'Accepted'
        )
        /
		COUNT(*) FILTER (
			WHERE sales_outcome IN ('Accepted', 'Declined')
            ),
        2
    ) AS acceptance_rate

FROM transactions
GROUP BY shopper_type
ORDER BY acceptance_rate DESC
LIMIT 1;


-- Business Question 4:
-- What are the top 3 refusal reasons?

SELECT
    refusal_reason,
    COUNT(*) AS declined_count,
    ROUND(
        100.0 * COUNT(*)
        /
        (
			SELECT COUNT(*)
        	FROM transactions
        	WHERE sales_outcome = 'Declined'
        ),
        2
    ) AS percentage_of_declined

FROM transactions
WHERE sales_outcome = 'Declined'
GROUP BY refusal_reason
ORDER BY declined_count DESC
LIMIT 3;


-- Business Question 5:
-- Does the "opportunity score system" effectively identify high-potential members?

SELECT
    upgrade_opportunity,
    COUNT(*) AS transactions,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE sales_outcome = 'Accepted'
        )
        /
		COUNT(*) FILTER (
			WHERE sales_outcome IN ('Accepted', 'Declined')
            ),
			2
    ) AS acceptance_rate,

    ROUND(AVG(basket_amount),
        2
    ) AS avg_basket_amount,

    ROUND(AVG(net_upgrade_cost),
        2
    ) AS avg_net_upgrade_cost

FROM transactions
GROUP BY upgrade_opportunity
ORDER BY
    CASE
        WHEN upgrade_opportunity = 'High' THEN 1
        WHEN upgrade_opportunity = 'Medium' THEN 2
        WHEN upgrade_opportunity = 'Low' THEN 3
    END;