-- 0412
-- SEQUENCE�� ���� �˾ƺ���
-- �ڵ���ȣ �߱����ִ� ��ü

-- �⺻ SEQUENCE �����ϱ�
-- CREATE SEQUENCE �������̸� [�ɼ�] ;
-- �⺻���� �����ϸ� ��ȣ�� 1���� 1�� �����ؼ� �߱�����
-- 1. SEQUENCE ��ȣ�� �߱��Ϸ��� ��������.NEXTVAL�� �����Ѵ�.
CREATE SEQUENCE SEQ_BASIC;
SELECT SEQ_BASIC.NEXTVAL FROM DUAL; -- ������ ������ +1
-- SEQUENCE�� �ߺ����� �ʴ� ���ڸ� �߱����ֱ� ������ ���̺��� PK�÷��� ������ ���� ����Ѵ�.
SELECT * FROM BOARD;
DESC BOARD;
INSERT INTO BOARD VALUES(SEQ_BASIC.NEXTVAL, 'ù ��° �Խñ�', 'ù ��°', '������', SYSDATE);

-- ���� SEQUENCE ���� Ȯ���ϱ�
-- ��������.CULLVAL�� �̿��Ѵ�.
SELECT SEQ_BASIC.CURRVAL FROM DUAL; -- ���� �� Ȯ��
SELECT SEQ_BASIC.NEXTVAL FROM DUAL;

SELECT * FROM BOARD;
CREATE TABLE ATTACHMENT(
        ATTACH_NO NUMBER PRIMARY KEY,
        BOARD_REF NUMBER REFERENCES BOARD(BOARD_NO),
        FILENAME VARCHAR2(200) NOT NULL
);
INSERT INTO BOARD VALUES(SEQ_BASIC.NEXTVAL, '÷�����ϰԽñ�', '÷�������ִ�', '������', SYSDATE);
INSERT INTO ATTACHMENT VALUES(1, SEQ_BASIC.CURRVAL, '�� ����.png');
INSERT INTO ATTACHMENT VALUES(2, SEQ_BASIC.CURRVAL, '�� ����2.png');
SELECT * FROM BOARD;
SELECT * FROM ATTACHMENT;
SELECT * FROM BOARD JOIN ATTACHMENT ON BOARD_NO = BOARD_REF;


-- SEQUENCE �ɼǰ� Ȱ���ϱ�
-- START WITH ���� : ������ ���ں��� ���� DEFAULT 1
-- INCREMENT BY ���� : �����ϴ� ������ �ǹ� DEFAULT 1
-- MAXVALUE ���� : �ִ밪�� ����
-- MINVALUE ���� : �ּҰ��� ����
-- CYCLE/NOCYCLE : ��ȣ�� ��ȯ���� ���� �����ϴ� �� * MAXVALUE, MINVALUE �� �����Ǿ� �־���Ѵ�.
-- CACHE : �̸� ��ȣ�� �����ϴ� ��� DEFAULT 20

-- 1. START WITH
SELECT * FROM USER_SEQUENCES;
CREATE SEQUENCE SEQ_01
START WITH 100;
SELECT SEQ_01.NEXTVAL FROM DUAL;

-- 2. INCREMENT BY
CREATE SEQUENCE SEQ_02
START WITH 100
INCREMENT BY 10;
SELECT SEQ_02.NEXTVAL FROM DUAL;

-- 3. MAXVALUE/MINVALUE
CREATE SEQUENCE SEQ_03
START WITH 100
INCREMENT BY -50
MAXVALUE 200
MINVALUE 0;
SELECT SEQ_03.NEXTVAL FROM DUAL;

-- 4. CYCLE/NOCYCLE + 5. CACHE
CREATE SEQUENCE SEQ_04
START WITH 100
INCREMENT BY 50
MAXVALUE 200
MINVALUE 0
CYCLE
NOCACHE;
SELECT SEQ_04.NEXTVAL FROM DUAL;

-- 1. CURRVAL�� ȣ���Ϸ��� ���� SESSION�ȿ��� NEXTVAL�� �� ���̶� ȣ���ϰ� ȣ���ؾ� �Ѵ�.
CREATE SEQUENCE SEQ_05;
SELECT SEQ_05.CURRVAL FROM DUAL; -- ����Ұ�
SELECT SEQ_05.NEXTVAL, SEQ_05.CURRVAL FROM DUAL;

-- 2. SEQUENCE�� ���� �߰��ؼ� PK������ �� �� �ִ�.
-- P_001, M_001
SELECT 'P_' || LPAD(SEQ_05.NEXTVAL, 4, '0') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') || '_' || SEQ_05.NEXTVAL FROM DUAL;

-- ����Ŭ���� �����ϴ� SELECT��
-- ����������, �� ���̺��� �����ִ� ROW�� ��� ����� �� �ְ� ���ִ� ������
--  -> ROW������ �����ִ� �ڷ�� �����ؼ� ���
-- �Ŵ����� �����ؼ� ����ϱ�
SELECT LEVEL, EMP_ID, EMP_NAME, MANAGER_ID
FROM EMPLOYEE
        START WITH EMP_ID = 200 -- ROOT �ֻ�(LEVEL = 1, ����� ROW 2 , ���� ����� ROW 3)
        CONNECT BY PRIOR EMP_ID = MANAGER_ID;

SELECT LEVEL || ' ' || LPAD(' ', (LEVEL -1)*5, ' ') || EMP_NAME || NVL2(MANAGER_ID, '(' || MANAGER_ID || ')' , '') AS ������
FROM EMPLOYEE
        START WITH EMP_ID = 200
        CONNECT BY PRIOR EMP_ID = MANAGER_ID;