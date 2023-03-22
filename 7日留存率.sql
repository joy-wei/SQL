SELECT
  DATEDIFF(a.date, b.date) AS days_since_signup,
  COUNT(DISTINCT b.user_id) AS total_signups,
  COUNT(DISTINCT a.user_id) AS retained_users,
  COUNT(DISTINCT a.user_id) / COUNT(DISTINCT b.user_id) AS retention_rate
FROM
  user_signup AS b
LEFT JOIN
  user_signup AS a
ON
  b.user_id = a.user_id
  AND DATEDIFF(a.date, b.date) BETWEEN 1 AND 7
GROUP BY
  1
ORDER BY
  1
