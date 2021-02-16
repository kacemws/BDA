
--1) fact function :
create or replace function factoriel(x in number)
return number
Is 
  fact number:=1;
begin
  for i in 1..x loop
    fact:=fact*i;
  end loop;
  return fact;
end;


declare
res number;
begin
res:=factoriel(10);
dbms_output.put_line(' Factoriel de 10 est : ' || res); 
END; 
/
--2) montant :
delete from client;
alter table client add montant numeric;

--3) procédure
create or replace procedure Ajout_client (nom_client in varchar2, prenom_client in varchar2, date_naiss in date, adresse in varchar2)
IS
BEGIN 
    insert into client values(id_client.nextVal,nom_client,prenom_client,date_naiss, adresse, 0 );
    dbms_output.put_line(' added client ! '); 
END; 


exec Ajout_client('kamel','Ahmed',TO_DATE('14/05/1991', 'dd/mm/yyyy'),'ORAN'); 
select * from client;

--4) somme
delete from vente;
alter table vente add somme numeric;

--5) procédure Ajout_qte
create or replace procedure Ajout_qte (id_client in number, l_ref_livre in varchar2,qte_vendue in number ,date_de_vente in date)
AS
somme number;
BEGIN 
    somme:=0;
    
    select l.prix into somme
    from livre l
    where l.ref_livre = l_ref_livre;

    somme:= somme*qte_vendue;
    
    INSERT INTO vente VALUES(l_ref_livre,qte_vendue,date_de_vente, num_v.nextVal, id_client, somme);
    dbms_output.put_line(' added vente ! '|| somme); 
END; 
/

exec Ajout_qte(43,'Liv3',5,TO_DATE('27/01/2021', 'dd/mm/yyyy')); 
/

--6) 
create or replace trigger insert_montant 
after insert on vente 
for each ROW  
BEGIN 
    update client
    set montant = :NEW.somme
    where id_client = :NEW.id_client;
    dbms_output.put_line(' added montant to user : '); 
END; 
/

--7) 
select * from client;
exec Ajout_qte(43,'Liv3',5,TO_DATE('27/01/2021', 'dd/mm/yyyy')); 
/
select * from client;









create or replace function | procedure name_of_func (var in number)
return number
IS | AS


-- declare 
-- inits

begin
--core function

end;
/


varchar2 | number | date


create or replace trigger name_of_trigger
after | before | instead of

insert | update | delete of name_of_column

on table_name