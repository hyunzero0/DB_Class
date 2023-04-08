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

-- UPDATE�� 



