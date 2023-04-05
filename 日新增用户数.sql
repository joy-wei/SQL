-- 使用 LEFT JOIN 和 WHERE 子句进行表的连接和筛选，得到历史注册表和活跃表的对应关系
-- 以历史注册表为基础，找出不在活跃表中的用户，即为新增用户
SELECT COUNT(DISTINCT hr.user_id) AS new_users
FROM historical_registrations hr
LEFT JOIN active_users au ON hr.user_id = au.user_id
WHERE au.user_id IS NULL;
