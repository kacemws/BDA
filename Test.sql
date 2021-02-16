--- table cycle
create table table_name(
    attr1 numeric constraint ctr_name primary key
    attr2 varchar(xx) constraint ctr_name references table(pk)
    attr3 date
    constraint ctr_name unique | not null | primary key | foreign key | check
);


drop table table_name;


alter table table_name add | alter | drop 
                                            constraint | column ....

-- table rows cycle


insert into table_name values(attr1, attr2, to_date(attr3, 'format'))

select * from table_name

update table_name set attr1 = neValue where....


delete from table_name where.....


-- utils

---sequence

create sequence seq_name start with 1 increment by 1;

seq_name.nextVal;


-- body
declare
var1 number:=0;
begin
--func
end;


-- function
create or replace function name_of_func ( attr in type)
return type
is
var1 number:=0;
begin
--func
end;


-- procedure
create or replace procedure name_of_proc ( attr in type)
is
var1 number:=0;
begin
--func
end;


--trigger
create or replace trigger name_of_trigger
after | before | instead of

insert | update | delete of name_of_column

on table_name

for each row
when condition

declare

begin 
end;


-- condition

if (ctd) then


end if;



if (ctd) then

else 


end if;


-- loops