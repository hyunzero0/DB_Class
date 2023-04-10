-- 0407
-- DML ������ ���� �˾ƺ���
-- ���̺� ����Ǵ� �����͸� �ٷ�� ��ɾ�
--      INSERT : ���̺� ������(ROW)�� �߰��ϴ� ��ɾ�
--      UPDATE : ���̺� �ִ� �������� Ư�� �÷��� �����ϴ� ��ɾ�
--      DELETE : ���̺� �ִ� Ư��ROW�� �����ϴ� ��ɾ�

-- INSERT�� Ȱ���ϱ�
-- 1. ��ü �÷��� ���� �����ϱ�
--      INSERT INTO ���̺�� VALUES(�÷��� ������ ��, �÷��� ������ ��, ...)
--          * �÷��� ������ �� : ���̺� ����� ��� �÷� ���� �����ؾ��Ѵ�.
-- 2. Ư���÷��� ��� ���� �����ϱ�
--      INSERT INTO ���̺��(Ư���÷�, Ư���÷�, ...) VALUES(Ư���÷��� ������ ��, Ư���÷��� ������ ��, ...)
--          * ������ �÷��� ���� VALUES�� �ִ� ���� ���ƾ� ��.
--          * �������� ���� �÷��� ���� NULL�� ���Եȴ�. * ����! ������ �÷��� NOT NULL ���������� ������ �ȵȴ�.

CREATE TABLE TEMP_DEPT
AS SELECT * FROM DEPARTMENT WHERE 1 = 0; -- �÷��� �����
SELECT * FROM TEMP_DEPT;

INSERT INTO TEMP_DEPT VALUES('D0', '�ڹ�', 'L1');
INSERT INTO TEMP_DEPT VALUES('D1', '����Ŭ'); -- X, �÷� �� �ȸ���
INSERT INTO TEMP_DEPT VALUES('D1', '����Ŭ', TO_NUMBER('10'));

-- �÷��� �����ؼ� ���� �����ϱ�
DESC TEMP_DEPT;
INSERT INTO TEMP_DEPT(DEPT_ID, LOCATION_ID) VALUES('D2', 'L3');
SELECT * FROM TEMP_DEPT;
INSERT INTO TEMP_DEPT(DEPT_ID) VALUES('D3'); -- X
CREATE TABLE TESTINSERT(
        TESTNO NUMBER PRIMARY KEY,
        TESTCONTENT VARCHAR2(200) DEFAULT 'TEST' NOT NULL
);
INSERT INTO TESTINSERT(TESTNO) VALUES(1);

-- SELECT���� �̿��ؼ� �� �����ϱ�
-- NOT NULL ���� ���Ǹ� ������
CREATE TABLE INSERT_SUB
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
        FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID WHERE 1=2;
        
SELECT * FROM INSERT_SUB;
INSERT INTO INSERT_SUB(
        SELECT EMP_ID, EMP_NAME, DEPT_TITLE
        FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
        WHERE SALARY >= 3000000
);

SELECT * FROM INSERT_SUB;

-- EMPLOYEE���̺��� �μ��� D6�� ������� INSERT_SUB�� �����ϱ�
INSERT INTO INSERT_SUB(
        SELECT EMP_ID, EMP_NAME, DEPT_TITLE -- �������..
        FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
        WHERE DEPT_CODE = 'D6'
);
SELECT * FROM INSERT_SUB;

-- ������ �÷��� SELECT������ ������ �����ϱ�
INSERT INTO INSERT_SUB(EMP_ID, EMP_NAME)(SELECT EMP_ID, EMP_NAME FROM EMPLOYEE);


-- INSERT ALL
-- SELECT���� �̿��ؼ� �� �� �̻��� ���̺� ���� ���� �� ���
CREATE TABLE EMP_HIRE_DATE
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE FROM EMPLOYEE WHERE 1=0;

CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID FROM EMPLOYEE WHERE 1=0;

INSERT ALL
INTO EMP_HIRE_DATE VALUES(EMP_ID, EMP_NAME, HIRE_DATE)
INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, MANAGER_ID
FROM EMPLOYEE;

SELECT * FROM EMP_HIRE_DATE;
SELECT * FROM EMP_MANAGER;

-- INSERT ALL �� ���ǿ� ���缭 �����Ű��
CREATE TABLE EMP_OLD
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE FROM EMPLOYEE WHERE 1=0;

CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE FROM EMPLOYEE WHERE 1=0;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

-- EMPLOYEE ���̺��� 00�� ���� �Ի��ڴ� EMP_OLD�� ����, ���� �Ի��ڴ� EMP_NEW�� �����ϱ�
INSERT ALL
        WHEN HIRE_DATE < '00/01/01' THEN INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE)
        WHEN HIRE_DATE >= '00/01/01' THEN INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE)
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE;
-- INSERT���� �ϳ� �� �� �� ����, 10���� 10�� ��������!

-- 0410
-- UPDATE�� Ȱ���ϱ�
-- UPDATE ���̺�� SET ������ �÷��� = ������ ��, ������ �÷��� = ������ ��, ... [WHERE ����]
-- WHERE�� �Ⱦ��� ��ü ����
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY, BONUS
FROM EMPLOYEE;
SELECT * FROM EMP_SALARY;

-- �������� �޿��� 300�������� �����ϱ�
UPDATE EMP_SALARY SET SALARY = 3000000 WHERE EMP_NAME = '������';

-- �ټ��÷����� ������ ���� , �� �����ؼ� �����Ѵ�.
UPDATE EMP_SALARY SET SALARY = 2500000, BONUS= 0.5 WHERE EMP_NAME = '������';

-- �ټ��� ROW�� �÷��� �����ϱ�
-- �μ��� D5�� ����� �޿��� 10������ �߰��ϱ�
UPDATE EMP_SALARY SET SALARY = SALARY + 100000 WHERE DEPT_CODE = 'D5';

-- ���� ���� ���� ����� �޿��� 50���� �ø��� ���ʽ��� 0.4�� �����ϱ�
UPDATE EMP_SALARY SET SALARY = SALARY + 500000, BONUS = 0.4 WHERE EMP_NAME LIKE '��%';

-- ���� �� ������ ��!! �ݵ�� WHERE�� �ۼ��ؼ� Ÿ���� ��Ȯ�ϰ� �����ؾ� �Ѵ�.
-- WHERE�� �ۼ����� ������ ��ü ROW�� �����Ǵ� �����ؾ� �Ѵ�.
UPDATE EMP_SALARY SET EMP_NAME = '������';
SELECT * FROM EMP_SALARY;
ROLLBACK; -- UPDATE�� ��� ó�� ������ ���ƿ�

-- UPDATE������ SELECT�� Ȱ���ϱ�
-- ������ �μ�, ���ʽ��� �ɺ����� �����ϰ� �����ϱ�
UPDATE EMP_SALARY
SET DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '�ɺ���'),
      BONUS = (SELECT BONUS FROM EMPLOYEE WHERE EMP_NAME = '�ɺ���')
WHERE EMP_NAME = '����';
SELECT * FROM EMP_SALARY;

ROLLBACK;
UPDATE EMP_SALARY
SET (DEPT_CODE, BONUS) = (SELECT DEPT_CODE, BONUS FROM EMPLOYEE WHERE EMP_NAME = '�ɺ���')
WHERE EMP_NAME = '����';

-- DELETE Ȱ���ϱ�
-- ���̺��� ROW�� �����ϴ� ��ɾ�
-- DELETE FROM ���̺�� [WHERE ����]
-- WHERE�� �Ⱦ��� ��ü ����
-- D9 �μ����� �����ϱ�
DELETE FROM EMP_SALARY WHERE DEPT_CODE = 'D9';
SELECT * FROM EMP_SALARY;
ROLLBACK;
DELETE FROM EMP_SALARY;

-- TRUNCATE ���� -> ROLLBACK �Ұ�, �ٷ� ����
-- DELETE ���� ����, �����ؼ� ��� X
TRUNCATE TABLE EMP_SALARY;
ROLLBACK; -- �ѹ�Ϸ�. ������ �ѹ� �ȵ�

-- MERGE
CREATE TABLE EMP_M1
AS SELECT * FROM EMPLOYEE;
CREATE TABLE EMP_M2
AS SELECT * FROM EMPLOYEE WHERE JOB_CODE = 'J4';

INSERT INTO EMP_M2 VALUES(999, '���ο�', '561014-123456', 'KWACK@DF.COM', '01021314123', 'D5', 'J1', 'S1', 90000, 0.5, NULL,
                                            SYSDATE, DEFAULT, DEFAULT);
UPDATE EMP_M2 SET SALARY = 0;
COMMIT;
SELECT * FROM EMP_M1;
SELECT * FROM EMP_M2;

MERGE INTO EMP_M1 USING EMP_M2 ON (EMP_M1.EMP_ID = EMP_M2.EMP_ID)
WHEN MATCHED THEN
        UPDATE SET
                EMP_M1.SALARY = EMP_M2.SALARY
WHEN NOT MATCHED THEN
        INSERT VALUES(EMP_M2.EMP_ID, EMP_M2.EMP_NAME, EMP_M2.EMP_NO, EMP_M2.EMAIL, EMP_M2.PHONE, EMP_M2.DEPT_CODE, 
                                EMP_M2.JOB_CODE, EMP_M2.SAL_LEVEL, EMP_M2.SALARY, EMP_M2.BONUS, EMP_M2.MANAGER_ID, 
                                EMP_M2.HIRE_DATE, EMP_M2.ENT_DATE, EMP_M2.ENT_YN);
SELECT * FROM EMP_M1;  