-- Question 1 --
    -- a --
    alter table client add CONSTRAINT unique_values UNIQUE (nom_client,prenom_client,date_naiss);
    -- b --
    alter table vente add CONSTRAINT limite_qte check(qte_vendue >= 0 and qte_vendue <= 100);
    -- c --
    alter table client add COLUMN adresse varchar(80);
    -- d --
    alter table client ADD CONSTRAINT in_values CHECK (adresse IN ('ORAN','TLEMCEN', 'MOSTAGANEM')); 


-- Question 2 --
    -- a --
        -- vente --
        delete from vente;
        -- client --
        delete from client;
    -- b --
    alter table vente drop constraint vente_pkey;
    alter table vente add COLUMN num_v numeric CONSTRAINT PK_VENTE PRIMARY KEY;
    alter table vente alter column id_client set NOT NULL;
    alter table vente alter column ref_livre set NOT NULL;

    -- c --
    alter table vente drop column id_client;
    -- d --
    alter table vente add column id_client numeric CONSTRAINT FK_Client REFERENCES Client(Id_Client) ON DELETE CASCADE NOT NULL;
    -- e --
    create sequence id_client START WITH 1 increment BY 1 owned by client.id_client;
    -- f --
    create sequence num_v START WITH 1 increment BY 1 owned by vente.num_v;
    -- g --
        -- client --
            insert into client values(nextval('id_client'),'MOKHTARI','Mohamed',TO_DATE('03/07/1986', 'dd/mm/yyyy'), 'MOSTAGANEM' );
            insert into client values(nextval('id_client'),'BENHMED','Sarah',TO_DATE('24/07/1984', 'dd/mm/yyyy'), 'ORAN');
        -- vente -- 
            INSERT INTO vente VALUES('Liv1',2,TO_DATE('13/10/2013', 'dd/mm/yyyy'), nextval('num_v'), 1 );
            INSERT INTO vente VALUES('Liv3',1,TO_DATE('18/07/2013', 'dd/mm/yyyy'), nextval('num_v'), 2 );
    -- h --
        -- delete --
            delete from client where id_client = 1;
        -- explication --
            -- lorsqu'un client est supprimé, les lignes qui font référence a celui là son supprimé de la table vente, et celà est du à la contrainte On DELETE CASCADE, 
            -- cette contrainte référentielle déclanche une transaction qui supprime les élements enfants lorsque le parent est suppprimé.



--change nextval() by field.nextVal--