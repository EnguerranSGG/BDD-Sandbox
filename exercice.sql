CREATE TABLE SEGMENT (N_SEGMENT VARCHAR(10) NOT NULL, NOM_SEGMENT VARCHAR(20) NOT NULL, PRIMARY KEY (N_SEGMENT))

CREATE TABLE SALLE (N_SALLE VARCHAR(7), NOM_SALLE VARCHAR(20), NB_POSTE NUMERIC(3))
ALTER TABLE SALLE ADD PRIMARY KEY (n_salle);
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





