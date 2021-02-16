--Question 1
create user user1 identified by password;
grant dba to user1;


--Question 2
--Question 2 - a
CREATE TABLE Client(
    num numeric CONSTRAINT PK_Client PRIMARY KEY,
    nom varchar(20) NOT NULL,
    prenom varchar(20) NOT NULL,
    date_naiss date NOT NULL,
    UNIQUE (nom,prenom,date_naiss)
);
--Question 2-b
INSERT INTO client VALUES(01,'MOKHTARI','Mohamed',TO_DATE('03/07/1986', 'dd/mm/yyyy') );
INSERT INTO client VALUES(02,'BENHMED','Sarah',TO_DATE('24/07/1984', 'dd/mm/yyyy') );
INSERT INTO client VALUES(03,'CHETTAB','Nadia',TO_DATE('28/01/1988', 'dd/mm/yyyy') );

--Question 3-a
select * from client;

--Question 3-b
select * from client;

--Question 3-c
--  while logged in to the same user, the first screen shows the added rows but the second doesn't

--Question 3-d
commit;

--Question 3-e
select * from client;

--Question 3-f
--  the previous commit; command confirmed the insertion transaction

--Question 4
-- user 1 :
grant select on client to belkacem;
-- belkacem : 
select * from user1.client;

-- Question 5-a
select * from user1.client;

-- Question 5-b
create or replace synonym s_client for user1.client;

-- Question 5-c
select * from s_client;

-- Question 5-d-1
insert into s_client values(id_client.nextVal,'Berras','Belkacem',TO_DATE('10/10/1999', 'dd/mm/yyyy') );
commit;

-- Question 5-d-2
select * from s_client;
-- on peut pas lire les lignes insérés par nos camarades, et cela est dû au fait que la transactions d'insertion n'a pas été confirmé 

-- Question 5-d-3
select * from s_client;

-- Question 6-a
lock table s_client in exclusive mode nowait;
-- Question 6-b
-- Oui
-- Question 6-c
lock table s_client in exclusive mode;

-- Question 6-d
commit;



