-- this script updates the tables TASKANA_SCHEMA_VERSION and ATTACHMENT.

SET SCHEMA %schemaName%;

INSERT INTO TASKANA_SCHEMA_VERSION (VERSION, CREATED) VALUES ('4.3.0', CURRENT_TIMESTAMP);

ALTER TABLE ATTACHMENT ALTER COLUMN REF_SYSTEM DROP NOT NULL ALTER COLUMN REF_INSTANCE DROP NOT NULL;

CALL SYSPROC.ADMIN_CMD ('REORG TABLE ATTACHMENT');