-- 0412
-- PL/SQL ���� �����ϰ� ����ϱ�
-- PROCEDURE, FUNCTION

-- 1. PROCEDURE
-- CREATE PROCEDURE ���ν�����
-- IS
-- ��������(�ʿ��ϸ�)
-- BEGIN
--      ������ ����
-- END;
-- /

-- ����� ���ν��� �����ϱ�
-- EXEC ���ν�����
CREATE TABLE EMP_DEL
AS SELECT * FROM EMPLOYEE;
SELECT * FROM EMP_DEL;

CREATE OR REPLACE PROCEDURE EMP_DEL_PRO -- REPLACE ��Ÿĥ��� ���ǻ� ���°���, �Ⱦ��°� ����!
IS
BEGIN
        DELETE FROM EMP_DEL;
        COMMIT;
END;
/
EXEC EMP_DEL_PRO;
SELECT * FROM EMP_DEL;

CREATE OR REPLACE PROCEDURE EMP_INSERT
IS
BEGIN
        FOR EMP IN (SELECT * FROM EMPLOYEE) LOOP
                INSERT INTO EMP_DEL VALUES(EMP.EMP_ID, EMP.EMP_NAME, EMP.EMP_NO, EMP.EMAIL, EMP.PHONE, EMP.DEPT_CODE,
                                                            EMP.JOB_CODE, EMP.SAL_LEVEL, EMP.SALARY, EMP.BONUS, EMP.MANAGER_ID, EMP.HIRE_DATE,
                                                            EMP.ENT_DATE, EMP.ENT_YN);
        END LOOP;
        COMMIT;
END;
/
EXEC EMP_INSERT; -- �ٽ� ����
SELECT * FROM EMP_DEL;
EXEC EMP_DEL_PRO; -- ������

-- ���ν����� �Ű����� Ȱ���ϱ�
-- IN �Ű����� : ���ν��� ���� �ÿ� �ʿ��� �����͸� �޴� �Ű����� * �Ϲ����� �Ű�����
-- OUT �Ű����� : ȣ���� ������ ������ ������ �����͸� �������ִ� �Ű�����
CREATE OR REPLACE PROCEDURE PRO_SELECT_EMP(V_EMPID IN EMPLOYEE.EMP_ID%TYPE, V_EMPNAME OUT EMPLOYEE.EMP_NAME%TYPE)
IS
        TEST VARCHAR2(20);
BEGIN
        SELECT EMP_NAME 
        INTO V_EMPNAME
        FROM EMPLOYEE
        WHERE EMP_ID = V_EMPID;
END;
/

-- �������� ����
VAR EMP_NAME VARCHAR2(20);
PRINT EMP_NAME;
EXEC PRO_SELECT_EMP(201, :EMP_NAME);
PRINT EMP_NAME;

-- 2. FUNCTION ������Ʈ
-- �Լ� : �Ű�����, ���ϰ��� ���´�.
-- SELECT�� ���ο��� ������

-- CREATE FUNCTION �Լ���([�Ű���������])
-- RETURN ����Ÿ��
-- IS 
-- [��������] 
-- BEGIN 
--      ������ ����
-- END;
-- /

-- �Ű������� ���� ���ڿ��� ���̸� ��ȯ���ִ� �Լ�
CREATE OR REPLACE FUNCTION MYFUNC(V_STR VARCHAR2)
RETURN NUMBER
IS
    V_RESULT NUMBER;
BEGIN
    SELECT LENGTH (V_STR)
    INTO V_RESULT
    FROM DUAL;
    RETURN V_RESULT;
END;
/

SELECT MYFUNC('������')
FROM DUAL;
SELECT MYFUNC(EMAIL)
FROM EMPLOYEE;

-- �Ű������� EMP_ID�� �޾Ƽ� ������ ������ִ� �Լ� �����
CREATE OR REPLACE FUNCTION SAL_YEAR(V_EMPID EMPLOYEE.EMP_ID%TYPE)
RETURN NUMBER
IS
        V_RESULT NUMBER;
BEGIN
        SELECT SALARY * 12
        INTO V_RESULT
        FROM EMPLOYEE
        WHERE EMP_ID = V_EMPID;
        RETURN V_RESULT;
END;
/
SELECT SAL_YEAR(200) FROM DUAL;
SELECT EMP_NAME, SALARY, BONUS, SAL_YEAR(EMP_ID)
FROM EMPLOYEE;