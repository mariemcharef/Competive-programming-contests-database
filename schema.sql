--table users

CREATE TABLE
    "submitters" (
        "id" INTEGER,
        "name" TEXT NOT NULL UNIQUE,
        PRIMARY KEY ("id")
    );
CREATE TABLE
    "users" (
        "id" INTEGER,
        "mail" TEXT NOT NULL UNIQUE,
        "password" TEXT NOT NULL,
        "rating" INTEGER DEFAULT 0,
       FOREIGN KEY ("id") REFERENCES "submitters" ("id")ON DELETE CASCADE
    );
--table teams
CREATE TABLE
    "teams" (
        "id" INTEGER,
        "users" INTEGER DEFAULT 2 CHECK ("users" IN (2, 3)),
        FOREIGN KEY ("id") REFERENCES "submitters" ("id")ON DELETE CASCADE
    );
--table competitions
CREATE TABLE
    "competitions" (
        "id" INTEGER,
        "creator_id" INTEGER NOT NULL,
        "name" TEXT NOT NULL,
        "duration" NUMERIC NOT NULL,
        "starting_time" NUMERIC,
        "ending_time" NUMERIC,
        "penalty_time" INTEGER NOT NULL DEFAULT 20,
        PRIMARY KEY ("id"),
        FOREIGN KEY ("creator_id") REFERENCES "users" ("id")
    );
--table problems
CREATE TABLE
    "problems" (
        "id" INTEGER,
        "competition_id" INTEGER NOT NULL,
        "label" TEXT NOT NULL,
        "name" TEXT NOT NULL,
        "time_limit" NUMERIC NOT NULL,
        "memory_limit" INTEGER NOT NULL,
        "content" TEXT NOT NULL,
        PRIMARY KEY ("id"),
        FOREIGN KEY ("competition_id") REFERENCES "competitions" ("id")
    );
--table test_cases
CREATE TABLE
    "test_cases" (
        "id" INTEGER,
        "problem_id" INTEGER NOT NULL,
        "input" TEXT NOT NULL,
        "output" TEXT NOT NULL,
        "explanation" TEXT,
        "hidden" INTEGER DEFAULT 1 NOT NULL CHECK(hidden in(0,1)),
        PRIMARY KEY ("id"),
        FOREIGN KEY ("problem_id") REFERENCES "problems" ("id")
    );
--table topics
CREATE TABLE
    "topics" (
        "id" INTEGER,
        "name" TEXT NOT NULL,
        PRIMARY KEY ("id")
    );
--table submissions
CREATE TABLE
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
        FOREIGN KEY ("submitter_id") REFERENCES "submitters" ("id"),
        FOREIGN KEY ("problem_id") REFERENCES "problems" ("id")
    );
--table clarifications
CREATE TABLE
    "clarifications" (
        "id" INTEGER,
        "submitter_id" INTEGER,
        "problem_id" INTEGER,
        "content" TEXT NOT NULL,
        PRIMARY KEY ("id"),
        FOREIGN KEY ("problem_id") REFERENCES "problems" ("id"),
        FOREIGN KEY ("submitter_id") REFERENCES "submitters" ("id")
    );
--table announcements
CREATE TABLE
    "announcements" (
        "id" INTEGER,
        "competition_id" INTEGER,
        "content" TEXT NOT NULL,
        PRIMARY KEY ("id"),
        FOREIGN KEY ("competition_id") REFERENCES "competitions" ("id")
    );
--table teams competitions to specify the team participation in a competition
CREATE TABLE
    "teams_competitions" (
        "competition_id" INTEGER,
        "submitter_id" TEXT NOT NULL UNIQUE,
        "score" INTEGER DEFAULT "0",
        "rank" INTEGER,
        PRIMARY KEY ("competition_id", "submitter_id"),
        FOREIGN KEY ("competition_id") REFERENCES "competitions" ("id"),
        FOREIGN KEY ("submitter_id") REFERENCES "submitters" ("id")
    );
-- table problem topics , to describe topics associated to a problem
CREATE TABLE
    "problems_topics" (
        "problem_id" INTEGER,
        "topic_id" TEXT NOT NULL UNIQUE,
        PRIMARY KEY ("problem_id", "topic_id"),
        FOREIGN KEY ("problem_id") REFERENCES "problems" ("id"),
        FOREIGN KEY ("topic_id") REFERENCES "topics" ("id")
    );
-- to enumerate team members
CREATE TABLE
    "user_teams" (
        "user_id" INTEGER,
        "team_id" TEXT NOT NULL UNIQUE,
        PRIMARY KEY ("user_id", "team_id"),
        FOREIGN KEY ("user_id") REFERENCES "users" ("id"),
        FOREIGN KEY ("teams_id") REFERENCES "teams" ("id")
    );
--index to facilitate search of users
CREATE INDEX "user_name_search" ON "users" ("username");
--index to facilitate search of teams
CREATE INDEX "team_name_search" ON "teams" ("team_name");
--index to facilitate search of problems
CREATE INDEX "problem_name_search" ON "problems" ("name");
--view competitions results

DROP view "scoreboard";


