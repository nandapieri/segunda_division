-- Sanity checks for La Liga 2024/25 match dataset
-- Expected number of matches: 380

-- 1. Total number of matches
SELECT COUNT(*) AS total_matches
FROM matches;

-- 2. Check for NULLs in mandatory fields
SELECT
    COUNT(*) AS rows_with_missing_data
FROM matches
WHERE
    date IS NULL
    OR home_team IS NULL
    OR away_team IS NULL
    OR score IS NULL;

-- 3. Check score format consistency (should contain a dash)
SELECT
    COUNT(*) AS invalid_score_format
FROM matches
WHERE score NOT LIKE '%–%';

-- 4. Regular season: expected 462 matches
SELECT
    COUNT(*) AS regular_season_matches
FROM matches_regular_season;

-- 5. Playoffs: expected 6 matches
SELECT
    COUNT(*) AS playoff_matches
FROM matches_playoffs;

-- 6. Regular season: expected 924 team-match rows
SELECT
    COUNT(*) AS regular_season_team_rows
FROM team_matches_regular;

-- 7. Playoffs: expected 12 team-match rows
SELECT
    COUNT(*) AS playoff_team_rows
FROM team_matches_playoffs;

-- 8. Expected: 22 teams
SELECT
    COUNT(DISTINCT team) AS number_of_teams
FROM team_matches_regular;

-- 9. Expected: 42 matches per team
SELECT
    team,
    COUNT(*) AS matches_played
FROM team_matches_regular
GROUP BY team
ORDER BY matches_played DESC;

-- 10. Regular base without playoofs
SELECT
    COUNT(*) AS playoff_rows_in_regular
FROM team_matches_regular
WHERE date >= (
    SELECT MIN(date) FROM matches_playoffs
);
