# Design Document

By Mohamed Bouafif  and  Mariem Charef

Video overview: (Normally there would be a URL here, but not for this sample assignment!)

## Scope

The database for CS50 SQL includes all entities necessary to facilitate the process of tracking student progress and leaving feedback on student work. As such, included in the database's scope is:

* users, including basic identifying information
* Instructors, including basic identifying information
* Student submissions, including the time at which the submission was made, the correctness score it received, and the problem to which the submission is related
* Problems, which includes basic information about the course's problems
* Comments from instructors, including the content of the comment and the submission on which the comment was left


## Functional Requirements

This database will support:

* CRUD operations for users , competitions, teams, problems and submissions.
* Tracking all versions of team submissions, including multiple submissions for the same problem.
* The problem details like test cases, topics and to which cometition associated.
* Adding multiple clarifications from a user to the competition creator .
* Adding multiple announcements to participants from the competition creator.

## Representation

Entities are captured in SQLite tables with the following schema.

### Entities

The database includes the following entities:

#### Submitters

The `submitters` table includes:

* `id`, which specifies the unique ID for the submitter as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `name`, which specifies the name as `TEXT`, given `TEXT` is appropriate for name fields. This column thus has the `NOT NULL` and `UNIQUE` constraint applied.

#### Users

The `users` table includes:

* `id`, which specifies the unique ID for the user as an `INTEGER`. This column thus has the `FOREIGN KEY` references to `submitters` table constraint applied.
* `mail`, which specifies the user's email as `TEXT`,and `UNIQUE`.This column thus has the `NOT NULL` constraint applied.
* `password`, which specifies the user's password,given `TEXT` is appropriate for name fields . This column thus has the `NOT NULL` constraint applied.
* `rating`, which specifies when the submitter's rating. type of `INTEGER` and `DEFAULT 0` AS a default value.

#### Teams

The `teams` table includes:

* `id`, which specifies the unique ID for the user as an `INTEGER`. This column thus has the `FOREIGN KEY` references to `submitters` table constraint applied.
* `users`, which specifies the number of users within this team as `INTEGER`. This column has the `CHECK users IN (2,3)` , `DEFAULT 2`.

#### User_Teams

The `user_teams` table includes:

* `user_id`,  which specifies the unique ID for the user as an `INTEGER`. This column thus has the `FOREIGN KEY` that references the `users` table constraint applied.
* `team_id`, which specifies the unique ID for the team as an `INTEGER`. This column thus has the `FOREIGN KEY` that references the `teams` table constraint applied.

#### Competitions

The `competitions` table includes:

* `id`, which specifies the unique ID for the compeition as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `creator_id`,which specifies the ID of the user who created the competition  This column thus has the `FOREIGN KEY`that references the `user` table constraint applied.
* `name`, which specifies the competition name as `TEXT` .This column thus has the `NOT NULL` constraint applied.
* `duration` ,  which specifies the competition duration in minutes as `Numeric` and `NOT NULL` constraint applied.
* `starting_time`, which is the timestamp at which the competition start.
* `ending_time`, which is the timestamp at which the competition end.
* `penalty_time` , Penalty time for a wrong submission. Only relevant if scoreboard_type is pass-fail.

#### Submitters_Competitions

The `submitters_competitions` table includes:

* `competition_id`,  which specifies the unique ID for the competition as an `INTEGER`. This column thus has the `FOREIGN KEY` that references the `competitions` table constraint applied.
* `submitter_id`, which specifies the unique ID for the submitter as an `INTEGER`. This column thus has the `FOREIGN KEY` that references the `submitters` table constraint applied.
* `score`, which the score of the submitter in this competition as `INTEGER`,`DEFAULT 0`.
* `rank`, which the rank of the submitter in this competition as `INTEGER`.

#### Problems

The `problems` table includes:

* `id`, which specifies the unique ID for the instructor as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `competition_id`, which specifies the unique ID for the competition as an `INTEGER`. This column thus has the `FOREIGN KEY` that references the `competition` table constraint applied.
* `label` , Label of the problem on the scoreboard, as `TEXT` typically a single capitalized letter and `NOT NULL`.
* `name`, which is the name of the problem set as `TEXT`.This column thus has the `UNIQUE` and `NOT NULL` constraint applied.
* `time_limit` , Time limit in seconds per test data set (i.e. per single run). Should be a `NUMERIC` multiple of 1 and `NOT NULL`.
* `memory_limit` , Memory limit in megabytes (MB) per test dataset (i.e., per single run). Should be a `NUMERIC` multiple of 1
* `content` , the content of the problem as `TEXT` ant `NOT NULL`.

#### Test_cases

The `test_cases` table includes:

* `id`, which specifies the unique ID for the test_case as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `problem_id`, which is the ID of the problem which the test case associated to as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `problems` table to ensure data integrity.
* `input`, which the input of the test as `TEXT`,`NOT NULL`.
* `output`, the expected output of the test as `TEXT`,`NOT NULL`.
* `explanation` ,expanation of the test if it is necessary as `TEXT`.
* `hidden`, which Specifies whether this test case is displayed (1) with the problem content or hidden (0) `CHECK IN(0,1)` ,`NOT NULL` and `DEFAULT 0`
#### Topics

The `topics` table includes:

* `id`, which specifies the unique ID for the topic as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `name`, the name of the topic as `TEXT`, `NOT NULL`.

#### Problems_Topics

The `problems_topics` table includes:

* `problem_id`,  which specifies the unique ID for the problem as an `INTEGER`. This column thus has the `FOREIGN KEY` that references the `problems` table constraint applied.
* `topic_id`, which specifies the unique ID for the topic as an `INTEGER`. This column thus has the `FOREIGN KEY` that references the `topics` table constraint applied.

#### Submissions

The `submissions` table includes:

* `id`, which specifies the unique ID for the submission as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `submitter_id`, which is the ID of the submitter who made the submission as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `submitter` table to ensure data integrity.
* `problem_id`, which is the ID of the problem which the submission solves as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `problems` table to ensure data integrity.
* `time`, `timestamp` of when the submission was made, defaults to the current timestamp when a new row is inserted.
* `language`, Identifier of the language submitted for `TEXT`, `CHECK IN(ada,c,cpp,csharp,go,haskell,java,javascript,kotlin,objectivec,pascal,php,prolog,python2,python3,ruby,rust,scala)` and `NOT NULL`.
* `judgement`,the result of the submition `CHECK IN (in_queue,accepted,wrong_answer,time_limit_exceeded,memory_limit_exceeded,compilation_error)`, `DEFAULT in_queue`.
* `code` , the solution of the problem as `TEXT`, `NOT NULL`.

#### Clarifications

The `clarifications` table includes:

* `id`, which specifies the unique ID for the clarification as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `submitter_id`, which specifies the ID of the submitter who asked for the clarification as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `submitters` table, which ensures that each clarification be referenced back to a submitter.
* `problem_id`, which specifies the ID of the problem for which clarification has been requeste as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `problems` table, which ensures that each clarification be referenced back to a problem.
* `content`,the clarification content as `TEXT`, `NOT NULL`.

#### Anouncements

The `anouncements` table includes:

* `id`, which specifies the unique ID for the announcement as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `competition_id`, which specifies the ID of the competition to clarify one or many points in one or more problems or submissions as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `competitions` table, which ensures that each announcement be referenced back to a competition.
* `content`,the announcement content as `TEXT`, `NOT NULL` written by the competition creator.


### Relationships

The below entity relationship diagram describes the relationships among the entities in the database.

![ER Diagram](diagram.png)

As detailed by the diagram:

* One submitter(user or team) is  capable of making 0 to many submissions. 0, if they have yet to submit any work, and many if they submit to more than one problem (or make more than one submission to any one problem). A submission is made by one and only one submitter.
* A submission is associated with one and only one problem. At the same time, a problem can have 0 to many submissions: 0 if no submitter has yet submitted work to that problem, and many if more than one submitter has submitted work for that problem.
* A submitter contains one to many users and users belong to at least one submitter.
* A competition created by one user, contains many problems, many submitters can participate and there are 0 to many announcements related to it.
* A submitter has score in particular competition and can particate in many competitions.
* A problem belongs to one competition.
* A clarification is asked by one submitter associated to one problem.A submitter can ask of many clarifications for many problems.
* A problem has one to many test cases, A test case associated to one problem .
* A problem can be associated to many topics and a topic can be associated to many problems.

## Optimizations

Per the typical queries in `queries.sql`, it is common for users of the database to access all submissions submitted by any particular submitter. For that reason, indexes are created on the `submitter_name` column to speed the identification of submitters by those columns.

Similarly, it is also common practice for a user of the database to concerned with viewing all submitters who make subbmissions to a particular problem. As such, an index is created on the `name` column in the `problems` table to speed the identification of problems by name.

Also, it is common practice for a database user to view the results of any competition as a table of submitters sorted by rank. AS such,A view is created to sort all submitters by their rank in a competition.

## Limitations
Lack of social communication – Users cannot connect, add friends, or follow others, limiting engagement and collaboration.

Users cannot collaborate to create a competition, the competition is created by one person.

This project miss the tutorials of problems.
