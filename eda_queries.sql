-- Get an overview of the data
SELECT * FROM videos LIMIT 10;


-- Check the completeness of video data
SELECT
	COUNT(*),
	COUNT(title),
	COUNT(published_at),
	COUNT(views),
	COUNT(likes),
	COUNT(comments),
	COUNT(tags),
	COUNT(duration_seconds)
FROM
	videos;


-- Check the range and distribution of numerical metrics
SELECT 
	MIN(published_at) AS earlist_published, MAX(published_at) AS latest_published,
	MIN(views) AS min_views, MAX(views) AS max_views,
	MIN(likes) AS min_likes, MAX(likes) AS max_likes,
	MIN(comments) AS min_comments, MAX(comments) AS max_comments,
	MIN(duration_seconds) AS shorest_duration, MAX(duration_seconds) AS longest_duration
FROM
	videos;

SELECT * FROM videos where duration_seconds = 9;

