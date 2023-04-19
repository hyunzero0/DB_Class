-- JOIN에 대해 알아보자
-- 두 개 이상의 테이블을 특정컬럼을 기준으로 연결해주는 기능
-- JOIN은 크게 두 종류가 있음
-- 1. INNER JOIN : 기준이 되는 값이 일치하는 ROW만 가져오는 JOIN 
-- 2. OUTER JOIN :  기준이 되는 값이 일치하지 않은 ROW도 가져오는 JOIN * 기준 필요

-- JOIN을 작성하는 방법 2가지
-- 1. 오라클 조인방식 : , 와 WHERE절로 작성
-- 2. ANSI 표준 조인방식 : JOIN, ON || USING 예약어를 사용해서 작성

-- EMPLOYEE테이블과 DEPARTMENT테이블 JOIN하기
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT; -- 공통인 값 찾기

-- 오라클 방식으로 JOIN하기
SELECT *
FROM EMPLOYEE, DEPARTMENT -- 테이블 묶는거라 FROM절 아래에(FROM절에) 작성
WHERE EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID;

-- ANSI 표준으로 JOIN하기
SELECT *
FROM EMPLOYEE JOIN DEPARTMENT ON EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID;

-- 사원에 대해 사원명, 이메일, 전화번호, 부서명 조회하기
SELECT EMP_NAME, EMAIL, PHONE, DEPT_TITLE
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- JOIN문에서도 WHERE절 사용하기
-- 부서가 총무부인 사원의 사원명, 월급, 보너스, 부서명 조회하기
SELECT EMP_NAME, SALARY, BONUS, DEPT_TITLE
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE = '총무부';

-- JOIN문에서 GROUP BY절 사용하기
-- 부서별 평균급여를 출력하기 부서명, 평균급여
SELECT DEPT_TITLE, AVG(SALARY)
FROM EMPLOYEE
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
GROUP BY DEPT_TITLE
HAVING AVG(SALARY) >= 3000000;

-- JOIN할 때 기준이 되는 컬럼명이 중복된다면 반드시 별칭을 작성해야한다.
-- 사원명, 급여, 보너스, 직책명을 조회하기
SELECT *
FROM EMPLOYEE E
        JOIN JOB J ON E.JOB_CODE = J.JOB_CODE -- 중복된 컬럼이 두 개 출력됨(E, J)
WHERE E.JOB_CODE = 'J3'; -- WHERE절에서도 별칭 부여해야함

-- 중복되는 컬럼명으로 JOIN할 때는 USING을 이용할 수 있다
SELECT *
FROM EMPLOYEE 
        JOIN JOB USING(JOB_CODE) -- 중복된 컬럼 한 개 출력됨(JOB_CODE 하나)
WHERE JOB_CODE = 'J3'; -- USING 사용시 별칭(식별자) 사용 X

-- 직책이 과장인 사원의 이름, 직책명, 직책코드, 월급을 조회하세요
SELECT EMP_NAME, JOB_NAME, JOB_CODE, SALARY
FROM EMPLOYEE 
        JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장';

SELECT COUNT(*)
FROM EMPLOYEE
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID -- INNER JOIN일 때 NULL이 있으면 포함X
WHERE DEPT_CODE IS NULL; -- 이미 위에서 NULL값 제거

-- OUTER JOIN 사용하기
-- 컬럼에 대해 동일비교를 했을 때 없는 ROW를 출력해주는 JOIN
-- (모든 데이터를 출력할)기준이 되는 테이블을 설정해줘야한다.
-- LEFT OUTER JOIN : JOIN을 기준으로 왼쪽에 있는 테이블을 기준으로 설정
-- RIGHT OUTER JOIN : JOIN을 기준으로 오른쪽에 있는 테이블을 기준으로 설정
-- 일치하는 ROW가 없는 경우 모든 컬럼을 NULL로 표시함
SELECT * 
FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID; -- OUTER생략가능
        
SELECT *
FROM EMPLOYEE RIGHT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- CROSS JOIN : 모든 ROW를 연결해주는 JOIN
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE CROSS JOIN DEPARTMENT
ORDER BY 1;

-- SELF JOIN : 한 개의 테이블에 다른 컬럼의 값을 가지고 있는 경우 그 두 개 컬럼을 이용해서 JOIN
SELECT * FROM EMPLOYEE;
-- MANAGER가 있는 사원의 이름, MANAGER_ID, MANAGER사원번호, MANAGER이름 조회
SELECT E.EMP_NAME, E.MANAGER_ID, M.EMP_ID, M.EMP_NAME
FROM EMPLOYEE E
        JOIN EMPLOYEE M ON E.MANAGER_ID = M.EMP_ID;
-- 사원이름, 매니저아이디, 매니저사원번호, 매니저 이름 조회
-- 매니저가 없으면 없음을 출력하기
SELECT E.EMP_NAME, NVL(E.MANAGER_ID, '없음'), NVL(M.EMP_ID, '없음'), NVL(M.EMP_NAME, '없음')
FROM EMPLOYEE E
        LEFT OUTER JOIN EMPLOYEE M ON E.MANAGER_ID = M.EMP_ID;

SELECT * FROM EMPLOYEE;

-- 동등조인 동등비교를 해서 처리함. ON 컬럼명 = 컬럼명
-- 비동등조인에 대해 알아보자
-- 연결할 테이블이 범위값을 가져야한다.
SELECT * FROM SAL_GRADE;
SELECT *
FROM EMPLOYEE
        JOIN SAL_GRADE ON SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- 회원등급 포인트제, 상품등급(상태), 댓글 수에 따른 회원등급

-- 다중조인을 할 수 있다.
-- 세 개 이상의 테이블을 연결해서 사용하기
-- 사원의 사원명, 직책명, 부서명을 조회하기
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE
FROM EMPLOYEE 
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
        JOIN JOB USING(JOB_CODE);

-- 사원의 사원명, 부서명, 직책명, 근무지역(LOCAL_NAME) 조회하기
-- 부서명이 없으면 대기, 근무지역이 없으면 대기발령을 출력하기
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM JOB;
SELECT * FROM LOCATION;

SELECT EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME
FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
        JOIN JOB USING(JOB_CODE)
        LEFT JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;