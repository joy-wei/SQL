SELECT user_id
FROM (
  SELECT user_id, login_date,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY login_date) AS row_number
  FROM user_login
) AS t1
WHERE EXISTS (
  SELECT *
  FROM (
    SELECT user_id, login_date,
      ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY login_date) AS row_number
    FROM user_login
  ) AS t2
  WHERE t1.user_id = t2.user_id
    AND t2.login_date >= t1.login_date
    AND t2.login_date <= DATE_ADD(t1.login_date, INTERVAL 6 DAY)
    AND t2.row_number = t1.row_number + 6
)
GROUP BY user_id
HAVING COUNT(*) >= 7;
