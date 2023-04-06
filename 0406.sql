-- 0406
-- 서브쿼리 : SELECT문 안에 SELECT문이 하나 더 있는 쿼리문을 말함.
-- 서브쿼리는 반드시 ()안에 작성을 해야한다.
-- 윤은해 사원과 동일한 급여를 받고있는 사원을 조회하기
SELECT SALARY
FROM EMPLOYEE
WHERE EMP_NAME = '윤은해';
SELECT *
FROM EMPLOYEE
WHERE SALARY = 2000000;

SELECT *
FROM EMPLOYEE
WHERE SALARY = (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '윤은해');

-- D5부서의 평균급여보다 많이 받는 사원구하기
SELECT *
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = 'D5');

-- 1. 단일행 서브쿼리
-- 서브쿼리 SELECT문의 결과가 1개 열, 1개 행
-- 컬럼, WHERE절에 비교대상 값
-- 사원들의 급여 평균보다 급여를 많이 받는 사원의 이름, 급여, 부서코드 출력하기
SELECT EMP_NAME, SALARY, DEPT_CODE, (SELECT AVG(SALARY) FROM EMPLOYEE) AS AVG
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);

-- 부서가 총무부인 사원을 조회하기
-- 1.
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_ID FROM DEPARTMENT WHERE DEPT_TITLE = '총무부');

-- 2.
SELECT *
FROM EMPLOYEE
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE = '총무부';

-- 직책이 과장인 사원을 조회하기
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE = (SELECT JOB_CODE FROM JOB WHERE JOB_NAME = '과장');

SELECT *
FROM EMPLOYEE 
        JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '과장';

-- 2. 다중행 서브쿼리
-- 서브쿼리의 결과가 1개 열, 다수 행(ROW)
-- 직책이 부장, 과장인 사원을 조회하기
SELECT JOB_CODE
FROM JOB
WHERE JOB_NAME IN ('부장', '과장');

SELECT *
FROM EMPLOYEE
WHERE JOB_CODE NOT IN (SELECT JOB_CODE FROM JOB WHERE JOB_NAME IN ('부장', '과장')); -- 값 1개와 다수 값을 비교 불가해서 '=' 사용X, IN/NOT IN 사용

-- 다중행에 대한 대소비교하기
-- >=, >, <, <=
SELECT *
FROM EMPLOYEE;
--WHERE SALARY >= (SELECT SALARY FROM EMPLOYEE WHERE DEPT_CODE IN ('D5', 'D6'));
-- ANY : OR로 ROW를 연결
-- ALL : AND로 ROW를 연결
-- 컬럼 >(=) ANY (서브쿼리) : 다중행 서브쿼리의 결과 중 하나라도 크면 TRUE -> 다중행 서브쿼리의 결과 중 최소값보다 크면 TRUE 
-- 컬럼 <(=) ANY (서브쿼리) : 다중행 서브쿼리의 결과 중 하나라도 작으면 TRUE -> 다중행 서브쿼리의 결과 중 최대값보다 작으면 TRUE

SELECT *
FROM EMPLOYEE;
-- WHERE SALARY >= ANY (SELECT SALARY FROM EMPLOYEE WHERE DEPT_CODE IN ('D5', 'D6'));
--WHERE SALARY >= (SELECT MIN(SALARY) FROM EMPLOYEE WHERE DEPT_CODE IN ('D5', 'D6')); 위와 같음 

-- 컬럼 >(=) ALL(서브쿼리) : 다중행 서브쿼리의 결과가 모두 클 때 TRUE -> 다중행 서브쿼리의 결과 중 최대값보다 크면 TRUE
-- 컬럼 <(=) ALL(서브쿼리) : 다중행 서브쿼리의 결과가 모두 작을 때 TRUE -> 다중행 서브쿼리의 결과 중 최소값보다 작으면 TRUE
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
--WHERE SALARY < ALL(SELECT SALARY FROM EMPLOYEE WHERE DEPT_CODE IN ('D5', 'D6'));
WHERE SALARY < (SELECT MIN(SALARY) FROM EMPLOYEE WHERE DEPT_CODE IN ('D5', 'D6'));

-- 2000년 1월 1일 이전 입사자 중 2000년 1월 1일 이후 입사한 사원 중 가장 높게 받는 사원보다 급여를 높게 받는 사원의
-- 사원명, 급여 조회하기
SELECT EMP_NAME, SALARY, 
FROM EMPLOYEE
WHERE HIRE_DATE < '00/01/01' -- 이전 입사자
            AND SALARY > ALL(SELECT SALARY FROM EMPLOYEE WHERE HIRE_DATE >= '00/01/01');
            
-- 다중열 서브쿼리 : 열이 다수, 행이 1개
-- 퇴직한 여사원의 같은 부서, 같은 직급에 해당하는 사원 조회하기
SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE WHERE ENT_YN = 'Y' AND SUBSTR(EMP_NO, 8, 1) = '2';

SELECT *
FROM EMPLOYEE
--WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE ENT_YN = 'Y' AND SUBSTR(EMP_NO, 8, 1) = '2')
--            AND JOB_CODE = (SELECT JOB_CODE FROM EMPLOYEE WHERE ENT_YN = 'Y' AND SUBSTR(EMP_NO, 8, 1) = '2')
--            AND ENT_YN = 'N';
WHERE (DEPT_CODE, JOB_CODE)
            IN (SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE WHERE ENT_YN = 'Y' AND SUBSTR(EMP_NO, 8, 1) = '2')
            AND ENT_YN = 'N'; -- 자기자신 제외

-- 기술지원부이면서 급여가 200만원인 사원이 있다고 한다.
-- 그 사원의 이름, 부서명, 급여 출력하기
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
--WHERE DEPT_TITLE = '기술지원부' AND SALARY = 2000000;
WHERE (DEPT_CODE, SALARY)
            IN (SELECT DEPT_CODE, SALARY
                FROM EMPLOYEE
                            JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
                WHERE DEPT_TITLE = '기술지원부' AND SALARY = 2000000);
                
-- 다중행 다중열 서브쿼리                
-- 사원 중 총무부이고 300만원 이상 월급을 받는 사원
SELECT DEPT_CODE, SALARY
FROM EMPLOYEE
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE = '총무부' AND SALARY >= 3000000;

SELECT *
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, SALARY
                                                FROM EMPLOYEE
                                                         JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
                                                WHERE DEPT_TITLE = '총무부' AND SALARY >= 3000000);

-- 다중행, 다중행다중열 서브쿼리는 컬럼에는 사용불가.
-- WHERE, FROM절에 사용(다중행다중열은 FROM절에 많이 사용 = INLINE VIEW)
SELECT EMP_NAME, (SELECT DEPT_CODE, SALARY
                                                FROM EMPLOYEE
                                                         JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
                                                WHERE DEPT_TITLE = '총무부' AND SALARY >= 3000000) AS TEST -- 컬럼에는 1개의 ROW만 있어야함
FROM EMPLOYEE;

-- 상관 서브쿼리
-- 서브쿼리를 구성할 때 메인쿼리에 값을 가져와 사용하게 설정
-- 메인쿼리의 값이 서브쿼리의 결과에 영향을 주고, 서브쿼리의 결과가 메인쿼리의 결과에 영향을 줌
-- 본인이 속한 부서의 사원 수를 조회하기
-- 사원명, 부서코드, 사원수
SELECT COUNT(*) FROM EMPLOYEE WHERE DEPT_CODE = 'D9'; -- 선동일 부서 사원 수

SELECT EMP_NAME, DEPT_CODE, (SELECT COUNT(*) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE) AS 사원수
FROM EMPLOYEE E;

-- WHERE에 상관 서브쿼리 이용하기
-- EXISTS(서브쿼리) : 서브쿼리의 결과가 1행 이상이면 TRUE, 0행이면 FALSE -> 있니?
SELECT *
FROM EMPLOYEE E
--WHERE EXISTS(SELECT DEPT_CODE FROM EMPLOYEE WHERE DEPT_CODE = 'D9'); -- TRUE
WHERE EXISTS(SELECT 1 FROM EMPLOYEE WHERE E.EMP_ID = MANAGER_ID); -- 메인을 무조건 기준으로 비교

-- 최소 급여를 받는 사원 조회하기
SELECT *
FROM EMPLOYEE E
-- WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);
WHERE NOT EXISTS(SELECT 1 FROM EMPLOYEE WHERE E.SALARY > SALARY);

-- 모든 사원의 사원 번호, 이름, 매니저 아이디, 매니저 이름 조회하기
-- 서브쿼리로 풀어보자
SELECT EMP_NO, EMP_NAME, MANAGER_ID, (SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_ID = M.MANAGER_ID)
FROM EMPLOYEE M;

-- 사원의 이름, 급여, 부서명, 소속부서 급여평균 조회하기
SELECT EMP_NAME, SALARY,(SELECT DEPT_TITLE FROM DEPARTMENT WHERE DEPT_ID = E.DEPT_CODE) AS 부서명,
            FLOOR((SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE)) AS 평균
FROM EMPLOYEE E;

SELECT EMP_NAME,SALARY,DEPT_TITLE,
            TO_CHAR(FLOOR((SELECT AVG(SALARY) FROM EMPLOYEE WHERE E.DEPT_CODE=DEPT_CODE)),'FML999,999,999') 
            AS 소속부서평균
FROM EMPLOYEE E
             JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID;
-- 직급이 J1이 아닌 사원 중에서 자신의 부서별 평균 급여보다 급여를 적게 받는 사원 조회하기
SELECT *
FROM EMPLOYEE E
WHERE JOB_CODE != 'J1' AND SALARY < (SELECT AVG(SALARY) FROM EMPLOYEE WHERE E.DEPT_CODE = DEPT_CODE);
-- 자신이 속한 직급의 평균급여보다 많이 받는 직원의 이름, 직책명, 급여를 조회하기
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E
--        JOIN JOB USING (JOB_CODE)
        JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE WHERE E.JOB_CODE = JOB_CODE);

-- FROM절에 서브쿼리 이용하기
-- INLINE VIEW
-- FROM절에 사용하는 서브쿼리는 대부분 다중행다중열 서브쿼리 사용
-- RESULT SET을 하나의 테이블처럼 사용하게 하는 것
-- 가상컬럼을 포함하고 있거나, JOIN을 사용한 SELECT문을 사용
-- VIEW : INLINE VIEW, STORED VIEW
-- EMPLOYEE테이블에 성별을 추가해서 출력하기
SELECT E.*,  DECODE(SUBSTR(EMP_NO, 8,1), '1', '남', '2', '여', '3', '남', '4', '여') AS GENDER -- *, 가상컬럼 함께 사용X 사용하기 위해선 별칭 부여
FROM EMPLOYEE E;

-- 여자만 출력
SELECT E.*,  DECODE(SUBSTR(EMP_NO, 8,1), '1', '남', '2', '여', '3', '남', '4', '여') AS GENDER -- *, 가상컬럼 함께 사용X 사용하기 위해선 별칭 부여
FROM EMPLOYEE E
WHERE DECODE(SUBSTR(EMP_NO, 8,1), '1', '남', '2', '여', '3', '남', '4', '여') = '여';

-- INLINE VIEW 이용하기
SELECT *
FROM (
    SELECT E.*,  DECODE(SUBSTR(EMP_NO, 8,1), '1', '남', '2', '여', '3', '남', '4', '여') AS GENDER
    FROM EMPLOYEE E -- FROM절 안에 그대로 서브쿼리 써주면 테이블처럼 사용 가능
) 
WHERE GENDER = '여'; -- 테이블처럼 사용하기때문에 가상컬럼을 컬럼으로 사용 가능

-- JOIN 집합연산자 활용했을 때
SELECT *
FROM(
    SELECT *
    FROM EMPLOYEE
            LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
            JOIN JOB USING(JOB_CODE)
)
WHERE DEPT_TITLE = '총무부' AND JOB_NAME = '부사장';

SELECT T.*, T.SALARY * 12 AS 연봉
FROM (
        (SELECT E.*, D.*, (SELECT TRUNC(AVG(SALARY), -1) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE) AS DEPT_SAL_AVG
        FROM EMPLOYEE E 
        LEFT JOIN DEPARTMENT D ON DEPT_CODE = DEPT_ID) T
        )
WHERE DEPT_SAL_AVG > 3000000;

-- 집합연산자 이용하기
SELECT *
FROM (SELECT EMP_ID AS CODE, EMP_NAME AS TITLE
        FROM EMPLOYEE
        UNION
        SELECT DEPT_ID, DEPT_TITLE
        FROM DEPARTMENT
        UNION
        SELECT JOB_CODE, JOB_NAME
        FROM JOB
) 
WHERE CODE LIKE '%1%';

SELECT *
FROM(SELECT ROWNUM AS RNUM, E.*
            FROM(SELECT * FROM EMPLOYEE) E);

-- ROW의 순위를 정하고 출력하기
-- TOP N 출력하기
SELECT * FROM EMPLOYEE;

-- 급여를 많이 받는 사원 1~3위까지 출력하기
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;

-- 아래코드는 불가능
SELECT ROWNUM, EMP_NAME, SALARY --3번째 실행
FROM EMPLOYEE E -- 1번째 실행
WHERE ROWNUM BETWEEN 1 AND 3 --2번째 실행
ORDER BY SALARY DESC; --4번째 실행

-- 1. 오라클이 제공하는 가상컬럼 ROWNUM을 이용하기
SELECT ROWNUM, E.* FROM EMPLOYEE E WHERE ROWNUM BETWEEN 1 AND 3;

-- SELECT문을 실행할 때마다 ROWNUM이 생성이 됨 > 출력하기 위해 SELECT를 써준 것
SELECT ROWNUM, T.*
FROM(
        SELECT ROWNUM AS INNERNUM, E.*
        FROM EMPLOYEE E
        ORDER BY SALARY DESC
) T
WHERE ROWNUM <= 3;

-- 5~10위까지 구하기
SELECT * FROM(
SELECT ROWNUM AS RNUM, T.*
FROM(
        SELECT ROWNUM AS INNERNUM, E.*
        FROM EMPLOYEE E
        ORDER BY SALARY DESC
) T
)
WHERE RNUM BETWEEN 5 AND 10; -- ROWNUM은 중간 범위부터는 못가져옴, 1부터는 가능

-- 2. RANK() OVER() 함수 이용하기
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) AS NUM
FROM EMPLOYEE
WHERE ;

SELECT *
FROM (
            SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) AS NUM, -- 중복값만큼 다음 수
            DENSE_RANK() OVER(ORDER BY SALARY DESC) AS NUM2 -- 중복값있으면 바로 다음 수
            FROM EMPLOYEE
            )
WHERE NUM BETWEEN 5 AND 10;
                
-- 평균급여를 많이 받는 부서 3개 출력하기
-- 1. ROWNUM
SELECT *
FROM (
        SELECT ROWNUM AS RNUM, D.*
        FROM (
                SELECT DEPT_TITLE, AVG(SALARY) AS SAL_AVG
                FROM DEPARTMENT
                        JOIN EMPLOYEE ON DEPT_CODE = DEPT_ID
                        GROUP BY DEPT_TITLE
                ORDER BY 2 DESC
        ) D
)
WHERE RNUM <= 3;

-- 2. RANK() OVER()
SELECT *
FROM (
        SELECT RANK() OVER(ORDER BY SAL_AVG) AS SAL_ORDER, D.*
        FROM (
                SELECT DEPT_TITLE, AVG(SALARY) AS SAL_AVG
                FROM DEPARTMENT
                        JOIN EMPLOYEE ON DEPT_CODE = DEPT_ID
                        GROUP BY DEPT_TITLE
                ORDER BY 2 DESC
        ) D -- D라는 테이블 하나 만든 것(부서별 평균급여)
)
WHERE SAL_ORDER > 3;

-- WITH
WITH TOPN_SAL AS (SELECT EMP_NAME, SALARY FROM EMPLOYEE
                                ORDER BY SALARY DESC)
SELECT ROWNUM AS RNUM, EMP_NAME, SALARY
FROM TOPN_SAL;


-- 07_DDL(CREATE)
-- DDL에 대해 알아보자
-- 데이터 정의언어로 오라클에서 사용하는 객체를 생성, 수정, 삭제하는 명령어
-- 생성 : CREATE 오브젝트명 ....
-- 수정 : ALTER 오브젝트명 ....
-- 삭제 : DROP 오브젝트명

-- 테이블을 생성하는 방법부터 알아보자!
-- 테이블 생성 : 데이터를 저장할 수 있는 공간을 생성하는 것
-- 테이블을 생성하기 위해서는 저장공간을 확보하는데 확보할 때 TYPE이 필요
-- 오라클이 제공하는 타입 중 자주 사용하는 타입에 대해 알아보자.
-- 문자형 타입 : CHAR, VARCHAR2, NCHAR, NVARCHAR2, (CLOB)
-- 숫자형 타입 : NUMBER
-- 날짜형 타입 : DATE, TIMESTAMP

-- 문자형 타입에 대해 알아보자
-- CHAR(길이) : 고정형 문자열 저장타입으로 길이만큼 공간을 확보하고 저장한다. * 최대 2000byte 저장 가능
-- VARCHAR2(길이) : 가변형 문자열 저장타입으로 저장되는 데이터만큼 공간을 확보해서 저장한다. * 최대 4000byte 저장 가능
CREATE TABLE TBL_STR (
    A CHAR(6), -- 바이트기반
    B VARCHAR(6), -- 문자열기반
    C NCHAR(6),
    D NVARCHAR2(6)
);
SELECT * FROM TBL_STR;
INSERT INTO TBL_STR VALUES('ABC', 'ABC', 'ABC', 'ABC'); -- A, B, C, D 순으로 저장
INSERT INTO TBL_STR VALUES('가나', '가나', '가나', '가나');
INSERT INTO TBL_STR VALUES('가나', '가나다', '가나', '가나다'); -- 저장불가능, 너무 큼(실제 : 9, 최대값 : 6)
INSERT INTO TBL_STR VALUES('가나', '가나', '가나', '가나다라마바'); -- 저장 가능
INSERT INTO TBL_STR VALUES(1234,'가나','가나','가나다라마바'); -- 저장 가능

SELECT LENGTH(A), LENGTH(B), LENGTH(C), LENGTH(D)
FROM TBL_STR; -- CHAR인 애들은 무조건 6바이트(설정바이트) 사용, VARCHAR은 문자 들어간만큼만 공간 사용

-- 숫자형 자료형
-- NUMBER : 실수, 정수 모두 저장이 가능함
-- 선언방법
-- NUMBER : 기본값
-- NUMBER(PRECISION, SCALE) : 저장할 범위 설정
--              PRECISON : 표현할 수 있는 전체 자리 수(1~38)
--              SCALE : 소수점 이하의 자리수(-84~127번째 자리까지 지정 가능)
CREATE TABLE TBL_NUM(
    A NUMBER,
    B NUMBER(5),
    C NUMBER(5, 1), -- 4자리, 소수점 1자리 
    D NUMBER(5, -2) -- 7자리
);
SELECT * FROM TBL_NUM;
INSERT INTO TBL_NUM VALUES(1234.567, 1234.567, 1234.567, 1234.567);
INSERT INTO TBL_NUM VALUES(123456.123, 12345.123, 0, 0); -- 이 열에 대해 지정된 전체 자릿수보다 큰 값이 허용됩니다.
INSERT INTO TBL_NUM VALUES(123456.123, 12345.123, 1234.123, 0);
INSERT INTO TBL_NUM VALUES(123456.123, 12345.123, 1234.123, 1234567);
INSERT INTO TBL_NUM VALUES('1234.567', '1234.567', '1234.567', '1234.567'); -- 자동형변환
INSERT INTO TBL_NUM VALUES('1234.오육', '1234.567', '1234.567', '1234.567'); -- 수치가 부적합합니다

-- 날짜
-- DATE, TIMESTAMP
CREATE TABLE TBL_DATE(
    BIRTHDAY DATE,
    TODAY TIMESTAMP
);

SELECT * FROM TBL_DATE;
INSERT INTO TBL_DATE VALUES('98/08/03', '98/01/26 15:30:30');
INSERT INTO TBL_DATE VALUES(TO_DATE('98/08/03', 'RR/MM/DD'),
            TO_TIMESTAMP('98/01/26 15:30:30', 'RR/MM/DD HH24:MI:SS'));

CREATE TABLE TBL_STR2(
    TESTSTR CLOB,
    TESTVARCHAR VARCHAR2(4000) -- VARCHAR2 최대값 4000
);
SELECT * FROM TBL_STR2;
INSERT INTO TBL_STR2 VALUES('AKLFJLAJKLALKEFLAKL/.FEA;WF3[;,');

