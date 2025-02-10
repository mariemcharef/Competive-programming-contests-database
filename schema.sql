--table users

CREATE TABLE IF NOT EXISTS
    "submitters" (
        "id" INTEGER,
        "name" TEXT NOT NULL UNIQUE,
        "type" TEXT NOT NULL CHECK ("type" in ("user","team")) ,
        PRIMARY KEY ("id")
    );
CREATE TABLE IF NOT EXISTS
    "users" (
        "id" INTEGER PRIMARY KEY,  -- Ensure ID is primary key
        "name" TEXT NOT NULL UNIQUE,
        "mail" TEXT NOT NULL UNIQUE,
        "password" TEXT NOT NULL,
        "rating" INTEGER DEFAULT 0,
        FOREIGN KEY ("id") REFERENCES "submitters" ("id") ON DELETE CASCADE
    );

CREATE TABLE IF NOT EXISTS
    "teams" (
        "id" INTEGER PRIMARY KEY,  -- Ensure ID is primary key
        "name" TEXT NOT NULL UNIQUE,
        "users" INTEGER DEFAULT 2 CHECK ("users" IN (2, 3)),
        FOREIGN KEY ("id") REFERENCES "submitters" ("id") ON DELETE CASCADE
    );

    -- to enumerate team members
CREATE TABLE IF NOT EXISTS
    "user_teams" (
        "user_id" INTEGER,
        "team_id" INTEGER,
        PRIMARY KEY ("user_id", "team_id"),
        FOREIGN KEY ("user_id") REFERENCES "users" ("id")ON DELETE  CASCADE,
        FOREIGN KEY ("team_id") REFERENCES "teams" ("id")ON DELETE  CASCADE
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
--table teams competitions to specify the team participation in a competition
CREATE TABLE IF NOT EXISTS
    "submitters_competitions" (
        "competition_id" INTEGER,
        "submitter_id" INTEGER ,
        "score" INTEGER DEFAULT "0",
        "rank" INTEGER,
        PRIMARY KEY ("competition_id", "submitter_id"),
        FOREIGN KEY ("competition_id") REFERENCES "competitions" ("id"),
        FOREIGN KEY ("submitter_id") REFERENCES "submitters" ("id")
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
        "submitter_id" INTEGER,
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
        FOREIGN KEY ("submitter_id") REFERENCES "submitters" ("id")ON DELETE  CASCADE,
        FOREIGN KEY ("problem_id") REFERENCES "problems" ("id")ON DELETE  CASCADE
    );
--table clarifications
CREATE TABLE IF NOT EXISTS
    "clarifications" (
        "id" INTEGER,
        "submitter_id" INTEGER,
        "problem_id" INTEGER,
        "content" TEXT NOT NULL,
        PRIMARY KEY ("id"),
        FOREIGN KEY ("problem_id") REFERENCES "problems" ("id")ON DELETE  CASCADE,
        FOREIGN KEY ("submitter_id") REFERENCES "submitters" ("id")ON DELETE  CASCADE
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
        "topic_id" TEXT NOT NULL UNIQUE,
        PRIMARY KEY ("problem_id", "topic_id"),
        FOREIGN KEY ("problem_id") REFERENCES "problems" ("id")ON DELETE  CASCADE,
        FOREIGN KEY ("topic_id") REFERENCES "topics" ("id")
    );

--index to facilitate search of users
CREATE INDEX IF NOT EXISTS "user_name_search" ON "users" ("username");
--index to facilitate search of teams
CREATE INDEX IF NOT EXISTS "team_name_search" ON "teams" ("team_name");
--index to facilitate search of problems
CREATE INDEX  IF NOT EXISTS "problem_name_search" ON "problems" ("name");
--view competitions results
CREATE VIEW IF NOT EXISTS
    "scoreboard" AS
SELECT
    "competitions"."name" AS "competition",
    "submitters"."submitter_name" AS "submitter",
    "submitters_competitions"."rank" AS "rank"
FROM
    "submitters_competitions"
    JOIN "submitters" ON "submitters_competitions"."submitter_id" = "submitters"."id"
    JOIN "competitions" ON "competitions"."id" = "submitters_competitions"."competition_id"
ORDER BY
    "rank" ;

--view all team and users submitions
CREATE VIEW IF NOT EXISTS
"submitters_submissions" AS
SELECT
    "submitters"."submitter_name",
    "submissions"."code",
    "problems"."id",
    "submissions"."judgments"
FROM
    "submitters"
JOIN "submissions" ON "submissions"."submitter_id" = "submitters"."id";

--view all user's teams
CREATE VIEW IF NOT EXISTS
"users_teams_names" AS
SELECT
    "users"."name" AS 'user' , "teams"."name" AS 'team'
    FROM "users" JOIN "user_teams" ON "users"."id" = "user_teams"."user_id"
    JOIN "teams" ON "teams"."id" = "user_teams"."team_id";

--create view to see all the competitions name and the submitters that participated
CREATE VIEW IF NOT EXISTS
"participants" AS
SELECT
    "competitions"."name" AS 'competition',"submitters"."name" AS 'participant', "type","rank", "score"
    FROM "competitions"
    JOIN "submitters_competitions" ON "submitters_competitions"."competition_id" = "competitions"."id"
    JOIN "submitters" ON "submitters"."id" = "submitters_competitions"."submitter_id";
-- to evitate code duplications in the database
-- to check a duplication we must insure that the code is the submitted at least twice from the same team for the same problem
-- (in certain conditions we can have different teams that submit same code for same problem or same code submitted for different problem)
CREATE TRIGGER IF NOT EXISTS "no_code_duplication"
BEFORE INSERT ON submissions
FOR EACH ROW
WHEN EXISTS (
    SELECT 1 FROM submissions
    WHERE submitter_id = NEW.submitter_id
    AND problem_id = NEW.problem_id
    AND code = NEW.code
)
BEGIN
     SELECT RAISE(ABORT, 'YOU CANNOT SUBMIT THE SAME SOLUTION TWICE');
END;

CREATE TRIGGER IF NOT EXISTS "auto_insertion_user_submitter"
BEFORE INSERT ON "users"
BEGIN
    INSERT INTO "submitters"("id","name","type")
    VALUES
    (NEW.id, NEW.name,'user');
END;

CREATE TRIGGER IF NOT EXISTS "auto_insertion_team_submitter"
BEFORE INSERT ON "teams"
BEGIN
    INSERT INTO "submitters"("id","name","type")
    VALUES
    (NEW.id, NEW.name,'team');
END;




--.read schema.sql
