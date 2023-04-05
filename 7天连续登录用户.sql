-- 从登录表中选择每个用户的登录日期，并使用 LEAD 函数计算第七次登录日期
SELECT 
    COUNT(DISTINCT user_id) AS num_users 
FROM 
    (SELECT 
        user_id, 
        login_date, 
        LEAD(login_date, 6) OVER (PARTITION BY user_id ORDER BY login_date) AS seventh_login -- 使用 DATE_ADD 函数将第一次登录日期加上 6 天，与第七次登录日期比较，若相等则说明用户连续登录 7 天
    FROM 
        login_table) AS t 
WHERE 
    seventh_login = DATE_ADD(login_date, INTERVAL 6 DAY)


