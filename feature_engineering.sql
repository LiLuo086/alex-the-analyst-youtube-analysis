-- 6. Feature engineering(lite)
-- Add calculated column like_ratio
ALTER TABLE videos ADD COLUMN like_ratio FLOAT;
UPDATE videos 
SET like_ratio = CASE
				 	WHEN views >0 then ROUND(likes::numeric/views,2)
				 	ELSE 0
				 END;


-- 7. Extract weekday and hours from publish date and time
ALTER TABLE videos ADD COLUMN published_us_est TIMESTAMP WITHOUT TIME ZONE;
UPDATE videos
SET published_us_est = published_at AT TIME ZONE 'UTC' AT TIME ZONE 'US/Eastern';



ALTER TABLE videos ADD COLUMN published_weekday_us_est TEXT;
UPDATE videos
SET published_weekday_us_est = TRIM(TO_CHAR(published_us_est,'Day'));


ALTER TABLE videos ADD COLUMN published_hour_us_est INTEGER;
UPDATE videos
SET published_hour_us_est = EXTRACT(HOUR FROM published_us_est);