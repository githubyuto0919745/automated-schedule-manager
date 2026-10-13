
# Automated Schedule Manager: Example Questions and Results

This document demonstrates how the natural-language interface processes questions about the automated schedule manager database. It includes supported questions that generate SQL queries and return database results, as well as unsupported questions that return `CANNOT_ANSWER`.

## Example 1: Unsupported Question

**Question:** How many students at the gym in the UK? 
**Generated SQL:**
``` test
CANNOT_ANSWER 
```

**Response:**
I can't answer that using the current database.

## Example 2: High-Priority Tasks

**Question:** What are the high priority tasks?
**Generated SQL:** 
```sql
SELECT *
FROM task
WHERE priority = 3;
```


**Database Results:**
```text
 [(4, 1, 'Clean room', 3, datetime.date(2026, 10, 14), 45, 'COMPLETED')]
 ```

**Friendly Response:**
High priority task:- 
- **Clean room** — due **Oct 14, 2026** — **Completed**


## Example 3: Tasks That Have Not Started

**Question:** Which tasks have not started?
**Generated SQL:**
```sql  
SELECT *
FROM task
WHERE status = 'NOT_STARTED';
```

**Database Results:**
```text
[
    (2, 1, 'Buy groceries', 2, datetime.date(2026, 10, 10), 60, 'NOT_STARTED'), (3, 1, 'Pay bill', 1, datetime.date(2026, 10, 8), 20, 'NOT_STARTED'), (6, 1, 'Call the doctor', 1, datetime.date(2026, 10, 15), 15, 'NOT_STARTED')
]
```

**Friendly Response:**
The tasks that have not started are:
- Buy groceries
- Pay bill
- Call the doctor

## Example 4: Tasks With Deadlines After October 12, 2026

**Question:** Which tasks have deadlines after October 12,2026?
**Generated SQL:**
```sql
SELECT *
FROM task
WHERE deadline > '2026-10-12';
```

**Database Results:**
```text
[
    (4, 1, 'Clean room', 3, datetime.date(2026, 10, 14), 45, 'COMPLETED'), (6, 1, 'Call the doctor', 1, datetime.date(2026, 10, 15), 15, 'NOT_STARTED')
]
```

**Friendly Response:**

Tasks with deadlines after October 12, 2026:
 **Clean room** — due **October 14, 2026** — **Completed**
 **Call the doctor** — due **October 15, 2026** — **Not started**


## Example 5: Users With No Tasks
**Question:** Which users have no tasks?
**Generated SQL:**
```sql  
SELECT u.user_id, u.first_name, u.last_name, u.email
FROM `user` AS u
WHERE NOT EXISTS (
    SELECT 1
    FROM task AS t
    WHERE t.user_id = u.user_id
);

```


**Database Results:**
```text
 [
    (2, 'Emily', 'Johnson', 'emily.johnson@example.com'), (3, 'Michael', 'Brown', 'michael.brown@example.com')
]
```

**Friendly Response:** 
The users with no tasks are:

- Emily Johnson (emily.johnson@example.com)
- Michael Brown (michael.brown@example.com)


## Example 6: Tasks That Are Not Completed

**Question:** Which tasks are not completed?

**Generated SQL:**
```sql  
SELECT task_id, user_id, title, priority, deadline, estimated_duration, status
FROM task
WHERE status <> 'COMPLETED';
```

**Database Results:** 
```text
  [(1, 1, 'Finish homework', 1, datetime.date(2026, 10, 12), 120, 'IN_PROGRESS'), (2, 1, 'Buy groceries', 2, datetime.date(2026, 10, 10), 60, 'NOT_STARTED'), (3, 1, 'Pay bill', 1, datetime.date(2026, 10, 8), 20, 'NOT_STARTED'), (6, 1, 'Call the doctor', 1, datetime.date(2026, 10, 15), 15, 'NOT_STARTED')]
```
**Friendly Response:**
Tasks not completed:

- Finish homework (IN_PROGRESS)
- Buy groceries (NOT_STARTED)
- Pay bill (NOT_STARTED)
- Call the doctor (NOT_STARTED)

## Example 7: General Knowledge Question
**Question:** Why is the sky blue?
**Generated SQL:**
```text 
  CANNOT_ANSWER
```

**Response:**
I can't answer that using the current database.

## Example 8: Song Identification
**Question:**  What is this song?
**Generated SQL:**
```text
CANNOT_ANSWER
```
**Response:**
I can't answer that using the current database.

