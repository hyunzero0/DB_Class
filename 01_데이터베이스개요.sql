SELECT * FROM DBA_USERS;
SELECT * FROM TAB;

-- DATABASE사용하기
-- 1. 사용할 계정을 관리자(SYSTEM) 계정으로 생성해줌
--      - 관리자로 접속해서 생성명령어를 이용함.
-- 2. 생성한 계정이 DATABASE를 이용하기 위해서는 권한을 부여해줘야 한다.
--      - 관리자 계정으로 접속해서 권한 부여 명령어를 이용
--      - 부여권한 : 접속할 수 있는 권한(CONNECT), 사용할 수 있는 권한(RESOURCE)
 
-- 계정생성하는 명령어(외우기)
-- CREATE USER 사용자계정명(대소문자구분X) IDENTIFIED BY 비밀번호(대소문자구분O) DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
-- 계정명, 비밀번호만 변경
CREATE USER BS IDENTIFIED BY BS DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
-- 18C 버전부터 사용자계정명에 ##을 붙여서 생성해야한다.
-- ## 안붙일 수 있게 설정하기
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
 
-- DB에 등록되어있는 사용자 조회하기
SELECT * FROM DBA_USERS;
 
-- 사용자를 생성하더라도 권한이 없으면 DB를 이용할 수 없다.
-- 사용자에게 권한 부여하기
-- GRANT 권한 or 롤(역할) TO 사용자계정명
GRANT CONNECT TO BS;
-- 테이블을 이용할 수 있는 권한을 부여하기
GRANT RESOURCE TO BS;
 
GRANT CONNECT, RESOURCE TO BS;
 
-- BS계정에서 SQL문 실행해보기
SELECT * FROM TAB; --계정에서 이용하고 있는 테이블을 조회하는 명령어
CREATE TABLE TEST(
    TEST VARCHAR2(200)
);
 
-- USER01/USER01이라는 계정을 생성하고 접속해 아래 명령어 실행하기
-- CREATE TABLE USER01(
-- AGE NUMBER
-- );
 
CREATE USER USER01 IDENTIFIED BY USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
GRANT CONNECT, RESOURCE TO USER01;
 
-- USER01
CREATE TABLE USER01(
   AGE NUMBER
);

SELECT * FROM TAB; -- 테이블 조회
SELECT * FROM BS.TEST;
SELECT * FROM USER01.USER01;

-- 기본 실습 DB에 대해 알아보자.
-- 사원, 부서, 직책, 근무지, 급여수준, 근무지별 국가
-- 사원 테이블의 정보확인하기
SELECT * FROM EMPLOYEE;
-- 부서 테이블의 정보확인하기
SELECT * FROM DEPARTMENT;
-- 직책 테이블의 정보확인하기
SELECT * FROM JOB;
-- 부서별 근무지
SELECT * FROM LOCATION;
-- 근무지역 국가별 정보
SELECT * FROM NATIONAL;
-- 급여수준
SELECT * FROM SAL_GRADE;