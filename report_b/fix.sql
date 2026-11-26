-- Change the predicate in the "Top Listeners this Month" query to remove
-- functions that prevent index usage.
SELECT a.account_id, a.name,
       ROUND(SUM(p.play_duration_seconds) / 60.0, 1) AS minutes
FROM   accounts a
JOIN   plays p ON p.user_id = a.account_id
WHERE  p.played_at >= '2025-12-01'
  AND  p.played_at <  '2026-01-01'
GROUP  BY a.account_id, a.name
ORDER  BY minutes DESC NULLS LAST, a.account_id ASC
LIMIT  20;