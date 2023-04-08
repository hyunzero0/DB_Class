-- 0407
-- DML 구문에 대해 알아보자
-- 테이블에 저장되는 테이터를 다루는 명령어
--      INSERT : 테이블에 데이터(ROW)를 추가하는 명령어
--      UPDATE : 테이블에 있는 데이터의 특정 컬럼을 수정하는 명령어
--      DELETE : 테이블에 있는 특정ROW를 삭제하는 명령어

-- INSERT문 활용하기
-- 1. 전체 컬럼에 값을 대입하기
--      INSERT INTO 테이블명 VALUES(컬럼에 대입할 값, 컬럼에 대입할 값, ...)
--          * 컬럼에 대입할 값 : 테이블에 선언된 모든 컬럼 수와 동일해야한다.
-- 2. 특정컬럼을 골라서 값을 대입하기
--      INSERT INTO 테이블명(특정컬럼, 특정컬럼, ...) VALUES(특정컬럼에 대입할 값, 특정컬럼에 대입할 값, ...)
--          * 지정된 컬럼의 수와 VALUES에 있는 수가 같아야 함.
--          * 지정되지 않은 컬럼의 값은 NULL로 대입된다. * 주의! 나머지 컬럼에 NOT NULL 제약조건이 있으면 안된다.

CREATE TABLE TEMP_DEPT
AS SELECT * FROM DEPARTMENT WHERE 1 = 0; -- 컬럼만 만든거
SELECT * FROM TEMP_DEPT;

INSERT INTO TEMP_DEPT VALUES('D0', '자바', 'L1');
INSERT INTO TEMP_DEPT VALUES('D1', '오라클'); -- X, 컬럼 수 안맞음
INSERT INTO TEMP_DEPT VALUES('D1', '오라클', TO_NUMBER('10'));

-- 컬럼을 지정해서 값을 대입하기
DESC TEMP_DEPT;
INSERT INTO TEMP_DEPT(DEPT_ID, LOCATION_ID) VALUES('D2', 'L3');
SELECT * FROM TEMP_DEPT;
INSERT INTO TEMP_DEPT(DEPT_ID) VALUES('D3'); -- X
CREATE TABLE TESTINSERT(
        TESTNO NUMBER PRIMARY KEY,
        TESTCONTENT VARCHAR2(200) DEFAULT 'TEST' NOT NULL
);
INSERT INTO TESTINSERT(TESTNO) VALUES(1);

-- SELECT문을 이용해서 값 대입하기
-- NOT NULL 제약 조건만 가져옴
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

-- EMPLOYEE테이블에서 부서가 D6인 사원들을 INSERT_SUB에 저장하기
INSERT INTO INSERT_SUB(
        SELECT EMP_ID, EMP_NAME, DEPT_TITLE -- 맞춰야함..
        FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
        WHERE DEPT_CODE = 'D6'
);
SELECT * FROM INSERT_SUB;

-- 지정한 컬럼에 SELECT문으로 데이터 저장하기
INSERT INTO INSERT_SUB(EMP_ID, EMP_NAME)(SELECT EMP_ID, EMP_NAME FROM EMPLOYEE);


-- INSERT ALL
-- SELECT문을 이용해서 두 개 이상의 테이블에 값을 넣을 때 사용
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

-- INSERT ALL 을 조건에 맞춰서 저장시키기
CREATE TABLE EMP_OLD
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE FROM EMPLOYEE WHERE 1=0;

CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE FROM EMPLOYEE WHERE 1=0;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

-- EMPLOYEE 테이블에서 00년 이전 입사자는 EMP_OLD에 저장, 이후 입사자는 EMP_NEW에 저장하기
INSERT ALL
        WHEN HIRE_DATE < '00/01/01' THEN INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE)
        WHEN HIRE_DATE >= '00/01/01' THEN INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE)
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE;
-- INSERT문은 하나 당 한 개 저장, 10개면 10개 만들어야함!

-- UPDATE는 



