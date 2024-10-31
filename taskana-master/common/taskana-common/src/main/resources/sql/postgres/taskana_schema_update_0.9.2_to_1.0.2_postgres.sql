-- this script migrates the schema only. 
-- data is not migrated, as this is currently not necessary.

SET SCHEMA %schemaName%;

DROP TABLE TASKANA_SCHEMA_VERSION;

CREATE TABLE TASKANA_SCHEMA_VERSION(
        ID INT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
        VERSION VARCHAR(255) NOT NULL,
        CREATED TIMESTAMP NOT NULL,
        PRIMARY KEY (ID)
);
INSERT INTO TASKANA_SCHEMA_VERSION (VERSION, CREATED) VALUES ('0.9.2', CURRENT_TIMESTAMP);
INSERT INTO TASKANA_SCHEMA_VERSION (VERSION, CREATED) VALUES ('1.0.2', CURRENT_TIMESTAMP);

DROP TABLE JOB;

CREATE TABLE SCHEDULED_JOB(
        JOB_ID          INTEGER NOT NULL,
        PRIORITY        INTEGER NULL,
        CREATED         TIMESTAMP NULL,
        DUE             TIMESTAMP NULL,
        STATE           VARCHAR(32) NULL,
        LOCKED_BY       VARCHAR(32) NULL,
        LOCK_EXPIRES    TIMESTAMP NULL,
        TYPE            VARCHAR(32) NULL,
        RETRY_COUNT     INTEGER NOT NULL,
        ARGUMENTS       TEXT NULL,
        PRIMARY KEY (JOB_ID)
);

DROP SEQUENCE JOB_SEQ;

CREATE SEQUENCE SCHEDULED_JOB_SEQ
  MINVALUE 1
  START WITH 1
  INCREMENT BY 1
  CACHE 10;
 
ALTER TABLE CLASSIFICATION
		ADD COLUMN PARENT_KEY
		VARCHAR(32) NOT NULL DEFAULT '';

UPDATE CLASSIFICATION C 
	SET C.PARENT_KEY = 
		(SELECT KEY FROM CLASSIFICATION WHERE ID = C.PARENT_ID) 
	WHERE C.PARENT_ID != '';
 
ALTER TABLE TASK
	ADD COLUMN CALLBACK_INFO
	TEXT NULL DEFAULT NULL;

ALTER TABLE WORKBASKET_ACCESS_LIST
	ADD COLUMN ACCESS_NAME
	VARCHAR(255) NULL DEFAULT NULL;
