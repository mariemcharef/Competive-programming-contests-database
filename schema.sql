--table users


CREATE TABLE IF NOT EXISTS
    "users" (
        "id" INTEGER PRIMARY KEY,  -- Ensure ID is primary key
        "name" TEXT NOT NULL UNIQUE,
        "mail" TEXT NOT NULL UNIQUE,
        "password" TEXT NOT NULL,
        "rating" INTEGER DEFAULT 0
    );

CREATE TABLE IF NOT EXISTS
    "participants" (--paricipant (one user) or a team (more than one)
        "id" INTEGER PRIMARY KEY,  -- Ensure ID is primary key
        "name" TEXT NOT NULL UNIQUE,
        "users" INTEGER DEFAULT 1 CHECK ("users" IN (1,2, 3))--number of users
    );

    -- to enumerate participant members
CREATE TABLE IF NOT EXISTS
    "user_participants" (
        "user_id" INTEGER,
        "participant_id" INTEGER,
        PRIMARY KEY ("user_id", "participant_id"),
        FOREIGN KEY ("user_id") REFERENCES "users" ("id")ON DELETE  CASCADE,
        FOREIGN KEY ("participant_id") REFERENCES "participants" ("id")ON DELETE  CASCADE
    );
--table competitions
CREATE TABLE IF NOT EXISTS
    "competitions" (
        "id" INTEGER,
        "creator_id" INTEGER NOT NULL,
        "name" TEXT NOT NULL,
        "duration" NUMERIC NOT NULL,--in minutes
        "starting_time" NUMERIC,
        "ending_time" NUMERIC,
        "penalty_time" INTEGER NOT NULL DEFAULT 20,
        PRIMARY KEY ("id"),
        FOREIGN KEY ("creator_id") REFERENCES "users" ("id")
    );
--table participants competitions to specify the participant participation in a competition
CREATE TABLE IF NOT EXISTS--many to many relationship
    "participants_competitions" (
        "competition_id" INTEGER,
        "participant_id" INTEGER ,
        "score" INTEGER DEFAULT "0",
        "rank" INTEGER,
        PRIMARY KEY ("competition_id", "participant_id"),
        FOREIGN KEY ("competition_id") REFERENCES "competitions" ("id"),
        FOREIGN KEY ("participant_id") REFERENCES "participants" ("id")
    );
--table problems
CREATE TABLE IF NOT EXISTS
    "problems" (
        "id" INTEGER,
        "competition_id" INTEGER NOT NULL,
        "label" TEXT NOT NULL,
        "name" TEXT NOT NULL,
        "time_limit" NUMERIC NOT NULL,
        "memory_limit" INTEGER NOT NULL,
        "content" TEXT NOT NULL,
        "rating" NUMERIC,
        PRIMARY KEY ("id"),
        FOREIGN KEY ("competition_id") REFERENCES "competitions" ("id") ON DELETE  CASCADE
    );
--table test_cases
CREATE TABLE IF NOT EXISTS
    "test_cases" (
        "id" INTEGER,
        "problem_id" INTEGER NOT NULL,
        "input" TEXT NOT NULL,
        "output" TEXT NOT NULL,
        "explanation" TEXT,
        "hidden" INTEGER DEFAULT 1 NOT NULL CHECK(hidden in(0,1)),
        PRIMARY KEY ("id"),
        FOREIGN KEY ("problem_id") REFERENCES "problems" ("id")ON DELETE  CASCADE
    );
--table topics
CREATE TABLE IF NOT EXISTS
    "topics" (
        "id" INTEGER,
        "name" TEXT NOT NULL,
        PRIMARY KEY ("id")
    );
--table submissions
CREATE TABLE IF NOT EXISTS
    "submissions" (
        "id" INTEGER,
        "participant_id" INTEGER,
        "problem_id" INTEGER,
        "time" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
        "language" TEXT NOT NULL CHECK (
            "language" IN (
                'ada',
                'c',
                'cpp',
                'csharp',
                'go',
                'haskell',
                'java',
                'javascript',
                'kotlin',
                'objectivec',
                'pascal',
                'php',
                'prolog',
                'python2',
                'python3',
                'ruby',
                'rust',
                'scala'
            )
        ),
        "judgement" TEXT CHECK (
            "judgement" IN (
                'in_queue',
                'accepted',
                'wrong_answer',
                'time_limit_exceeded',
                'memory_limit_exceeded',
                'compilation_error'
            )
        ) DEFAULT 'in_queue',
        "code" TEXT NOT NULL,
        PRIMARY KEY ("id"),
        FOREIGN KEY ("participant_id") REFERENCES "participants" ("id")ON DELETE  CASCADE,
        FOREIGN KEY ("problem_id") REFERENCES "problems" ("id")ON DELETE  CASCADE
    );
--table clarifications
CREATE TABLE IF NOT EXISTS
    "clarifications" (
        "id" INTEGER,
        "participant_id" INTEGER,
        "problem_id" INTEGER,
        "content" TEXT NOT NULL,
        PRIMARY KEY ("id"),
        FOREIGN KEY ("problem_id") REFERENCES "problems" ("id")ON DELETE  CASCADE,
        FOREIGN KEY ("participant_id") REFERENCES "participants" ("id")ON DELETE  CASCADE
    );
--table announcements
CREATE TABLE IF NOT EXISTS
    "announcements" (
        "id" INTEGER,
        "competition_id" INTEGER,
        "content" TEXT NOT NULL,
        PRIMARY KEY ("id"),
        FOREIGN KEY ("competition_id") REFERENCES "competitions" ("id")ON DELETE  CASCADE
    );

-- table problem topics , to describe topics associated to a problem
CREATE TABLE IF NOT EXISTS
    "problems_topics" (
        "problem_id" INTEGER,
        "topic_id" INTEGER,
        PRIMARY KEY ("problem_id", "topic_id"),
        FOREIGN KEY ("problem_id") REFERENCES "problems" ("id")ON DELETE  CASCADE,
        FOREIGN KEY ("topic_id") REFERENCES "topics" ("id")
    );

--index to facilitate search of users
CREATE INDEX IF NOT EXISTS "user_name_search" ON "users" ("name");
--index to facilitate search of participants
CREATE INDEX IF NOT EXISTS "participant_name_search" ON "participants" ("name");
--index to facilitate search of problems
CREATE INDEX  IF NOT EXISTS "problem_name_search" ON "problems" ("name");


--view competitions results
CREATE VIEW IF NOT EXISTS
    "scoreboard" AS
SELECT
    "competitions"."name" AS "competition",
    "participants"."name" AS "participant",
    "participants_competitions"."rank" AS "rank",
    "participants_competitions"."score" AS "score"
FROM
    "participants_competitions"
    JOIN "participants" ON "participants_competitions"."participant_id" = "participants"."id"
    JOIN "competitions" ON "competitions"."id" = "participants_competitions"."competition_id"
ORDER BY
    "rank" ;

--view all participants submitions
CREATE VIEW IF NOT EXISTS
"participants_submissions" AS
SELECT
    "participants"."name",
    "competitions"."name" AS 'competition',
    "problems"."name"AS "problem",
    "submissions"."code" AS 'code',
    "submissions"."judgement" AS'judgement'
FROM
    "participants"
    JOIN "submissions" ON "submissions"."participant_id" = "participants"."id"
    JOIN "problems" ON "problems"."id" = "submissions"."problem_id"
    JOIN "competitions" ON "competitions"."id" = "problems"."competition_id";

--view all user's teams(if participant consists of more than one user it becomes a team)
CREATE VIEW IF NOT EXISTS
"teams_names" AS
SELECT
    "users"."name" AS 'user' , "participants"."name" AS 'team'
    FROM "users" JOIN "user_participants" ON "users"."id" = "user_participants"."user_id"
    JOIN "participants" ON "participants"."id" = "user_participants"."participant_id"
WHERE "participants"."users">1;

-- to evitate code duplications in the database
-- to check a duplication we must insure that the code is the submitted at least twice from the same participant for the same problem
-- (in certain conditions we can have different participants that submit same code for same problem or same code submitted for different problem)
CREATE TRIGGER IF NOT EXISTS "no_code_duplication"
BEFORE INSERT ON submissions
FOR EACH ROW
WHEN EXISTS (
    SELECT 1 FROM submissions
    WHERE participant_id = NEW.participant_id
    AND problem_id = NEW.problem_id
    AND code = NEW.code
)
BEGIN
     SELECT RAISE(ABORT, 'YOU CANNOT SUBMIT THE SAME SOLUTION TWICE');
END;

--View to observe the creators of each competition
CREATE VIEW IF NOT EXISTS
"competitions_view" AS
SELECT "competitions"."name","duration", "starting_time", "ending_time", "penalty_time" , "users"."name" AS 'creator'
FROM "competitions" JOIN "users" ON "competitions"."creator_id" = "users"."id";

--View to visualise the problems names and their topics names
CREATE VIEW IF NOT EXISTS
"problems_topics_view" AS
SELECT "problems"."name" AS 'problem', "topics"."name" AS 'topic'
FROM "problems"
JOIN "problems_topics" ON "problems_topics"."problem_id" = "problems"."id"
JOIN "topics" ON "topics"."id"  = "problems_topics"."topic_id";
--problems how they are disbled to the user
CREATE VIEW IF NOT EXISTS "problems_view" AS
SELECT
    "problems"."label" AS "#",
    "problems"."name" AS "name",
    (SELECT COUNT(*)
     FROM "submissions"
     WHERE "submissions"."problem_id" = "problems"."id"
     AND "submissions"."judgement" = 'accepted'
    ) AS "solved by"
FROM "problems"
ORDER BY "problems"."label";


