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

-- 0410
-- UPDATE문 활용하기
-- UPDATE 테이블명 SET 수정할 컬럼명 = 수정할 값, 수정할 컬럼명 = 수정할 값, ... [WHERE 조건]
-- WHERE절 안쓰면 전체 수정
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY, BONUS
FROM EMPLOYEE;
SELECT * FROM EMP_SALARY;

-- 전형돈의 급여를 300만원으로 수정하기
UPDATE EMP_SALARY SET SALARY = 3000000 WHERE EMP_NAME = '전형돈';

-- 다수컬럼값을 수정할 때는 , 로 구분해서 대입한다.
UPDATE EMP_SALARY SET SALARY = 2500000, BONUS= 0.5 WHERE EMP_NAME = '전형돈';

-- 다수의 ROW와 컬럼을 수정하기
-- 부서가 D5인 사원의 급여를 10만원씩 추가하기
UPDATE EMP_SALARY SET SALARY = SALARY + 100000 WHERE DEPT_CODE = 'D5';

-- 유씨 성을 가진 사원의 급여를 50만원 올리고 보너스는 0.4로 수정하기
UPDATE EMP_SALARY SET SALARY = SALARY + 500000, BONUS = 0.4 WHERE EMP_NAME LIKE '유%';

-- 수정 시 주의할 점!! 반드시 WHERE을 작성해서 타겟을 정확하게 설정해야 한다.
-- WHERE을 작성하지 않으면 전체 ROW가 수정되니 주의해야 한다.
UPDATE EMP_SALARY SET EMP_NAME = '유병승';
SELECT * FROM EMP_SALARY;
ROLLBACK; -- UPDATE문 모두 처음 값으로 돌아옴

-- UPDATE문에서 SELECT문 활용하기
-- 방명수의 부서, 보너스를 심봉선과 동일하게 수정하기
UPDATE EMP_SALARY
SET DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '심봉선'),
      BONUS = (SELECT BONUS FROM EMPLOYEE WHERE EMP_NAME = '심봉선')
WHERE EMP_NAME = '방명수';
SELECT * FROM EMP_SALARY;

ROLLBACK;
UPDATE EMP_SALARY
SET (DEPT_CODE, BONUS) = (SELECT DEPT_CODE, BONUS FROM EMPLOYEE WHERE EMP_NAME = '심봉선')
WHERE EMP_NAME = '방명수';

-- DELETE 활용하기
-- 테이블의 ROW를 삭제하는 명령어
-- DELETE FROM 테이블명 [WHERE 조건]
-- WHERE절 안쓰면 전체 삭제
-- D9 부서원들 삭제하기
DELETE FROM EMP_SALARY WHERE DEPT_CODE = 'D9';
SELECT * FROM EMP_SALARY;
ROLLBACK;
DELETE FROM EMP_SALARY;

-- TRUNCATE 삭제 -> ROLLBACK 불가, 바로 삭제
-- DELETE 보다 빠름, 웬만해선 사용 X
TRUNCATE TABLE EMP_SALARY;
ROLLBACK; -- 롤백완료. 뜨지만 롤백 안됨

-- MERGE
CREATE TABLE EMP_M1
AS SELECT * FROM EMPLOYEE;
CREATE TABLE EMP_M2
AS SELECT * FROM EMPLOYEE WHERE JOB_CODE = 'J4';

INSERT INTO EMP_M2 VALUES(999, '곽두원', '561014-123456', 'KWACK@DF.COM', '01021314123', 'D5', 'J1', 'S1', 90000, 0.5, NULL,
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