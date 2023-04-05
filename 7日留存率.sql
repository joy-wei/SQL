SELECT 
    COUNT(DISTINCT t1.user_id) AS `7_day_retention` -- 统计留存用户数
FROM 
    (
    SELECT 
        user_id, 
        DATE(created_at) AS `day`, 
        LEAD(DATE(created_at), 7) OVER (PARTITION BY user_id ORDER BY DATE(created_at)) AS `7th_day` -- 计算第七天的日期
    FROM 
        user_login_log
    ) t1
WHERE 
    t1.`7th_day` = DATE_ADD(t1.`day`, INTERVAL 7 DAY) -- 满足第七天登录的用户
    AND t1.`day` = '2023-03-10' -- 统计 2023-03-10 这一天的留存率

