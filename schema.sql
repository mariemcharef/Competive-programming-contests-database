CREATE TABLE
    "users" (
        "id" INTEGER,
        "username" TEXT NOT NULL UNIQUE,
        "mail" TEXT NOT NULL UNIQUE,
        "password" TEXT NOT NULL,
        "rating" INTEGER DEFAULT 0,
        PRIMARY KEY ("id")
    );

CREATE TABLE
    "teams" (
        "id" INTEGER,
        "team_name" TEXT NOT NULL UNIQUE,
        "users" INTEGER DEFAULT 1 CHECK ("users" IN (1, 2, 3)),
        PRIMARY KEY ("id")
    );

CREATE TABLE
    "competitions" (
        "id" INTEGER,
        "creator_id" INTEGER NOT NULL,
        "name" TEXT NOT NULL,
        "duration" NUMERIC NOT NULL,
        "starting_time" NUMERIC,
        "ending_time" NUMERIC,
        "scoreboard_type" TEXT NOT NULL CHECK ("scoreboard_type" IN ("pass_fail", "score")) DEFAULT "pass_fail",
        "penalty_time" INTEGER NOT NULL DEFAULT 20,
        PRIMARY KEY ("id"),
        FOREIGN KEY ("creator_id") REFERENCES "users" ("id")
    );

CREATE TABLE
    "problems" (
        "id" INTEGER,
        "competition_id" INTEGER NOT NULL,
        "label" TEXT NOT NULL,
        "name" TEXT NOT NULL,
        "ordinal" INTEGER NOT NULL,
        "time_limit" NUMERIC NOT NULL,
        "test_data_count" INTEGER NOT NULL,
        "content" TEXT NOT NULL,
        PRIMARY KEY ("id"),
        FOREIGN KEY ("competition_id") REFERENCES "competitions" ("id")
    );

CREATE TABLE
    "test_cases" (
        "id" INTEGER,
        "problem_id" INTEGER NOT NULL,
        "duration" NUMERIC NOT NULL,
        "input" TEXT NOT NULL,
        "output" TEXT NOT NULL,
        "explanation" TEXT,
        PRIMARY KEY ("id"),
        FOREIGN KEY ("problem_id") REFERENCES "problems" ("id")
    );

CREATE TABLE
    "topics" (
        "id" INTEGER,
        "name" TEXT NOT NULL,
        PRIMARY KEY ("id")
    );

CREATE TABLE
    "submissions" (
        "id" INTEGER,
        "team_id" INTEGER,
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
        FOREIGN KEY ("team_id") REFERENCES "teams" ("id"),
        FOREIGN KEY ("problem_id") REFERENCES "problems" ("id")
    );

CREATE TABLE
    "clarifications" (
        "id" INTEGER,
        "team_id" INTEGER,
        "problem_id" INTEGER,
        "content" TEXT NOT NULL,
        PRIMARY KEY ("id"),
        FOREIGN KEY ("problem_id") REFERENCES "problems" ("id"),
        FOREIGN KEY ("team_id") REFERENCES "teams" ("id")
    );

CREATE TABLE
    "announcements" (
        "id" INTEGER,
        "competition_id" INTEGER,
        "content" TEXT NOT NULL,
        PRIMARY KEY ("id"),
        FOREIGN KEY ("competition_id") REFERENCES "competitions" ("id")
    );

CREATE TABLE
    "teams_competitions" (
        "competition_id" INTEGER,
        "team_id" TEXT NOT NULL UNIQUE,
        "score" INTEGER DEFAULT "0",
        "rank" INTEGER,
        PRIMARY KEY ("competition_id", "team_id")
    );

CREATE TABLE
    "problems_topics" (
        "problem_id" INTEGER,
        "topic_id" TEXT NOT NULL UNIQUE,
        PRIMARY KEY ("problem_id", "topic_id")
    );

CREATE TABLE
    "user_teams" (
        "user_id" INTEGER,
        "team_id" TEXT NOT NULL UNIQUE,
        PRIMARY KEY ("user_id", "team_id")
    );

CREATE INDEX "user_name_search" ON "users" ("username");

CREATE INDEX "team_name_search" ON "teams" ("team_name");

CREATE INDEX "problem_name_search" ON "problems" ("name");

DROP view "scoreboard";

CREATE VIEW
    "scoreboard" AS
SELECT
    "competitions"."name" AS "competition",
    "teams"."team_name" AS "team",
    "teams_competitions"."rank" AS "rank"
FROM
    "teams_competitions"
    JOIN "teams" ON "teams_competitions"."team_id" = "teams"."id"
    JOIN "competitions" ON "competitions"."id" = "teams_competitions"."competition_id"
ORDER BY
    "rank" AS

