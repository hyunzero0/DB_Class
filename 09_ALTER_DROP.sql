-- 0410
-- DDL(ALTER, DROP)
-- DELETE�� �÷�, ALTER/DROP�� ���̺� ����
-- ARTER : ����Ŭ�� ���ǵǾ� �ִ� ������Ʈ�� ������ �� ����ϴ� ��ɾ�
-- ALTER TABLE : ���̺� ���ǵǾ� �ִ� �÷�, ���������� ������ �� ���
CREATE TABLE TBL_USERALTER(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(20)
);
SELECT * FROM TBL_USERALTER;
-- 1. ������ TBL_USERALTER ���̺� �÷��� �߰��ϱ�
--      ALTER TABLER ���̺�� ADD (�÷��� �ڷ��� [��������])
ALTER TABLE TBL_USERALTER ADD (USER_NAME VARCHAR2(20));
DESC TBL_USERALTER;
INSERT INTO TBL_USERALTER VALUES(1, 'ADMIN', '1234', '������');

--      ���̺� �����Ͱ� �ִ� ���¿��� �÷��� �߰��ϸ�?? �����ұ�??
ALTER TABLE TBL_USERALTER ADD (NICKNAME VARCHAR2(30));
SELECT * FROM TBL_USERALTER; 

--      �̸��� �ּ� �߰��� �� NOT NULL �������� ����
ALTER TABLE TBL_USERALTER ADD(EMAIL VARCHAR2(40) DEFAULT '�̼���' NOT NULL);
ALTER TABLE TBL_USERALTER ADD(GENDER VARCHAR2(10) CONSTRAINT GENDER_CK CHECK (GENDER IN('��', '��')));
INSERT INTO TBL_USERALTER VALUES(2, 'USER01', 'USER01', '����1', '����', 'USER01@USER01.COM', '��');

-- 2. �������� �߰��ϱ�
--      ALTER TABLE ���̺�� ADD CONSTRAINT �������Ǹ� �������Ǽ���
ALTER TABLE TBL_USERALTER ADD CONSTRAINT USERID_UQ UNIQUE(USER_ID);
INSERT INTO TBL_USERALTER VALUES(3, 'USER01', 'USER02', '����2', '����2', 'USER01@USER02.COM', '��'); -- X
INSERT INTO TBL_USERALTER VALUES(3, 'USER02', 'USER02', '����2', '����2', 'USER01@USER02.COM', '��'); -- O

--      NOT NULL ���������� �̹� �÷��� NULLABLE�� ������ �Ǿ��ֱ� ������ ADD�� �ƴ� MODIFY �������� ����� �Ѵ�.
--ALTER TABLE TBL_USERALTER ADD CONSTRAINT PASSWORD_NN NO NULL(PASSWORD);
ALTER TABLE TBL_USERALTER MODIFY USER_PWD CONSTRAINT PASSWORD_NN NOT NULL;

-- 1. �÷� �����ϱ� -> �÷��� Ÿ��, ũ�⸦ �����ϴ� ��
-- ALTER TABLE ���̺�� MODIFY �÷��� �ڷ���
DESC TBL_USERALTER;
ALTER TABLE TBL_USERALTER MODIFY GENDER CHAR(10);

-- 2. �������� �����ϱ�
ALTER TABLE TBL_USERALTER
MODIFY USER_PWD CONSTRAINT USER_PWD_UQ UNIQUE;

-- 1. �÷��� �����ϱ�
--      ALTER TABLE ���̺�� RENAME COLUMN �÷��� TO �� �÷���
ALTER TABLE TBL_USERALTER RENAME COLUMN USER_ID TO USERID;
DESC TBL_USERALTER;

-- 2. �������Ǹ� �����ϱ�
--      ALTER TABLE ���̺�� RENAME CONSTRAINT �������Ǹ� TO �� �������Ǹ�
ALTER TABLE TBL_USERALTER RENAME CONSTRAINT SYS_C007439 TO USERALTER_PK;

-- 1. �÷� �����ϱ�
--       ALTER TABLE ���̺�� DROP COLUMN �÷���
ALTER TABLE TBL_USERALTER DROP COLUMN EMAIL;
DESC TBL_USERALTER;

-- 2. �������� �����ϱ�
--      ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ�
ALTER TABLE TBL_USERALTER DROP CONSTRAINT USERALTER_PK;

-- 3. ���̺� �����ϱ�
DROP TABLE TBL_USERALTER;
SELECT * FROM TBL_USERALTER; -- ���̺� �Ǵ� �䰡 �������� �ʽ��ϴ�
--      ���̺��� ������ �� FK ���������� �����Ǿ� �ִٸ� �⺻������ ������ �Ұ�����
ALTER TABLE EMP_COPY ADD CONSTRAINT EMP_ID_PK PRIMARY KEY(EMP_ID);
CREATE TABLE TBL_FKTEST(
    EMP_ID VARCHAR(20) CONSTRAINT FK_EMPID REFERENCES EMP_COPY(EMP_ID),
    CONTENT VARCHAR(20)
);

DROP TABLE EMP_COPY; 
-- �ɼ��� �����ؼ� ������ �� �ִ�
DROP TABLE EMP_COPY CASCADE CONSTRAINT; -- ���� �ȵǴ� �� �����ϰ� ���� ���� ����


-- DCL�� ���� �˾ƺ���. -> SYSTEM ������ ����
-- ������� ���� �����ϴ� ��ɾ�
-- GRANT ����, ���� TO ����ڰ�����
-- ���� : CREATE VIEW, CREATE TABLE, INSERT, SELECT, UPDATE ��
-- ����(ROLE) : ������ ����
-- �� ����(ROLE)�� �ο��� ���� Ȯ���ϱ�
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'RESOURCE'; -- DBA����(SYSTEM)���� �����ؼ� ������
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'CONNECT'; 

ALTER SESSION SET "_ORACLE_SCRIPT" =TRUE;
CREATE USER QWER IDENTIFIED BY QWER DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
GRANT CONNECT TO QWER;

-- BS������ ���̺��� ��ȸ�� �� �ִ� ���� �ο��ϱ�
GRANT SELECT ON BS.EMPLOYEE TO QWER;
GRANT UPDATE ON BS.EMPLOYEE TO QWER;

-- ���� ȸ���ϱ�
-- REVOKE ���� || ROLE FROM ����ڰ�����
REVOKE UPDATE ON BS.EMPLOYEE FROM QWER;

-- ROLE �����
CREATE ROLE MYROLE;
GRANT CREATE TABLE, CREATE VIEW TO MYROLE;

SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'MYROLE';
GRANT MYROLE TO QWER;


-- QWER/QWER ���� ��Ʈ
SELECT * FROM BS.EMPLOYEE; -- SELECT �ο������� ����
UPDATE BS.EMPLOYEE SET SALARY = 1000000; -- UPDATE �ο������� ����
ROLLBACK;

CREATE TABLE TEST(
    TESTNO NUMBER,
    TESTCONTENT VARCHAR2(200)
);

-- TCL : Ʈ�������� ��Ʈ���ϴ� ��ɾ�
-- COMMIT : ���ݱ��� ������ ��������(DML) ��ɾ ��� DB�� ����
-- ROLLBACK : ���ݱ��� ������ ��������(DML) ��ɾ ��� ���
-- Ʈ������ : �ϳ��� �۾�����, �� �� ����
-- Ʈ�������� ����� �Ǵ� ��ɾ� : DML(INSERT, UPDATE, DELETE)

INSERT INTO JOB VALUES('J0', '����');
SELECT * FROM JOB;
COMMIT;