/* Summary of Poland's results at the World Cup */
SELECT 
    wcm.year_match AS "year_tournament",
    COUNT(wcm.id) AS matches,
    /* Average number of points by Poland per match in the World Cup played in a given year */
    ROUND(
        AVG(
            CASE 
                WHEN wcm.home_team = 'Poland' AND wcm.home_goals > wcm.away_goals THEN 3
                WHEN wcm.away_team = 'Poland' AND wcm.away_goals > wcm.home_goals THEN 3
                WHEN wcm.home_team = 'Poland' AND wcm.home_goals = wcm.away_goals THEN 1
                WHEN wcm.away_team = 'Poland' AND wcm.away_goals = wcm.home_goals THEN 1
                ELSE 0 
            END
        ), 2
    ) AS avg_points,
    /* Average goals scored by Poland per game in the World Cup played in a given year */
    ROUND(
        AVG(
            CASE 
                WHEN wcm.home_team = 'Poland' THEN wcm.home_goals 
                WHEN wcm.away_team = 'Poland' THEN wcm.away_goals 
                ELSE 0 
            END
        ), 2
    ) AS avg_goals_scored,
    /* Average number of goals lost by Poland per match in the World Cup played in a given year */
    ROUND(
        AVG(
            CASE 
                WHEN wcm.home_team = 'Poland' THEN wcm.away_goals 
                WHEN wcm.away_team = 'Poland' THEN wcm.home_goals 
                ELSE 0 
            END
        ), 2
    ) AS avg_goals_lost,
    /*The phase of the tournament in which the last match at a given World Cup was played */
    MAX(wcm.stage) AS "last_match"
FROM world_cup_matches wcm
WHERE wcm.home_team = 'Poland' OR wcm.away_team = 'Poland'
GROUP BY wcm.year_match
/* Include results from the last World Cup */
UNION ALL
SELECT 
    wcm2.year_match AS "year_tournament",
    COUNT(wcm2.id) AS matches,
    ROUND(
        AVG(
            CASE 
                WHEN wcm2.home_team = 'Poland' AND wcm2.home_goals > wcm2.away_goals THEN 3
                WHEN wcm2.away_team = 'Poland' AND wcm2.away_goals > wcm2.home_goals THEN 3
                WHEN wcm2.home_team = 'Poland' AND wcm2.home_goals = wcm2.away_goals THEN 1
                WHEN wcm2.away_team = 'Poland' AND wcm2.away_goals = wcm2.home_goals THEN 1
                ELSE 0 
            END
        ), 2
    ) AS avg_points,
    ROUND(
        AVG(
            CASE 
                WHEN wcm2.home_team = 'Poland' THEN wcm2.home_goals 
                WHEN wcm2.away_team = 'Poland' THEN wcm2.away_goals 
                ELSE 0 
            END
        ), 2
    ) AS avg_goals_scored,
    ROUND(
        AVG(
            CASE 
                WHEN wcm2.home_team = 'Poland' THEN wcm2.away_goals 
                WHEN wcm2.away_team = 'Poland' THEN wcm2.home_goals 
                ELSE 0 
            END
        ), 2
    ) AS avg_goals_lost,
    MAX(wcm2.stage) AS "last_match"
FROM world_cup_matches_2022 wcm2
WHERE wcm2.home_team = 'Poland' OR wcm2.away_team = 'Poland'
GROUP BY wcm2.year_match
ORDER BY 3 DESC;

