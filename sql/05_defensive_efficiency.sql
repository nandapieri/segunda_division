-- Defensive stability analysis
-- Segunda División 2024/25 (regular season only)
-- Focus: goals conceded and defensive stability, not xG efficiency

SELECT
    team,
    COUNT(*) AS matches_played,

    -- Defensive output
    SUM(goals_against) AS goals_conceded,
    ROUND(AVG(goals_against), 2) AS goals_conceded_per_match,

    -- Context
    SUM(goals_for) AS goals_scored,
    SUM(goals_for) - SUM(goals_against) AS goal_difference,

    -- Points (for context, not ranking)
    SUM(
        CASE
            WHEN goals_for > goals_against THEN 3
            WHEN goals_for = goals_against THEN 1
            ELSE 0
        END
    ) AS points

FROM team_matches_regular
GROUP BY team
ORDER BY goals_conceded_per_match ASC;