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
SET title = TRIM(title),
    tags = TRIM(tags);

-- 5. Handle NULLs in numerical columns
UPDATE VIDEOS
SET 
	views = COALESCE(views,0),
	likes = COALESCE(likes,0),
	comments = COALESCE(comments,0);



	