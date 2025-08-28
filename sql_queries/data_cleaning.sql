-- Data Cleaning

-- 1. Copy original data for data cleaning
CREATE TABLE videos_cleaned AS
SELECT * FROM videos;


-- 2. Check data structure
SELECT * FROM videos_cleaned LIMIT 10;


-- 3. check data type of columns
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'videos_cleaned';


-- 4. Check for duplicate video_ids
SELECT video_id, COUNT(video_id)
FROM videos_cleaned
GROUP BY video_id
HAVING COUNT(video_id)>1;


-- 5. Trim whitespace in text columns
UPDATE videos_cleaned
SET 
	video_id = LOWER(TRIM(COALESCE(video_id, ''))),
	title = LOWER(TRIM(COALESCE(title, ''))),
    tags = LOWER(TRIM(COALESCE(tags, ''))),
	playlist_title = LOWER(TRIM(COALESCE(playlist_title, '')));
	

-- 6. Handle NULLs in numerical columns
UPDATE videos_cleaned
SET 
	views = COALESCE(views,0),
	likes = COALESCE(likes,0),
	comments = COALESCE(comments,0);



-- 7. Check the data structure after cleaning process
SELECT * FROM videos_cleaned LIMIT 10;
