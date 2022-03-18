show databases;
use e2e;
show tables;

select * from H1N1 limit 20;

delimiter $$
CREATE TRIGGER h1n1_concern_trigger BEFORE INSERT ON H1N1
FOR EACH ROW
BEGIN 
IF NEW.h1n1_concern >3 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'H1N1 concern should be a numerical value between 0 and 3. Please try again.';
END IF; 
END; 
$$ 

insert into H1N1(h1n1_concern) VALUE (8);

