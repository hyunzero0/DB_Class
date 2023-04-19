SELECT * FROM DBA_USERS;
SELECT * FROM TAB;

-- DATABASE����ϱ�
-- 1. ����� ������ ������(SYSTEM) �������� ��������
--      - �����ڷ� �����ؼ� ������ɾ �̿���.
-- 2. ������ ������ DATABASE�� �̿��ϱ� ���ؼ��� ������ �ο������ �Ѵ�.
--      - ������ �������� �����ؼ� ���� �ο� ��ɾ �̿�
--      - �ο����� : ������ �� �ִ� ����(CONNECT), ����� �� �ִ� ����(RESOURCE)
 
-- ���������ϴ� ��ɾ�(�ܿ��)
-- CREATE USER ����ڰ�����(��ҹ��ڱ���X) IDENTIFIED BY ��й�ȣ(��ҹ��ڱ���O) DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
-- ������, ��й�ȣ�� ����
CREATE USER BS IDENTIFIED BY BS DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
-- 18C �������� ����ڰ����� ##�� �ٿ��� �����ؾ��Ѵ�.
-- ## �Ⱥ��� �� �ְ� �����ϱ�
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
 
-- DB�� ��ϵǾ��ִ� ����� ��ȸ�ϱ�
SELECT * FROM DBA_USERS;
 
-- ����ڸ� �����ϴ��� ������ ������ DB�� �̿��� �� ����.
-- ����ڿ��� ���� �ο��ϱ�
-- GRANT ���� or ��(����) TO ����ڰ�����
GRANT CONNECT TO BS;
-- ���̺��� �̿��� �� �ִ� ������ �ο��ϱ�
GRANT RESOURCE TO BS;
 
GRANT CONNECT, RESOURCE TO BS;
 
-- BS�������� SQL�� �����غ���
SELECT * FROM TAB; --�������� �̿��ϰ� �ִ� ���̺��� ��ȸ�ϴ� ��ɾ�
CREATE TABLE TEST(
    TEST VARCHAR2(200)
);
 
-- USER01/USER01�̶�� ������ �����ϰ� ������ �Ʒ� ��ɾ� �����ϱ�
-- CREATE TABLE USER01(
-- AGE NUMBER
-- );
 
CREATE USER USER01 IDENTIFIED BY USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
GRANT CONNECT, RESOURCE TO USER01;
 
-- USER01
CREATE TABLE USER01(
   AGE NUMBER
);

SELECT * FROM TAB; -- ���̺� ��ȸ
SELECT * FROM BS.TEST;
SELECT * FROM USER01.USER01;

-- �⺻ �ǽ� DB�� ���� �˾ƺ���.
-- ���, �μ�, ��å, �ٹ���, �޿�����, �ٹ����� ����
-- ��� ���̺��� ����Ȯ���ϱ�
SELECT * FROM EMPLOYEE;
-- �μ� ���̺��� ����Ȯ���ϱ�
SELECT * FROM DEPARTMENT;
-- ��å ���̺��� ����Ȯ���ϱ�
SELECT * FROM JOB;
-- �μ��� �ٹ���
SELECT * FROM LOCATION;
-- �ٹ����� ������ ����
SELECT * FROM NATIONAL;
-- �޿�����
SELECT * FROM SAL_GRADE;