-- 0410
-- DDL(ALTER, DROP)
-- DELETE는 컬럼, ALTER/DROP은 테이블 기준
-- ARTER : 오라클에 정의되어 있는 오브젝트를 수정할 때 사용하는 명령어
-- ALTER TABLE : 테이블에 정의되어 있는 컬럼, 제약조건을 수정할 때 사용
CREATE TABLE TBL_USERALTER(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(20)
);
SELECT * FROM TBL_USERALTER;
-- 1. 생성된 TBL_USERALTER 테이블에 컬럼을 추가하기
--      ALTER TABLER 테이블명 ADD (컬럼명 자료형 [제약조건])
ALTER TABLE TBL_USERALTER ADD (USER_NAME VARCHAR2(20));
DESC TBL_USERALTER;
INSERT INTO TBL_USERALTER VALUES(1, 'ADMIN', '1234', '관리자');

--      테이블에 데이터가 있는 상태에서 컬럼을 추가하면?? 가능할까??
ALTER TABLE TBL_USERALTER ADD (NICKNAME VARCHAR2(30));
SELECT * FROM TBL_USERALTER; 

--      이메일 주소 추가할 때 NOT NULL 제약조건 설정
ALTER TABLE TBL_USERALTER ADD(EMAIL VARCHAR2(40) DEFAULT '미설정' NOT NULL);
ALTER TABLE TBL_USERALTER ADD(GENDER VARCHAR2(10) CONSTRAINT GENDER_CK CHECK (GENDER IN('남', '여')));
INSERT INTO TBL_USERALTER VALUES(2, 'USER01', 'USER01', '유저1', '유저', 'USER01@USER01.COM', '여');

-- 2. 제약조건 추가하기
--      ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 제약조건설정
ALTER TABLE TBL_USERALTER ADD CONSTRAINT USERID_UQ UNIQUE(USER_ID);
INSERT INTO TBL_USERALTER VALUES(3, 'USER01', 'USER02', '유저2', '유저2', 'USER01@USER02.COM', '남'); -- X
INSERT INTO TBL_USERALTER VALUES(3, 'USER02', 'USER02', '유저2', '유저2', 'USER01@USER02.COM', '남'); -- O

--      NOT NULL 제약조건은 이미 컬럼에 NULLABLE로 설정이 되어있기 때문에 ADD가 아닌 MODIFY 변경으로 해줘야 한다.
--ALTER TABLE TBL_USERALTER ADD CONSTRAINT PASSWORD_NN NO NULL(PASSWORD);
ALTER TABLE TBL_USERALTER MODIFY USER_PWD CONSTRAINT PASSWORD_NN NOT NULL;

-- 1. 컬럼 수정하기 -> 컬럼의 타입, 크기를 변경하는 것
-- ALTER TABLE 테이블명 MODIFY 컬럼명 자료형
DESC TBL_USERALTER;
ALTER TABLE TBL_USERALTER MODIFY GENDER CHAR(10);

-- 2. 제약조건 수정하기
ALTER TABLE TBL_USERALTER
MODIFY USER_PWD CONSTRAINT USER_PWD_UQ UNIQUE;

-- 1. 컬럼명 변경하기
--      ALTER TABLE 테이블명 RENAME COLUMN 컬럼명 TO 새 컬럼명
ALTER TABLE TBL_USERALTER RENAME COLUMN USER_ID TO USERID;
DESC TBL_USERALTER;

-- 2. 제약조건명 변경하기
--      ALTER TABLE 테이블명 RENAME CONSTRAINT 제약조건명 TO 새 제약조건명
ALTER TABLE TBL_USERALTER RENAME CONSTRAINT SYS_C007439 TO USERALTER_PK;

-- 1. 컬럼 삭제하기
--       ALTER TABLE 테이블명 DROP COLUMN 컬럼명
ALTER TABLE TBL_USERALTER DROP COLUMN EMAIL;
DESC TBL_USERALTER;

-- 2. 제약조건 삭제하기
--      ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명
ALTER TABLE TBL_USERALTER DROP CONSTRAINT USERALTER_PK;

-- 3. 테이블 삭제하기
DROP TABLE TBL_USERALTER;
SELECT * FROM TBL_USERALTER; -- 테이블 또는 뷰가 존재하지 않습니다
--      테이블을 삭제할 때 FK 제약조건이 설정되어 있다면 기본적으로 삭제가 불가능함
ALTER TABLE EMP_COPY ADD CONSTRAINT EMP_ID_PK PRIMARY KEY(EMP_ID);
CREATE TABLE TBL_FKTEST(
    EMP_ID VARCHAR(20) CONSTRAINT FK_EMPID REFERENCES EMP_COPY(EMP_ID),
    CONTENT VARCHAR(20)
);

DROP TABLE EMP_COPY; 
-- 옵션을 설정해서 삭제할 수 있다
DROP TABLE EMP_COPY CASCADE CONSTRAINT; -- 원래 안되던 게 설정하고 나서 삭제 가능


-- DCL에 대해 알아보자. -> SYSTEM 계정이 수행
-- 사용자의 권한 관리하는 명령어
-- GRANT 권한, 역할 TO 사용자계정명
-- 권한 : CREATE VIEW, CREATE TABLE, INSERT, SELECT, UPDATE 등
-- 역할(ROLE) : 권한의 묶음
-- 각 역할(ROLE)에 부여된 권한 확인하기
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'RESOURCE'; -- DBA계정(SYSTEM)으로 접속해서 봐야함
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'CONNECT'; 

ALTER SESSION SET "_ORACLE_SCRIPT" =TRUE;
CREATE USER QWER IDENTIFIED BY QWER DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
GRANT CONNECT TO QWER;

-- BS계정의 테이블을 조회할 수 있는 권한 부여하기
GRANT SELECT ON BS.EMPLOYEE TO QWER;
GRANT UPDATE ON BS.EMPLOYEE TO QWER;

-- 권한 회수하기
-- REVOKE 권한 || ROLE FROM 사용자계정명
REVOKE UPDATE ON BS.EMPLOYEE FROM QWER;

-- ROLE 만들기
CREATE ROLE MYROLE;
GRANT CREATE TABLE, CREATE VIEW TO MYROLE;

SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'MYROLE';
GRANT MYROLE TO QWER;


-- QWER/QWER 계정 시트
SELECT * FROM BS.EMPLOYEE; -- SELECT 부여받으면 가능
UPDATE BS.EMPLOYEE SET SALARY = 1000000; -- UPDATE 부여받으면 가능
ROLLBACK;

CREATE TABLE TEST(
    TESTNO NUMBER,
    TESTCONTENT VARCHAR2(200)
);

-- TCL : 트렌젝션을 컨트롤하는 명령어
-- COMMIT : 지금까지 실행한 수정구문(DML) 명령어를 모두 DB에 저장
-- ROLLBACK : 지금까지 실행한 수정구문(DML) 명령어를 모두 취소
-- 트렌젝션 : 하나의 작업단위, 한 개 서비스
-- 트렌젝션의 대상이 되는 명령어 : DML(INSERT, UPDATE, DELETE)

INSERT INTO JOB VALUES('J0', '강사');
SELECT * FROM JOB;
COMMIT;