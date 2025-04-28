# Learning Log - SQL Practice

## 📅 2025-04-27

---

## 🎯 Question Info

- **Set Name**: Golden 150 SQL Questions (Custom Practice Set)
- **Question Number**: 17
- **Platform**: LeetCode – Problem 1084: Sales Analysis III

---

## 🔥 Key Concepts Practiced

- `INNER JOIN` usage
- Date filtering using `BETWEEN`
- Exclusion with `NOT IN` and subquery logic

---

### 🚨 Mistakes to Watch Out For

- **Mistake 1: Incomplete Problem Understanding**  
  I rushed into writing a query without fully understanding the problem's specific requirement: products must only have sales during Q1 2019, and no sales afterward.  
  My initial query filtered sales only within Q1 2019, but it failed to exclude products that had sales beyond March 31, 2019.

- **Mistake 2: Missing Exclusion Logic**  
  I did not initially include a `NOT IN (subquery)` or any similar logic to eliminate products that had sales after Q1, leading to incorrect results.

### 🔎 Lesson Learned

- Always slow down and read the question carefully — sometimes, business requirements aren't just about filtering what exists but about ensuring what doesn't exist.
- Build the habit of asking yourself: "Is there anything the query needs to explicitly reject or exclude?"
