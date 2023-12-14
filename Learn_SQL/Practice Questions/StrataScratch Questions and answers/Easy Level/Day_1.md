##### [Unique Users Per Client Per Month](https://platform.stratascratch.com/coding/2024-unique-users-per-client-per-month?code_type=3) <p align="right"> :calendar: 14-12-2023 </p>

<dl>
  <dt>Question</dt>
  <dd>Write a query that returns the number of unique users per client per month</dd>
</dl>

```markdown
#Table: fact_events
#Schema
id: int
time_id: datetime
user_id: varchar
customer_id: varchar
client_id: varchar
event_type:varchar
event_id:int
```

##### Answer

```sql
SELECT
    client_id,
    MONTH(time_id) AS month,
    COUNT(DISTINCT user_id) AS user_count
FROM
    fact_events
GROUP BY
    client_id, month;


```

##### Output

| client_id | month(time_id) | count(distinct user_id) |
|-----------|-----------------|---------------------------|
| desktop   | 2               | 13                        |
| desktop   | 3               | 16                        |
| desktop   | 4               | 11                        |
| mobile    | 2               | 9                         |
| mobile    | 3               | 14                        |
| mobile    | 4               | 9                         |

---

##### [Number of Shipments Per Month](https://platform.stratascratch.com/coding/2056-number-of-shipments-per-month?code_type=1)

**Question**
Write a query that will calculate the number of shipments per month. The unique key for one shipment is a combination of shipment_id and sub_id. Output the year_month in format YYYY-MM and the number of shipments in that month.

```markdown
#Table: amazon_shipment
#Schema
shipment_id:int
sub_id:int
weight:int
shipment_date:datetime
```

##### Answer

```sql
SELECT
    COUNT(shipment_id),
    date_ym
FROM (
    SELECT
        shipment_id,
        DATE_FORMAT(shipment_date, '%Y-%m') AS date_ym
    FROM
        amazon_shipment
) a
GROUP BY
    date_ym;
```

##### Output

| count(shipment_id) | date_ym |
|--------------------|---------|
| 3                  | 2021-08 |
| 6                  | 2021-09 |

---
##### [Most Lucrative Products](https://platform.stratascratch.com/coding/2119-most-lucrative-products?code_type=1)

**Question**
You have been asked to find the 5 most lucrative products in terms of total revenue for the first half of 2022 (from January to June inclusive).


Output their IDs and the total revenue.

```markdown
#Table: online_orders
#Schema
product_id:int
promotion_id:int
cost_in_dollars:int
customer_id:int
date:datetime
units_sold:int
```

##### Answer

```sql
SELECT
    product_id,
    SUM(cost_in_dollars * units_sold) AS revenue
FROM
    online_orders
WHERE
    MONTH(date) > 1 AND MONTH(date) <= 6
GROUP BY
    product_id
ORDER BY
    revenue DESC
LIMIT 5;
```

##### Output

| product_id | revenue |
|------------|---------|
| 2          | 207     |
| 3          | 201     |
| 5          | 199     |
| 1          | 65      |
| 6          | 56      |

---
##### [Number Of Bathrooms And Bedrooms](https://platform.stratascratch.com/coding/9622-number-of-bathrooms-and-bedrooms?code_type=1)

**Question**
Find the average number of bathrooms and bedrooms for each city’s property types. Output the result along with the city name and the property type.

```markdown
#Table: airbnb_search_details
#Schema
id:int
price:float
property_type:varchar
room_type:varchar
amenities:varchar
accommodates:int
bathrooms:int
bed_type:varchar
cancellation_policy:varchar
cleaning_fee:bool
city:varchar
host_identity_verified:varchar
host_response_rate:varchar
host_since:datetime
neighbourhood:varchar
number_of_reviews:int
review_scores_rating:float
zipcode:int
bedrooms:int
beds:int
```

##### Answer

```sql
SELECT
    city,
    property_type,
    AVG(bathrooms) AS bathrooms,
    AVG(bedrooms) AS bedrooms
FROM
    airbnb_search_details
GROUP BY
    city, property_type;
```

##### Output

| city   | property_type | bathrooms | bedrooms |
|--------|---------------|-----------|----------|
| NYC    | Apartment     | 1.117     | 1.25     |
| LA     | Cabin         | 3         | 1        |
| SF     | House         | 1.4       | 1.8      |
| LA     | Villa         | 2.067     | 2.533    |
| LA     | House         | 1.5       | 1.559    |
| NYC    | House         | 1.4       | 1.8      |
| LA     | Apartment     | 1.143     | 1.143    |
| DC     | House         | 1         | 1        |
| Boston | House         | 1         | 1        |
| LA     | Other         | 1         | 1        |
| LA     | Condominium   | 1.5       | 1.5      |
| Boston | Condominium   | 2         | 2        |
| Boston | Apartment     | 1         | 1        |
| Chicago| Condominium   | 2         | 2        |
| NYC    | Condominium   | 1         | 1.333    |
| NYC    | Townhouse     | 1         | 0        |
| LA     | Loft          | 1         | 0        |
| Chicago| Apartment     | 2         | 2        |
| Chicago| House         | 2         | 3        |
| NYC    | Loft          | 1         | 0.5      |
| SF     | Apartment     | 1         | 2        |
| LA     | Townhouse     | 2         | 3        |
| LA     | Bungalow      | 1         | 0        |

---
##### [Count the number of user events performed by MacBookPro users](https://platform.stratascratch.com/coding/9653-count-the-number-of-user-events-performed-by-macbookpro-users?code_type=1)

**Question**
Count the number of user events performed by MacBookPro users.
Output the result along with the event name.
Sort the result based on the event count in the descending order.

```markdown
#Table: playbook_events
#Schema
user_id:int
occurred_at:datetime
event_type:varchar
event_name:varchar
location:varchar
device:varchar
```

##### Answer

```sql
SELECT
    event_name,
    COUNT(*) AS event_count
FROM
    playbook_events
WHERE
    device = 'macbook pro'
GROUP BY
    event_name
ORDER BY
    event_count DESC;
```

##### Output

| event_name          | event_count |
|---------------------|-------------|
| home_page           | 8           |
| like_message        | 3           |
| login               | 3           |
| search_autocomplete | 3           |
| view_inbox          | 3           |
| send_message        | 1           |

---
##### [Find the most profitable company in the financial sector of the entire world along with its continent](https://platform.stratascratch.com/coding/9663-find-the-most-profitable-company-in-the-financial-sector-of-the-entire-world-along-with-its-continent?code_type=1)

**Question**
Find the most profitable company from the financial sector. Output the result along with the continent.

```markdown
#Table: forbes_global_2010_2014
#Schema
company: varchar
sector: varchar
industry: varchar
continent: varchar
country: varchar
marketvalue: float
sales: float
profits: float
assets: float
rank: int
forbeswebpage: varchar
```

##### Answer

```sql
SELECT
    company,
    continent
FROM
    forbes_global_2010_2014
WHERE
    sector = 'Financials'
ORDER BY
    profits DESC
LIMIT 1;
```

##### Output

| company | continent |
|---------|-----------|
| ICBC    | Asia      |
---
##### [Churro Activity Date](https://platform.stratascratch.com/coding/9688-churro-activity-date?code_type=1)

**Question**
Find the activity date and the pe_description of facilities with the name 'STREET CHURROS' and with a score of less than 95 points.

```markdown
#Table: los_angeles_restaurant_health_inspections
#Schema
serial_number: varchar
activity_date: datetime
facility_name: varchar
score: int
grade: varchar
service_code: int
service_description: varchar
employee_id: varchar
facility_address: varchar
facility_city: varchar
facility_id: varchar
facility_state: varchar
facility_zip: varchar
owner_id: varchar
owner_name: varchar
pe_description: varchar
program_element_pe: int
program_name: varchar
program_status: varchar
record_id: varchar
```

##### Answer

```sql
SELECT
    activity_date,
    pe_description
FROM
    los_angeles_restaurant_health_inspections
WHERE
    facility_name = 'STREET CHURROS'
    AND score < 95;
```

##### Output

| activity_date | pe_description                    |
|---------------|-----------------------------------|
| 2017-12-29    | RESTAURANT (0-30) SEATS LOW RISK  |
| 2016-12-01    | RESTAURANT (0-30) SEATS LOW RISK  |
| 2016-06-16    | RESTAURANT (0-30) SEATS LOW RISK  |
