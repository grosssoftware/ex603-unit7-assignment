-- These are the indexes to keep.

-- The starter index is used by the report B query. It makes queries filtered by
-- played_at efficient.
CREATE INDEX IF NOT EXISTS idx_plays_played_at
    ON plays (played_at);

-- The index added for reports A and C make queries filtered by user_id and
-- played_at efficient, and also provide the track_id to prevent another lookup.
CREATE INDEX IF NOT EXISTS idx_plays_user_played_at
    ON plays (user_id, played_at)
    INCLUDE (track_id);