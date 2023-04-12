--0412
-- PL/SQL������ ���� �˾ƺ���
-- PL/SQL������ ����ϴ� ���
-- 1. �͸����� �̿��ϱ� -> BEGIN ~ END; / ������ ����ϴ� �� * ������ �Ұ�����.
-- 2. PROCEDURE, FUNCTION ��ü�� �����ؼ� �̿� -> OBJECT �ȿ� �ۼ��� PL/SQL * ������ OBJECT������ ������ ����

-- 1. �͸���
-- PL/SQL������ ũ�� 3������ ������
-- [�����] : DECLARE ���� ���, ����/����� ����
--              ���� ���� ��� : ������ Ÿ��(�⺻Ÿ��, ����Ÿ��, ROWTYPE, TABLE, RECORD);
-- [�����] : ���ǹ�, �ݺ��� �� ������ ���뿡 ���� �ۼ��ϴ� ����
--              ���� ���� ��� : BEGIN �����ۼ� END ;/
-- [����ó����] : ó���� ���ܰ� ���� �� �ۼ��ϴ� ����

SET SERVEROUTPUT ON;
-- ��ũ��Ʈ ���â�� ������ ����� �� �ִ�.(�𺧷��� ���� �� ������ ���� ��������� ��)

BEGIN
        DBMS_OUTPUT.PUT_LINE('�ȳ� ���� ù PL/SQL����');
END;
/

-- ���� Ȱ���ϱ�
-- ������ DECLARE�κп� ������ �ڷ��� �������� ����
-- �ڷ����� ����

-- �⺻�ڷ��� : ����Ŭ�� �����ϴ� TYPE��(NUMBER, VARCHAR2, CHAR, DATE...)(�� �� �÷�)
-- �������ڷ��� : ���̺��� Ư���÷��� ������ Ÿ���� �ҷ��� ���(�� �� �÷�)
-- ROWTYPE : ���̺��� �� �� ROW�� ������ �� �ִ� Ÿ��(�� �� ROW)

-- Ÿ���� �����ؼ� Ȱ��
-- TABLETYPE : �ڹ��� �迭�� ����� Ÿ�� -> �ε�����ȣ�� �ְ�, �� �� Ÿ�Ը� ���� ����
-- RECORD : �ڹ��� Ŭ������ ����� Ÿ�� -> ��������� �ְ�, �ټ�Ÿ�� ���� ����

-- �⺻�ڷ��� ����� �̿��ϱ�
DECLARE 
        V_EMPNO VARCHAR2(20);
        V_EMPNAME VARCHAR2(15);
        V_AGE NUMBER := 19;
BEGIN
        V_EMPNO := '010224-1234567';
        V_EMPNAME := '������';
        DBMS_OUTPUT.PUT_LINE(V_EMPNO);
        DBMS_OUTPUT.PUT_LINE(V_EMPNAME);
        DBMS_OUTPUT.PUT_LINE(V_AGE);
END;
/

-- := ���Կ���(�� �־���)

-- �������ڷ��� �̿��ϱ�
DECLARE 
        V_EMPID EMPLOYEE.EMP_ID%TYPE; --Ÿ�� �ҷ�����
        V_SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
        V_EMPID := '200';
        V_SALARY := 1000000;
        DBMS_OUTPUT.PUT_LINE(V_EMPID || ' : ' || V_SALARY);
        -- SQL���� �����Ͽ� ó���ϱ�
        SELECT EMP_ID, SALARY
        -- PL/SQL ���� �ȿ��� SQL�� ���� INTO �ʼ�
        INTO V_EMPID, V_SALARY
        FROM EMPLOYEE
        WHERE EMP_ID = V_EMPID;
        DBMS_OUTPUT.PUT_LINE(V_EMPID || ' ' || V_SALARY);
END;
/

-- ROWTYPE
DECLARE
        V_EMP EMPLOYEE%ROWTYPE;
        V_DEPT DEPARTMENT%ROWTYPE;
BEGIN
        SELECT *
        INTO V_EMP
        FROM EMPLOYEE
        WHERE EMP_ID = '&�����ȣ';
        -- ROWTYPE�� �� �÷��� ����Ϸ��� . �����ڸ� �̿��ؼ� �÷������� �����Ѵ�.
        DBMS_OUTPUT.PUT_LINE(V_EMP.EMP_ID || ' ' || V_EMP.EMP_NAME || ' ' || V_EMP.SALARY || ' ' || V_EMP.BONUS);
        SELECT *
        INTO V_DEPT
        FROM DEPARTMENT
        WHERE DEPT_ID = V_EMP.DEPT_CODE;
        DBMS_OUTPUT.PUT_LINE(V_DEPT.DEPT_ID || ' ' || V_DEPT.DEPT_TITLE || ' ' || V_DEPT.LOCATION_ID);
END;
/
        
-- �����ؼ� ����ϴ� Ÿ��
-- TABLETYPE
DECLARE
        TYPE EMP_ID_TABLE IS TABLE OF EMPLOYEE.EMP_ID%TYPE
        INDEX BY BINARY_INTEGER;
        -- ������ Ÿ��
        MYTABLE_ID EMP_ID_TABLE;
        I BINARY_INTEGER := 0;
BEGIN
        MYTABLE_ID(1) := '100';
        MYTABLE_ID(2) := '200';
        MYTABLE_ID(3) := '300';
        DBMS_OUTPUT.PUT_LINE(MYTABLE_ID(1));
        DBMS_OUTPUT.PUT_LINE(MYTABLE_ID(2));
        DBMS_OUTPUT.PUT_LINE(MYTABLE_ID(3));
        
        FOR K IN (SELECT EMP_ID FROM EMPLOYEE) LOOP
                I := I + 1;
                MYTABLE_ID(I) := K.EMP_ID;
        END LOOP;
        FOR J IN 1..I LOOP
                DBMS_OUTPUT.PUT_LINE(MYTABLE_ID(J));
        END LOOP;
END;
/
        
-- RECORD Ÿ��
-- Ŭ������ ����
DECLARE
        TYPE MYRECORD IS RECORD(
                ID EMPLOYEE.EMP_ID%TYPE,
                NAME EMPLOYEE.EMP_NAME%TYPE,
                DEPTTITLE DEPARTMENT.DEPT_TITLE%TYPE,
                JOBNAME JOB.JOB_NAME%TYPE
        );
        MYDATA MYRECORD;
BEGIN
        SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
        INTO MYDATA
        FROM EMPLOYEE
                JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
                JOIN JOB USING(JOB_CODE)
        WHERE EMP_NAME = '&�����';
        DBMS_OUTPUT.PUT_LINE(MYDATA.ID || MYDATA.NAME || MYDATA.DEPTTITLE || MYDATA.JOBNAME);
END;
/
        
-- PL/SQL�������� ���ǹ� Ȱ���ϱ�
-- IF�� Ȱ��
--      IF ���ǽ�
--          THEN : ���ǽ��� TRUE�� �� THEN�� �ִ� ������ �����.
--      END IF;
DECLARE
        V_SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
        SELECT SALARY
        INTO V_SALARY
        FROM EMPLOYEE
        WHERE EMP_ID = '&�����ȣ';
        
        IF V_SALARY > 3000000
            THEN DBMS_OUTPUT.PUT_LINE('���� �����ó׿�!');
        END IF;
END;
/

-- IF
--      THEN ���౸��
--      ELSE ���౸��
-- END IF;

DECLARE
        V_SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
        SELECT SALARY
        INTO V_SALARY
        FROM EMPLOYEE 
        WHERE EMP_NAME = '&�����';
        IF V_SALARY > 3000000
            THEN DBMS_OUTPUT.PUT_LINE('���� �����ó׿�!');
        ELSE 
            DBMS_OUTPUT.PUT_LINE('�����̽ó׿�!');
        END IF;
END;
/

CREATE TABLE HIGH_SAL(
        EMP_ID VARCHAR2(20) REFERENCES EMPLOYEE(EMP_ID),
        SALARY NUMBER
);

CREATE TABLE LOW_SAL(
        EMP_ID VARCHAR2(20) REFERENCES EMPLOYEE(EMP_ID),
        SALARY NUMBER
);
        
DECLARE
        EMPID EMPLOYEE.EMP_ID%TYPE;
        SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
        SELECT EMP_ID, SALARY
        INTO EMPID, SALARY
        FROM EMPLOYEE
        WHERE EMP_NAME = '&�����';
        
        IF SALARY > 3000000
            THEN        INSERT INTO HIGH_SAL VALUES(EMPID,SALARY);
        ELSE
            INSERT INTO LOW_SAL VALUES(EMPID, SALARY);
        END IF;
        COMMIT;
END;
/

SELECT * FROM HIGH_SAL;
SELECT * FROM LOW_SAL;


-- IF ���ǽ� THEN ELSIF ���ǽ� THEN ELSE END IF;
CREATE TABLE MSGTEST(
        EMP_ID VARCHAR2(20) REFERENCES EMPLOYEE(EMP_ID),
        MSG VARCHAR2(100)
);

DECLARE
        V_EMP_ID EMPLOYEE.EMP_ID%TYPE;
        V_JOBCODE EMPLOYEE.JOB_CODE%TYPE;
        MSG VARCHAR2(100);
BEGIN
        SELECT EMP_ID, JOB_CODE
        INTO V_EMP_ID, V_JOBCODE
        FROM EMPLOYEE
        WHERE EMP_ID = '&�����ȣ';
        
        IF V_JOBCODE = 'J1'
                THEN MSG := '��ǥ�̻�';
        ELSIF V_JOBCODE IN ('J2', 'J3', 'J4')
                THEN MSG := '�ӿ�';
        ELSE MSG := '���';
        END IF;
        INSERT INTO MSGTEST VALUES(V_EMP_ID, MSG);
        COMMIT;
END;
/
SELECT * FROM MSGTEST JOIN EMPLOYEE USING(EMP_ID);

-- CASE�� �̿��ϱ�
DECLARE
        NUM NUMBER;
BEGIN
        NUM := '&��';
        CASE
                WHEN NUM > 10
                        THEN DBMS_OUTPUT.PUT_LINE('10�ʰ�');
                WHEN NUM > 5
                        THEN DBMS_OUTPUT.PUT_LINE('6~10 ���̰�');
                ELSE DBMS_OUTPUT.PUT_LINE('5������ ���Դϴ�.');
        END CASE;
END;
/

-- �ݺ��� ����ϱ�
-- �⺻�ݺ��� LOOP���� �̿�
-- FOR, WHILE���� ����
DECLARE
        NUM NUMBER := 1;
        RNDNUM NUMBER;
BEGIN
        LOOP
                DBMS_OUTPUT.PUT_LINE(NUM);
                -- ����Ŭ���� ������ ����ϱ�
                RNDNUM := FLOOR(DBMS_RANDOM.VALUE(1, 10));
                DBMS_OUTPUT.PUT_LINE(RNDNUM);
                INSERT INTO BOARD VALUES(SEQ_BASIC.NEXTVAL, '����' || RNDNUM, 'CONTENT' || RNDNUM, '�ۼ���' || RNDNUM, SYSDATE);
                NUM := NUM + 1;
                IF NUM > 100
                        THEN EXIT; -- BREAK���� ����
                END IF;
        END LOOP;
        COMMIT;
END;
/

SELECT * FROM BOARD;

-- WHILE��
-- WHILE ���ǹ� LOOP
--      ���౸��
-- END LOOP;
DECLARE
        NUM NUMBER := 1;
BEGIN
        WHILE NUM <= 10 LOOP
               DBMS_OUTPUT.PUT_LINE(NUM);
               NUM := NUM + 1;
        END LOOP;
END;
/

-- FOR ���� IN ����(����.. ��) LOOP
-- END LOOP;
BEGIN
        FOR N IN 1..10 LOOP
                DBMS_OUTPUT.PUT_LINE(N);
        END LOOP;
END;
/

-- FOR ���� IN (SELECT��) LOOP
-- END LOOP;
-- ��ü ROW ��ȸ(ROWTYPE)
BEGIN
        FOR EMP IN (SELECT * FROM EMPLOYEE) LOOP
                -- DBMS_OUTPUT.PUT_LINE(EMP.EMP_ID || EMP.EMP_NAME || EMP.SALARY || EMP.DEPT_CODE || EMP.JOB_CODE);
                IF EMP.SALARY > 3000000
                        THEN INSERT INTO HIGH_SAL VALUES(EMP.EMP_ID, EMP.SALARY);
                ELSE INSERT INTO LOW_SAL VALUES(EMP.EMP_ID, EMP.SALARY);
                END IF;
                COMMIT; 
        END LOOP;
END;
/
SELECT * FROM HIGH_SAL;
SELECT * FROM LOW_SAL;