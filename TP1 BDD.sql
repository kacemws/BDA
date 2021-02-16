
-- CREATE CLIENT TABLE AS SO :
CREATE TABLE Client(
    Id_Client numeric CONSTRAINT PK_Client PRIMARY KEY,
    nom_client varchar(20) NOT NULL,
    prenom_client varchar(20) NOT NULL,
    date_naiss date NOT NULL,
    UNIQUE (nom_client,prenom_client,date_naiss)
);

-- CREATE LIVRE TABLE AS SO :
CREATE TABLE Livre(
    ref_livre varchar(20) CONSTRAINT PK_Livre PRIMARY KEY,
    titre_livre varchar(80) NOT NULL,
    auteur varchar(20) NOT NULL,
    prix numeric NOT NULL,
    UNIQUE (titre_livre,auteur,prix)
);

-- CREATE VENTE TABLE AS SO :
CREATE TABLE Vente (
    Id_Client numeric 
        CONSTRAINT FK_Client REFERENCES Client(Id_Client) ON DELETE CASCADE,
    ref_livre varchar(20) 
        CONSTRAINT FK_Livre REFERENCES Livre(ref_livre) ON DELETE CASCADE,
    qte_vendue numeric NOT NULL,
    date_vente date NOT NULL,
    PRIMARY KEY (Id_Client,ref_livre)
);

--INSERTION PART :
--CLIENTS :  
INSERT INTO client VALUES(01,'MOKHTARI','Mohamed',TO_DATE('03/07/1986', 'dd/mm/yyyy') );
INSERT INTO client VALUES(02,'BENHMED','Sarah',TO_DATE('24/07/1984', 'dd/mm/yyyy') );
INSERT INTO client VALUES(03,'CHETTAB','Nadia',TO_DATE('28/01/1988', 'dd/mm/yyyy') );
INSERT INTO client VALUES(04,'SAID','Amine',TO_DATE('12/10/1990', 'dd/mm/yyyy') );

--LIVRES :  
INSERT INTO livre VALUES('Liv1', 'S''initier à la programmation et à l''orienté objet ', 'C Delannoy',2461.96 );
INSERT INTO livre VALUES('Liv2', 'Linux Administration - Tome 4', 'J-F Bouchaudy',2909.58 );
INSERT INTO livre VALUES('Liv3', 'AutoCAD 2014','J-P Couwenbergh',4028.66 );
INSERT INTO livre VALUES('Liv4', 'jQuery-Ajax avec PHP','J-M Defrance',4364.38 );

--VENTES : 
INSERT INTO vente VALUES(01,'Liv1',2,TO_DATE('13/10/2013', 'dd/mm/yyyy') );
INSERT INTO vente VALUES(01,'Liv3',1,TO_DATE('18/07/2013', 'dd/mm/yyyy') );
INSERT INTO vente VALUES(02,'Liv1',3,TO_DATE('18/07/2013', 'dd/mm/yyyy') );
INSERT INTO vente VALUES(03,'Liv2',1,TO_DATE('01/05/2013', 'dd/mm/yyyy') );
INSERT INTO vente VALUES(03,'Liv3',2,TO_DATE('01/05/2013', 'dd/mm/yyyy') );
INSERT INTO vente VALUES(04,'Liv1',1,TO_DATE('12/02/2013', 'dd/mm/yyyy') );
INSERT INTO vente VALUES(04,'Liv2',1,TO_DATE('12/02/2013', 'dd/mm/yyyy') );
INSERT INTO vente VALUES(04,'Liv3',1,TO_DATE('08/04/2013', 'dd/mm/yyyy') );


--QUESTION 1 :
SELECT COUNT(*) FROM livre;

--QUESTION 2 :
SELECT max(prix) as plus_haut, min(prix) as plus_bas, AVG(prix) as moyenne FROM livre;

--QUESTION 3 :
SELECT nom_client as client, titre_livre as titre, (prix*qte_vendue) as prix_dachat FROM livre l, vente v, client c where l.ref_livre = v.ref_livre and c.Id_Client = v.Id_Client;

--QUESTION 4 :
--SELECT nom_client as client, titre_livre as titre, (prix*qte_vendue) as prix_dachat FROM livre l, vente v, client c where l.ref_livre = v.ref_livre and c.Id_Client = v.Id_Client;

--QUESTION 5 :
SELECT nom_client as client, titre_livre as titre, (prix*qte_vendue) as prix_dachat FROM livre l, vente v, client c where l.ref_livre = v.ref_livre and c.Id_Client = v.Id_Client;
SELECT max(prix) as plus_haut, min(prix) as plus_bas, AVG(prix) as moyenne FROM livre;

--QUESTION 6 :
SELECT ref_livre as ref, titre_livre as titre, prix FROM livre;

--QUESTION 7 :
CREATE VIEW livres_et_prix AS SELECT ref_livre as ref, titre_livre as titre, prix FROM livre;

--QUESTION 8 :
-- Dans notre cas, 
--                  une modification de données est possiblle, une view est non modifiable dans le cas où elle contient des set operators (UNION, INTERSECT, ...), l'opérateur DISTINCT, des fonctions comme (SUM, AVG...) ou bien la clause group by
--                  une insertion est impossible vue la contrainte d'intégrité sur la table livre ou l'auteur ne doit pas être une valeur null
--                  une suppression est possible, et cela est grace au fait que la contrainte on DELETE cascade est spécifié sur la clé étrangère ref_livre

--QUESTION 9 :
UPDATE livres_et_prix SET prix = 7000 WHERE ref='Liv1';

