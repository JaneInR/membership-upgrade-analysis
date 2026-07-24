/*
===============================================================
Membership Upgrade Analysis
File: 07_age_group_analysis.sql
Purpose: Summarize membership upgrade performance by age group.
===============================================================
*/


WITH age_group_summary AS (

	-- Age Group Performance
	SELECT
		-- group by age group
		age_group,
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
	GROUP BY age_group

	UNION ALL
	
	-- Overall Performance
	SELECT
		'Overall' AS age_group,
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
    age_group,
    transactions,
    opportunities,
    accepted,
    declined,
    acceptance_rate,
	avg_basket_amount,
    avg_net_upgrade_cost

FROM age_group_summary

ORDER BY age_group;