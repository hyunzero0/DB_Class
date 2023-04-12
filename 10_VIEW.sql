-- 0412
-- ORACLE���� �����ϴ� OBJECTȰ���ϱ�
-- USER, TABLE, VIEW, SEQUENCE, INDEX, SYNONYM, FUNCTION, PROCEDURE, PACKAGE ��

-- VIEW�� ���� �˾ƺ���
-- SELECT���� ��� RESULT SET�� �ϳ��� ���̺�ó�� Ȱ���ϰ� �ϴ� ��
-- STORED VIEW �����ϱ�
-- CREATE  [�ɼ�] VIEW ���Ī AS SELECT��
CREATE VIEW V_EMP
AS SELECT * FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- VIEW�� ������ ������ �ο��ؾ� �Ѵ�.
-- SYSTEM / SYS AS SYSDBA(�ְ� ������) �������� �ο��� �Ѵ�.
GRANT CREATE VIEW TO BS;

CREATE VIEW V_EMP
AS SELECT * FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- ������ TABLE �̿��ϱ�
SELECT * FROM V_EMP;

-- �μ���, ��å�� �޿��� ����� ���ϴ� SELECT��
SELECT DEPT_CODE, AVG(SALARY) FROM EMPLOYEE GROUP BY DEPT_CODE;
SELECT JOB_CODE, AVG(SALARY) FROM EMPLOYEE GROUP BY JOB_CODE;

SELECT DEPT_CODE, AVG(SALARY) FROM EMPLOYEE GROUP BY DEPT_CODE
UNION
SELECT JOB_CODE, AVG(SALARY) FROM EMPLOYEE GROUP BY JOB_CODE;

CREATE VIEW V_AVG_DEPTJOB
AS
SELECT DEPT_CODE, AVG(SALARY) AS AVG_SALARY FROM EMPLOYEE GROUP BY ROLLUP(DEPT_CODE)
UNION
SELECT JOB_CODE, AVG(SALARY) FROM EMPLOYEE GROUP BY ROLLUP(JOB_CODE);

SELECT * FROM V_AVG_DEPTJOB
WHERE AVG_SALARY >= 3000000 AND DEPT_CODE IS NOT NULL;

-- WITH VS VIEW
--   WITH�� ; ������ ����
--   VIEW�� SELECT�� �� �� �����ϸ� �� �� �� ����

-- VIEW ���̺� ��ȸ
SELECT * FROM USER_VIEWS;

-- VIEW�� Ư¡
-- DML������ ����� �����ϴ�?
-- ���� ���̺�� ����Ǿ� �ִ� �÷��� ������ ���� ����, �����÷��� ������ �Ұ����ϴ�.

-- 1. UPDATE
SELECT * FROM V_EMP;
UPDATE V_EMP SET EMP_NAME = '���ֿ�' WHERE EMP_NAME = '������';
SELECT * FROM EMPLOYEE; -- VIEW���̺��� ���������� ���� ���̺����� DML�� ������
UPDATE V_AVG_DEPTJOB SET AVG_SALARY = 1000000; -- X, �����÷��� DML�� ���� �Ұ���

-- 2. INSERT
-- ���� ���̺�� ������� VIEW�� INSERT�� ������.
-- -> VIEW���� ���� ���� �� �̿ܿ� �÷����� NULL���� ������ -> NOT NULL ���������� �����Ǹ� �ȵȴ�.
CREATE VIEW V_EMPTEST
AS SELECT EMP_ID, EMP_NO, EMP_NAME, EMAIL, PHONE, JOB_CODE, SAL_LEVEL FROM EMPLOYEE;
--SELECT DEPT_CODE FROM V_EMPTEST;
INSERT INTO V_EMPTEST VALUES ('997', '981011-1234123', 'ȫ�浿', 'HONG@HONG.COM', '12341234', 'J1', 'S1');

-- JOIN�� ����� VIEW�� INSERT�� �Ұ�����.
-- JOIN, UNION ����� VIEW�� �Է��� �Ұ�����.
INSERT INTO V_EMP VALUES('996', 'ȫ�浿', '980110-1234567', 'HONG@HONG.COM', '12345', 'D5', 'J1', 'S1', 100, 0.2, 206, SYSDATE,
                                            NULL, 'N', 'D0', '�Ǵ�', 'L3'); -- X, ���� �信 ���Ͽ� �ϳ� �̻��� �⺻ ���̺��� ������ �� �����ϴ�.
                                            
-- 3. DELETE                                            
-- DELETE ���� �����ϴ�? �����ϴ�.
DELETE FROM V_EMPTEST WHERE EMP_ID = '997';
SELECT * FROM EMPLOYEE; -- ���� ���̺����� ������
DELETE FROM V_EMP WHERE EMP_NAME = '�����'; -- JOIN�̾ DELETE�� ����

-- VIEW ���� �� ����� �� �ִ� �ɼ�
-- 1. OR REPLACE : �ߺ��Ǵ� VIEW�̸��� ������ ����⸦ ���ִ� �ɼ�
--      * OBJECT��Ī�� �ߺ��� �Ұ����ϴ�.
CREATE VIEW V_EMP
AS SELECT * FROM EMPLOYEE; -- X, ������ ��ü�� �̸��� ����ϰ� �ֽ��ϴ�.

CREATE OR REPLACE VIEW V_EMP
AS SELECT * FROM EMPLOYEE;  -- O, �����(JOIN�ߴ� DEPARTMENT �����)

SELECT * FROM V_EMP;

-- 2. FORCE/NOFORCE : ���� ���̺��� �������� �ʾƵ� VIEW�� ������ �� �ְ� ���ִ� �ɼ�
SELECT * FROM TT; -- ���� ���̺�
CREATE OR REPLACE VIEW V_TT
AS SELECT * FROM TT; -- X

CREATE FORCE VIEW V_TT
AS SELECT * FROM TT; -- O

SELECT * FROM V_TT; -- ��ȸ�� �Ұ���, �Ʒ� ���̺� ���� �� ��ȸ ����

CREATE TABLE TT(
    TTNO NUMBER,
    TTNAME VARCHAR2(200)
);

-- 3. WITH CHECK OPTION : SELECT���� WHERE���� ����� �÷��� �������� ���ϰ� ����� �ɼ�
CREATE OR REPLACE VIEW V_CHECK
AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' WITH CHECK OPTION;

SELECT * FROM V_CHECK; -- �������� D6���� �ٲ�鼭 ������ ROW ��� �ȵ�(WITH CHECK OPTION ���� ��)
UPDATE V_CHECK SET DEPT_CODE = 'D6' WHERE EMP_NAME = '������'; -- WITH CHECK OPTION �����ϸ� ���� �߻�
UPDATE V_CHECK SET EMP_NAME = '������' WHERE EMP_NAME = '������'; -- WHERE�� �÷��� �ƴϱ⶧���� ���� ����
ROLLBACK;

-- 4. WITH READ ONLY : VIEW ���̺��� ������ �Ұ����ϰ� �ϴ� �ɼ� -> �б� ����
CREATE OR REPLACE VIEW V_CHECK
AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' WITH READ ONLY;