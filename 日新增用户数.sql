SELECT date, COUNT(DISTINCT user_id) AS new_users
FROM user_activity AS a
WHERE date BETWEEN '2023-03-01' AND '2023-03-21'
  AND NOT EXISTS (
    SELECT DISTINCT user_id,date
    FROM user_activity AS b
    WHERE b.user_id = a.user_id
      AND b.date < '2023-03-01'
  )
GROUP BY date
ORDER BY date
