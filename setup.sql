create table user (
    user_id int auto_increment primary key,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    email varchar(200) not null,
);

create table task (
    task_id int auto_increment primary key,
    user_id int not null,
    title varchar(30) not null,
    priority int not null,
    deadline date not null,
    estimated_duration int not null,

    status enum('COMPLETED', 'IN_PROGRESS', 'NOT_STARTED') not null default 'NOT_STARTED',
   
    foreign key (user_id) references User (user_id)
);

create table fixed_block (
    block_id int auto_increment primary key,
    user_id int not null,
    title varchar(150) not null,
    start_time datetime not null,
    end_time datetime not null,
    
    recurrence_type enum (
        'ONCE',
        'DAILY',
        'WEEKLY',
        'MONTHLY'
    ) not null default 'once',

    recurrence_rule varchar(255) null,

    foreign key (user_id) references User (user_id)   
);

create table schedule_entry (
    schedule_entries_id int auto_increment primary key,
    user_id int not null.
    task_id int null,
    block_id int null,

    start_datetime datetime not null,
    end_datetime datetime not null,
    created_by date,
    is_locked boolean not null default false,

    foreign key (user_id) references User (user_id),
    foreign key (task_id) references Task (task_id),
    foreign key (block_id) references Fixed_block (block_id)

)

create table time_entry (
    time_entry_id int auto_increment primary key,
    task_id int not null,
    start_datetime datetime not null,
    end_datetime datetime not null,
    duration_minutes int not null,

    foreign key (task_id) references Task (task_id),
)




