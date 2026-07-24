/*
============================================================
Membership Upgrade Analysis
File: 05_monthly_analysis.sql
Purpose: Summarize membership upgrade performance by month.
============================================================
*/


WITH monthly_summary AS (

	SELECT
		-- group the date by month
		TO_CHAR(DATE_TRUNC('month', date),
			'Mon-YYYY'
		) AS month,
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

		-- Not presented
	    COUNT(*) FILTER (
	        WHERE sales_outcome = 'Not_Presented'
	    ) AS not_presented,
	
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
	
		-- Average Net Upgrade Cost
		ROUND(AVG(net_upgrade_cost),
			2
		) AS avg_net_upgrade_cost,
		
		EXTRACT(MONTH FROM date) 
		AS month_order
		
	FROM transactions
	GROUP BY 
		TO_CHAR(DATE_TRUNC('month', date), 'Mon-YYYY'),
	    EXTRACT(MONTH FROM date)

	UNION ALL
	
	-- Overall Performance
	SELECT
		'Overall' AS month,
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

		-- Not presented
	    COUNT(*) FILTER (
	        WHERE sales_outcome = 'Not_Presented'
	    ) AS not_presented,
	
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
	
		-- Average Net Upgrade Cost
		ROUND(AVG(net_upgrade_cost),
			2
		) AS avg_net_upgrade_cost,

		13 AS month_order
		
	FROM transactions
)

SELECT
    month,
    transactions,
    opportunities,
    accepted,
    declined,
	not_presented,
    acceptance_rate,
    avg_net_upgrade_cost

FROM monthly_summary

ORDER BY month_order;