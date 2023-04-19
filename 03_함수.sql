-- 0403
-- ����Ŭ���� �����ϴ� �Լ��� ���� �˾ƺ���
-- ������ �Լ� : ���̺��� ��� �࿡ ����� ��ȯ�Ǵ� �Լ�(Row�� ��ŭ ��ȯ)
--                   ����, ����, ��¥, ����ȯ, �����Լ�(����Ȱ��)
-- �׷��Լ� :  ���̺� �� �� ���� ����� ��ȯ�Ǵ� �Լ�
--                 �հ�, ���, ����, �ִ밪, �ּҰ�

-- ������ �Լ� Ȱ���ϱ�
-- ����ϴ� ��ġ
-- SELECT���� �÷��� �ۼ��ϴ� �κ�, WHERE��, INSERT, UPDATE, DELETE������ ��� ����

-- ���ڿ� �Լ��� ���� �˾ƺ���
-- ���ڿ��� ó���ϴ� ���
-- LENGTH : ������ �÷��̳� ���ͷ� ���� ���� ���̸� ������ִ� �Լ�
-- LENGTH('���ڿ�' || �÷���) -> ���ڿ��� ������ ���
SELECT LENGTH('���� ������ ������!')
FROM DUAL;

SELECT LENGTH(EMAIL)
FROM EMPLOYEE;

-- �̸����� 16���� �̻��� ����� ��ȸ�ϱ�
SELECT EMP_NAME, EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE
WHERE LENGTH(EMAIL) >= 16;

-- LENGTHB : �����ϴ� BYTE�� ���
-- EXPRESS�������� �ѱ��� 3BYTE�� ����, ENTERPRISE���������� 2BYTE�� ���
SELECT LENGTHB('ABCD'), LENGTHB('������')
FROM EMPLOYEE;

-- INSTR  : JAVA�� INDEXOF�� ������ ���
-- INSTR('���ڿ�' || �÷���, 'ã�� ����' [, ������ġ, ã��Ƚ��(�� ��°)] )
SELECT INSTR('GD��ī����', 'GD'), INSTR('GD��ī����', '��'), INSTR('GD��ī����', '��')
FROM DUAL; -- ����Ŭ���� �ε��� ��ȣ 0�� ���� 1���� ����, ���� �� 0 ���

SELECT EMAIL, INSTR(EMAIL, 'j')
FROM EMPLOYEE;

-- EMAIL�ּҿ� j�� ���ԵǾ��ִ� ��� ã��
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE INSTR(EMAIL, 'j') > 0;

SELECT INSTR('GD��ī���� GD������ GD���ǻ� GDȭ����', 'GD'),
           INSTR('GD��ī���� GD������ GD���ǻ� GDȭ����', 'GD', 3),
           INSTR('GD��ī���� GD������ GD���ǻ� GDȭ����', 'GD', -1), -- '��'���� �ڿ������� ã��
           INSTR('GD��ī���� GD������ GD���ǻ� GDȭ����', 'GD', 1, 3) -- 1������ 3��° GDã��
FROM DUAL;

-- ������̺��� @�� ��ġ�� ã��
SELECT EMP_NAME, EMAIL, INSTR(EMAIL, '@')
FROM EMPLOYEE;

-- LPAD/RPAD : ���ڿ��� ���̰� ������ ���̸�ŭ �����ʾ��� �� �� ������ ä���ִ� �Լ�
-- LPAD/RPAD(���ڿ� || �÷���, �ִ����, ��ü����)
SELECT LPAD('������', 10, '*'), RPAD('������', 10, '@'), LPAD('������', 10) -- �ִ���� -> BYTE�� �����, ���⼭�� 2BYTE�� ó��
FROM DUAL;

SELECT EMAIL, RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

-- LTRIM/RTRIM : ������ �����ϴ� �Լ�, Ư�����ڸ� �����ؼ� ����
-- LTRIM/RTRIM('���ڿ�' || �÷��� [, 'Ư������'] )
SELECT '      ����', LTRIM('      ����'), RTRIM('         ����         '), RTRIM('     ��   ��     ')
FROM DUAL;
-- Ư�����ڸ� �����ؼ� ������ �� �ִ�.
SELECT '����2222', RTRIM('����2222', '2'), RTRIM('����22122', '2'),
            RTRIM('����22122', '12') -- 1 OR 2�� �����ض�
FROM DUAL;

-- TRIM : ���ʿ� �ִ� ���� �����ϴ� �Լ�, �⺻ -> ����, �����ϸ� �������� ����(�� ���ڸ�)
-- TRIM(���ڿ� || �÷���)
-- TRIM(LEADING || TRAILING || BOTH '������ ����' FROM ���ڿ� || �÷���) / LEADING : ����, TRAILING : ������, BOTH : ����
SELECT '     ������     ', TRIM('     ������     '),
           'ZZZZZZ��¡��ZZZZZZ', TRIM('Z' FROM 'ZZZZZZ��¡��ZZZZZZ'),
           TRIM(LEADING 'Z' FROM 'ZZZZZZ��¡��ZZZZZZ'),
           TRIM(TRAILING 'Z' FROM 'ZZZZZZ��¡��ZZZZZZ'),
           TRIM(BOTH 'Z' FROM 'ZZZZZZ��¡��ZZZZZZ') -- 'Z'ó�� �� ���ڸ� ����
FROM DUAL;

-- SUBSTR : ���ڿ��� �߶󳻴� ��� * JAVA SUBSTRING �޼ҵ�� ����
-- SUBSTR(���ڿ� || �÷���, �����ε�����ȣ [, ����] ) 
SELECT SUBSTR('SHOWMETHEMONEY', 5), SUBSTR('SHOWMETHEMONEY', 5, 2),
           SUBSTR('SHOWMETHEMONEY', INSTR('SHOWMETHEMONEY', 'MONEY')),
           SUBSTR('SHOWMETHEMONEY', -5, 2)
FROM DUAL;

-- ����� �̸��Ͽ��� ���̵𰪸� ����ϱ�
-- ���̵� 7���� �̻��� ����� ��ȸ
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1)
FROM EMPLOYEE
--WHERE LENGTH(SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1)) >= 7;
WHERE EMAIL LIKE '_______@%';

-- ����� ������ ǥ���ϴ� ��ȣ�� ����ϱ�
-- ���ڻ���� ��ȸ
SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN (2, 4);

-- �����ڸ� ó���ϴ� �Լ� : UPPER, LOWER, INITCAP
SELECT UPPER('Welcom to oRACLE worLd'),
           LOWER('Welcom to oRACLE worLd'),
           INITCAP('Welcom to oRACLE worLd')
FROM DUAL;

-- CONCAT : ���ڿ��� �������ִ� �Լ�
-- || �����ڿ� ����
SELECT EMP_NAME || EMAIL, CONCAT(EMP_NAME, EMAIL),
           CONCAT(CONCAT(EMP_NAME, EMAIL), SALARY)
FROM EMPLOYEE;

-- REPLACE : �����(�÷�)���� �������ڸ� ã�Ƽ� Ư�����ڷ� �����ϴ� ��
-- REPLACE(���ڿ� || �÷���, 'ã������', '��ü����')
SELECT EMAIL, REPLACE(EMAIL, 'BS', 'GD')
FROM EMPLOYEE;

-- UPDATE EMPLOYEE SET EMAIL = REPLACE(EMAIL, 'BS', 'GD');
-- SELECT EMAIL FROM EMPLOYEE;
-- ROLLBACK;

-- REVERSE : ���ڿ��� �Ųٷ� ������ִ� ���
SELECT EMAIL, REVERSE(EMAIL), EMP_NAME, REVERSE(EMP_NAME) -- BYTE������ �߶� ����
FROM EMPLOYEE;

-- TRANSLATE : ��Ī�Ǵ� ���ڷ� �������ִ� �Լ�
SELECT TRANSLATE('010-3644-6259', '0123456789', '�����̻�����ĥ�ȱ�')
FROM DUAL;

-- ����ó���Լ�
-- ABS : ���밪�� ó���ϴ� �Լ�
SELECT ABS(-10), ABS(10)
FROM DUAL;

-- MOD : �������� ���ϴ� �Լ� * JAVA�� %�����ڿ� ������ �Լ�
SELECT MOD(3, 2)
FROM DUAL;

SELECT E.*, MOD(SALARY, 3) -- ���� �÷� ���� * ��ü ��� �Ұ�(��Ī�ο��ؼ� ���)
FROM EMPLOYEE E;

-- �Ҽ����� ó���ϴ� �Լ�
-- ROUND : �Ҽ����� �ݿø��ϴ� �Լ�
-- ROUND(���� || �÷��� [, �ڸ���])
SELECT 126.567, ROUND(126.567), ROUND(126.467), ROUND(126.567, 2)
FROM DUAL;

-- ���ʽ��� ������ ���ޱ��ϱ�
SELECT EMP_NAME, SALARY, SALARY + SALARY * NVL(BONUS, 0) - (SALARY * 0.03),
           ROUND(SALARY + SALARY * NVL(BONUS, 0) - (SALARY * 0.03))
FROM EMPLOYEE;

-- FLOOR : �Ҽ����ڸ� ����
SELECT 126.567, FLOOR(126.567) -- FLOOR(126.567, 2)
FROM DUAL;

-- TRUNC : �Ҽ����ڸ� �ڸ� �� �����ؼ� ����
SELECT 126.567, TRUNC(126.567), TRUNC(126.567, 2), TRUNC(126.567, -2),
           TRUNC(2123456.32, -1)
FROM DUAL;

-- CEIL : �Ҽ��� �ø�
SELECT 126.567, CEIL(126.567), CEIL(126.111)
FROM EMPLOYEE;

-- ��¥ó���Լ�
-- ����Ŭ���� ��¥�� ����� ���� �� ���� ����� ����
-- 1. SYSDATE����� -> ��¥ ��/��/�� ���� ��¥(����Ŭ�� ��ġ�Ǿ� �ִ� ��ǻ���� ��¥)�� �������
-- 2. SYSTIMESTAMP����� -> ��¥ + �ð����� �������
SELECT SYSDATE, SYSTIMESTAMP
FROM DUAL;

-- ��¥�� �������ó���� ������, +,- ���� ���� -> �� ���� ����, �߰���
SELECT SYSDATE, SYSDATE - 2, SYSDATE + 3, SYSDATE + 30
FROM DUAL;

-- NEXT_DAY : �Ű������� ���޹��� ���� �� ���� ����� ���� ��¥ ���
SELECT SYSDATE, NEXT_DAY(SYSDATE, '��'), NEXT_DAY(SYSDATE, '��') -- NEXT_DAY(SYSDATE, 'MON')
FROM DUAL;
-- LOCALE�� ���� ������ ����
SELECT * FROM V$NLS_PARAMETERS;
ALTER SESSION SET NLS_LANGUAGE = 'KOREAN';
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'MON'), NEXT_DAY(SYSDATE, 'TUESDAY')
FROM DUAL;

-- LAST_DAY : �� ���� ������ ���� ���
SELECT SYSDATE, LAST_DAY(SYSDATE), LAST_DAY(SYSDATE + 30)
FROM DUAL;

-- ADD_MONTHS : ���� ���� ���ϴ� �Լ�
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 10)
FROM DUAL;

-- MONTHS_BETWEEN : �� ���� ��¥�� �޾Ƽ� �� ��¥�� ���� ���� ������ִ� �Լ�
SELECT FLOOR(MONTHS_BETWEEN('23/08/17', SYSDATE))
FROM DUAL;

-- ��¥�� �⵵, ��, ���ڸ� ���� ����� �� �ִ� �Լ�
-- EXTRACT(YEAR || MONTH || DAY FROM ��¥) : ���ڷ� �������
-- ���� ��¥�� ��, ��, �� ����ϱ�
SELECT EXTRACT(YEAR FROM SYSDATE) AS ��, EXTRACT(MONTH FROM SYSDATE) AS ��, EXTRACT(DAY FROM SYSDATE) AS ��
FROM DUAL;

-- ��� �� 12���� �Ի��� ������� ���Ͻÿ�
SELECT *
FROM EMPLOYEE
WHERE EXTRACT(MONTH FROM HIRE_DATE) = 12;

SELECT EXTRACT(DAY FROM HIRE_DATE) + 100 --���ڰ��̱� ������ ����
FROM EMPLOYEE;

-- ���úη� ���ֿ�����... ����� �ٽ� ��������.. �Ф� ���뺹���Ⱓ�� 1�� 6����,
-- �������ڸ� ���ϰ�, ���������� �Դ� «�� ��(�Ϸ� �� ��)�� ���ϱ�
SELECT SYSDATE AS �Դ���, ADD_MONTHS(SYSDATE, 18) AS ������, (ADD_MONTHS(SYSDATE, 18) - SYSDATE) * 3 AS «���
FROM DUAL;

-- ����ȯ �Լ�
-- ����Ŭ������ �ڵ�����ȯ�� �� �۵���
-- ����Ŭ �����͸� �����ϴ� Ÿ���� ����
-- ���� : CHAR, VARCHAR2, NCHAR, NVARCHAR2 -> JAVA�� String�� ����
-- ���� : NUMBER
-- ��¥ : DATE, TIMESTAMP

-- TO_CHAR : ����, ��¥�� ���������� �������ִ� �Լ�
-- ��¥�� ���������� �����ϱ�
-- ��¥���� ��ȣ�� ǥ���ؼ� ���������� ������ �Ѵ�.
-- Y : ��, M : ��, D : ��, H : ��, MI : ��, SS : ��
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD'), TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') -- SYSDATE�� ��¥, TO_CHAR�� ����
FROM DUAL;

SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YY.MM.DD'), TO_CHAR(HIRE_DATE, 'YYYY-MM-DD HH24:MI:SS')
FROM EMPLOYEE;

-- ���ڸ� ���������� �����ϱ�
-- ���Ͽ� ���缭 ��ȯ -> �ڸ� ���� ��� ǥ���� �� ����
-- 0 : ��ȯ��� ���� �ڸ� ���� ������ �ڸ� ���� ��ġ���� ���� ��, ���� ���� �ڸ��� 0�� ǥ���ϴ� ����
-- 9 : ��ȯ��� ���� �ڸ� ���� ������ �ڸ� ���� ��ġ���� ���� ��, ���� ���� �ڸ��� �����ϴ� ����
-- ��ȭ�� ǥ���ϰ� ���� ���� L�� ǥ��
SELECT 1234567, TO_CHAR(1234567, '000,000,000'), TO_CHAR(1234567, '999,999,999'),
           TO_CHAR(500, 'L999,999')
FROM DUAL;
SELECT 180.5, TO_CHAR(180.5, '000,000.0'), TRIM(TO_CHAR(180.5, 'FM999,999.00')) AS Ű -- FM���̸� ������� ����
FROM DUAL;

-- ������ ��ȭǥ���ϰ� ,�� �����ؼ� ����ϰ� �Ի����� 0000.00.00���� ����ϱ�
SELECT EMP_NAME, TO_CHAR(SALARY, 'FML999,999,999') AS �޿�, TO_CHAR(HIRE_DATE, 'YYYY.MM.DD') AS �Ի���
FROM EMPLOYEE;

-- ���������� �����ϱ�
-- TO_NUMBER�Լ��� �̿�
-- ���ڸ� ���������� �����ϱ�
SELECT 1000000 + 1000000, TO_NUMBER('1,000,000','999,999,999') + 1000000,
           TO_CHAR(TO_NUMBER('1,000,000', '999,999,999') + 1000000, 'FML999,999,999')
FROM DUAL;

-- ��¥������ �����ϱ�
-- ���ڸ� ��¥�� ����
-- �������� ���ڷ� ����
SELECT TO_DATE('23/12/25', 'YY/MM/DD') - SYSDATE, TO_DATE('241225', 'YYMMDD'),
           TO_DATE('25-12-25', 'YY-MM-DD')
FROM DUAL;

SELECT TO_DATE(20230405, 'YYYYMMDD'), TO_DATE(230505, 'YYMMDD'), TO_DATE(TO_CHAR(000224, '000000'), 'YYMMDD')
FROM DUAL;

-- NULL���� ó�����ִ� �Լ�
-- NVL �Լ� : NVL(�÷���, '��ü��')
-- NVL2 �Լ� : NVL2(�÷���, NULL�� �ƴ� ��, NULL�� ��)
SELECT EMP_NAME, DEPT_CODE, NVL(DEPT_CODE, '����'), NVL2(DEPT_CODE, '����', '����')
FROM EMPLOYEE;

-- ���ǿ� ���� ����� ���� �������ִ� �Լ�
-- 1. DECODE
-- DECODE(�÷��� || ���ڿ�, '����', '��ü��', '����2', '��ü��2', ...)
-- �ֹι�ȣ���� 8��° �ڸ� ���� 1�̸� ����, 2�̸� ���� ����ϴ� ���� �÷� �߰��ϱ�
SELECT EMP_NAME, EMP_NO, DECODE(SUBSTR(EMP_NO, 8, 1), '1', '����', '2', '����') AS GENDER
FROM EMPLOYEE;
--WHERE GENDER = '����' �ȵ�

-- �� ��å�ڵ��� ��Ī�� ����ϱ�
-- J1 ��ǥ, J2 �λ���, J3����, J4 ����
-- �������� '���' = ELSE
SELECT EMP_NAME, JOB_CODE, DECODE(JOB_CODE, 'J1', '��ǥ', 'J2', '�λ���', 'J3', '����', 'J4', '����', '���') AS ����
FROM EMPLOYEE;

-- 2. CASE WHEN THEN ELSE
-- CASE 
--      WHEN ���ǽ� THEN ���೻��
--      WHEN ���ǽ� THEN ���೻��
--      WHEN ���ǽ� THEN ���೻��
--      ELSE ���೻��
-- END 

SELECT EMP_NAME, JOB_CODE,
        CASE
                WHEN JOB_CODE = 'J1' THEN '��ǥ'
                WHEN JOB_CODE = 'J2' THEN '�λ���'
                WHEN JOB_CODE = 'J3' THEN '����'
                WHEN JOB_CODE = 'J4' THEN '����'
                ELSE '���'
        END AS ��å,
        CASE JOB_CODE
                WHEN 'J1'  THEN '��ǥ'
                WHEN 'J2'  THEN '�λ���'
        END
FROM EMPLOYEE;

-- ������ �������� ��׿����ڿ� �߰������� �� �ܸ� ������ ����ϱ�
-- ������ 400���� �̻��̸� ���
-- ������ 400���� �̸� 300���� �̻��̸� �߰�����
-- �������� �� �ܸ� ����ϴ� �����÷� �����
-- �̸�, ����, ���
SELECT EMP_NAME, SALARY,
        CASE
                WHEN SALARY >= 4000000 THEN '��׿�����'
                WHEN SALARY >= 3000000 THEN '�߰�������'
                ELSE '�� ��'
        END AS ���
FROM EMPLOYEE;

-- ������̺��� ���� ���̸� ���ϱ�
SELECT *
FROM EMPLOYEE;

SELECT  EMP_NAME, EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1,2), 'YY')) || '��' AS YY��,
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1,2), 'RR')) || '��' AS RR��,
            EXTRACT(YEAR FROM SYSDATE) - (
                TO_NUMBER(SUBSTR(EMP_NO, 1, 2)) +
                CASE
                        WHEN SUBSTR(EMP_NO, 8, 1) IN (1, 2) THEN 1900
                        WHEN SUBSTR(EMP_NO, 8, 1) IN (3, 4) THEN 2000
                END
            ) AS ��
FROM EMPLOYEE;

-- RR�� �⵵�� ����� ��
-- ����⵵    �Է³⵵    ���⵵
-- 00~49        00~49       ������
-- 00~49        50~99       ������
-- 50~99        00~49       ��������
-- 50~99        50~99       ������

insert into EMPLOYEE (EMP_ID,EMP_NAME,EMP_NO,EMAIL,PHONE,DEPT_CODE,JOB_CODE,SAL_LEVEL,SALARY,BONUS,MANAGER_ID,HIRE_DATE, ENT_DATE,ENT_YN) 
values ('252','�����','320808-4123341','go_dm@kh.or.kr',null,'D2','J2','S5',4480000,null,null,to_date('94/01/20','RR/MM/DD'),null,'N');
SELECT * FROM EMPLOYEE;

UPDATE EMPLOYEE SET EMP_NO = '320808-1123341' WHERE EMP_ID = '252';
COMMIT;

-- �׷��Լ� Ȱ���ϱ�
-- ���̺��� �����Ϳ� ���� �����ϴ� �Լ��� �հ�, ����, ����, �ִ밪, �ּҰ��� ���ϴ� �Լ�
-- �׷��Լ��� ����� �⺻������ �� ���� ���� ������
-- �߰��÷��� �����ϴ� ���� ����
-- ����
-- SUM : ���̺��� Ư�� �÷��� ���� �� �� -> SUM(�÷���(NUMBER))
-- AVG : ���̺��� Ư�� �÷��� ���� ��� -> AVG(�÷���(NUMBER))
-- COUNT : ���̺��� ������ ���� ���(ROW ��) -> COUNT(* || �÷���)
-- MIN : ���̺��� Ư�� �÷��� ���� �ּҰ� -> MIN(�÷���) 
-- MAX : ���̺��� Ư�� �÷��� ���� �ִ밪 -> MAX(�÷���)

-- ��� ������ �� �հ踦 ���غ���
SELECT TO_CHAR(SUM(SALARY), 'FML999,999,999') FROM EMPLOYEE;

-- D5�μ��� ���� �� �հ踦 ���غ���
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--SELECT SUM(EMP_NAME)
--FROM EMPLOYEE;

-- J3����� �޿� �հ踦 ���Ͻÿ�
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE JOB_CODE = 'J3';

-- ��ձ��ϱ� AVG�Լ�
-- ��ü����� ���� ��� ���ϱ�
SELECT AVG(SALARY) FROM EMPLOYEE;
-- D5�� �޿� ��� ���ϱ�
SELECT AVG(SALARY) FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- D5�μ��� �޿� �հ�� ��� ���ϱ�
SELECT SUM(SALARY), AVG(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- NULL���� ���ؼ��� ��� ó���� �ɱ�? -> NULL ���� ������ �����ع���
SELECT SUM(BONUS), AVG(BONUS), AVG(NVL(BONUS, 0))
FROM EMPLOYEE;

-- ���̺��� ������ �� Ȯ���ϱ�
SELECT COUNT(*), COUNT(DEPT_CODE), COUNT(BONUS) -- NULL�� ROW ����
FROM EMPLOYEE; -- ROW����

-- D6�μ��� �ο� ��ȸ�ϼ���
SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6';

-- 400���� �̻� ������ �޴� ��� ��
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- D5�μ����� ���ʽ��� �ް� �ִ� ����� ����?
SELECT COUNT(BONUS)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- �μ��� D6, D5, D7�� ����� ��, �޿� �հ�, ����� ��ȸ�ϼ���
SELECT COUNT(*) AS �����, SUM(SALARY) AS �޿��հ�, AVG(SALARY) AS �޿����
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5', 'D6', 'D7');

SELECT MAX(SALARY), MIN(SALARY)
FROM EMPLOYEE;