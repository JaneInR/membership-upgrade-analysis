/*
==================================================================
Membership Upgrade Analysis
File: 08_shopper_type_analysis.sql
Purpose: Summarize membership upgrade performance by shopper type.
==================================================================
*/


WITH shopper_type_summary AS (

	-- Shopper Type Performance
	SELECT
		-- group by shopper type
		shopper_type,
		COUNT(*) AS transactions,
	
		-- Opportunities
		COUNT(*) FILTER (
			WHERE sales_outcome IN ('Accepted', 'Declined')
		) AS opportunities,
	
		-- Accepted
		COUNT(*) FILTER (
			WHERE sales_outcome = 'Accepted'
		) AS accepted,
	
		-- Declined
		COUNT(*) FILTER (
			WHERE sales_outcome = 'Declined'
		) AS declined,
	
		-- Acceptance Rate
		ROUND(
			100.0 * COUNT(*) FILTER (
				WHERE sales_outcome = 'Accepted'
			)
			/ COUNT(*) FILTER (
					WHERE sales_outcome IN ('Accepted', 'Declined')
			),
			2
		) AS acceptance_rate,

		-- Average Basket Amount
		ROUND(
		    AVG(basket_amount),
		    2
		) AS avg_basket_amount,
		
		-- Average Net Upgrade Cost
		ROUND(AVG(net_upgrade_cost),
			2
		) AS avg_net_upgrade_cost
		
	FROM transactions
	GROUP BY shopper_type

	UNION ALL
	
	-- Overall Performance
	SELECT
		'Overall' AS shopper_type,
		COUNT(*) AS transactions,
	
		-- Opportunities
		COUNT(*) FILTER (
			WHERE sales_outcome IN ('Accepted', 'Declined')
		) AS opportunities,
	
		-- Accepted
		COUNT(*) FILTER (
			WHERE sales_outcome = 'Accepted'
		) AS accepted,
	
		-- Declined
		COUNT(*) FILTER (
			WHERE sales_outcome = 'Declined'
		) AS declined,
	
		-- Acceptance Rate
		ROUND(
			100.0 * COUNT(*) FILTER (
				WHERE sales_outcome = 'Accepted'
			)
			/ COUNT(*) FILTER (
					WHERE sales_outcome IN ('Accepted', 'Declined')
			),
			2
		) AS acceptance_rate,

		-- Average Basket Amount
		ROUND(
		    AVG(basket_amount),
		    2
		) AS avg_basket_amount,
		
		-- Average Net Upgrade Cost
		ROUND(AVG(net_upgrade_cost),
			2
		) AS avg_net_upgrade_cost
		
	FROM transactions
)

SELECT
    shopper_type,
    transactions,
    opportunities,
    accepted,
    declined,
    acceptance_rate,
	avg_basket_amount,
    avg_net_upgrade_cost

FROM shopper_type_summary

ORDER BY
    CASE
        WHEN shopper_type = 'Individual' THEN 1
        WHEN shopper_type = 'Couple' THEN 2
        WHEN shopper_type = 'Family' THEN 3
        WHEN shopper_type = 'Business' THEN 4
        WHEN shopper_type = 'Overall' THEN 5
    END;