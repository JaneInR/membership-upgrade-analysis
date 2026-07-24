/*
====================================================================
Membership Upgrade Analysis
File: 06_promotion_analysis.sql
Purpose: Summarize membership upgrade performance by promotion type.
====================================================================
*/


WITH promotion_summary AS (

	-- Promotion Performance
	SELECT
		-- group by promotion type
		promotion_type,
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

        -- Eligible Transaction
        COUNT(*) FILTER (
            WHERE promotion_eligible = 'Yes'
        ) AS eligible_transaction,
	
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
		) AS avg_net_upgrade_cost
		
	FROM transactions
	GROUP BY promotion_type

	UNION ALL
	
	-- Overall Performance
	SELECT
		'Overall' AS promotion_type,
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

        -- Eligible Transaction
        COUNT(*) FILTER (
            WHERE promotion_eligible = 'Yes'
        ) AS eligible_transaction,
	
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
		) AS avg_net_upgrade_cost
		
	FROM transactions
)

SELECT
    promotion_type,
    transactions,
    opportunities,
    accepted,
    declined,
	eligible_transaction,
    acceptance_rate,
    avg_net_upgrade_cost

FROM promotion_summary

ORDER BY
    CASE
        WHEN promotion_type = 'No_Promotion' THEN 1
        WHEN promotion_type = 'Spend20_Save10' THEN 2
        WHEN promotion_type = 'Spend40_Save20' THEN 3
        WHEN promotion_type = 'Overall' THEN 4
    END;