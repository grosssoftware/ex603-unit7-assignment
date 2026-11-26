-- Augment previously created index to make track_id available.
DROP INDEX idx_plays_user_played_at;
CREATE INDEX IF NOT EXISTS idx_plays_user_played_at
    ON plays (user_id, played_at)
    INCLUDE (track_id);