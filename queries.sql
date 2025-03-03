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
--showing ho
SELECT * from "problems_view";
