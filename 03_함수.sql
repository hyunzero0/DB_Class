-- 0403
-- 오라클에서 제공하는 함수에 대해 알아보자
-- 단일행 함수 : 테이블의 모든 행에 결과가 반환되는 함수(Row수 만큼 반환)
--                   문자, 숫자, 날짜, 형변환, 선택함수(조건활용)
-- 그룹함수 :  테이블 당 한 개의 결과가 반환되는 함수
--                 합계, 평균, 개수, 최대값, 최소값

-- 단일행 함수 활용하기
-- 사용하는 위치
-- SELECT문의 컬럼을 작성하는 부분, WHERE절, INSERT, UPDATE, DELETE문에서 사용 가능

-- 문자열 함수에 대해 알아보자
-- 문자열을 처리하는 기능
-- LENGTH : 지정된 컬럼이나 리터럴 값에 대한 길이를 출력해주는 함수
-- LENGTH('문자열' || 컬럼명) -> 문자열의 개수를 출력
SELECT LENGTH('오늘 월요일 힘내요!')
FROM DUAL;

SELECT LENGTH(EMAIL)
FROM EMPLOYEE;

-- 이메일이 16글자 이상인 사원을 조회하기
SELECT EMP_NAME, EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE
WHERE LENGTH(EMAIL) >= 16;

-- LENGTHB : 차지하는 BYTE를 출력
-- EXPRESS버전에서 한글을 3BYTE로 저장, ENTERPRISE버전에서는 2BYTE로 출력
SELECT LENGTHB('ABCD'), LENGTHB('월요일')
FROM EMPLOYEE;

-- INSTR  : JAVA에 INDEXOF와 유사한 기능
-- INSTR('문자열' || 컬럼명, '찾을 문자' [, 시작위치, 찾을횟수(몇 번째)] )
SELECT INSTR('GD아카데미', 'GD'), INSTR('GD아카데미', '아'), INSTR('GD아카데미', '병')
FROM DUAL; -- 오라클에서 인덱스 번호 0은 없음 1부터 시작, 없을 때 0 출력

SELECT EMAIL, INSTR(EMAIL, 'j')
FROM EMPLOYEE;

-- EMAIL주소에 j가 포함되어있는 사원 찾기
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE INSTR(EMAIL, 'j') > 0;

SELECT INSTR('GD아카데미 GD게임즈 GD음악사 GD화이팅', 'GD'),
           INSTR('GD아카데미 GD게임즈 GD음악사 GD화이팅', 'GD', 3),
           INSTR('GD아카데미 GD게임즈 GD음악사 GD화이팅', 'GD', -1), -- '팅'부터 뒤에서부터 찾음
           INSTR('GD아카데미 GD게임즈 GD음악사 GD화이팅', 'GD', 1, 3) -- 1번부터 3번째 GD찾기
FROM DUAL;

-- 사원테이블에서 @의 위치의 찾기
SELECT EMP_NAME, EMAIL, INSTR(EMAIL, '@')
FROM EMPLOYEE;

-- LPAD/RPAD : 문자열의 길이가 지정한 길이만큼 차지않았을 때 빈 공백을 채워주는 함수
-- LPAD/RPAD(문자열 || 컬럼명, 최대길이, 대체문자)
SELECT LPAD('유병승', 10, '*'), RPAD('유병승', 10, '@'), LPAD('유병승', 10) -- 최대길이 -> BYTE로 계산함, 여기서는 2BYTE로 처리
FROM DUAL;

SELECT EMAIL, RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

-- LTRIM/RTRIM : 공백을 제거하는 함수, 특정문자를 지정해서 삭제
-- LTRIM/RTRIM('문자열' || 컬럼명 [, '특정문자'] )
SELECT '      병승', LTRIM('      병승'), RTRIM('         병승         '), RTRIM('     병   승     ')
FROM DUAL;
-- 특정문자를 지정해서 삭제할 수 있다.
SELECT '병승2222', RTRIM('병승2222', '2'), RTRIM('병승22122', '2'),
            RTRIM('병승22122', '12') -- 1 OR 2를 삭제해라
FROM DUAL;

-- TRIM : 양쪽에 있는 값을 제거하는 함수, 기본 -> 공백, 설정하면 설정값을 제거(한 글자만)
-- TRIM(문자열 || 컬럼명)
-- TRIM(LEADING || TRAILING || BOTH '제거할 문자' FROM 문자열 || 컬럼명) / LEADING : 왼쪽, TRAILING : 오른쪽, BOTH : 양쪽
SELECT '     월요일     ', TRIM('     월요일     '),
           'ZZZZZZ마징가ZZZZZZ', TRIM('Z' FROM 'ZZZZZZ마징가ZZZZZZ'),
           TRIM(LEADING 'Z' FROM 'ZZZZZZ마징가ZZZZZZ'),
           TRIM(TRAILING 'Z' FROM 'ZZZZZZ마징가ZZZZZZ'),
           TRIM(BOTH 'Z' FROM 'ZZZZZZ마징가ZZZZZZ') -- 'Z'처럼 한 글자만 가능
FROM DUAL;

-- SUBSTR : 문자열을 잘라내는 기능 * JAVA SUBSTRING 메소드와 동일
-- SUBSTR(문자열 || 컬럼명, 시작인덱스번호 [, 길이] ) 
SELECT SUBSTR('SHOWMETHEMONEY', 5), SUBSTR('SHOWMETHEMONEY', 5, 2),
           SUBSTR('SHOWMETHEMONEY', INSTR('SHOWMETHEMONEY', 'MONEY')),
           SUBSTR('SHOWMETHEMONEY', -5, 2)
FROM DUAL;

-- 사원의 이메일에서 아이디값만 출력하기
-- 아이디가 7글자 이상인 사원만 조회
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1)
FROM EMPLOYEE
--WHERE LENGTH(SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1)) >= 7;
WHERE EMAIL LIKE '_______@%';

-- 사원의 성별을 표시하는 번호를 출력하기
-- 여자사원만 조회
SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN (2, 4);

-- 영문자를 처리하는 함수 : UPPER, LOWER, INITCAP
SELECT UPPER('Welcom to oRACLE worLd'),
           LOWER('Welcom to oRACLE worLd'),
           INITCAP('Welcom to oRACLE worLd')
FROM DUAL;

-- CONCAT : 문자열을 결합해주는 함수
-- || 연산자와 동일
SELECT EMP_NAME || EMAIL, CONCAT(EMP_NAME, EMAIL),
           CONCAT(CONCAT(EMP_NAME, EMAIL), SALARY)
FROM EMPLOYEE;

-- REPLACE : 대상문자(컬럼)에서 지정문자를 찾아서 특정문자로 변경하는 것
-- REPLACE(문자열 || 컬럼명, '찾을문자', '대체문자')
SELECT EMAIL, REPLACE(EMAIL, 'BS', 'GD')
FROM EMPLOYEE;

-- UPDATE EMPLOYEE SET EMAIL = REPLACE(EMAIL, 'BS', 'GD');
-- SELECT EMAIL FROM EMPLOYEE;
-- ROLLBACK;

-- REVERSE : 문자열을 거꾸로 만들어주는 기능
SELECT EMAIL, REVERSE(EMAIL), EMP_NAME, REVERSE(EMP_NAME) -- BYTE단위로 잘라서 깨짐
FROM EMPLOYEE;

-- TRANSLATE : 매칭되는 문자로 변경해주는 함수
SELECT TRANSLATE('010-3644-6259', '0123456789', '영일이삼사오육칠팔구')
FROM DUAL;

-- 숫자처리함수
-- ABS : 절대값을 처리하는 함수
SELECT ABS(-10), ABS(10)
FROM DUAL;

-- MOD : 나머지를 구하는 함수 * JAVA의 %연산자와 동일한 함수
SELECT MOD(3, 2)
FROM DUAL;

SELECT E.*, MOD(SALARY, 3) -- 가상 컬럼 사용시 * 전체 출력 불가(별칭부여해서 사용)
FROM EMPLOYEE E;

-- 소수점을 처리하는 함수
-- ROUND : 소수점을 반올림하는 함수
-- ROUND(숫자 || 컬럼명 [, 자리수])
SELECT 126.567, ROUND(126.567), ROUND(126.467), ROUND(126.567, 2)
FROM DUAL;

-- 보너스를 포함한 월급구하기
SELECT EMP_NAME, SALARY, SALARY + SALARY * NVL(BONUS, 0) - (SALARY * 0.03),
           ROUND(SALARY + SALARY * NVL(BONUS, 0) - (SALARY * 0.03))
FROM EMPLOYEE;

-- FLOOR : 소수점자리 버림
SELECT 126.567, FLOOR(126.567) -- FLOOR(126.567, 2)
FROM DUAL;

-- TRUNC : 소수점자리 자리 수 지정해서 버림
SELECT 126.567, TRUNC(126.567), TRUNC(126.567, 2), TRUNC(126.567, -2),
           TRUNC(2123456.32, -1)
FROM DUAL;

-- CEIL : 소수점 올림
SELECT 126.567, CEIL(126.567), CEIL(126.111)
FROM EMPLOYEE;

-- 날짜처리함수
-- 오라클에서 날짜를 출력할 때는 두 가지 방식이 있음
-- 1. SYSDATE예약어 -> 날짜 년/월/일 오늘 날짜(오라클이 설치되어 있는 컴퓨터의 날짜)를 출력해줌
-- 2. SYSTIMESTAMP예약어 -> 날짜 + 시간까지 출력해줌
SELECT SYSDATE, SYSTIMESTAMP
FROM DUAL;

-- 날짜도 산술연산처리가 가능함, +,- 연산 가능 -> 일 수가 차감, 추가됨
SELECT SYSDATE, SYSDATE - 2, SYSDATE + 3, SYSDATE + 30
FROM DUAL;

-- NEXT_DAY : 매개변수로 전달받은 요일 중 가장 가까운 다음 날짜 출력
SELECT SYSDATE, NEXT_DAY(SYSDATE, '월'), NEXT_DAY(SYSDATE, '수') -- NEXT_DAY(SYSDATE, 'MON')
FROM DUAL;
-- LOCALE의 값을 가지고 언어선택
SELECT * FROM V$NLS_PARAMETERS;
ALTER SESSION SET NLS_LANGUAGE = 'KOREAN';
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'MON'), NEXT_DAY(SYSDATE, 'TUESDAY')
FROM DUAL;

-- LAST_DAY : 그 달의 마지막 날을 출력
SELECT SYSDATE, LAST_DAY(SYSDATE), LAST_DAY(SYSDATE + 30)
FROM DUAL;

-- ADD_MONTHS : 개월 수를 더하는 함수
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 10)
FROM DUAL;

-- MONTHS_BETWEEN : 두 개의 날짜를 받아서 두 날짜의 개월 수를 계산해주는 함수
SELECT FLOOR(MONTHS_BETWEEN('23/08/17', SYSDATE))
FROM DUAL;

-- 날짜의 년도, 월, 일자를 따로 출력할 수 있는 함수
-- EXTRACT(YEAR || MONTH || DAY FROM 날짜) : 숫자로 출력해줌
-- 현재 날짜의 년, 월, 일 출력하기
SELECT EXTRACT(YEAR FROM SYSDATE) AS 년, EXTRACT(MONTH FROM SYSDATE) AS 월, EXTRACT(DAY FROM SYSDATE) AS 일
FROM DUAL;

-- 사원 중 12월에 입사한 사원들을 구하시오
SELECT *
FROM EMPLOYEE
WHERE EXTRACT(MONTH FROM HIRE_DATE) = 12;

SELECT EXTRACT(DAY FROM HIRE_DATE) + 100 --숫자값이기 때문에 가능
FROM EMPLOYEE;

-- 오늘부로 최주영씨가... 군대로 다시 끌려간다.. ㅠㅠ 군대복무기간은 1년 6개월,
-- 전역일자를 구하고, 전역때까지 먹는 짬밥 수(하루 세 끼)를 구하기
SELECT SYSDATE AS 입대일, ADD_MONTHS(SYSDATE, 18) AS 전역일, (ADD_MONTHS(SYSDATE, 18) - SYSDATE) * 3 AS 짬밥수
FROM DUAL;

-- 형변환 함수
-- 오라클에서는 자동형변환이 잘 작동함
-- 오라클 데이터를 저장하는 타입이 있음
-- 문자 : CHAR, VARCHAR2, NCHAR, NVARCHAR2 -> JAVA의 String과 동일
-- 숫자 : NUMBER
-- 날짜 : DATE, TIMESTAMP

-- TO_CHAR : 숫자, 날짜를 문자형으로 변경해주는 함수
-- 날짜를 문자형으로 변경하기
-- 날짜값을 기호로 표시해서 문자형으로 변경을 한다.
-- Y : 년, M : 월, D : 일, H : 시, MI : 분, SS : 초
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD'), TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') -- SYSDATE는 날짜, TO_CHAR은 문자
FROM DUAL;

SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YY.MM.DD'), TO_CHAR(HIRE_DATE, 'YYYY-MM-DD HH24:MI:SS')
FROM EMPLOYEE;

-- 숫자를 문자형으로 변경하기
-- 패턴에 맞춰서 변환 -> 자리 수를 어떻게 표현할 지 선택
-- 0 : 변환대상 값의 자리 수가 지정한 자리 수와 일치하지 않을 때, 값이 없는 자리에 0을 표시하는 패턴
-- 9 : 변환대상 값의 자리 수가 지정한 자리 수와 일치하지 않을 때, 값이 없는 자리를 생략하는 패턴
-- 통화를 표시하고 싶을 때는 L을 표시
SELECT 1234567, TO_CHAR(1234567, '000,000,000'), TO_CHAR(1234567, '999,999,999'),
           TO_CHAR(500, 'L999,999')
FROM DUAL;
SELECT 180.5, TO_CHAR(180.5, '000,000.0'), TRIM(TO_CHAR(180.5, 'FM999,999.00')) AS 키 -- FM붙이면 공백까지 제거
FROM DUAL;

-- 월급을 통화표시하고 ,로 구분해서 출력하고 입사일은 0000.00.00으로 출력하기
SELECT EMP_NAME, TO_CHAR(SALARY, 'FML999,999,999') AS 급여, TO_CHAR(HIRE_DATE, 'YYYY.MM.DD') AS 입사일
FROM EMPLOYEE;

-- 숫자형으로 변경하기
-- TO_NUMBER함수를 이용
-- 문자를 숫자형으로 변경하기
SELECT 1000000 + 1000000, TO_NUMBER('1,000,000','999,999,999') + 1000000,
           TO_CHAR(TO_NUMBER('1,000,000', '999,999,999') + 1000000, 'FML999,999,999')
FROM DUAL;

-- 날짜형으로 변경하기
-- 숫자를 날짜로 변경
-- 문자형를 숫자로 변경
SELECT TO_DATE('23/12/25', 'YY/MM/DD') - SYSDATE, TO_DATE('241225', 'YYMMDD'),
           TO_DATE('25-12-25', 'YY-MM-DD')
FROM DUAL;

SELECT TO_DATE(20230405, 'YYYYMMDD'), TO_DATE(230505, 'YYMMDD'), TO_DATE(TO_CHAR(000224, '000000'), 'YYMMDD')
FROM DUAL;

-- NULL값을 처리해주는 함수
-- NVL 함수 : NVL(컬럼명, '대체값')
-- NVL2 함수 : NVL2(컬럼명, NULL이 아닐 때, NULL일 때)
SELECT EMP_NAME, DEPT_CODE, NVL(DEPT_CODE, '인턴'), NVL2(DEPT_CODE, '있음', '없음')
FROM EMPLOYEE;

-- 조건에 따라 출력할 값을 변경해주는 함수
-- 1. DECODE
-- DECODE(컬럼명 || 문자열, '예상값', '대체값', '예상값2', '대체값2', ...)
-- 주민번호에서 8번째 자리 수가 1이면 남자, 2이면 여자 출력하는 가상 컬럼 추가하기
SELECT EMP_NAME, EMP_NO, DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남자', '2', '여자') AS GENDER
FROM EMPLOYEE;
--WHERE GENDER = '남자' 안됨

-- 각 직책코드의 명칭을 출력하기
-- J1 대표, J2 부사장, J3부장, J4 과장
-- 마지막에 '사원' = ELSE
SELECT EMP_NAME, JOB_CODE, DECODE(JOB_CODE, 'J1', '대표', 'J2', '부사장', 'J3', '부장', 'J4', '과장', '사원') AS 직급
FROM EMPLOYEE;

-- 2. CASE WHEN THEN ELSE
-- CASE 
--      WHEN 조건식 THEN 실행내용
--      WHEN 조건식 THEN 실행내용
--      WHEN 조건식 THEN 실행내용
--      ELSE 실행내용
-- END 

SELECT EMP_NAME, JOB_CODE,
        CASE
                WHEN JOB_CODE = 'J1' THEN '대표'
                WHEN JOB_CODE = 'J2' THEN '부사장'
                WHEN JOB_CODE = 'J3' THEN '부장'
                WHEN JOB_CODE = 'J4' THEN '과장'
                ELSE '사원'
        END AS 직책,
        CASE JOB_CODE
                WHEN 'J1'  THEN '대표'
                WHEN 'J2'  THEN '부사장'
        END
FROM EMPLOYEE;

-- 월급을 기준으로 고액월급자와 중간월급자 그 외를 나눠서 출력하기
-- 월급이 400만원 이상이면 고액
-- 월급이 400만원 미만 300만원 이상이면 중간월급
-- 나머지는 그 외를 출력하는 가상컬럼 만들기
-- 이름, 월급, 결과
SELECT EMP_NAME, SALARY,
        CASE
                WHEN SALARY >= 4000000 THEN '고액월급자'
                WHEN SALARY >= 3000000 THEN '중간월급자'
                ELSE '그 외'
        END AS 결과
FROM EMPLOYEE;

-- 사원테이블에서 현재 나이를 구하기
SELECT *
FROM EMPLOYEE;

SELECT  EMP_NAME, EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1,2), 'YY')) || '살' AS YY년,
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1,2), 'RR')) || '살' AS RR년,
            EXTRACT(YEAR FROM SYSDATE) - (
                TO_NUMBER(SUBSTR(EMP_NO, 1, 2)) +
                CASE
                        WHEN SUBSTR(EMP_NO, 8, 1) IN (1, 2) THEN 1900
                        WHEN SUBSTR(EMP_NO, 8, 1) IN (3, 4) THEN 2000
                END
            ) AS 살
FROM EMPLOYEE;

-- RR로 년도를 출력할 때
-- 현재년도    입력년도    계산년도
-- 00~49        00~49       현세기
-- 00~49        50~99       전세기
-- 50~99        00~49       다음세기
-- 50~99        50~99       현세기

insert into EMPLOYEE (EMP_ID,EMP_NAME,EMP_NO,EMAIL,PHONE,DEPT_CODE,JOB_CODE,SAL_LEVEL,SALARY,BONUS,MANAGER_ID,HIRE_DATE, ENT_DATE,ENT_YN) 
values ('252','옛사람','320808-4123341','go_dm@kh.or.kr',null,'D2','J2','S5',4480000,null,null,to_date('94/01/20','RR/MM/DD'),null,'N');
SELECT * FROM EMPLOYEE;

UPDATE EMPLOYEE SET EMP_NO = '320808-1123341' WHERE EMP_ID = '252';
COMMIT;

-- 그룹함수 활용하기
-- 테이블의 데이터에 대해 집계하는 함수들 합계, 형균, 개수, 최대값, 최소값을 구하는 함수
-- 그룹함수의 결과는 기본적으로 한 개의 값만 가져옴
-- 추가컬럼을 선택하는 것이 제한
-- 종류
-- SUM : 테이블의 특정 컬럼에 대한 총 합 -> SUM(컬럼명(NUMBER))
-- AVG : 테이블의 특정 컬럼에 대한 평균 -> AVG(컬럼명(NUMBER))
-- COUNT : 테이블의 데이터 수를 출력(ROW 수) -> COUNT(* || 컬럼명)
-- MIN : 테이블의 특정 컬럼에 대한 최소값 -> MIN(컬럼명) 
-- MAX : 테이블의 특정 컬럼에 대한 최대값 -> MAX(컬럼명)

-- 사원 월급의 총 합계를 구해보자
SELECT TO_CHAR(SUM(SALARY), 'FML999,999,999') FROM EMPLOYEE;

-- D5부서의 월급 총 합계를 구해보자
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--SELECT SUM(EMP_NAME)
--FROM EMPLOYEE;

-- J3사원의 급여 합계를 구하시오
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE JOB_CODE = 'J3';

-- 평균구하기 AVG함수
-- 전체사원에 대한 평균 구하기
SELECT AVG(SALARY) FROM EMPLOYEE;
-- D5의 급여 평균 구하기
SELECT AVG(SALARY) FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- D5부서의 급여 합계와 평균 구하기
SELECT SUM(SALARY), AVG(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- NULL값에 대해서는 어떻게 처리가 될까? -> NULL 값은 데이터 제외해버림
SELECT SUM(BONUS), AVG(BONUS), AVG(NVL(BONUS, 0))
FROM EMPLOYEE;

-- 테이블의 데이터 수 확인하기
SELECT COUNT(*), COUNT(DEPT_CODE), COUNT(BONUS) -- NULL인 ROW 제외
FROM EMPLOYEE; -- ROW개수

-- D6부서의 인원 조회하세요
SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6';

-- 400만원 이상 월급을 받는 사원 수
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- D5부서에서 보너스를 받고 있는 사원의 수는?
SELECT COUNT(BONUS)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- 부서가 D6, D5, D7인 사원의 수, 급여 합계, 평균을 조회하세요
SELECT COUNT(*) AS 사원수, SUM(SALARY) AS 급여합계, AVG(SALARY) AS 급여평균
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5', 'D6', 'D7');

SELECT MAX(SALARY), MIN(SALARY)
FROM EMPLOYEE;