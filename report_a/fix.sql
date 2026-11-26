-- Create a composite index on user_id and played_at to provide quick lookup of
-- a range of play times for each user.
CREATE INDEX idx_plays_user_played_at
    ON plays (user_id, played_at);

-- Continue to use original query for "Your Top Songs this Year".
SELECT s.song_id, s.title, COUNT(*) AS play_count
FROM   plays p
JOIN   songs s ON s.song_id = p.track_id
WHERE  p.user_id = 1
  AND  p.played_at >= '2025-01-01'
  AND  p.played_at <  '2026-01-01'
GROUP  BY s.song_id, s.title
ORDER  BY play_count DESC, s.song_id ASC
LIMIT  20;