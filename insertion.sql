INSERT INTO "users" ("id", "name", "mail", "password", "rating")
VALUES
    (1, 'Alice Johnson', 'alice@example.com', 'hashed_password_1', 1200),
    (2, 'Bob Smith', 'bob@example.com', 'hashed_password_2', 1500),
    (3, 'Charlie Brown', 'charlie@example.com', 'hashed_password_3', 1100),
    (4, 'David Miller', 'david@example.com', 'hashed_password_4', 1750),
    (5, 'Emma Wilson', 'emma@example.com', 'hashed_password_5', 950),
    (6, 'Frank Thomas', 'frank@example.com', 'hashed_password_6', 2000),
    (7, 'Grace Hall', 'grace@example.com', 'hashed_password_7', 1350),
    (8, 'Henry Clark', 'henry@example.com', 'hashed_password_8', 1600),
    (9, 'Isabella Young', 'isabella@example.com', 'hashed_password_9', 1800),
    (10, 'Jack White', 'jack@example.com', 'hashed_password_10', 1200);



INSERT INTO "teams" ("id", "name", "users")
VALUES
    (11, 'Alpha Coders', 2),  -- Team with 2 members
    (12, 'Byte Masters', 3),  -- Team with 3 members
    (13, 'Code Warriors', 2),
    (14, 'Dev Dynamos', 3),
    (15, 'Elite Hackers', 2);
INSERT INTO "user_teams" ("user_id", "team_id")
VALUES
    -- Alpha Coders (Team ID: 11)
    (1, 11),
    (2, 11),

    -- Byte Masters (Team ID: 12)
    (3, 12),
    (4, 12),
    (5, 12),

    -- Code Warriors (Team ID: 13)
    (6, 13),
    (7, 13),

    -- Dev Dynamos (Team ID: 14)
    (8, 14),
    (9, 14),
    (10, 14),

    -- Elite Hackers (Team ID: 15)
    (1, 15),
    (3, 15);
--creating a competition of 3 hours long
INSERT INTO "competitions" ("id", "creator_id", "name", "duration", "starting_time", "ending_time", "penalty_time")
VALUES (1, 2, 'Hackathon Challenge', 180, '2025-02-15 10:00:00', '2025-02-15 13:00:00', 20);

--inserting the users into the competition
INSERT INTO "submitters_competitions" ("competition_id", "submitter_id")
SELECT 1, "id" FROM "submitters";

-- Showing the results of the competition named Hackathon challenge
-- SELECT * FROM participants WHERE competition = 'Hackathon Challenge' ORDER BY rank;
