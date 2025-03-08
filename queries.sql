--Showing users
SELECT * FROM "users"
ORDER BY "name";

--Showing team
SELECT * FROM  "participants"
ORDER BY "name";

--Showing user's teams
SELECT * FROM "teams_names";

--showing competitions and their creator
SELECT * FROM "competitions_view"
WHERE "name" LIKE 'Hackathon challenge';

--Showing the results of the competition named Hackathon challenge
SELECT * FROM "scoreboard"
WHERE "competition" LIKE 'Hackathon challenge';

--Showing each participant name with the code submitted for each problem with its judgement
SELECT * from "participants_submissions";

--showing the number of accepted submissions for each problem
SELECT * from "problems_view";

UPDATE competitions
SET starting_time = '2025-04-10 14:00:00'
WHERE name = 'Spring Challenge';

UPDATE participants_competitions
SET score = score + 10
WHERE participant_id = (SELECT id FROM participants WHERE name = 'TeamABC')
AND competition_id = (SELECT id FROM competitions WHERE name = 'Winter Code Fest');

DELETE FROM test_cases WHERE problem_id = (SELECT id FROM problems WHERE label='B');


