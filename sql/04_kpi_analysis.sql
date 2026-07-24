/*
=============================================================================
Membership Upgrade Analysis
File: 03_kpi_analysis.sql
Purpose: Generate the overall KPI summary for membership upgrade performance.
=============================================================================
*/


-- Calculate the overall KPI summary:

SELECT

    -- Transactions
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
    ) AS avg_net_upgrade_cost

FROM transactions;