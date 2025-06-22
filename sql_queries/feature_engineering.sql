-- Feature engineering(lite)


-- 1. Copy cleaned data for feature engineering
CREATE TABLE videos_featured AS
SELECT * FROM videos_cleaned;

SELECT * FROM videos_featured LIMIT 10;



-- 2. Extract weekday and hours from publish date and time
-- Convert publish timestamp to local us/east time
ALTER TABLE videos_featured ADD COLUMN published_us_est TIMESTAMP WITHOUT TIME ZONE;
UPDATE videos_featured
SET published_us_est = published_at AT TIME ZONE 'UTC' AT TIME ZONE 'US/Eastern';


-- Extract year from publish date
ALTER TABLE videos_featured ADD COLUMN published_year TEXT;
UPDATE videos_featured
SET published_year = EXTRACT(YEAR FROM published_us_est);


-- Extract month from publish date
ALTER TABLE videos_featured ADD COLUMN published_month TEXT;
UPDATE videos_featured
SET published_month = EXTRACT(MONTH FROM published_us_est);


-- Extract the weekday from publish date
ALTER TABLE videos_featured ADD COLUMN published_weekday TEXT;
UPDATE videos_featured
SET published_weekday = TRIM(TO_CHAR(published_us_est,'Day'));


-- Extract publish hour from publish date
ALTER TABLE videos_featured ADD COLUMN published_hour INTEGER;
UPDATE videos_featured
SET published_hour = EXTRACT(HOUR FROM published_us_est);


-- 2. Add calculated column like_ratio
ALTER TABLE videos ADD COLUMN like_ratio FLOAT;
UPDATE videos 
SET like_ratio = CASE
				 	WHEN views >0 then ROUND(likes::numeric/views,2)
				 	ELSE 0
				 END;


