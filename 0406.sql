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
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE HIRE_DATE < '00/01/01' 
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
            AND ENT_YN = 'N';

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







