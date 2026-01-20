-- Team-level performance overview
-- Segunda División 2024/25 (regular season only)

SELECT
    team,

    -- Volume (sanity)
    COUNT(*) AS matches_played,

    -- Goals
    SUM(goals_for) AS goals_for,
    SUM(goals_against) AS goals_against,
    SUM(goals_for) - SUM(goals_against) AS goal_difference,

    -- Points
    SUM(
        CASE
            WHEN goals_for > goals_against THEN 3
            WHEN goals_for = goals_against THEN 1
            ELSE 0
        END
    ) AS points,

    ROUND(
        1.0 * SUM(
            CASE
                WHEN goals_for > goals_against THEN 3
                WHEN goals_for = goals_against THEN 1
                ELSE 0
            END
        ) / COUNT(*),
    2) AS points_per_match,

    -- Home vs Away (points)
    SUM(
        CASE
            WHEN venue_side = 'home' AND goals_for > goals_against THEN 3
            WHEN venue_side = 'home' AND goals_for = goals_against THEN 1
            ELSE 0
        END
    ) AS points_home,

    SUM(
        CASE
            WHEN venue_side = 'away' AND goals_for > goals_against THEN 3
            WHEN venue_side = 'away' AND goals_for = goals_against THEN 1
            ELSE 0
        END
    ) AS points_away

FROM team_matches_regular
GROUP BY team
ORDER BY points DESC;