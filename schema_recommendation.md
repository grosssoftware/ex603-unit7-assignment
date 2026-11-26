# Schema Recommendation

There are several ways to create a "Top Songs in Your Region" query, but I
believe the most straightforward would be to include the region column in the
plays table. The query might look like:
```
SELECT s.song_id, s.title, COUNT(*) AS play_count
FROM plays p
JOIN songs s ON s.song_id = p.track_id
WHERE p.region_code = 1
GROUP BY s.song_id, s.title
ORDER BY play_count DESC, s.song_id ASC
LIMIT 20;
```
When the plays row is written, the extra width of a region_code won't
significantly affect write time. Having the region_code in the play table
altogether avoids joining on the accounts table to get it. An index similar to
what was devised for reports A and C would make the query efficient:
```
CREATE INDEX IF NOT EXISTS idx_plays_region_code_track_id
    ON plays (region_code, track_id);
```
And its size would roughly be the number of rows in the plays table times the
size to store two BIGINTs plus a pointer. The lesson from fixing report A was to
have an index that would eliminate the costly sequential scans when using highly
selective filters.