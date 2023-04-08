-- 07_DDL(CREATE)
-- DDL�� ���� �˾ƺ���
-- ������ ���Ǿ��� ����Ŭ���� ����ϴ� ��ü�� ����, ����, �����ϴ� ��ɾ�
-- ���� : CREATE ������Ʈ�� ....
-- ���� : ALTER ������Ʈ�� ....
-- ���� : DROP ������Ʈ��

-- ���̺��� �����ϴ� ������� �˾ƺ���!
-- ���̺� ���� : �����͸� ������ �� �ִ� ������ �����ϴ� ��
-- ���̺��� �����ϱ� ���ؼ��� ��������� Ȯ���ϴµ� Ȯ���� �� TYPE�� �ʿ�
-- ����Ŭ�� �����ϴ� Ÿ�� �� ���� ����ϴ� Ÿ�Կ� ���� �˾ƺ���.
-- ������ Ÿ�� : CHAR, VARCHAR2, NCHAR, NVARCHAR2, (CLOB) 
-- ������ Ÿ�� : NUMBER
-- ��¥�� Ÿ�� : DATE, TIMESTAMP

-- ������ Ÿ�Կ� ���� �˾ƺ���
-- CHAR(����) : ������ ���ڿ� ����Ÿ������ ���̸�ŭ ������ Ȯ���ϰ� �����Ѵ�. * �ִ� 2000byte ���� ����
-- VARCHAR2(����) : ������ ���ڿ� ����Ÿ������ ����Ǵ� �����͸�ŭ ������ Ȯ���ؼ� �����Ѵ�. * �ִ� 4000byte ���� ����
CREATE TABLE TBL_STR (
    A CHAR(6), -- ����Ʈ���
    B VARCHAR(6), -- ���ڿ����
    C NCHAR(6),
    D NVARCHAR2(6)
);
SELECT * FROM TBL_STR;
INSERT INTO TBL_STR VALUES('ABC', 'ABC', 'ABC', 'ABC'); -- A, B, C, D ������ ����
INSERT INTO TBL_STR VALUES('����', '����', '����', '����');
INSERT INTO TBL_STR VALUES('����', '������', '����', '������'); -- ����Ұ���, �ʹ� ŭ(���� : 9, �ִ밪 : 6)
INSERT INTO TBL_STR VALUES('����', '����', '����', '�����ٶ󸶹�'); -- ���� ����
INSERT INTO TBL_STR VALUES(1234,'����','����','�����ٶ󸶹�'); -- ���� ����

SELECT LENGTH(A), LENGTH(B), LENGTH(C), LENGTH(D)
FROM TBL_STR; -- CHAR�� �ֵ��� ������ 6����Ʈ(��������Ʈ) ���, VARCHAR�� ���� ����ŭ�� ���� ���

-- ������ �ڷ���
-- NUMBER : �Ǽ�, ���� ��� ������ ������
-- ������
-- NUMBER : �⺻��
-- NUMBER(PRECISION, SCALE) : ������ ���� ����
--              PRECISON : ǥ���� �� �ִ� ��ü �ڸ� ��(1~38)
--              SCALE : �Ҽ��� ������ �ڸ���(-84~127��° �ڸ����� ���� ����)
CREATE TABLE TBL_NUM(
    A NUMBER,
    B NUMBER(5),
    C NUMBER(5, 1), -- 4�ڸ�, �Ҽ��� 1�ڸ� 
    D NUMBER(5, -2) -- 7�ڸ�
);
SELECT * FROM TBL_NUM;
INSERT INTO TBL_NUM VALUES(1234.567, 1234.567, 1234.567, 1234.567);
INSERT INTO TBL_NUM VALUES(123456.123, 12345.123, 0, 0); -- �� ���� ���� ������ ��ü �ڸ������� ū ���� ���˴ϴ�.
INSERT INTO TBL_NUM VALUES(123456.123, 12345.123, 1234.123, 0);
INSERT INTO TBL_NUM VALUES(123456.123, 12345.123, 1234.123, 1234567);
INSERT INTO TBL_NUM VALUES('1234.567', '1234.567', '1234.567', '1234.567'); -- �ڵ�����ȯ
INSERT INTO TBL_NUM VALUES('1234.����', '1234.567', '1234.567', '1234.567'); -- ��ġ�� �������մϴ�

-- ��¥
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
    TESTVARCHAR VARCHAR2(4000) -- VARCHAR2 �ִ밪 4000
);
SELECT * FROM TBL_STR2;
INSERT INTO TBL_STR2 VALUES('AKLFJLAJKLALKEFLAKL/.FEA;WF3[;,');


-- 0407
-- �⺻ ���̺� �ۼ��ϱ�
-- CREATE TABLE ���̺�� ex) BOARD_COMMENT(�÷��� �ڷ���(����), �÷���2 �ڷ��� ...);
-- ȸ���� �����ϴ� ���̺� �����
-- �̸� : ����, ȸ����ȣ : ���� || ����, ���̵� : ����, �н����� : ����, �̸��� : ����, ���� : ����
CREATE TABLE MEMBER(
        MEMBER_NAME VARCHAR2(20),
        MEMBER_NO NUMBER,
        MEMBER_ID VARCHAR2(15),
        MEMBER_PWD VARCHAR2(20),
        EMAIL VARCHAR2(30),
        AGE NUMBER,
        ENROLL_DATE DATE
); -- ���� BYTE ������ ����

SELECT * FROM MEMBER;
-- ������ ���̺� �÷��� ����(COMMENT) �ۼ��ϱ�
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS 'ȸ���̸� �ּ� 2���� �̻� ����';
COMMENT ON COLUMN MEMBER.MEMBER_ID IS 'ȸ�����̵� �ּ� 4���� �̻�';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS 'ȸ����й�ȣ �ּ� 8���� �̻�';

SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'MEMBER';

-- ���̺� Ŀ��Ʈ �ۼ��ϱ�
COMMENT ON TABLE MEMBER IS 'ȸ����������';

SELECT *
FROM USER_TAB_COMMENTS;

-- ���̺��� �� �÷��� ����Ǵ� �������� Ư���� ���� ���������� ������ �� �ִ�.
-- ����Ŭ�� �����ϴ� ��������
-- NOT NULL(C) : ������ �÷��� NULL���� ������� �ʴ� �� * DEFAULT���� NULLABLE
-- UNIQUE(U) : ������ �÷��� �ߺ����� ������� �ʴ� ��
-- PRIMARY KEY(P) / PK : ������(ROW)�� �����ϴ� �÷��� �����ϴ� �������� -> NOT NULL, UNIQUE �������� (�ڵ�)����
--                                 �Ϲ������� �� �� ���̺� �� �� PK ����
--                                 �ټ� �÷��� ������ ���� �ִ�(����Ű)                                  
-- FOREIGN KEY(R) : ������ �÷��� ���� �ٸ� ���̺��� ������ �÷��� �ִ� ���� �����ϰ� �ϴ� ��������
--                          �ٸ� ���̺� ������ �÷��� �ߺ��� ������ �ȵ�! (UNIQUE ���������̳� PK���������� ������ �÷� ����)
-- CHECK(C) : ������ �÷��� ������ ���� �����ϱ� ���� �������� * ���, ������ ����

-- ���̺�, �÷��� ������ ���������� Ȯ���ϴ� ��ɾ�
SELECT * 
FROM USER_CONSTRAINTS; -- �÷������� �ȳ���
SELECT *
FROM USER_CONS_COLUMNS; -- �������� �ȳ���

SELECT C.CONSTRAINT_NAME, CONSTRAINT_TYPE, C.TABLE_NAME, SEARCH_CONDITION, COLUMN_NAME
FROM USER_CONSTRAINTS C
        JOIN USER_CONS_COLUMNS CC ON C.CONSTRAINT_NAME = CC.CONSTRAINT_NAME;

-- ���̺� �������� �����ϱ�
-- �������� �����ϴ� ��� 2����
--      1. ���̺� ������ ���ÿ� �����ϱ�
--           1) �÷� �������� ����
--                ex) CREATE TABLE ���̺��(�÷��� �ڷ��� ��������, �÷���2 �ڷ��� ��������, ...)
--           2) ���̺� �������� ����
--                ex) CREATE TABLE ���̺��(�÷��� �ڷ���, �÷���2 �ڷ���, �������Ǽ���..)

--      2. ������ ���̺� �������� �߰��ϱ� -> ALTER��ɾ� �̿�

-- 1. NOT NULL �������� �����ϱ�
--      �÷����������� ������ ����
CREATE TABLE BASIC_MEMBER(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER
);
-- ���������� �������� ������ ��� �÷����� NULL���� ����Ѵ�
INSERT INTO BASIC_MEMBER VALUES(NULL, NULL, NULL, NULL, NULL);
SELECT * FROM BASIC_MEMBER;
-- ID, PASSWORD�� NULL�� ����ϸ� �ȵǴ� �÷�
CREATE TABLE NN_MEMBER(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20) NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER
--  NOT NULL(MEMBER_NO) ���̺��������� ���� �Ұ���
);
SELECT * FROM NN_MEMBER;
INSERT INTO NN_MEMBER VALUES(NULL, 'ADMIN', '1234', NULL, NULL);

-- 2. UNIQUE ��������
--      �÷��� ������ ���� �����ؾ��� �� ���
SELECT * FROM BASIC_MEMBER;
INSERT INTO BASIC_MEMBER VALUES(1, 'ADMIN', '1234', '������', 48);
INSERT INTO BASIC_MEMBER VALUES(2, 'ADMIN', '3333', '����1', 31);

CREATE TABLE NQ_MEMBER(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20) UNIQUE,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER
);
SELECT * FROM NQ_MEMBER;
INSERT INTO NQ_MEMBER VALUES('1', 'ADMIN', '1234', '������', 44); -- O
INSERT INTO NQ_MEMBER VALUES('2', 'ADMIN', '1234', '����1', 33); -- X

-- NULL���� ���� ó���� ��� ? ?
INSERT INTO NQ_MEMBER VALUES(3, NULL, '1234', '����2', 22); -- O
SELECT * FROM NQ_MEMBER;
INSERT INTO NQ_MEMBER VALUES(4, NULL, '4444', '����3', 11); -- O, NULL�� ���� �ߺ����� �� �� ����

-- NULL���� ������� �������� ���������� �߰��ϸ� �ȴ�.
CREATE TABLE NQ_MEMBER2(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20) UNIQUE NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER
);
SELECT * FROM NQ_MEMBER2;
INSERT INTO NQ_MEMBER2 VALUES(1, NULL, '1234', '������', 44); -- X
INSERT INTO NQ_MEMBER2 VALUES(1, 'ADMIN', '1234', '������', 44); -- O
INSERT INTO NQ_MEMBER2 VALUES(2, 'ADMIN', '2222', '����2', 22); -- X

-- UNIQUE ���������� ���̺� ���������� ������ ����
CREATE TABLE NQ_MEMBER3(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20) NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER, 
    UNIQUE(MEMBER_ID) -- �ټ��� �÷��� UNIQUE ���������� ������ �� ���
);
INSERT INTO NQ_MEMBER3 VALUES(1, 'ADMIN', '1234', '������', 45); -- O
INSERT INTO NQ_MEMBER3 VALUES(2, 'ADMIN', '2222', '������', 45); -- X
SELECT * FROM NQ_MEMBER3;

-- �ټ� �÷��� UNIQUE �������� �����ϱ�
--      �ټ� �÷��� ���� ��ġ�ؾ� �ߺ������� �ν� -> �����÷��� �ϳ��� �׷����� ����
CREATE TABLE NQ_MEMBER4(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20) NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER, 
    UNIQUE(MEMBER_ID, MEMBER_NAME) -- ID, NAME ��� ���ƾ� �ߺ����� ó��
);
INSERT INTO NQ_MEMBER4 VALUES(1, 'ADMIN', '1234', '������', 44); -- O
SELECT * FROM NQ_MEMBER4;
INSERT INTO NQ_MEMBER4 VALUES(2, 'ADMIN', '3333', '����1', 33); -- O
INSERT INTO NQ_MEMBER4 VALUES(4, 'ADMIN', '4444', '������', 24); -- X

-- 3. PRIMARY KEY �����ϱ�
--      ������ ���̺��� �÷� �� �������� �ߺ����� ����, NULL���� ������� ���� �� �� �÷��� ����
--      PK�� �÷��� �����ؼ� Ȱ�� -> IDX, STUDENTNO, PRODUCTNO, BOARDNO
--      ����Ǵ� ������ �� �ϳ��� �����ؼ� ����
--      PK�� �����ϸ� �ڵ����� UNIQUE, NOT NULL��������, INDEX�� �ο���.
CREATE TABLE PK_MEMBER(
    MEMBER_NO NUMBER PRIMARY KEY,
    MEMBER_ID VARCHAR2(20) UNIQUE NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER
);
INSERT INTO PK_MEMBER VALUES(NULL, 'ADMIN', '1234', '������', 44); -- X, NOT NULL �������� �ڵ����� ����
INSERT INTO PK_MEMBER VALUES(1, 'ADMIN', '1234', '������', 44); -- O
INSERT INTO PK_MEMBER VALUES(1, 'USER01', '2222', '����1', 22); -- X
SELECT * FROM PK_MEMBER;

SELECT * FROM PK_MEMBER WHERE MEMBER_NO = 1; -- ������ �� �ϳ� ��ȯ

-- PK ���̺������� �����ϱ�
CREATE TABLE PK_MEMBER1(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20) UNIQUE NOT NULL,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER,
    PRIMARY KEY(MEMBER_NO)
);
INSERT INTO PK_MEMBER1 VALUES(1, 'ADMIN', '1234', '������', 44); -- O
INSERT INTO PK_MEMBER1 VALUES(1, 'ADMIN', '1234', '������', 44); -- X

-- PRIMARY KEY�� �ټ� �÷��� ������ �� �ִ�. -> ����Ű
-- ���̺� �������� ����
CREATE TABLE PK_MEMBER2(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(10),
    MEMBER_AGE NUMBER,
    PRIMARY KEY(MEMBER_NO, MEMBER_ID)
);
DROP TABLE PK_MEMBER2;
INSERT INTO PK_MEMBER2 VALUES(1, 'USER01', '1111', '����1', 33); -- O
INSERT INTO PK_MEMBER2 VALUES(2, 'USER01', '2222', '����2', 22); -- O, NO, ID �� �Ѵ� ���ƾ� ���� �Ұ���
INSERT INTO PK_MEMBER2 VALUES(1, 'USER01', '2222', '����2', 22); -- X
INSERT INTO PK_MEMBER2 VALUES(NULL, 'USER02', '3333', '����3', 33); -- X
INSERT INTO PK_MEMBER2 VALUES(3, NULL, '3333', '����3', 33); -- X
SELECT * FROM PK_MEMBER2;

-- �������̺�, ��ٱ��� ���̺� � ����Ű�� ������ �� �ִ�.
CREATE TABLE CART(
        MEMBER_ID VARCHAR2(20),
        PRODUCT_NO NUMBER,
        BUY_DATE DATE,
        STOCK NUMBER,
        PRIMARY KEY(MEMBER_ID, PRODUCT_NO, BUY_DATE)
);

-- 4. FOREIGN KEY �������� �����ϱ�
--      �ٸ� ���̺� �ִ� �����͸� ������ ����ϴ� ��(����)
--      �������踦 �����ϸ� �θ�(�����Ǵ� ���̺�) - �ڽ�(�����ϴ� ���̺�) ���谡 ������ ��.
--      FK ���������� �ڽ����̺� ����
--      FK ���������� �����ϴ� �÷��� UNIQUE ���������̳� PK���������� �����Ǿ� �־�� �Ѵ�.(������ ��)
CREATE TABLE BOARD( -- �Խñ� ���̺�
    BOARD_NO NUMBER PRIMARY KEY,
    BOARD_TITLE VARCHAR2(200),
    BOARD_CONTENT VARCHAR2(3000),
    BOARD_WRITER VARCHAR2(10) NOT NULL,
    BOARD_DATE DATE
);

CREATE TABLE BOARD_COMMENT( -- ��� ���̺�
    COMMENT_NO NUMBER PRIMARY KEY,
    COMMENT_CONTENT VARCHAR2(800),
    COMMENT_WRITER VARCHAR2(10),
    COMMENT_DATE DATE,
    BOARD_REF NUMBER REFERENCES BOARD(BOARD_NO) -- BOARD ����
);

INSERT INTO BOARD VALUES(1, '�ù�', NULL, '������', SYSDATE);
SELECT * FROM BOARD;
INSERT INTO BOARD VALUES(2, '���̾�...', '�ʹ��ϼ���!!!', '���α�', SYSDATE);
INSERT INTO BOARD VALUES(3, '������ ���� �ݿ���', '�ݿ����ε� ������ �ð�... ����', '���ֿ�', SYSDATE);

INSERT INTO BOARD_COMMENT VALUES(1, '�� �����!!!', '������', SYSDATE, 3);
INSERT INTO BOARD_COMMENT VALUES(2, '�� �׷� �ǵ��� �������', '�ּ�', SYSDATE, 2);
INSERT INTO BOARD_COMMENT VALUES(3, '�� �׷� �ǵ��� �������', '�ּ�', SYSDATE, 3); -- '4' ������ X, 4�� �Խñ� ����(�θ� Ű�� �����ϴ�)
INSERT INTO BOARD_COMMENT VALUES(4, 'ȣȣȣ �ݿ��� ��ܿ�!', '������', SYSDATE, 3);

SELECT *
FROM BOARD
        JOIN BOARD_COMMENT ON BOARD_NO = BOARD_REF;

-- FK�� ������ �÷��� NULL?? ����ȴ�.
-- �������� �������� NOT NULL ���������� �����ؾ��Ѵ�.
INSERT INTO BOARD_COMMENT VALUES(5, 'NULL', '�ּ�', SYSDATE, NULL); -- O
SELECT * FROM BOARD_COMMENT;

-- FK�� �����ؼ� ���̺� �� ����� ������ �Ǹ� �����ǰ� �ִ� �θ� ���̺��� ROW�� �Ժη� ������ �� ����.
DELETE FROM BOARD WHERE BOARD_NO = 1; -- 3�̸� X
SELECT * FROM BOARD;

-- FK������ �� ������ ���� �ɼ��� ������ �� �ִ�.
-- ON DELETE SET NULL : �����÷��� NULL������ ���� * �����÷��� NOT NULL ���������� ������ �ȵ�
-- ON DELETE CASCADE : �����Ǵ� �θ� �����Ͱ� �����Ǹ� ���� �����ع���

CREATE TABLE BOARD_COMMENT2( -- ��� ���̺�
    COMMENT_NO NUMBER PRIMARY KEY,
    COMMENT_CONTENT VARCHAR2(800),
    COMMENT_WRITER VARCHAR2(10),
    COMMENT_DATE DATE,
--    BOARD_REF NUMBER REFERENCES BOARD(BOARD_NO) ON DELETE SET NULL -- BOARD_NO�� �������� NULL�� �־��
    BOARD_REF NUMBER REFERENCES BOARD(BOARD_NO) ON DELETE CASCADE
);

INSERT INTO BOARD VALUES (1, '�ù�', NULL, '������', SYSDATE);
INSERT INTO BOARD_COMMENT2 VALUES(6, 'SET NULL', '������', SYSDATE, 1);
SELECT * FROM BOARD_COMMENT2;
DELETE FROM BOARD WHERE BOARD_NO = 1; 
DROP TABLE BOARD_COMMENT2;

-- �������踦 ������ �� ����� �Ǵ� �÷����� �ݵ�� UNIQUE, PK���������� �����Ǿ� �־�� �Ѵ�.
CREATE TABLE FK_TEST(
    FK_NO NUMBER,
    PARENT_NAME VARCHAR2(20), -- REFERENCES BASIC_MEMBER(MEMBER_ID)
    FOREIGN KEY(PARENT_NAME) REFERENCES NQ_MEMBER2(MEMBER_ID) -- ���̺��������� ��������
); -- X

-- FK�� �� ���� ���̺� ����, �ټ� �÷��� ������ �� ����.
-- FK �����ϴ� �÷��� �����ϴ� �÷��� Ÿ��, ����(�� Ŀ�� �������)�� ��ġ�ؾ� �Ѵ�.

-- 5. CHECK ��������
-- �÷��� ������ ���� ������ �� �ְ� �ϴ� ��������
-- �÷��������� ����
CREATE TABLE PERSON(
        NAME VARCHAR2(20),
        AGE NUMBER CHECK(AGE > 0) NOT NULL,
        GENDER VARCHAR2(5) CHECK(GENDER IN('��', '��'))
);
INSERT INTO PERSON VALUES('������', -10, '��'); -- X, ���� 0 ����
INSERT INTO PERSON VALUES('������', 19, '��'); -- O
INSERT INTO PERSON VALUES('������', 19, '��'); -- X, ��/�� �ƴ�

-- ���̺� ������ DEFAULT ���� ������ �� ����
-- DEFAULT ����� ���
CREATE TABLE DEFAULT_TEST(
        TEST_NO NUMBER PRIMARY KEY,
        TEST_DATE DATE DEFAULT SYSDATE,
        TEST_DATA VARCHAR2(20) DEFAULT '�⺻��'
);
INSERT INTO DEFAULT_TEST VALUES(1, DEFAULT, DEFAULT);
INSERT INTO DEFAULT_TEST VALUES(2, '23/02/04', '������');
INSERT INTO DEFAULT_TEST(TEST_NO) VALUES(3); -- �÷� ������ �� ����, ������ �÷����� DEFAULT ��
SELECT * FROM DEFAULT_TEST;

-- �������� ������ �̸� �����ϱ�
-- �⺻������� ���������� �����ϸ� SYS00000 ���� �ڵ� ����
CREATE TABLE MEMBER_TEST(
        MEMBER_NO NUMBER CONSTRAINT MEMBER_NO_PK PRIMARY KEY, -- �÷�����
        MEMBER_ID VARCHAR2(20) CONSTRAINT MEMBER_ID_UQ UNIQUE NOT NULL,
        MEMBER_PWD VARCHAR2(20) CONSTRAINT MEMBER_PWD_NN NOT NULL,
        CONSTRAINT COMPOSE_UQ UNIQUE(MEMBER_NO, MEMBER_ID) -- ���̺���
);

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'MEMBER_TEST';

-- ���̺��� ������ �� SELECT���� �̿��� �� �ִ�.
-- ���̺� ���� ����
CREATE TABLE EMP_COPY
AS SELECT * FROM EMPLOYEE;

SELECT * FROM EMP_COPY;
DESC EMP_COPY;

CREATE TABLE EMP_SAL
AS SELECT E.*, D.*, (SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE) AS SAL_DEPT_AVG
FROM EMPLOYEE E JOIN DEPARTMENT D ON DEPT_ID = DEPT_CODE;

CREATE TABLE EMP_SAL2
AS SELECT E.*, D.*, (SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE) AS SAL_DEPT_AVG
FROM EMPLOYEE E JOIN DEPARTMENT D ON DEPT_ID = DEPT_CODE WHERE 1=2; -- FALSE�� ���� �÷�'��' �ִ� ���̺� ����

SELECT * FROM EMP_SAL;
SELECT * FROM EMP_SAL2;

--TEST_MEMBER ���̺�
--MEMBER_CODE(NUMBER) - �⺻Ű                  -- ȸ�������ڵ� 
--MEMBER_ID (varchar2(20) ) - �ߺ�����, NULL�� ������   -- ȸ�� ���̵�
--MEMBER_PWD (char(20)) - NULL �� ������               -- ȸ�� ��й�ȣ
--MEMBER_NAME(nchar(10)) - �⺻�� '�ƹ���'            -- ȸ�� �̸�
--MEMBER_ADDR (char(50)) - NULL�� ������               -- ȸ�� ������
--GENDER (varchar2(5)) - '��' Ȥ�� '��'�θ� �Է� ����            -- ����
--PHONE(varchar2(20)) - NULL �� ������                -- ȸ�� ����ó
--HEIGHT(NUMBER(5,2) - 130�̻��� ���� �Է°���           -- ȸ��Ű
CREATE TABLE TEST_MEMBER(
        MEMBER_CODE NUMBER CONSTRAINT PK_MEMBER_CODE PRIMARY KEY,
        MEMBER_ID VARCHAR2(20) UNIQUE NOT NULL,
        MEMBER_PWD CHAR(20) NOT NULL,
        MEMBER_NAME NCHAR(10) DEFAULT '�ƹ���',
        MEMBER_ADDR CHAR(50) NOT NULL,
        GENDER VARCHAR2(5) CHECK(GENDER IN ('��', '��')),
        PHONE VARCHAR2(20) NOT NULL,
        HEIGHT NUMBER(5, 2) CHECK(HEIGHT >= 130)
);

COMMENT ON COLUMN TEST_MEMBER.MEMBER_CODE IS 'ȸ�������ڵ�';
COMMENT ON COLUMN TEST_MEMBER.MEMBER_ID IS 'ȸ�� ���̵�';
COMMENT ON COLUMN TEST_MEMBER.MEMBER_NAME IS 'ȸ�� �̸�';
COMMENT ON COLUMN TEST_MEMBER.MEMBER_ADDR IS 'ȸ�� ������';
COMMENT ON COLUMN TEST_MEMBER.GENDER IS '����';
COMMENT ON COLUMN TEST_MEMBER.PHONE IS 'ȸ�� ����ó';
COMMENT ON COLUMN TEST_MEMBER.HEIGHT IS 'ȸ��Ű';

SELECT * FROM TEST_MEMBER;