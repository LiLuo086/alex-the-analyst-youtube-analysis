-- Data Cleaning

-- 1. Copy original data for data cleaning
CREATE TABLE VIDEOS_CLEANED AS
SELECT * FROM RAW_VIDEOS;


-- 2. Check data structure
SELECT * FROM VIDEOS_CLEANED LIMIT 10;


-- 3. Check the duplicate in table videos_cleaned
SELECT a.*
FROM VIDEOS_CLEANED a
JOIN VIDEOS_CLEANED b
ON 
	a.video_id = b.video_id
WHERE
	a.ctid < b.ctid;
-- Result: there is no duplicate


-- 4. Trim whitespace in text columns
UPDATE VIDEOS_CLEANED
SET 
	video_id = TRIM(video_id),
	title = TRIM(title),
    tags = TRIM(tags);
	

-- 5. Handle NULLs in numerical columns
UPDATE VIDEOS_CLEANED
SET 
	views = COALESCE(views,0),
	likes = COALESCE(likes,0),
	comments = COALESCE(comments,0);


-- 6. check data type of columns
SELECT
	column_name, data_type
FROM
	information_schema.columns
WHERE
	table_name = 'videos_cleaned';