--You have a table of survey responses where each row represents one answer to one question from one respondent. 
--You need to obatin the survey response into required format.

use questions;

/*
-- Create the survey_responses table
CREATE TABLE survey_responses (
    respondent_id INT,
    question_id INT,
    question_text NVARCHAR(100),
    response_value NVARCHAR(50) -- Using NVARCHAR to handle mixed data types
);

-- Insert sample data
INSERT INTO survey_responses (respondent_id, question_id, question_text, response_value)
VALUES
    (1, 101, 'Satisfaction Level', '4'),
    (1, 102, 'Recommend to Friend', 'Yes'),
    (1, 103, 'Favorite Feature', 'Speed'),
    (2, 101, 'Satisfaction Level', '2'),
    (2, 102, 'Recommend to Friend', 'No'),
    (2, 103, 'Favorite Feature', 'UI'),
    (3, 101, 'Satisfaction Level', '5'),
    (3, 102, 'Recommend to Friend', 'Yes'),
    (3, 103, 'Favorite Feature', 'Support');
	*/


select * from survey_responses;


--Method 1
SELECT
    respondent_id,
    MAX(CASE WHEN question_id = 101 THEN response_value END) AS satisfaction_level,
    MAX(CASE WHEN question_id = 102 THEN response_value END) AS recommend_to_friend,
    MAX(CASE WHEN question_id = 103 THEN response_value END) AS favorite_feature
FROM survey_responses
GROUP BY respondent_id
ORDER BY respondent_id;

--Method 2

select respondent_id,
	[101] as satisfaction_level,
	[102] as recommend_to_friends,
	[103] as favourite_feature
	from
(select respondent_id,
		question_id,
		response_value
from survey_responses) assrc
pivot (
max(response_value) for question_id in	([101],[102],[103])
) as pvt;