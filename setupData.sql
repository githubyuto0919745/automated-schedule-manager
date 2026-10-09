USE task_manager;

insert into user 
    (user_id, first_name,last_name, email) 
values
    (1, 'John', 'Smith', 'john.smith@example.com'),
    (2, 'Emily', 'Johnson', 'emily.johnson@example.com'),
    (3, 'Michael', 'Brown', 'michael.brown@example.com');

-- Priority: 1= low, 2= medium, 3 = high

insert into task
    (task_id ,user_id,title ,priority,deadline, estimated_duration, status)
values 
     (1, 1, 'Finish homework', 1, '2026-10-12', 120, 'IN_PROGRESS'),
    (2, 1, 'Buy groceries', 2, '2026-10-10', 60, 'NOT_STARTED'),
    (3, 1, 'Pay bill', 1, '2026-10-08', 20, 'NOT_STARTED'),
    (4, 1, 'Clean room', 3, '2026-10-14', 45, 'COMPLETED'),
    (5, 1, 'Go to the gym', 2, '2026-10-09', 60, 'COMPLETED'),
    (6, 1, 'Call the doctor', 1, '2026-10-15', 15, 'NOT_STARTED');

insert into fixed_block 
    (block_id, user_id, title, start_datetime, end_datetime, recurrence_type, recurrence_rule)
values 
    (1, 1, 'Work',
     '2026-10-09 09:00:00', '2026-10-09 17:00:00',
     'WEEKLY', 'MON,TUE,WED,THU,FRI'),

    (2, 1, 'Class',
     '2026-10-12 13:00:00', '2026-10-12 14:00:00',
     'WEEKLY', 'MON,WED'),

    (3, 1, 'Doctor appointment',
     '2026-10-15 10:00:00', '2026-10-15 11:00:00',
     'ONCE', NULL);

insert into schedule_entry
    (schedule_entry_id, user_id, task_id, block_id, start_datetime, end_datetime, is_locked)
values 
    (1, 1, 1, NULL,
     '2026-10-09 18:00:00', '2026-10-09 20:00:00', FALSE),

    (2, 1, 2, NULL,
     '2026-10-10 10:00:00', '2026-10-10 11:00:00', FALSE),

    (3, 1, 6, NULL,
     '2026-10-14 15:00:00', '2026-10-14 15:15:00', FALSE),

    (4, 1, NULL, 1,
     '2026-10-09 09:00:00', '2026-10-09 17:00:00', TRUE),

    (5, 1, NULL, 2,
     '2026-10-12 13:00:00', '2026-10-12 14:00:00', TRUE),

    (6, 1, NULL, 3,
     '2026-10-15 10:00:00', '2026-10-15 11:00:00', TRUE);


insert into time_entry 
    (time_entry_id, task_id, start_datetime, end_datetime, duration_minutes)
values     
    (1, 1, '2026-10-08 18:00:00', '2026-10-08 19:00:00', 60),
    (2, 4, '2026-10-07 16:00:00', '2026-10-07 16:45:00', 45),
    (3, 5, '2026-10-08 17:00:00', '2026-10-08 18:00:00', 60);     