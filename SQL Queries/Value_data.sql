-- Table emps

insert into emps (emp_id,first_name,last_name,Depart) 
values(1,'Robert','John','Marketing'),
(2,'Sam','Tom','IT'),
(3,'Sherly','Nick','Seller'),
(4,'Chandler','Bing','Cyber'),
(5,'Chi','Ling','Admin'),
(6,'Max','Johnson','Support'),
(7,'Monica','Gellerd','Food'),
(8,'Alice','W','Sales'),
(9,'Carol','Davis','Finance'),
(10,'Emily','Wilson','Product Development');


select * from emps;

-- Table skill

insert into skills(skill_id,skill_name,category) 
values('S01','Communication','Market'),
('S02','Python Programming','Technicl'),
('S03','Media Marketing','Ecom'),
('S04','Cyber security','Cyber_Security'),
('S05','Management','Workspace Management'),
('S06','IT Troubleshooting','Technical Support'),
('S07','Indian Cuisine','South Asia Food'),
('S08','Story Telling','Sales & Marketing'),
('S09','Ms excel','Bank Finance'),
('S10','Developer','App Development');

commit;

select * from skills;

-- Table emp_skill

INSERT INTO emp_skill(emp_id, skill_id, required_proficiency, current_proficiency)
VALUES
(1,'S01',5,4), 
(2,'S02',5,4),
(3,'S03',5,3),
(4,'S04',5,3),
(5,'S05',5,2),
(6,'S06',5,1),
(7,'S07',5,2),
(8,'S08',5,3),
(9,'S09',5,4),
(10,'S10',5,3);

commit;

select * from emp_skill;


-- Table training

insert into training(sess_id,sess_name,skill_id,session_cost,post_training_score,emp_id)
values ('Se01','Master class','S01',599,100,1),
('Se02','Python MasterClass','S02',1299,98,2),
('Se03','Master Media','S03',399,91,3),
('Se04','Cyber Training','S04',1399,96,4),
('Se05','Management class','S05',499,98,5),
('Se06','IT Support class','S06',799,90,6),
('Se07','Learn Cooking','S07',699,98,7),
('Se08','Sale storytelling','S08',1299,93,8),
('Se09','Master MS Excel','S09',1899,99,9),
('Se10','Master JavaScript','S10',2999,100,10);


select * from training;


commit;








