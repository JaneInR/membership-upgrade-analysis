/*
================================================================
Membership Upgrade Analysis
File: 09_group_size_analysis.sql
Purpose: Summarize membership upgrade performance by group size.
================================================================
*/


WITH group_size_summary AS (

	-- Group Size Performance
	SELECT
		-- group by group size
		group_size,
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
	GROUP BY group_size

	UNION ALL
	
	-- Overall Performance
	SELECT
		'Overall' AS group_size,
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
    group_size,
    transactions,
    opportunities,
    accepted,
    declined,
    acceptance_rate,
	avg_basket_amount,
    avg_net_upgrade_cost

FROM group_size_summary

ORDER BY group_size;