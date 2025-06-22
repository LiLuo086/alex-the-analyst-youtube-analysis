-- Data Cleaning

-- 1. Copy original data for data cleaning
CREATE TABLE videos_cleaned AS
SELECT * FROM raw_videos;


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
	video_id = TRIM(COALESCE(video_id, '')),
	title = TRIM(COALESCE(title, '')),
    tags = TRIM(COALESCE(tags, ''));
	

-- 6. Handle NULLs in numerical columns
UPDATE videos_cleaned
SET 
	views = COALESCE(views,0),
	likes = COALESCE(likes,0),
	comments = COALESCE(comments,0);


-- 7. Convert 'tags' string to text[] array
ALTER TABLE videos_cleaned
ADD COLUMN tags_array text[];

UPDATE videos_cleaned
SET
	tags_array = string_to_array(
				  REPLACE(REPLACE(REPLACE(tags, '[',''),']',''),'''',''),
				  ', '); 

-- Verifying the changes				
SELECT tags, tags_array FROM videos_cleaned LIMIT 10;

-- drop the old column 'tags'
ALTER TABLE videos_cleaned
DROP COLUMN tags;


-- 8. Check the data structure after cleaning process
SELECT * FROM videos_cleaned LIMIT 10;
