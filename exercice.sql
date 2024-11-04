CREATE TABLE SEGMENT (N_SEGMENT VARCHAR(10) NOT NULL, NOM_SEGMENT VARCHAR(20) NOT NULL, PRIMARY KEY (N_SEGMENT));

CREATE TABLE SALLE (N_SALLE VARCHAR(7), NOM_SALLE VARCHAR(20), NB_POSTE NUMERIC(3), PRIMARY KEY (n_salle));
ALTER TABLE SALLE ADD COLUMN N_SEGMENT VARCHAR(10);
ALTER TABLE SALLE ADD CONSTRAINT FK_N_SEGMENT FOREIGN KEY (N_SEGMENT) REFERENCES segment(n_segment);

CREATE TABLE POSTE (N_POST VARCHAR(7), NOM_POSTE VARCHAR(20), AD VARCHAR(2), TYPE_POST VARCHAR(20))
ALTER TABLE POSTE ADD COLUMN N_SEGMENT VARCHAR(10);
ALTER TABLE POSTE 
ADD CONSTRAINT FK_N_SEGMENT
FOREIGN KEY (N_SEGMENT) REFERENCEs segment(n_segment);
ALTER TABLE POSTE ADD COLUMN N_SALLE VARCHAR(7);
ALTER TABLE poste RENAME COLUMN n_post to n_poste;
ALTER TABLE poste RENAME COLUMN type_post to type_poste;
ALTER TABLE POSTE ADD PRIMARY KEY (n_poste);

ALTER TABLE POSTE 
ADD CONSTRAINT FK_N_SALLE
FOREIGN KEY (N_SALLE) REFERENCES salle(n_salle);

CREATE TABLE LOGICIEL (N_LOGICIEL VARCHAR(7), DATE_ACHAT DATE, VERSIONS VARCHAR(7), TYPE_LOGICIEL VARCHAR(20), PRIMARY KEY (N_LOGICIEL));
ALTER TABLE logiciel ADD COLUMN NOM_LOGICIEL VARCHAR(20);

CREATE TABLE INSTALLER (N_POSTE VARCHAR(7), N_LOGICIEL VARCHAR(7), PRIMARY KEY (N_POSTE, N_LOGICIEL), FOREIGN KEY (N_POSTE) references poste(n_poste), FOREIGN KEY (N_LOGICIEL) references logiciel(n_
logiciel));
ALTER TABLE installer ADD COLUMN date_install DATE;

INSERT INTO segment (N_SEGMENT, NOM_SEGMENT) VALUES ('130.120.80', 'segment 80'), ('130.120.81', 'segment 81'), ('130.120.82', 'segment 82');

INSERT INTO salle (N_SALLE, NOM_SALLE, NB_POSTE, FK_N_SEGMENT) VALUES ('S01', 'Salle 1', 3, '130.120.80'), ('S02', 'Salle 2', 2, '130.120.80'), ('S03', 'Salle 3', 2, '130.120.80'), ('S11', 'Salle 11
', 2, '130.120.81'), ('S12', 'Salle 12', 1, '130.120.81'), ('S21', 'Salle 21', 2, '130.120.82');

INSERT INTO salle (N_SALLE, NOM_SALLE, NB_POSTE, FK_N_SEGMENT) VALUES ('S01', 'Salle 1', 3, '130.120.80'), ('S02', 'Salle 2', 2, '130.120.80'), ('S03', 'Salle 3', 2, '130.120.80'), ('S11', 'Salle 11
', 2, '130.120.81'), ('S12', 'Salle 12', 1, '130.120.81'), ('S21', 'Salle 21', 2, '130.120.82');

INSERT INTO POSTE (N_POSTE, NOM_POSTE,FK_N_SEGMENT, AD, TYPE_POSTE,FK_N_SALLE)
VALUES 
     ('P1', 'Poste 1', '130.120.80', '01', 'TX', 'S01'),
     ('P2', 'Poste 2', '130.120.80', '02', 'UNIX', 'S01'),
     ('P3', 'Poste 3', '130.120.80', '03', 'TX', 'S01'),
     ('P4', 'Poste 4', '130.120.80', '04', 'PCWS', 'S02'),
     ('P5', 'Poste 5', '130.120.80', '05', 'PCWS', 'S02'),
     ('P6', 'Poste 6', '130.120.80', '06', 'UNIX', 'S03'),
     ('P7', 'Poste 7', '130.120.80', '07', 'TX', 'S03'),
     ('P8', 'Poste 8', '130.120.81', '01', 'UNIX', 'S11'),
     ('P9', 'Poste 9', '130.120.81', '02', 'TX', 'S11'),
     ('P10', 'Poste 10', '130.120.81', '03', 'UNIX', 'S12'),
     ('P11', 'Poste 11', '130.120.82', '01', 'PCXP', 'S21')
ON CONFLICT (N_POSTE) DO NOTHING;

 INSERT INTO POSTE (N_POSTE, NOM_POSTE,FK_N_SEGMENT, AD, TYPE_POSTE,FK_N_SALLE)
  VALUES ('P12', 'Poste 12', '130.120.82', '02', 'PCXP', 'S21') ON CONFLICT (N_POSTE) DO NOTHING;

  INSERT INTO LOGICIEL (N_LOGICIEL, NOM_LOGICIEL, DATE_ACHAT, VERSION, TYPE_LOGICIEL)
 VALUES 
     ('Log1', 'Oracle 9i', '2021-05-13', '9.2', 'UNIX'),
     ('Log2', 'Oracle 10g', '2020-09-15', '10.1', 'UNIX'),
     ('Log3', 'Sql Server', '2022-04-12', '2020SE', 'PCXP'),
     ('Log4', '4D', '2020-06-03', '2019.4', 'PCXP'),
     ('Log5', 'Windev', '2021-11-12', '10', 'PCWS'),
     ('Log6', 'Sql*Net', '2021-05-13', '2.5', 'UNIX'),
     ('Log7', 'I. I. S.', '2020-04-12', '6.0', 'PCXP'),
     ('Log8', 'Autocad', '2022-03-21', 'AU2019', 'PCWS')
 ON CONFLICT (N_LOGICIEL) DO NOTHING;

 INSERT INTO INSTALLER (N_POSTE, N_LOGICIEL, DATE_INSTALL)
 VALUES 
     ('P2', 'Log1', '2021-05-15'),
     ('P2', 'Log2', '2020-09-17'),
     ('P4', 'Log5', '2022-05-30'),
     ('P6', 'Log6', '2021-05-20'),
     ('P6', 'Log1', '2021-05-20'),
     ('P8', 'Log2', '2021-05-19'),
     ('P8', 'Log6', '2021-05-20'),
     ('P11', 'Log3', '2022-04-20'),
     ('P12', 'Log4', '2020-06-20'),
     ('P11', 'Log7', '2022-04-20')
 ON CONFLICT (N_POSTE, N_LOGICIEL) DO NOTHING;

 ALter TABLE installer RENAME TO old_installer;

 CREATE TABLE installer (N_POSTE VARCHAR(7), N_LOGICIEL VARCHAR(7), PRIMARY KEY (N_POSTE, N_LOGICIEL), FOREIGN KEY (N_POSTE) references poste(n_poste), FOREIGN KEY (N_LOGICIEL) references logiciel(n_
 logiciel));

MERGE INTO installer AS inst USING old_installer AS old_inst ON inst.n_poste = old_inst.n_poste WHEN NOT MATCHED THEN DO NOTHING WHEN MATCHED AND inst.date_install < old_inst.date_install THEN DELET
 E;

 CREATE table logiciel_type (TYPE_LP varchar(20), NOM_TYPE VARCHAR(25), primary key(TYPE_LP));

 INSERT INTO logiciel_type (TYPE_LP, NOM_TYPE)
 VALUES
     ('TX', 'Terminal X-WINDOW'),
     ('UNIX', 'Système Unix'),
     ('PCXP', 'PC Windows XP'),
     ('PCWS', 'PC Windows Server'),
     ('NC', 'Network Computer');

 MERGE INTO logiciel_type AS lt1 USING logiciel_type AS lt2 ON lt1.type_lp = lt2.type_lp WHEN MATCHED DO NOTHING WHEN NOT MATCHED INSERT (type_lp, nom_type) VALUES (lt2.type_lp, lt2.nom_type);

 ALTER TABLE poste ADD CONSTRAINT fk_type FOREIGN KEY (type_poste) REFERENCES logiciel_type(type_lp);
 ALTER TABLE logiciel ADD CONSTRAINT fk_type FOREIGN KEY (type_logiciel) REFERENCES logiciel_type(type_lp);

 UPDATE logiciel_type SET nom_type = 'Unix' WHERE type_lp = 'UNIX';

 UPDATE installer SET n_logiciel = 'Log2' WHERE n_logiciel = 'Log1';

 ALTER TABLE salle
 DROP CONSTRAINT fk_n_segment,
 ADD CONSTRAINT fk_n_segment
 FOREIGN KEY (n_segment) REFERENCES segment(n_segment)
 ON UPDATE CASCADE;

 ALTER TABLE poste
 DROP CONSTRAINT fk_n_segment,
 ADD CONSTRAINT fk_n_segment
 FOREIGN KEY (n_segment) REFERENCES segment(n_segment)
 ON UPDATE CASCADE;

 UPDATE segment SET n_segment = '130.120.08' WHERE nom_segment = 'segment 80';

 ## Part5

ALTER TABLE installer DROP CONSTRAINT installer_n_poste_fkey1;
ALTER TABLE installer ADD CONSTRAINT fk_n_poste FOREIGN KEY (n_poste) REFERENCES poste(n_poste) ON DELETE CASCADE;

DELETE FROM poste WHERE fk_n_salle = 'S21';

DO $$
 BEGIN
     IF EXISTS (SELECT 1 FROM poste JOIN installer ON installer.n_poste = poste.n_poste WHERE installer.n_logiciel = 'Log7') THEN
         DELETE FROM poste
         USING installer
         WHERE installer.n_poste = poste.n_poste
         AND installer.n_logiciel = 'Log7';
         RAISE NOTICE 'Les enregistrements ont été supprimés.';
     ELSE
         RAISE NOTICE 'Il n''y a aucun PC ayant le logiciel IIS d''installé.';
     END IF;
 END $$

 ALTER TABLE poste
 DROP CONSTRAINT fk_n_salle,
 ADD CONSTRAINT fk_n_salle
 FOREIGN KEY (fk_n_salle) REFERENCES salle(n_salle)
 ON UPDATE CASCADE
 ON DELETE CASCADE;

 DELETE FROM salle WHERE n_salle = 'S01';

 DO $$
 BEGIN
     IF EXISTS (SELECT * FROM poste JOIN installer ON installer.n_poste = poste.n_poste WHERE installer.n_logiciel <> 'Log3') THEN
         DELETE FROM poste
         USING installer
         WHERE installer.n_poste = poste.n_poste
         AND installer.n_logiciel <> 'Log3';
         RAISE NOTICE 'Les enregistrements ont été supprimés.';
     ELSE
         RAISE NOTICE 'Il n''y a aucun PC n''ayant pas le logiciel Slq Server d''installé.';
     END IF;
END $$;

## Partie 2 : 

### Exercice 1

CREATE DATABASE exercice2;

CREATE TABLE entreprise (n_siret varchar(14) NOT NULL, raison_social varchar(20), adresse varchar(50), PRIMARY KEY (n_siret));

CREATE TABLE agence (id varchar(14), adresse varchar(50), PRIMARY KEY (id));
ALTER TABLE agence ADD COLUMN n_siret varchar(14);
ALTER TABLE agence ADD CONSTRAINT fk_n_siret FOREIGN KEY (n_siret) REFERENCES entreprise(n_siret);

INSERT INTO entreprise (n_siret, raison_social, adresse) VALUES 
 ('12345678901234', 'Tech Innov', '12 Avenue des Sciences, 75001 Paris'),
 ('56789012345678', 'Green Solutions', '45 Rue de l''Écologie, 69002 Lyon'),
 ('98765432109876', 'Smart Build', '3 Boulevard de la Construction, 13001 Marseille'),
 ('54321098765432', 'Digital Wave', '99 Rue du Numérique, 33000 Bordeaux');

 INSERT INTO agence (id, adresse, n_siret) VALUES 
 ('AG123', '24 Quai de la Garonne, 31000 Toulouse', '12345678901234'),
 ('AG124', '16 Rue de l''Innovation, 75003 Paris', '12345678901234'),
 ('AG125', '34 Avenue du Progrès, 69003 Lyon', '12345678901234'),
 ('AG126', '1 Boulevard des Sciences, 34000 Montpellier', '12345678901234'),
 ('AG456', '78 Allée des Énergies, 44000 Nantes', '56789012345678'),
 ('AG457', '12 Rue Verte, 38000 Grenoble', '56789012345678'),
 ('AG458', '5 Rue de la Nature, 67000 Strasbourg', '56789012345678'),
 ('AG459', '10 Rue des Plantes, 21000 Dijon', '56789012345678'),
 ('AG789', '22 Place de la Liberté, 59000 Lille', '98765432109876'),
 ('AG790', '50 Rue des Travaux, 31000 Toulouse', '98765432109876'),
 ('AG791', '15 Boulevard de la Construction, 72000 Le Mans', '98765432109876'),
 ('AG792', '9 Rue du Bâtiment, 41000 Blois', '98765432109876'),
 ('AG101', '5 Rue de la Mer, 06000 Nice', '54321098765432'),
 ('AG102', '3 Place du Digital, 69002 Lyon', '54321098765432'),
 ('AG103', '8 Rue des Réseaux, 75015 Paris', '54321098765432'),
 ('AG104', '21 Avenue du Numérique, 33000 Bordeaux', '54321098765432');

CREATE TABLE client (id SERIAL NOT NULL, nom VARCHAR(20) NOT NULL, prenom VARCHAR(20) NOT NULL, adresse VARCHAR(50), num_telephone VARCHAR(10), PRIMARY KEY (id));

CREATE TABLE client_entreprise (
      id_client INTEGER NOT NULL,
      n_siret VARCHAR(14) NOT NULL,
      PRIMARY KEY (id_client, n_siret),
      FOREIGN KEY (id_client) REFERENCES client(id),
      FOREIGN KEY (n_siret) REFERENCES entreprise(n_siret));

INSERT INTO client (nom, prenom, adresse, num_telephone) VALUES
     ('Martin', 'Alice', '12 Rue des Lilas, Paris', '0123456789'),
     ('Dupont', 'Pierre', '34 Avenue des Champs, Lyon', '0234567890'),
     ('Durand', 'Sophie', '56 Boulevard Victor Hugo, Marseille', '0345678901'),
     ('Petit', 'Louis', '78 Rue du Faubourg, Lille', '0456789012'),
     ('Moreau', 'Claire', '90 Rue de Rivoli, Bordeaux', '0567890123');

INSERT INTO client_entreprise (id_client, n_siret) VALUES
     (1, '12345678901234'),  
     (2, '56789012345678'),  
     (3, '98765432109876'),  
     (4, '54321098765432'),  
     (5, '12345678901234');