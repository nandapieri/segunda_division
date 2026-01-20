-- Outcome efficiency outliers
-- Segunda División 2024/25 (regular season only)

WITH team_base AS (
    SELECT
        team,
        COUNT(*) AS matches,
        SUM(goals_for) AS goals_for,
        SUM(goals_against) AS goals_against,
        SUM(goals_for - goals_against) AS goal_diff,

        SUM(
            CASE
                WHEN goals_for > goals_against THEN 3
                WHEN goals_for = goals_against THEN 1
                ELSE 0
            END
        ) AS points
    FROM team_matches_regular
    GROUP BY team
),

team_rates AS (
    SELECT
        team,
        matches,
        goals_for,
        goals_against,
        goal_diff,
        points,
        ROUND(1.0 * goal_diff / matches, 2) AS gd_per_match,
        ROUND(1.0 * points / matches, 2) AS ppg
    FROM team_base
)

SELECT
    team,
    matches,
    goal_diff,
    gd_per_match,
    points,
    ppg,

    -- Outcome efficiency delta
    ROUND(ppg - gd_per_match, 2) AS outcome_efficiency_delta

FROM team_rates
ORDER BY ppg DESC;