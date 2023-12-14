##### [Share of Active Users](https://platform.stratascratch.com/coding/2005-share-of-active-users?code_type=3) <p align="right"> :calendar: 14-12-2023 </p>


**Question**
Output share of US users that are active. Active users are the ones with an "open" status in the table.

```markdown
#Table: fb_active_users
#Schema
user_id:int
name:varchar
status:varchar
country:varchar
```

##### Answer

```sql
SELECT active_users / total_users as active_users_share
FROM (
    SELECT
        COUNT(user_id) AS total_users,
        COUNT(CASE WHEN status = 'open' THEN 1 ELSE NULL END) AS active_users
    FROM
        fb_active_users
    WHERE
        country = 'USA'
) AS u;
```

##### Output

| active_users_share | 
|------------|
| 0.5         | 

:--: :calendar: 2023-01-25
