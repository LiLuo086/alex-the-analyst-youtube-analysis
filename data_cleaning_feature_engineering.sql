-- Data Cleaning

-- 1. Copy original data for data cleaning
CREATE TABLE VIDEOS AS
SELECT * FROM RAW_VIDEOS;


-- 2. Check data structure
SELECT * FROM videos LIMIT 10;


-- 3. Check the duplicate in table videos
SELECT a.*
FROM videos a
JOIN videos b
ON 
	a.video_id = b.video_id
WHERE
	a.ctid < b.ctid;
-- Result: there is no duplicate


-- 4. Trim whitespace in text columns
UPDATE VIDEOS
SET 
	video_id = TRIM(video_id),
	title = TRIM(title),
    tags = TRIM(tags);
	

-- 5. Handle NULLs in numerical columns
UPDATE VIDEOS
SET 
	views = COALESCE(views,0),
	likes = COALESCE(likes,0),
	comments = COALESCE(comments,0);
	

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




SELECT COUNT(*) FROM videos;
SELECT * FROM videos LIMIT 100;
	