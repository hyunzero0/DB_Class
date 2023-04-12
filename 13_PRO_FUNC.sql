-- 0412
-- PL/SQL 구문 저장하고 사용하기
-- PROCEDURE, FUNCTION

-- 1. PROCEDURE
-- CREATE PROCEDURE 프로시저명
-- IS
-- 변수선언(필요하면)
-- BEGIN
--      실행할 로직
-- END;
-- /

-- 저장된 프로시저 실행하기
-- EXEC 프로시저명
CREATE TABLE EMP_DEL
AS SELECT * FROM EMPLOYEE;
SELECT * FROM EMP_DEL;

CREATE OR REPLACE PROCEDURE EMP_DEL_PRO -- REPLACE 오타칠까봐 편의상 쓰는거임, 안쓰는게 좋음!
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
EXEC EMP_INSERT; -- 다시 저장
SELECT * FROM EMP_DEL;
EXEC EMP_DEL_PRO; -- 지워짐

-- 프로시저의 매개변수 활용하기
-- IN 매개변수 : 프로시저 실행 시에 필요한 데이터를 받는 매개변수 * 일반적인 매개변수
-- OUT 매개변수 : 호출한 곳에서 지정한 변수에 데이터를 대입해주는 매개변수
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

-- 전역변수 선언
VAR EMP_NAME VARCHAR2(20);
PRINT EMP_NAME;
EXEC PRO_SELECT_EMP(201, :EMP_NAME);
PRINT EMP_NAME;

-- 2. FUNCTION 오브젝트
-- 함수 : 매개변수, 리턴값을 갖는다.
-- SELECT문 내부에서 실행함

-- CREATE FUNCTION 함수명([매개변수선언])
-- RETURN 리턴타입
-- IS 
-- [변수선언] 
-- BEGIN 
--      실행할 로직
-- END;
-- /

-- 매개변수로 받은 문자열의 길이를 반환해주는 함수
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

SELECT MYFUNC('유병승')
FROM DUAL;
SELECT MYFUNC(EMAIL)
FROM EMPLOYEE;

-- 매개변수로 EMP_ID를 받아서 연봉을 계산해주는 함수 만들기
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