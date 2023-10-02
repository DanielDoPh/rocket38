/*
2023-09-27 Wed
*/
use dbrocket38;

select ga.groupID, ac.accountID, ac.fullname, g.groupName 
from `account` as ac 
	join `groupaccount` as ga on ac.accountID = ga.accountID
	join `group` as g on ga.groupID = g.groupID
where g.groupID =1
union
select ga.groupID, ac.accountID, ac.fullname, g.groupName 
from `account` as ac 
	join `groupaccount` as ga on ac.accountID = ga.accountID
	join `group` as g on ga.groupID = g.groupID
where g.groupID =2;


select 
	ga.groupID, 
	g.groupName, 
	count(ga.groupID) as SL 
from `groupaccount` as ga 
    join `group` as g on ga.groupID = g.groupID
group by ga.groupID
having count(ga.groupID) > 3
union all
-- check here
select 
	ga.groupID, 
	g.groupName, 
	count(ga.groupID) as SL 
from `groupaccount` as ga 
    join `group` as g on ga.groupID = g.groupID
group by ga.groupID
having count(ga.groupID) < 7;




select * from groupaccount;

alter table groupaccount add FOREIGN KEY (groupID) REFERENCES `group` (groupID);
-- drop PRIMARY KEY ;
ALTER TABLE groupaccount
ADD PRIMARY KEY (groupID, accountID);
UPDATE `groupaccount` 
set groupID= 5 where accountID=1 and joindate = '2023-09-22';
insert into groupaccount 
values 
	(1,1,current_date()),
    (1,3,current_date()),
    (1,2,current_date()),
    (1,5,current_date()),
    (1,4,current_date()),
    (2,3,current_date()),(3,1,current_date()),(4,1,current_date()),(3,5,current_date()),(2,1,current_date())
    ;
    
