-- Mattéo KERVADEC et Stanislas ROLLAND
-- Groupe C24 - 1A
-- SAE1.04 - Base de Données

-- Rénitialise le shéma si il existe

DROP SCHEMA IF EXISTS programme_but cascade;

-- Création du shéma

CREATE SCHEMA programme_but ;
SET SCHEMA 'programme_but' ;

-- Création des tables

CREATE TABLE competences (
    lib_competence VARCHAR(50) NOT NULL,
    CONSTRAINT competences_pk PRIMARY KEY(lib_competence)
);

CREATE TABLE activites (
    lib_activite VARCHAR(50) NOT NULL,
    lib_competence VARCHAR(50) NOT NULL,
    CONSTRAINT activites_pk PRIMARY KEY(lib_activite),
    CONSTRAINT releve_de_pk FOREIGN KEY(lib_competence) REFERENCES competences(lib_competence)
);

CREATE TABLE parcours (
    code_p CHAR(1),
    libelle_parcours VARCHAR NOT NULL,
    nbre_gpe_td_p INT,
    nbre_gpe_tp_p INT,
    CONSTRAINT parcours_pk PRIMARY KEY(code_p)
);

CREATE TABLE niveau (
    numero_n INT,
    CONSTRAINT niveau_pk PRIMARY KEY(numero_n)
);

CREATE TABLE semestre (
    numero_sem VARCHAR(50) NOT NULL,
    CONSTRAINT semestre_pk PRIMARY KEY(numero_sem)
);

CREATE TABLE ue (
    code_ue VARCHAR(50) NOT NULL,
    numero_sem VARCHAR(50) NOT NULL, 
    lib_activite VARCHAR(50) NOT NULL,
    CONSTRAINT ue_pk PRIMARY KEY(code_ue),
    CONSTRAINT est_realise_dans_fk FOREIGN KEY (lib_activite) REFERENCES activites(lib_activite),
    CONSTRAINT dans_fk FOREIGN KEY (numero_sem) REFERENCES semestre(numero_sem)
);

CREATE TABLE ressources (
    code_r VARCHAR(50) NOT NULL,
    lib_r VARCHAR(50) NOT NULL,
    nb_h_td_pn INT,
    nb_h_tp_pn INT,
    nb_h_cm_pn INT,
    CONSTRAINT ressources_pk PRIMARY KEY (code_r)
);

CREATE TABLE sae (
    code_sae CHAR(5),
    lib_sae VARCHAR(50) NOT NULL,
    nb_h_td_enc INT,
    nb_h_tp_projet_autonomie INT,
    CONSTRAINT sae_pk PRIMARY KEY (code_sae)
);

-- Création des relations

CREATE TABLE correspond (
    lib_activite VARCHAR(50) NOT NULL,
    numero_n INT,
    code_p CHAR(1),
    CONSTRAINT correspond_pk PRIMARY KEY (lib_activite, numero_n, code_p),
    CONSTRAINT correspond_fk_activite FOREIGN KEY (lib_activite) REFERENCES activites(lib_activite),
    CONSTRAINT correspond_fk_niveau FOREIGN KEY (numero_n) REFERENCES niveau(numero_n),
    CONSTRAINT correspond_fk_parcours FOREIGN KEY (code_p) REFERENCES parcours(code_p)
);

CREATE TABLE fait_partie (
    numero_n INT,
    numero_sem VARCHAR(50) NOT NULL,
    CONSTRAINT fait_partie_pk PRIMARY KEY (numero_n,numero_sem),
    CONSTRAINT fait_partie_fk_niveau FOREIGN KEY (numero_n) REFERENCES niveau(numero_n),
    CONSTRAINT fait_partie_fk_semestre FOREIGN KEY (numero_sem) REFERENCES semestre(numero_sem)
);

CREATE TABLE quand (
    numero_sem VARCHAR(50) NOT NULL,
    code_r VARCHAR(50) NOT NULL,
    CONSTRAINT quand_pk PRIMARY KEY (numero_sem,code_r),
    CONSTRAINT quand_fk_semetre FOREIGN KEY (numero_sem) REFERENCES semestre(numero_sem),
    CONSTRAINT quand_fk_ressources FOREIGN KEY (code_r) REFERENCES ressources(code_r)
);

CREATE TABLE est_enseigne (
    code_p CHAR(1),
    code_r VARCHAR(50) NOT NULL,
    CONSTRAINT est_enseigne_pk PRIMARY KEY (code_p,code_r),
    CONSTRAINT est_enseigne_fk_parcours FOREIGN KEY (code_p) REFERENCES parcours(code_p),
    CONSTRAINT est_enseigne_fk_ressources FOREIGN KEY (code_r) REFERENCES ressources(code_r)
);

-- Création des tables relationnels

CREATE TABLE r_comp (
    code_r VARCHAR(50) NOT NULL,
    code_sae CHAR(5),
    nb_h_td_c INT,
    nb_h_tp_c INT,
    CONSTRAINT r_comp_pk PRIMARY KEY(code_r,code_sae),
    CONSTRAINT comprend_r_fk FOREIGN KEY(code_sae) REFERENCES sae(code_sae),
    CONSTRAINT r_comp_fk_ressources FOREIGN KEY(code_r) REFERENCES ressources(code_r)
);

-- Affiche les tables du schéma programme_but
\d