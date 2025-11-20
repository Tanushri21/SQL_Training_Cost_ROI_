 create table emps(
    emp_id varchar(5) primary key not null, -- unique ID for Employee
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    Depart varchar(100)
 );


create table skills(skill_id varchar(5) primary key not null, -- unique ID for skill (PK)
skill_name varchar(50) not null,
category varchar(50) not null); -- e.g., 'Technical','Soft','Financial


create table emp_skill(
   emp_id varchar(5) references emps(emp_id), -- FK to Employees
   skill_id varchar(5) references skills(skill_id), -- FK to skills
   required_proficiency int not null check (required_proficiency between 1 and 5), -- Target Score(1-5)
   current_proficiency int not null check (current_proficiency between 1 and 5), -- Employee's current score(1-5)
   primary key(emp_id,skill_id) -- Composite Primary Key
);


create table training(sess_id varchar(5) primary key not null,
sess_name varchar(250) not null,
skill_id varchar(5) references skills(skill_id),   -- FK to skills
session_cost numeric(10,2) not null, -- cost for ROI Calculations
post_training_score int check (post_training_score between 0 and 100), -- Effectiveness Score
emp_id varchar(5) references emps(emp_id) -- FK to Employees
);


commit;

