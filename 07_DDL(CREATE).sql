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


-- 0407
-- 기본 테이블 작성하기
-- CREATE TABLE 테이블명 ex) BOARD_COMMENT(컬럼명 자료형(길이), 컬럼명2 자료형 ...);
-- 회원을 저장하는 테이블 만들기
-- 이름 : 문자, 회원번호 : 숫자 || 문자, 아이디 : 문자, 패스워드 : 문자, 이메일 : 문자, 나이 : 숫자
CREATE TABLE MEMBER(
        MEMBER_NAME VARCHAR2(20),
        MEMBER_NO NUMBER,
        MEMBER_ID VARCHAR2(15),
        MEMBER_PWD VARCHAR2(20),
        EMAIL VARCHAR2(30),
        AGE NUMBER,
        ENROLL_DATE DATE
); -- 길이 BYTE 단위로 생각

SELECT * FROM MEMBER;
-- 생성된 테이블 컬럼에 설명(COMMENT) 작성하기
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원이름 최소 2글자 이상 저장';
COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원아이디 최소 4글자 이상';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '회원비밀번호 최소 8글자 이상';

SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'MEMBER';

-- 테이블에 커멘트 작성하기
COMMENT ON TABLE MEMBER IS '회원정보저장';

SELECT *
FROM USER_TAB_COMMENTS;

-- 테이블의 각 컬럼에 저장되는 데이터의 특성에 따라 제약조건을 설정할 수 있다.
-- 오라클이 제공하는 제약조건
-- NOT NULL(C) : 지정된 컬럼에 NULL값을 허용하지 않는 것 * DEFAULT설정 NULLABLE
-- UNIQUE(U) : 지정된 컬럼에 중복값을 허용하지 않는 것
-- PRIMARY KEY(P) / PK : 데이터(ROW)를 구분하는 컬럼에 설정하는 제약조건 -> NOT NULL, UNIQUE 제약조건 (자동)설정
--                                 일반적으로 한 개 테이블에 한 개 PK 설정
--                                 다수 컬럼에 설정할 수도 있다(복합키)                                  
-- FOREIGN KEY(R) : 지정된 컬럼의 값을 다른 테이블의 지정된 컬럼에 있는 값만 저장하게 하는 제약조건
--                          다른 테이블 지정된 컬럼은 중복이 있으면 안됨! (UNIQUE 제약조건이나 PK제약조건이 설정된 컬럼 참조)
-- CHECK(C) : 지정된 컬럼에 지정된 값을 저장하기 위한 제약조건 * 동등값, 범위값 지정

-- 테이블, 컬럼에 설정된 제약조건을 확인하는 명령어
SELECT * 
FROM USER_CONSTRAINTS; -- 컬럼정보는 안나옴
SELECT *
FROM USER_CONS_COLUMNS; -- 제약조건 안나옴

SELECT C.CONSTRAINT_NAME, CONSTRAINT_TYPE, C.TABLE_NAME, SEARCH_CONDITION, COLUMN_NAME
FROM USER_CONSTRAINTS C
        JOIN USER_CONS_COLUMNS CC ON C.CONSTRAINT_NAME = CC.CONSTRAINT_NAME;

-- 테이블에 제약조건 설정하기
-- 제약조건 설정하는 방법 2가지
--      1. 테이블 생성과 동시에 설정하기
--           1) 컬럼 레벨에서 설정
--                ex) CREATE TABLE 테이블명(컬럼명 자료형 제약조건, 컬럼명2 자료형 제약조건, ...)
--           2) 테이블 레벨에서 설정
--                ex) CREATE TABLE 테이블명(컬럼명 자료형, 컬럼명2 자료형, 제약조건설정..)

--      2. 생성된 테이블에 제약조건 추가하기 -> ALTER명령어 이용

-- 1. NOT NULL 제약조건 설정하기
--      컬럼레벨에서만 설정이 가능
CREATE TABLE BASIC_MEMBER(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER
);
-- 제약조건이 설정되지 않으면 모든 컬럼에는 NULL값을 허용한다
INSERT INTO BASIC_MEMBER VALUES(NULL, NULL, NULL, NULL, NULL);
SELECT * FROM BASIC_MEMBER;
-- ID, PASSWORD는 NULL을 허용하면 안되는 컬럼
CREATE TABLE NN_MEMBER(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20) NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER
--  NOT NULL(MEMBER_NO) 테이블레벨에서는 설정 불가능
);
SELECT * FROM NN_MEMBER;
INSERT INTO NN_MEMBER VALUES(NULL, 'ADMIN', '1234', NULL, NULL);

-- 2. UNIQUE 제약조건
--      컬럼이 유일한 값을 유지해야할 때 사용
SELECT * FROM BASIC_MEMBER;
INSERT INTO BASIC_MEMBER VALUES(1, 'ADMIN', '1234', '관리자', 48);
INSERT INTO BASIC_MEMBER VALUES(2, 'ADMIN', '3333', '유저1', 31);

CREATE TABLE NQ_MEMBER(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20) UNIQUE,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER
);
SELECT * FROM NQ_MEMBER;
INSERT INTO NQ_MEMBER VALUES('1', 'ADMIN', '1234', '관리자', 44); -- O
INSERT INTO NQ_MEMBER VALUES('2', 'ADMIN', '1234', '유저1', 33); -- X

-- NULL값에 대한 처리는 어떻게 ? ?
INSERT INTO NQ_MEMBER VALUES(3, NULL, '1234', '유저2', 22); -- O
SELECT * FROM NQ_MEMBER;
INSERT INTO NQ_MEMBER VALUES(4, NULL, '4444', '유저3', 11); -- O, NULL에 대한 중복값은 알 수 없음

-- NULL값을 허용하지 않으려면 제약조건을 추가하면 된다.
CREATE TABLE NQ_MEMBER2(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20) UNIQUE NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER
);
SELECT * FROM NQ_MEMBER2;
INSERT INTO NQ_MEMBER2 VALUES(1, NULL, '1234', '관리자', 44); -- X
INSERT INTO NQ_MEMBER2 VALUES(1, 'ADMIN', '1234', '관리자', 44); -- O
INSERT INTO NQ_MEMBER2 VALUES(2, 'ADMIN', '2222', '유저2', 22); -- X

-- UNIQUE 제약조건을 테이블 레벨에서도 설정이 가능
CREATE TABLE NQ_MEMBER3(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20) NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER, 
    UNIQUE(MEMBER_ID) -- 다수의 컬럼에 UNIQUE 제약조건을 설정할 때 사용
);
INSERT INTO NQ_MEMBER3 VALUES(1, 'ADMIN', '1234', '관리자', 45); -- O
INSERT INTO NQ_MEMBER3 VALUES(2, 'ADMIN', '2222', '관리자', 45); -- X
SELECT * FROM NQ_MEMBER3;

-- 다수 컬럼에 UNIQUE 제약조건 설정하기
--      다수 컬럼의 값이 일치해야 중복값으로 인식 -> 선언컬럼이 하나의 그룹으로 묶임
CREATE TABLE NQ_MEMBER4(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20) NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER, 
    UNIQUE(MEMBER_ID, MEMBER_NAME) -- ID, NAME 모두 같아야 중복으로 처리
);
INSERT INTO NQ_MEMBER4 VALUES(1, 'ADMIN', '1234', '관리자', 44); -- O
SELECT * FROM NQ_MEMBER4;
INSERT INTO NQ_MEMBER4 VALUES(2, 'ADMIN', '3333', '유저1', 33); -- O
INSERT INTO NQ_MEMBER4 VALUES(4, 'ADMIN', '4444', '관리자', 24); -- X

-- 3. PRIMARY KEY 설정하기
--      생성한 테이블의 컬럼 중 도메인이 중복값이 없고, NULL값을 허용하지 않을 때 그 컬럼에 설정
--      PK용 컬럼을 생성해서 활용 -> IDX, STUDENTNO, PRODUCTNO, BOARDNO
--      저장되는 데이터 중 하나를 선택해서 설정
--      PK를 설정하면 자동으로 UNIQUE, NOT NULL제약조건, INDEX가 부여됨.
CREATE TABLE PK_MEMBER(
    MEMBER_NO NUMBER PRIMARY KEY,
    MEMBER_ID VARCHAR2(20) UNIQUE NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER
);
INSERT INTO PK_MEMBER VALUES(NULL, 'ADMIN', '1234', '관리자', 44); -- X, NOT NULL 제약조건 자동으로 설정
INSERT INTO PK_MEMBER VALUES(1, 'ADMIN', '1234', '관리자', 44); -- O
INSERT INTO PK_MEMBER VALUES(1, 'USER01', '2222', '유저1', 22); -- X
SELECT * FROM PK_MEMBER;

SELECT * FROM PK_MEMBER WHERE MEMBER_NO = 1; -- 유일한 값 하나 반환

-- PK 테이블레벨에서 설정하기
CREATE TABLE PK_MEMBER1(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20) UNIQUE NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER,
    PRIMARY KEY(MEMBER_NO)
);
INSERT INTO PK_MEMBER1 VALUES(1, 'ADMIN', '1234', '관리자', 44); -- O
INSERT INTO PK_MEMBER1 VALUES(1, 'ADMIN', '1234', '관리자', 44); -- X

-- PRIMARY KEY를 다수 컬럼에 설정할 수 있다. -> 복합키
-- 테이블 레벨에서 설정
CREATE TABLE PK_MEMBER2(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER,
    PRIMARY KEY(MEMBER_NO, MEMBER_ID)
);
DROP TABLE PK_MEMBER2;
INSERT INTO PK_MEMBER2 VALUES(1, 'USER01', '1111', '유저1', 33); -- O
INSERT INTO PK_MEMBER2 VALUES(2, 'USER01', '2222', '유저2', 22); -- O, NO, ID 값 둘다 같아야 저장 불가능
INSERT INTO PK_MEMBER2 VALUES(1, 'USER01', '2222', '유저2', 22); -- X
INSERT INTO PK_MEMBER2 VALUES(NULL, 'USER02', '3333', '유저3', 33); -- X
INSERT INTO PK_MEMBER2 VALUES(3, NULL, '3333', '유저3', 33); -- X
SELECT * FROM PK_MEMBER2;

-- 구매테이블, 장바구니 테이블 등에 복합키를 설정할 수 있다.
CREATE TABLE CART(
        MEMBER_ID VARCHAR2(20),
        PRODUCT_NO NUMBER,
        BUY_DATE DATE,
        STOCK NUMBER,
        PRIMARY KEY(MEMBER_ID, PRODUCT_NO, BUY_DATE)
);

-- 4. FOREIGN KEY 제약조건 설정하기
--      다른 테이블에 있는 데이터를 가져와 사용하는 것(참조)
--      참조관계를 설정하면 부모(참조되는 테이블) - 자식(참조하는 테이블) 관계가 설정이 됨.
--      FK 제약조건은 자식테이블에 설정
--      FK 제약조건을 설정하는 컬럼은 UNIQUE 제약조건이나 PK제약조건이 설정되어 있어야 한다.(유일한 값)
CREATE TABLE BOARD( -- 게시글 테이블
    BOARD_NO NUMBER PRIMARY KEY,
    BOARD_TITLE VARCHAR2(200),
    BOARD_CONTENT VARCHAR2(3000),
    BOARD_WRITER VARCHAR2(10) NOT NULL,
    BOARD_DATE DATE
);

CREATE TABLE BOARD_COMMENT( -- 댓글 테이블
    COMMENT_NO NUMBER PRIMARY KEY,
    COMMENT_CONTENT VARCHAR2(800),
    COMMENT_WRITER VARCHAR2(10),
    COMMENT_DATE DATE,
    BOARD_REF NUMBER REFERENCES BOARD(BOARD_NO) -- BOARD 참조
);

INSERT INTO BOARD VALUES(1, '냉무', NULL, '관리자', SYSDATE);
SELECT * FROM BOARD;
INSERT INTO BOARD VALUES(2, '솔이씨...', '너무하세요!!!', '강민기', SYSDATE);
INSERT INTO BOARD VALUES(3, '선생님 오늘 금요일', '금요일인데 정리할 시간... 없다', '최주영', SYSDATE);

INSERT INTO BOARD_COMMENT VALUES(1, '네 없어요!!!', '유병승', SYSDATE, 3);
INSERT INTO BOARD_COMMENT VALUES(2, '전 그럴 의도가 없었어요', '최솔', SYSDATE, 2);
INSERT INTO BOARD_COMMENT VALUES(3, '전 그럴 의도가 없었어요', '최솔', SYSDATE, 3); -- '4' 넣으면 X, 4번 게시글 없음(부모 키가 없습니다)
INSERT INTO BOARD_COMMENT VALUES(4, '호호호 금요일 즐겨요!', '조장흠', SYSDATE, 3);

SELECT *
FROM BOARD
        JOIN BOARD_COMMENT ON BOARD_NO = BOARD_REF;

-- FK가 설정된 컬럼에 NULL?? 저장된다.
-- 저장하지 않으려면 NOT NULL 제약조건을 설정해야한다.
INSERT INTO BOARD_COMMENT VALUES(5, 'NULL', '최솔', SYSDATE, NULL); -- O
SELECT * FROM BOARD_COMMENT;

-- FK를 설정해서 테이블 간 관계과 설정이 되면 참조되고 있는 부모 테이블의 ROW를 함부로 삭제할 수 없다.
DELETE FROM BOARD WHERE BOARD_NO = 1; -- 3이면 X
SELECT * FROM BOARD;

-- FK설정할 때 삭제에 대한 옵션을 설정할 수 있다.
-- ON DELETE SET NULL : 참조컬럼을 NULL값으로 수정 * 참조컬럼에 NOT NULL 제약조건이 있으면 안됨
-- ON DELETE CASCADE : 참조되는 부모 데이터가 삭제되면 같이 삭제해버림

CREATE TABLE BOARD_COMMENT2( -- 댓글 테이블
    COMMENT_NO NUMBER PRIMARY KEY,
    COMMENT_CONTENT VARCHAR2(800),
    COMMENT_WRITER VARCHAR2(10),
    COMMENT_DATE DATE,
--    BOARD_REF NUMBER REFERENCES BOARD(BOARD_NO) ON DELETE SET NULL -- BOARD_NO가 지워지면 NULL을 넣어라
    BOARD_REF NUMBER REFERENCES BOARD(BOARD_NO) ON DELETE CASCADE
);

INSERT INTO BOARD VALUES (1, '냉무', NULL, '유병승', SYSDATE);
INSERT INTO BOARD_COMMENT2 VALUES(6, 'SET NULL', '유병승', SYSDATE, 1);
SELECT * FROM BOARD_COMMENT2;
DELETE FROM BOARD WHERE BOARD_NO = 1; 
DROP TABLE BOARD_COMMENT2;

-- 참조관계를 설정할 때 대상이 되는 컬럼에는 반드시 UNIQUE, PK제약조건이 설정되어 있어야 한다.
CREATE TABLE FK_TEST(
    FK_NO NUMBER,
    PARENT_NAME VARCHAR2(20), -- REFERENCES BASIC_MEMBER(MEMBER_ID)
    FOREIGN KEY(PARENT_NAME) REFERENCES NQ_MEMBER2(MEMBER_ID) -- 테이블레벨에서도 설정가능
); -- X

-- FK는 한 개의 테이블만 가능, 다수 컬럼을 지정할 수 없다.
-- FK 설정하는 컬럼은 참조하는 컬럼과 타입, 길이(더 커도 상관없음)이 일치해야 한다.

-- 5. CHECK 제약조건
-- 컬럼에 지정한 값만 저장할 수 있게 하는 제약조건
-- 컬럼레벨에서 가능
CREATE TABLE PERSON(
        NAME VARCHAR2(20),
        AGE NUMBER CHECK(AGE > 0) NOT NULL,
        GENDER VARCHAR2(5) CHECK(GENDER IN('남', '여'))
);
INSERT INTO PERSON VALUES('유병승', -10, '남'); -- X, 나이 0 이하
INSERT INTO PERSON VALUES('유병승', 19, '남'); -- O
INSERT INTO PERSON VALUES('유병승', 19, '유'); -- X, 남/여 아님

-- 테이블 생성시 DEFAULT 값을 설정할 수 있음
-- DEFAULT 예약어 사용
CREATE TABLE DEFAULT_TEST(
        TEST_NO NUMBER PRIMARY KEY,
        TEST_DATE DATE DEFAULT SYSDATE,
        TEST_DATA VARCHAR2(20) DEFAULT '기본값'
);
INSERT INTO DEFAULT_TEST VALUES(1, DEFAULT, DEFAULT);
INSERT INTO DEFAULT_TEST VALUES(2, '23/02/04', '데이터');
INSERT INTO DEFAULT_TEST(TEST_NO) VALUES(3); -- 컬럼 골라넣을 수 있음, 나머지 컬럼에는 DEFAULT 값
SELECT * FROM DEFAULT_TEST;

-- 제약조건 설정시 이름 설정하기
-- 기본방식으로 제약조건을 설정하면 SYS00000 으로 자동 설정
CREATE TABLE MEMBER_TEST(
        MEMBER_NO NUMBER CONSTRAINT MEMBER_NO_PK PRIMARY KEY, -- 컬럼레벨
        MEMBER_ID VARCHAR2(20) CONSTRAINT MEMBER_ID_UQ UNIQUE NOT NULL,
        MEMBER_PWD VARCHAR2(20) CONSTRAINT MEMBER_PWD_NN NOT NULL,
        CONSTRAINT COMPOSE_UQ UNIQUE(MEMBER_NO, MEMBER_ID) -- 테이블레벨
);

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'MEMBER_TEST';

-- 테이블을 생성할 때 SELECT문을 이용할 수 있다.
-- 테이블 복사 개념
CREATE TABLE EMP_COPY
AS SELECT * FROM EMPLOYEE;

SELECT * FROM EMP_COPY;
DESC EMP_COPY;

CREATE TABLE EMP_SAL
AS SELECT E.*, D.*, (SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE) AS SAL_DEPT_AVG
FROM EMPLOYEE E JOIN DEPARTMENT D ON DEPT_ID = DEPT_CODE;

CREATE TABLE EMP_SAL2
AS SELECT E.*, D.*, (SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE) AS SAL_DEPT_AVG
FROM EMPLOYEE E JOIN DEPARTMENT D ON DEPT_ID = DEPT_CODE WHERE 1=2; -- FALSE를 만들어서 컬럼'만' 있는 테이블 생성

SELECT * FROM EMP_SAL;
SELECT * FROM EMP_SAL2;

--TEST_MEMBER 테이블
--MEMBER_CODE(NUMBER) - 기본키                  -- 회원전용코드 
--MEMBER_ID (varchar2(20) ) - 중복금지, NULL값 허용금지   -- 회원 아이디
--MEMBER_PWD (char(20)) - NULL 값 허용금지               -- 회원 비밀번호
--MEMBER_NAME(nchar(10)) - 기본값 '아무개'            -- 회원 이름
--MEMBER_ADDR (char(50)) - NULL값 허용금지               -- 회원 거주지
--GENDER (varchar2(5)) - '남' 혹은 '여'로만 입력 가능            -- 성별
--PHONE(varchar2(20)) - NULL 값 허용금지                -- 회원 연락처
--HEIGHT(NUMBER(5,2) - 130이상의 값만 입력가능           -- 회원키
CREATE TABLE TEST_MEMBER(
        MEMBER_CODE NUMBER CONSTRAINT PK_MEMBER_CODE PRIMARY KEY,
        MEMBER_ID VARCHAR2(20) UNIQUE NOT NULL,
        MEMBER_PWD CHAR(20) NOT NULL,
        MEMBER_NAME NCHAR(10) DEFAULT '아무개',
        MEMBER_ADDR CHAR(50) NOT NULL,
        GENDER VARCHAR2(5) CHECK(GENDER IN ('남', '여')),
        PHONE VARCHAR2(20) NOT NULL,
        HEIGHT NUMBER(5, 2) CHECK(HEIGHT >= 130)
);

COMMENT ON COLUMN TEST_MEMBER.MEMBER_CODE IS '회원전용코드';
COMMENT ON COLUMN TEST_MEMBER.MEMBER_ID IS '회원 아이디';
COMMENT ON COLUMN TEST_MEMBER.MEMBER_NAME IS '회원 이름';
COMMENT ON COLUMN TEST_MEMBER.MEMBER_ADDR IS '회원 거주지';
COMMENT ON COLUMN TEST_MEMBER.GENDER IS '성별';
COMMENT ON COLUMN TEST_MEMBER.PHONE IS '회원 연락처';
COMMENT ON COLUMN TEST_MEMBER.HEIGHT IS '회원키';

SELECT * FROM TEST_MEMBER;