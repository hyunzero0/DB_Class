-- SELECT문을 활용하기
-- 기본문법
-- SELECT 컬럼명, 컬럼명... || *
-- FROM 테이블명;

-- SELECT문을 이용해서 EMPLOYEE 테이블 조회하기
SELECT EMP_NAME, EMP_NO, EMAIL, PHONE
FROM EMPLOYEE;

-- SELECT문을 이용해서 EMPLOYEE테이블의 전체 컬럼 조회하기
SELECT * -- *은 ALL이라는 뜻, 엔터쳐서 구분하기
FROM EMPLOYEE;

-- 전체 사원의 이름, 월급, 보너스, 입사일 조회하기
SELECT EMP_NAME, SALARY, BONUS, HIRE_DATE
FROM EMPLOYEE;

-- 모든 내용을 확인할 때는 SELECT문을 이용함
-- SELECT문을 이용해서 산술연산 처리하기
-- +, -, *, / (사칙연산) -> 피연산자 = 리터럴, 컬럼값
SELECT 10 + 20, 10 - 20, 20 / 3, 5 * 4
FROM DUAL;

-- 리터럴, 컬럼 연산
-- 전체사원의 급여에 100원 더하기
SELECT EMP_NAME, SALARY + 100, SALARY
FROM EMPLOYEE;

-- 컬럼, 컬럼 연산
SELECT EMP_NAME, SALARY + BONUS
FROM EMPLOYEE;
-- NULL값과의 연산은 불가능하다. -> 결과 무조건 NULL로 출력
SELECT SALARY, BONUS
FROM EMPLOYEE;

-- 산술연산은 숫자형만 가능하다.
-- 오라클에서 문자열 리터럴은 ''을 사용한다.
SELECT '이제 점심먹자' + 100
FROM DUAL;

SELECT EMP_NAME, SALARY, BONUS, 10 + 30 -- 10 + 30은 원래 컬럼에 없음 -> 가상컬럼
FROM EMPLOYEE;


-- 사원 테이블에서 사원명, 부서코드, 월급, 연봉 조회하기
SELECT EMP_NAME, DEPT_CODE, SALARY, SALARY * 12
FROM EMPLOYEE;

-- 사원테이블에서 사원명, 부서코드, 월급, 보너스가 포함된 연봉 조회하기
SELECT EMP_NAME, DEPT_CODE, SALARY, (SALARY + SALARY * BONUS) * 12
FROM EMPLOYEE;

-- 테이블에 존재한느 컬럼만 조회가 가능하다.
SELECT EMP_NAME, DEPT_TITLE --DEPT_TITLE은 조회 불가능/ '부적합한 식별자'
FROM EMPLOYEE;
--SELECT * FROM DEPARTMENT;

SELECT * FROM EMPLOYEE;
-- 조회된 컬럼에 별칭을 부여할 수 있다. -> 가상컬럼에 많이 사용
-- AS 예약어를 사용한다.
-- 예) SELECT EMP_NAME AS 사원명 FROM EMPLOYEE;
SELECT EMP_NAME AS 사원명, SALARY AS 월급, EMAIL AS 이메일
FROM EMPLOYEE;
-- AS를 생략하고 띄어쓰기로 부여할 수 있다.
SELECT EMP_NAME 사원명, SALARY 월급, EMAIL 이메일
FROM EMPLOYEE;

-- 별칭에 띄어쓰기, 특수기호가 가능하니?
SELECT EMP_NAME AS "사 원 명", SALARY AS "$월$급"
FROM EMPLOYEE;

-- 조회되는 데이터의 중복을 제거해주는 명령어 : DISTINCT
-- 컬럼명 앞에 사용, SELECT문의 맨 앞에 작성
-- SELECT DISTINCT 컬럼명[,컬럼명...] FROM 테이블명
SELECT DEPT_CODE FROM EMPLOYEE;
SELECT DISTINCT DEPT_CODE FROM EMPLOYEE;
--SELECT EMP_NAME, DISTINCT DEPT_CODE FROM EMPLOYEE;

SELECT DISTINCT EMP_NAME, DEPT_CODE FROM EMPLOYEE;
SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE;
SELECT DISTINCT DEPT_CODE, JOB_CODE, SALARY FROM EMPLOYEE;

-- 오라클에서 문자열을 연결해주는 연산자 : ||
SELECT '점심' + '맛있다'
FROM DUAL;

SELECT '점심' || '맛없다 FEAT 반장'
FROM DUAL;

-- ||연산은 컬럼을 합쳐서 출력할 때도 사용한다.
SELECT EMP_NAME || EMP_NO || EMAIL AS INFO
FROM EMPLOYEE;
SELECT EMP_NAME || SALARY || BONUS
FROM EMPLOYEE;

SELECT EMP_NAME || '님의 월급은 ' || SALARY || ' 보너스' || BONUS
FROM EMPLOYEE;

-- 원하는 ROW(DATA) 출력하기
-- 지정한 조건에 맞는 데이터만 가져오기
-- WHERE 조건식
-- 사용방식
-- SELECT 컬럼, 컬럼... || *
-- FROM 테이블명
-- WHERE 조건식
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 사원 중 월급이 200만원 이상인 사원을 조회하기
SELECT *
FROM EMPLOYEE
WHERE SALARY >= 2000000;

-- 사원 중 직책이 J2가 아닌 사원 조회하기
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE != 'J2'; -- <>, !=, ^=

-- 여러 개의 비교연산 처리하기
-- 사원 중 부서가 D5이고 월급이 300만원 이상인 사원의 이름, 부서코드, 월급 조회하기
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY >= 3000000;

-- 사원 중 부서가 D5이거나 월급이 300만원 이상인 사원의 이름, 부서코드, 월급 조회하기
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY >= 3000000;

SELECT *
FROM EMPLOYEE
WHERE 1 = 2;

-- 날짜 대소비교하기
-- 날짜를 대소비교할 때는 문자로 비교, 문자열 패턴을 맞춰줌
-- 기본적인 날짜를 표시하는 문자열 패턴 : YY/MM/DD -> 'YY/MM/DD'
SELECT HIRE_DATE
FROM EMPLOYEE;

-- 입사일이 2000년 01월 01일 이전인 사원의 이름, 입사일 조회하기
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE < '00/01/01';

-- 입사일이 95년 01월 01일 이전인 사원의 전체 내용 조회하기
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE < '95/01/01';

-- 특정 범위에 있는 값을 조회하기
-- 사원 중 월급 200만원 이상 300만원 이하 월급을 받는 사원의 사원명, 월급, 보너스, 입사일을 조회하기
SELECT EMP_NAME, SALARY, BONUS, HIRE_DATE
FROM EMPLOYEE
WHERE 2000000 <= SALARY AND SALARY <= 3000000;

-- 사원 중 입사일이 00년 01월 01일부터 02년 12월 31일까지인 사원 전체조회하기
SELECT *
FROM EMPLOYEE
WHERE '00/01/01' <= HIRE_DATE AND HIRE_DATE <= '02/12/31';

-- 범위의 값으로 조회할 때 BETWEEN AND 연산 이용하기
-- 컬럼명 BETWEEN 값 AND 값
SELECT EMP_NAME, SALARY, BONUS, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 3000000;
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '00/01/01' AND '02/12/31' AND DEPT_CODE = 'D9';

-- LIKE 연산자 이용하기
-- 검색어를 문자열 패턴으로 검색하는 기능 -> 부분일치, 포함여부, 원하는 문자열 패턴검색
-- 문자열 패턴을 나타내는 기호
-- % : 문자가 0개 이상 아무 문자나 허용할 때 사용
-- 예) %강% : 강이 포함되어 있는 문자열 찾기(%에 문자가 있는지) -> 강, 한강, 두강, 두만강, 한강다리, 강강술래 O
--      %강 : 강으로 끝나는 말
--      강% : 강으로 시작하는 말
-- _ : 문자가 1개 아무 문자나 허용할 때 사용
-- 예) _강_ : 중간에 강이 있는 세 글자
--      _강 : 강으로 끝나는 두 글자
--      강_ : 강으로 시작하는 두 글자
--      _강% : 두 글자 이상의 두 번째 자리에 강을 포함하는 문자
-- 컬럼명 LIKE '패턴';

-- 사원 중 '유'씨 성을 가진 사원의 이름, 월급, 부서코드를 조회하기
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '유%'; -- '유__'도 가능

-- 이메일 주소에 'yo'를 포함하고 있는 사원의 사원명, 이메일 조회하기
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '%yo%';

-- 이메일 주소에 'j'를 포함하고 '유'씨 성을 가진 사원 조회하기
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '%j%' AND EMP_NAME LIKE '유%';

-- LIKE에 일치하지 않는 사원 찾기
-- NOT 부정연산 사용
-- '김'씨가 아닌 사원들 찾기
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME NOT LIKE '김%'; -- WHERE 뒤에 NOT 붙여도 가능

-- 이메일 주소에 _앞글자가 세 글자인 사원의 사원명, 이메일 조회하기
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___\_%' ESCAPE '\'; -- ESCAPE(*, \ 등) 앞에 써주면 문자처리

-- NULL값을 조회하기
-- NULL -> 쓰레기, 아무 의미없는 값 -> 연산이 불가능
-- 오라클이 제공하는 NULL 비교연산자를 사용
-- IS NULL, IS NOT NULL
-- 보너스를 받지 않는 사원 조회하기
SELECT EMP_NAME, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- 보너스를 받고있는 사원의 이름, 보너스를 조회하기
SELECT EMP_NAME, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

-- 조회된 컬럼값이 NULL일 때 대체하기
-- NVL(컬럼명, 대체값) 함수를 이용
SELECT EMP_NAME, SALARY, NVL(BONUS, 0)
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE, '인턴') AS DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL;

-- 다중값 동등비교하기
-- IN, NOT IN : 여러 개의 값을 OR로 연결해서 동등비교할 때 사용하는 연산자
-- 사원 중 부서코드가 D5, D6, D7, D8인 사원 구하기
SELECT *
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D5' OR DEPT_CODE = 'D6' OR DEPT_CODE = 'D7' OR DEPT_CODE = 'D8';
WHERE DEPT_CODE NOT IN ('D5', 'D6', 'D7','D8');

-- 서브쿼리문
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IN(SELECT DEPT_ID FROM DEPARTMENT WHERE DEPT_TITLE = '총무부' OR DEPT_TITLE LIKE '%해외%');

-- 연산자 우선순위
-- 직책이 J7이거나 J2인 사원 중 급여가 200만원 이상인 사원을 조회하기
-- 이름, 월급, 직책코드
SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
--WHERE JOB_CODE IN ('J7', 'J2') AND SALARY >= 2000000;
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J2')  AND SALARY >= 2000000;

-- 오늘 날짜를 출력할 수 있음
-- SYSDATE
SELECT SYSDATE FROM DUAL;
SELECT SYSDATE -10 FROM DUAL;
SELECT SYSDATE - HIRE_DATE
FROM EMPLOYEE;