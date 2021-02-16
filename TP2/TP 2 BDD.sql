-- Question 1 --
    -- a --
    alter table client add CONSTRAINT unique_values UNIQUE (nom_client,prenom_client,date_naiss);
    -- b --
    alter table vente add CONSTRAINT limite_qte check(qte_vendue >= 0 and qte_vendue <= 100);
    -- c --
    alter table client add adresse varchar(80);
    -- d --
    alter table client ADD CONSTRAINT in_values CHECK (adresse IN ('ORAN','TLEMCEN', 'MOSTAGANEM')); 


-- Question 2 --
    -- a --
        -- vente --
        delete from vente;
        -- client --
        delete from client;
    -- b --
    select constraint_name from user_constraints where table_name = 'VENTE'
    alter table vente drop constraint PK_VENTE;
    alter table vente add num_v numeric CONSTRAINT PK_VENTE PRIMARY KEY;
    alter table vente modify (id_client NOT NULL);
    alter table vente modify (ref_livre NOT NULL);

    -- c --
    alter table vente drop column id_client;
    -- d --
    alter table vente add id_client numeric CONSTRAINT FK_Client REFERENCES Client(Id_Client) ON DELETE CASCADE NOT NULL;
    -- e --
    create sequence id_client START WITH 1 increment BY 1;
    -- f --
    create sequence num_v START WITH 1 increment BY 1;
    -- g --
        -- client --
            insert into client values(id_client.nextVal,'MOKHTARI','Mohamed',TO_DATE('03/07/1986', 'dd/mm/yyyy'), 'MOSTAGANEM' );
            insert into client values(id_client.nextVal,'BENHMED','Sarah',TO_DATE('24/07/1984', 'dd/mm/yyyy'), 'ORAN');
        -- vente -- 
            INSERT INTO vente VALUES('Liv1',2,TO_DATE('13/10/2013', 'dd/mm/yyyy'), num_v.nextVal, 1 );
            INSERT INTO vente VALUES('Liv3',1,TO_DATE('18/07/2013', 'dd/mm/yyyy'), num_v.nextVal, 2 );
    -- h --
        -- delete --
            delete from client where id_client = 1;
        -- explication --
            -- lorsqu'un client est supprimé, les lignes qui font référence a celui là son supprimé de la table vente, et celà est du à la contrainte On DELETE CASCADE, 
            -- cette contrainte référentielle déclanche une transaction qui supprime les élements enfants lorsque le parent est suppprimé.

