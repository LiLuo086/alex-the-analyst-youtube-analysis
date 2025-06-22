-- Data Cleaning

-- 1. Copy original data for data cleaning
CREATE TABLE videos_cleaned AS
SELECT * FROM raw_videos;


-- 2. Check data structure
SELECT * FROM videos_cleaned LIMIT 10;


-- 3. check data type of columns
SELECT
	column_name, data_type
FROM
	information_schema.columns
WHERE
	table_name = 'videos_cleaned';


-- 4. Check the duplicate in table videos_cleaned
SELECT a.*
FROM videos_cleaned a
JOIN videos_cleaned b
ON 
	a.video_id = b.video_id
WHERE
	a.ctid < b.ctid;
-- Result: there is no duplicate


-- 5. Trim whitespace in text columns
UPDATE videos_cleaned
SET 
	video_id = TRIM(video_id),
	title = TRIM(title),
    tags = TRIM(tags);
	

-- 6. Handle NULLs in numerical columns
UPDATE videos_cleaned
SET 
	views = COALESCE(views,0),
	likes = COALESCE(likes,0),
	comments = COALESCE(comments,0);





-- 7. Convert tags to text array
ALTER TABLE videos_cleaned
ADD COLUMN tags_array text[];

UPDATE videos_cleaned
SET
	tags_array = string_to_array(REPLACE(REPLACE(REPLACE(tags, '[',''),']',''),'''',''),', '); 

