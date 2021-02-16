-- user credentials
-- belkacem1 : bdda 
-- belkacem2 : bdda
--1)
create table client_f(
    ncl numeric CONSTRAINT pk_client PRIMARY KEY,
    ndept numeric not null,
    nom varchar(20) not null,
    prenom varchar(20) not null,
    tel varchar(10),
    adresse varchar(80),
    solde numeric,
    UNIQUE(nom,prenom,tel)
);

create table produit_f(
    nprod numeric CONSTRAINT pk_produit PRIMARY KEY,
    ndept numeric not null,
    designation varchar(200) not null,
    prix_u numeric not null
);

create table commande_f(
    ncom numeric CONSTRAINT pk_commande PRIMARY KEY,
    ndept numeric not null,
    ncl numeric constraint fk_client REFERENCES client_f(ncl) on delete cascade,
    datecom date not null,
    nprod numeric constraint fk_produit REFERENCES produit_f(nprod) on delete cascade,
    qtecom numeric not null,
    payment numeric not null
);

--2)
create sequence ncl_seq START WITH 1 increment BY 1 ;
create sequence nprod_seq START WITH 1 increment BY 1 ;
create sequence ncom_seq START WITH 1 increment BY 1 ;

--3)
create or replace procedure ajout_client (nom in varchar2, prenom in varchar2, tel in varchar2, adresse in varchar2)
AS
num_post number:=1;
BEGIN 
    insert into client_f values(ncl_seq.nextVal,num_post,nom,prenom,tel,adresse,0 );
END; 
/

exec ajout_client('SAID','MOHAMED', '041450931','ORAN');

-- 4)
create or replace procedure ajout_produit (designation in varchar2, prix_u in number)
AS
num_post number:=1;
BEGIN 
    insert into produit_f values(nprod_seq.nextVal,num_post,designation,prix_u);
END; 
/

exec ajout_produit('Diaries book',800);

create or replace procedure ajout_commande (ncl in number,nprod in number,qtecom in number,payment in number)
AS
num_post number:=1;
prix_u number:=1;
BEGIN 
    insert into commande_f values(ncom_seq.nextVal,num_post,ncl,SYSDATE,nprod,qtecom,payment);
    -- getting the prix_u
    for rec in (select p.prix_u
                from produit_f p
                where p.nprod = nprod) loop
        prix_u:= rec.prix_u;
        exit;
    end loop;
    -- updating the solde field
    update client_f c set c.solde = c.solde + qtecom * prix_u - payment where c.ncl = ncl;

END; 
/

exec ajout_commande(1,1,10,500);

-- 5)
exec ajout_client('BERRAS','BELKACEM', '0779236172','MOSTAGANEM');
exec ajout_client('CHAMBA','LAMBA', '0779236172','ALGER');

exec ajout_produit('Pen',1000);
exec ajout_produit('Chamba Lamba',1000);

exec ajout_commande(2,3,5,5000);
exec ajout_commande(3,2,2,1500);
exec ajout_commande(1,2,8,8000);
exec ajout_commande(3,1,7,7000);
exec ajout_commande(2,1,6,6000);

-- 6)
create database link dept1 
connect to belkacem1 identified by bdda
using 'orcl';

-- 7)
select * from client_f@dept1;

-- 8)
create or replace view client as ( select * from client_f union all select * from client_f@dept1);
create or replace view produit as ( select * from produit_f union all select * from produit_f@dept1);
create or replace view commande as ( select * from commande_f union all select * from commande_f@dept1);

-- 9)
create table Devis1(
    nlot number constraint pk_devis1 PRIMARY KEY,
    commentaire1 varchar2(20),
    CONSTRAINT in_values CHECK (commentaire1 IN ('défectueux','non défectueux'))
);

create table Devis2(
    nlot number constraint pk_devis2 PRIMARY KEY,
    commentaire2 varchar2(20),
    CONSTRAINT in_values2 CHECK (commentaire2 IN ('défectueux','non défectueux'))
);


insert into Devis1 VALUES(1,'défectueux');
insert into Devis1 VALUES(2,'non défectueux');
insert into Devis1 VALUES(3,'défectueux');
insert into Devis1 VALUES(4,'non défectueux');
insert into Devis1 VALUES(5,'défectueux');

insert into Devis2 VALUES(1,'non défectueux');
insert into Devis2 VALUES(2,'défectueux');
insert into Devis2 VALUES(3,'non défectueux');
insert into Devis2 VALUES(4,'défectueux');
insert into Devis2 VALUES(5,'non défectueux');


create or replace view alldevis as (select d1.nlot, d1.commentaire1, d2.commentaire2 from Devis1 d1, Devis2 d2 where d1.nlot = d2.nlot);


-- 10)
create or replace procedure delete_client (nom in varchar2, prenom in varchar2, tel in varchar2)
AS
ndept number;
id number;
BEGIN 
    for rec in (select c.ndept, c.ncl
                from client c
                where c.nom = nom and c.prenom = prenom and c.tel = tel
                ) loop
        ndept:=rec.ndept;
        id:=rec.ncl;
        exit;
    end loop;
    DBMS_OUTPUT.PUT_LINE ('---------------------------------------------------');
    dbms_output.put_line(''||id);
    if ndept is not null then
        if ndept = 1 then
            delete from client_f@dept1 c where c.ncl = id;
        else
            delete from client_f c where c.ncl = id;
        end if;
    end if;
END; 
/

exec delete_client('BERRAS','BELKACEM', '0779236172');