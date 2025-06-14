CREATE TABLE VIDEOS(
video_id TEXT PRIMARY KEY,
title TEXT,
published_at TIMESTAMP,
views INTEGER,
likes INTEGER,
comments INTEGER,
tags TEXT,
duration_seconds INTEGER
)