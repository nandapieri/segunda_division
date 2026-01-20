-- Home vs Away: goals comparison (regular season only)

SELECT
    'Home' AS team_type,
    COUNT(*) AS matches,
    SUM(CAST(substr(score, 1, instr(score, '–') - 1) AS INTEGER)) AS goals,
    ROUND(
        AVG(CAST(substr(score, 1, instr(score, '–') - 1) AS INTEGER)),
    2) AS goals_per_match
FROM matches_regular_season

UNION ALL

SELECT
    'Away' AS team_type,
    COUNT(*) AS matches,
    SUM(CAST(substr(score, instr(score, '–') + 1) AS INTEGER)) AS goals,
    ROUND(
        AVG(CAST(substr(score, instr(score, '–') + 1) AS INTEGER)),
    2) AS goals_per_match
FROM matches_regular_season;

-- Match result distribution (regular season)

SELECT
    CASE
        WHEN CAST(substr(score, 1, instr(score, '–') - 1) AS INTEGER) >
             CAST(substr(score, instr(score, '–') + 1) AS INTEGER)
            THEN 'Home win'
        WHEN CAST(substr(score, 1, instr(score, '–') - 1) AS INTEGER) <
             CAST(substr(score, instr(score, '–') + 1) AS INTEGER)
            THEN 'Away win'
        ELSE 'Draw'
    END AS result,
    COUNT(*) AS matches,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM matches_regular_season),
    1) AS pct_matches
FROM matches_regular_season
GROUP BY result;