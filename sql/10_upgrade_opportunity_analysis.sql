/*
=======================================================================
Membership Upgrade Analysis
File: 10_opportunity_analysis.sql
Purpose: Summarize membership upgrade performance by opportunity level.
=======================================================================
*/

WITH upgrade_opportunity_summary AS (

	-- Upgrade Opportunity Performance
	SELECT
		-- Group by Upgrade Opportunity
		upgrade_opportunity,
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
	GROUP BY upgrade_opportunity

	UNION ALL
	
	-- Overall Performance
	SELECT
		'Overall' AS upgrade_opportunity,
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
    upgrade_opportunity,
    transactions,
    opportunities,
    accepted,
    declined,
    acceptance_rate,
	avg_basket_amount,
    avg_net_upgrade_cost

FROM upgrade_opportunity_summary

ORDER BY 
	CASE
		WHEN upgrade_opportunity = 'High' THEN 1
		WHEN upgrade_opportunity = 'Medium' THEN 2
		WHEN upgrade_opportunity = 'Low' THEN 3
		WHEN upgrade_opportunity = 'Overall' THEN 4
	END;