/*
You are analyzing data from a game where players earn points in rounds. 
Sometimes, a specific round is designated as a "reset round," meaning that 
the player's cumulative score should start fresh from that round onward. 
Your task is to calculate the running total score for each player, respecting these reset conditions.
*/

/*
Write a single SQL query to display player_id, round_number, score, is_reset_round, 
and a new column running_total_score. The running_total_score should accumulate points per player and round, 
but should reset to the current round's score whenever is_reset_round is 1.
*/

use questions;

/*
CREATE TABLE GameScores (
    player_id INT NOT NULL,
    round_number INT NOT NULL,
    score INT NOT NULL,
    is_reset_round TINYINT NOT NULL CHECK (is_reset_round IN (0, 1)),
    PRIMARY KEY (player_id, round_number) 
	-- Composite primary key to ensure uniqueness per round per player
);

INSERT INTO GameScores (player_id, round_number, score, is_reset_round) 
VALUES(1, 1, 10, 0),
(1, 2, 5, 0),
(1, 3, 20, 1),
(1, 4, 15, 0),
(1, 5, 10, 1),
(1, 6, 5, 0),
(2, 1, 100, 0),
(2, 2, 50, 1),
(2, 3, 20, 0);
*/

--select * from gamescores;

with t1 as(
select *,
		sum(is_reset_round) over(partition by player_id order by round_number asc) as flag
from gamescores
)
select player_id, round_number, score, is_reset_round,
		sum(score) over(partition by player_id, flag order by round_number asc) as running_total_score
from t1