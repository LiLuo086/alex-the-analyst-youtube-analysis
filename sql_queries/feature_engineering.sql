-- Feature engineering(lite)


-- 1. Copy cleaned data for feature engineering
CREATE TABLE videos_featured AS
SELECT * FROM videos_cleaned;

SELECT * FROM videos_featured LIMIT 100;



-- 2. Add derived datetime features (in US Eastern Time)
ALTER TABLE videos_featured 
ADD COLUMN published_us_est TIMESTAMP WITHOUT TIME ZONE,
ADD COLUMN published_year INTEGER,
ADD COLUMN published_month INTEGER,
ADD COLUMN published_quarter TEXT,
ADD COLUMN published_weekday TEXT,
ADD COLUMN published_hour INTEGER;

-- Convert timestamp to US Eastern and extract features
UPDATE videos_featured
SET 
	published_us_est = published_at AT TIME ZONE 'UTC' AT TIME ZONE 'US/Eastern',
	published_year = EXTRACT(YEAR FROM published_at AT TIME ZONE 'UTC' AT TIME ZONE 'US/Eastern'),
	published_month = EXTRACT(MONTH FROM published_at AT TIME ZONE 'UTC' AT TIME ZONE 'US/Eastern'),
	published_quarter = 'Q' || EXTRACT(QUARTER FROM published_at AT TIME ZONE 'UTC' AT TIME ZONE 'US/Eastern'),
	published_weekday = TRIM(TO_CHAR(published_at AT TIME ZONE 'UTC' AT TIME ZONE 'US/Eastern','Day')),
	published_hour = EXTRACT(HOUR FROM published_at AT TIME ZONE 'UTC' AT TIME ZONE 'US/Eastern');



-- 3. Add engagement ratio features
ALTER TABLE videos_featured 
ADD COLUMN like_ratio FLOAT,
ADD COLUMN comment_ratio FLOAT;

-- Compte ratios(avoid division by zero)
UPDATE videos_featured 
SET like_ratio = CASE
				 	WHEN views >0 THEN ROUND(likes::numeric/views,4)
				 	ELSE 0
				 END,
    comment_ratio = CASE
				 	WHEN views >0 THEN ROUND(comments::numeric/views,4)
				 	ELSE 0
				 END;



-- 4. Bucket publish hours into time-of-day categories
ALTER TABLE videos_featured
ADD COLUMN published_time_of_day TEXT;
UPDATE videos_featured
SET published_time_of_day = CASE
	WHEN published_hour BETWEEN 0 AND 5 THEN 'Early Morning'
	WHEN published_hour BETWEEN 6 AND 11 THEN 'Morning'
	WHEN published_hour BETWEEN 12 AND 17 THEN 'Afternoon'
	WHEN published_hour BETWEEN 18 AND 23 THEN 'Evening'
	ELSE 'Unknown'
END;



--  5. Add if the video is a short
ALTER TABLE videos_featured
ADD COLUMN is_short BOOL;
UPDATE videos_featured
SET is_short =CASE
	WHEN duration_seconds <=120 THEN True
	ELSE False
END;


SELECT * FROM videos_featured LIMIT 100;