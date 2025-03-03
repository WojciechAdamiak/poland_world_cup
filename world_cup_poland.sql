select * from world_cup_matches wcm where home_team ="Poland" or away_team ="Poland"
union
select * from world_cup_matches_2022 wcm2 where home_team ="Poland" or away_team ="Poland"

select * from world_cup_matches_2022 wcg where home_team ="Poland" or away_team ="Poland"

select 
	sum(home_goals),
	sum(away_goals),
	avg(home_goals),
	avg(away_goals)
from world_cup_matches_2022 wcg where home_team ="Poland" or away_team ="Poland"

SELECT 
    AVG(CASE 
            WHEN home_team = 'Poland' THEN home_goals 
            WHEN away_team = 'Poland' THEN away_goals 
            ELSE 0 
        END) as avg_goals_scored_by_poland_per_match
FROM world_cup_matches_2022 
WHERE home_team = 'Poland' OR away_team = 'Poland';

SELECT 
    AVG(CASE 
            WHEN home_team = 'Poland' THEN away_goals 
            WHEN away_team = 'Poland' THEN home_goals 
            ELSE 0 
        END) as avg_goals_lost_by_poland_per_match
FROM world_cup_matches_2022 
WHERE home_team = 'Poland' OR away_team = 'Poland';

SELECT 
    AVG(CASE 
            WHEN home_team = 'Poland' THEN home_goals 
            WHEN away_team = 'Poland' THEN away_goals 
            ELSE 0 
        END) as avg_goals_scored_by_poland_per_match
FROM world_cup_matches 
WHERE home_team = 'Poland' OR away_team = 'Poland';

SELECT 
    AVG(CASE 
            WHEN home_team = 'Poland' THEN away_goals 
            WHEN away_team = 'Poland' THEN home_goals 
            ELSE 0 
        END) as avg_goals_lost_by_poland_per_match
FROM world_cup_matches
WHERE home_team = 'Poland' OR away_team = 'Poland';

SELECT 
	ROUND(
	    AVG(
	    	CASE 
	            WHEN home_team = 'Poland' and home_goals > away_goals THEN 3
	            WHEN away_team = 'Poland' and away_goals > home_goals THEN 3
	            WHEN home_team = 'Poland' and home_goals = away_goals THEN 1
	            WHEN away_team = 'Poland' and away_goals = home_goals THEN 1
	            WHEN home_team = 'Poland' and home_goals < away_goals THEN 0
	            WHEN away_team = 'Poland' and away_goals < home_goals THEN 0
	            ELSE 0 
	        END
		), 2
	) AS avg_points_per_match
FROM world_cup_matches 
WHERE home_team = 'Poland' OR away_team = 'Poland';

SELECT 
    year_match,
    COUNT(id) AS matches
FROM world_cup_matches wcm 
WHERE home_team = 'Poland' OR away_team = 'Poland'
GROUP BY 
year_match;

SELECT 
    wcm.year_match,
    COUNT(wcm.id) AS matches,
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
    ) AS avg_points_per_match,
    ROUND(
        AVG(
            CASE 
                WHEN home_team = 'Poland' THEN home_goals 
                WHEN away_team = 'Poland' THEN away_goals 
                ELSE 0 
            END
        ), 2
    ) AS avg_goals_scored_by_poland_per_match,
    ROUND(
        AVG(
            CASE 
                WHEN home_team = 'Poland' THEN away_goals 
                WHEN away_team = 'Poland' THEN home_goals 
                ELSE 0 
            END
        ), 2
    ) AS avg_goals_lost_by_poland_per_match,
    max(stage) as "Last match"
FROM world_cup_matches wcm
WHERE wcm.home_team = 'Poland' OR wcm.away_team = 'Poland'
GROUP BY wcm.year_match
ORDER BY matches desc


