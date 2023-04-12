--0412
-- PL/SQL구문에 대해 알아보자
-- PL/SQL구문을 사용하는 방법
-- 1. 익명블록을 이용하기 -> BEGIN ~ END; / 구문을 사용하는 것 * 재사용이 불가능함.
-- 2. PROCEDURE, FUNCTION 객체로 생성해서 이용 -> OBJECT 안에 작성된 PL/SQL * 생성된 OBJECT명으로 재사용이 가능

-- 1. 익명블록
-- PL/SQL구문은 크게 3가지로 나눠짐
-- [선언부] : DECLARE 예약어를 사용, 변수/상수를 선언
--              변수 선언 방법 : 변수명 타입(기본타입, 참조타입, ROWTYPE, TABLE, RECORD);
-- [실행부] : 조건문, 반복문 등 실행할 내용에 대해 작성하는 구문
--              변수 선언 방법 : BEGIN 구문작성 END ;/
-- [예외처리부] : 처리할 예외가 있을 때 작성하는 구문

SET SERVEROUTPUT ON;
-- 스크립트 출력창에 문구를 출력할 수 있다.(디벨로퍼 껐다 켤 때마다 세션 변경해줘야 함)

BEGIN
        DBMS_OUTPUT.PUT_LINE('안녕 나의 첫 PL/SQL구문');
END;
/

-- 변수 활용하기
-- 변수는 DECLARE부분에 변수명 자료형 형식으로 선언
-- 자료형의 종류

-- 기본자료형 : 오라클이 제공하는 TYPE들(NUMBER, VARCHAR2, CHAR, DATE...)(한 개 컬럼)
-- 참조형자료형 : 테이블의 특정컬럼에 설정된 타입을 불러와 사용(한 개 컬럼)
-- ROWTYPE : 테이블의 한 개 ROW를 저장할 수 있는 타입(한 개 ROW)

-- 타입을 생성해서 활용
-- TABLETYPE : 자바의 배열과 비슷한 타입 -> 인덱스번호가 있고, 한 개 타입만 저장 가능
-- RECORD : 자바의 클래스와 비슷한 타입 -> 멤버변수가 있고, 다수타입 저장 가능

-- 기본자료형 선언과 이용하기
DECLARE 
        V_EMPNO VARCHAR2(20);
        V_EMPNAME VARCHAR2(15);
        V_AGE NUMBER := 19;
BEGIN
        V_EMPNO := '010224-1234567';
        V_EMPNAME := '유병승';
        DBMS_OUTPUT.PUT_LINE(V_EMPNO);
        DBMS_OUTPUT.PUT_LINE(V_EMPNAME);
        DBMS_OUTPUT.PUT_LINE(V_AGE);
END;
/

-- := 대입연산(값 넣어줌)

-- 참조형자료형 이용하기
DECLARE 
        V_EMPID EMPLOYEE.EMP_ID%TYPE; --타입 불러오기
        V_SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
        V_EMPID := '200';
        V_SALARY := 1000000;
        DBMS_OUTPUT.PUT_LINE(V_EMPID || ' : ' || V_SALARY);
        -- SQL문과 연동하여 처리하기
        SELECT EMP_ID, SALARY
        -- PL/SQL 구문 안에서 SQL문 사용시 INTO 필수
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
        WHERE EMP_ID = '&사원번호';
        -- ROWTYPE의 각 컬럼을 출력하려면 . 연산자를 이용해서 컬럼명으로 접근한다.
        DBMS_OUTPUT.PUT_LINE(V_EMP.EMP_ID || ' ' || V_EMP.EMP_NAME || ' ' || V_EMP.SALARY || ' ' || V_EMP.BONUS);
        SELECT *
        INTO V_DEPT
        FROM DEPARTMENT
        WHERE DEPT_ID = V_EMP.DEPT_CODE;
        DBMS_OUTPUT.PUT_LINE(V_DEPT.DEPT_ID || ' ' || V_DEPT.DEPT_TITLE || ' ' || V_DEPT.LOCATION_ID);
END;
/
        
-- 생성해서 사용하는 타입
-- TABLETYPE
DECLARE
        TYPE EMP_ID_TABLE IS TABLE OF EMPLOYEE.EMP_ID%TYPE
        INDEX BY BINARY_INTEGER;
        -- 변수명 타입
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
        
-- RECORD 타입
-- 클래스와 유사
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
        WHERE EMP_NAME = '&사원명';
        DBMS_OUTPUT.PUT_LINE(MYDATA.ID || MYDATA.NAME || MYDATA.DEPTTITLE || MYDATA.JOBNAME);
END;
/
        
-- PL/SQL구문에서 조건문 활용하기
-- IF문 활용
--      IF 조건식
--          THEN : 조건식이 TRUE일 때 THEN에 있는 구문이 실행됨.
--      END IF;
DECLARE
        V_SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
        SELECT SALARY
        INTO V_SALARY
        FROM EMPLOYEE
        WHERE EMP_ID = '&사원번호';
        
        IF V_SALARY > 3000000
            THEN DBMS_OUTPUT.PUT_LINE('많이 받으시네요!');
        END IF;
END;
/

-- IF
--      THEN 실행구문
--      ELSE 실행구문
-- END IF;

DECLARE
        V_SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
        SELECT SALARY
        INTO V_SALARY
        FROM EMPLOYEE 
        WHERE EMP_NAME = '&사원명';
        IF V_SALARY > 3000000
            THEN DBMS_OUTPUT.PUT_LINE('많이 받으시네요!');
        ELSE 
            DBMS_OUTPUT.PUT_LINE('보통이시네요!');
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
        WHERE EMP_NAME = '&사원명';
        
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


-- IF 조건식 THEN ELSIF 조건식 THEN ELSE END IF;
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
        WHERE EMP_ID = '&사원번호';
        
        IF V_JOBCODE = 'J1'
                THEN MSG := '대표이사';
        ELSIF V_JOBCODE IN ('J2', 'J3', 'J4')
                THEN MSG := '임원';
        ELSE MSG := '사원';
        END IF;
        INSERT INTO MSGTEST VALUES(V_EMP_ID, MSG);
        COMMIT;
END;
/
SELECT * FROM MSGTEST JOIN EMPLOYEE USING(EMP_ID);

-- CASE문 이용하기
DECLARE
        NUM NUMBER;
BEGIN
        NUM := '&수';
        CASE
                WHEN NUM > 10
                        THEN DBMS_OUTPUT.PUT_LINE('10초과');
                WHEN NUM > 5
                        THEN DBMS_OUTPUT.PUT_LINE('6~10 사이값');
                ELSE DBMS_OUTPUT.PUT_LINE('5이하의 값입니다.');
        END CASE;
END;
/

-- 반복문 사용하기
-- 기본반복문 LOOP예약어를 이용
-- FOR, WHILE문이 있음
DECLARE
        NUM NUMBER := 1;
        RNDNUM NUMBER;
BEGIN
        LOOP
                DBMS_OUTPUT.PUT_LINE(NUM);
                -- 오라클에서 랜덤값 출력하기
                RNDNUM := FLOOR(DBMS_RANDOM.VALUE(1, 10));
                DBMS_OUTPUT.PUT_LINE(RNDNUM);
                INSERT INTO BOARD VALUES(SEQ_BASIC.NEXTVAL, '제목' || RNDNUM, 'CONTENT' || RNDNUM, '작성자' || RNDNUM, SYSDATE);
                NUM := NUM + 1;
                IF NUM > 100
                        THEN EXIT; -- BREAK문과 동일
                END IF;
        END LOOP;
        COMMIT;
END;
/

SELECT * FROM BOARD;

-- WHILE문
-- WHILE 조건문 LOOP
--      실행구문
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

-- FOR 변수 IN 범위(시작.. 끝) LOOP
-- END LOOP;
BEGIN
        FOR N IN 1..10 LOOP
                DBMS_OUTPUT.PUT_LINE(N);
        END LOOP;
END;
/

-- FOR 변수 IN (SELECT문) LOOP
-- END LOOP;
-- 전체 ROW 순회(ROWTYPE)
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