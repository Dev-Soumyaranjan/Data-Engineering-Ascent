# Learning Log - SQL Practice

## 📅 2025-04-27

---

## 🎯 Question Info

- **Set Name**: Golden 150 SQL Questions (Custom Practice Set)
- **Question Number**: 17
- **Platform**: LeetCode – Problem 1084: Sales Analysis III

---

## 🔥 Key Concepts Practiced

- **`INNER JOIN`**: Merging tables based on a common key.
- **Date filtering**: Using the `BETWEEN` clause to filter records within a specific date range.
- **Exclusion logic**: Ensuring certain records are excluded using conditions like `NOT IN` or subqueries.

---

### 🚨 Mistakes to Watch Out For

- **Mistake 1: Incomplete Problem Understanding**  
  I rushed into writing the query without fully understanding the problem’s specific requirement: products must only have sales during Q1 2019 and no sales afterward. My initial solution filtered sales only within Q1 2019 but failed to exclude products that had sales after March 31, 2019.

- **Mistake 2: Missing Exclusion Logic**  
  The `NOT IN (subquery)` I used in my initial solution didn’t account for products that had sales after Q1 2019 correctly. This exclusion logic was necessary to meet the requirements of the problem.

- **Mistake 3: Overcomplicating the Query**  
  My solution used a subquery (`NOT IN`), which, while valid, isn’t the most optimized approach in this scenario. It wasn’t the best way to filter out products with sales outside of Q1 2019.

---

### 🔎 Lesson Learned

- **Slow Down and Read Carefully**: The problem wasn’t just about filtering sales during Q1 2019 but also about excluding products that had sales after that. It's important to think about all possible scenarios when dealing with exclusion conditions.
  
- **Always Ask**: “Is there anything the query needs to explicitly reject or exclude?” This mental checklist can help clarify your approach to filtering records.

- **Optimizing Queries**: Using `NOT IN` with a subquery can be inefficient when handling large datasets. A better alternative is to use `COUNT` and `HAVING` to handle conditions more efficiently.

---

## 🔑 Updated Optimal Solution

```sql
SELECT p.product_id, p.product_name
FROM Product p
JOIN Sales s
ON p.product_id = s.product_id
GROUP BY p.product_id,p.product_name
HAVING COUNT(CASE WHEN s.sale_date BETWEEN '2019-01-01' AND '2019-03-31' THEN 1 END) = COUNT(*)
```

---

### ✅ Explanation of the Optimal Solution

- **JOIN:** This query uses an `INNER JOIN` to combine the `Product` and `Sales` tables based on the common `product_id`.

- **GROUP BY:** The query groups the data by `product_id`, meaning it analyzes each product's sales data.

- **COUNT(CASE WHEN ...):** The `COUNT` function is used with a `CASE` statement to only count the sales that occurred within Q1 2019. This ensures that the count reflects only sales made during the required time period.

- **HAVING:** The `HAVING` clause filters the results so that only products whose total sales within Q1 2019 match the total sales count (i.e., the product had no sales outside Q1 2019).

---

### ⚡ Pattern to Remember

**Pattern:** Using `HAVING` with conditional `COUNT` to filter aggregated results.  
This is a common pattern in SQL when you need to apply conditions to aggregate results after using `GROUP BY`. It’s especially useful when you need to ensure all records in a group meet specific conditions. In this case, it ensures that products sold only during Q1 2019 are included and that they have no sales outside of that period.

**Optimized Query Approach:**  
Whenever you're dealing with exclusion logic in aggregations (like this case where we need to exclude products that had sales outside a specific period), consider using `COUNT` with conditional aggregation inside `HAVING` instead of using subqueries with `NOT IN` or `NOT EXISTS`.

---

### 🧠 Reflection

I learned that clarifying the problem’s requirements is critical. It’s not just about filtering the data, but also making sure I exclude the correct records, which often requires thinking beyond the initial query.

The use of `COUNT` with `CASE WHEN` is a pattern that I should keep in mind when dealing with grouping and filtering based on multiple conditions. This approach is more efficient than subqueries, especially for large datasets.

**Optimization Tip:** The `HAVING` clause can be very useful in filtering on aggregated data and can often lead to cleaner, faster queries compared to subqueries.
