-- 0406
-- �������� : SELECT�� �ȿ� SELECT���� �ϳ� �� �ִ� �������� ����.
-- ���������� �ݵ�� ()�ȿ� �ۼ��� �ؾ��Ѵ�.
-- ������ ����� ������ �޿��� �ް��ִ� ����� ��ȸ�ϱ�
SELECT SALARY
FROM EMPLOYEE
WHERE EMP_NAME = '������';
SELECT *
FROM EMPLOYEE
WHERE SALARY = 2000000;

SELECT *
FROM EMPLOYEE
WHERE SALARY = (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '������');

-- D5�μ��� ��ձ޿����� ���� �޴� ������ϱ�
SELECT *
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = 'D5');

-- 1. ������ ��������
-- �������� SELECT���� ����� 1�� ��, 1�� ��
-- �÷�, WHERE���� �񱳴�� ��
-- ������� �޿� ��պ��� �޿��� ���� �޴� ����� �̸�, �޿�, �μ��ڵ� ����ϱ�
SELECT EMP_NAME, SALARY, DEPT_CODE, (SELECT AVG(SALARY) FROM EMPLOYEE) AS AVG
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);

-- �μ��� �ѹ����� ����� ��ȸ�ϱ�
-- 1.
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_ID FROM DEPARTMENT WHERE DEPT_TITLE = '�ѹ���');

-- 2.
SELECT *
FROM EMPLOYEE
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE = '�ѹ���';

-- ��å�� ������ ����� ��ȸ�ϱ�
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE = (SELECT JOB_CODE FROM JOB WHERE JOB_NAME = '����');

SELECT *
FROM EMPLOYEE 
        JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '����';

-- 2. ������ ��������
-- ���������� ����� 1�� ��, �ټ� ��(ROW)
-- ��å�� ����, ������ ����� ��ȸ�ϱ�
SELECT JOB_CODE
FROM JOB
WHERE JOB_NAME IN ('����', '����');

SELECT *
FROM EMPLOYEE
WHERE JOB_CODE NOT IN (SELECT JOB_CODE FROM JOB WHERE JOB_NAME IN ('����', '����')); -- �� 1���� �ټ� ���� �� �Ұ��ؼ� '=' ���X, IN/NOT IN ���

-- �����࿡ ���� ��Һ��ϱ�
-- >=, >, <, <=
SELECT *
FROM EMPLOYEE;
--WHERE SALARY >= (SELECT SALARY FROM EMPLOYEE WHERE DEPT_CODE IN ('D5', 'D6'));
-- ANY : OR�� ROW�� ����
-- ALL : AND�� ROW�� ����
-- �÷� >(=) ANY (��������) : ������ ���������� ��� �� �ϳ��� ũ�� TRUE -> ������ ���������� ��� �� �ּҰ����� ũ�� TRUE 
-- �÷� <(=) ANY (��������) : ������ ���������� ��� �� �ϳ��� ������ TRUE -> ������ ���������� ��� �� �ִ밪���� ������ TRUE

SELECT *
FROM EMPLOYEE;
-- WHERE SALARY >= ANY (SELECT SALARY FROM EMPLOYEE WHERE DEPT_CODE IN ('D5', 'D6'));
--WHERE SALARY >= (SELECT MIN(SALARY) FROM EMPLOYEE WHERE DEPT_CODE IN ('D5', 'D6')); ���� ���� 

-- �÷� >(=) ALL(��������) : ������ ���������� ����� ��� Ŭ �� TRUE -> ������ ���������� ��� �� �ִ밪���� ũ�� TRUE
-- �÷� <(=) ALL(��������) : ������ ���������� ����� ��� ���� �� TRUE -> ������ ���������� ��� �� �ּҰ����� ������ TRUE
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
--WHERE SALARY < ALL(SELECT SALARY FROM EMPLOYEE WHERE DEPT_CODE IN ('D5', 'D6'));
WHERE SALARY < (SELECT MIN(SALARY) FROM EMPLOYEE WHERE DEPT_CODE IN ('D5', 'D6'));

-- 2000�� 1�� 1�� ���� �Ի��� �� 2000�� 1�� 1�� ���� �Ի��� ��� �� ���� ���� �޴� ������� �޿��� ���� �޴� �����
-- �����, �޿� ��ȸ�ϱ�
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE HIRE_DATE < '00/01/01' 
            AND SALARY > ALL(SELECT SALARY FROM EMPLOYEE WHERE HIRE_DATE >= '00/01/01');
            
-- ���߿� �������� : ���� �ټ�, ���� 1��
-- ������ ������� ���� �μ�, ���� ���޿� �ش��ϴ� ��� ��ȸ�ϱ�
SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE WHERE ENT_YN = 'Y' AND SUBSTR(EMP_NO, 8, 1) = '2';

SELECT *
FROM EMPLOYEE
--WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE ENT_YN = 'Y' AND SUBSTR(EMP_NO, 8, 1) = '2')
--            AND JOB_CODE = (SELECT JOB_CODE FROM EMPLOYEE WHERE ENT_YN = 'Y' AND SUBSTR(EMP_NO, 8, 1) = '2')
--            AND ENT_YN = 'N';
WHERE (DEPT_CODE, JOB_CODE)
            IN (SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE WHERE ENT_YN = 'Y' AND SUBSTR(EMP_NO, 8, 1) = '2')
            AND ENT_YN = 'N';

-- ����������̸鼭 �޿��� 200������ ����� �ִٰ� �Ѵ�.
-- �� ����� �̸�, �μ���, �޿� ����ϱ�
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
--WHERE DEPT_TITLE = '���������' AND SALARY = 2000000;
WHERE (DEPT_CODE, SALARY)
            IN (SELECT DEPT_CODE, SALARY
                FROM EMPLOYEE
                            JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
                WHERE DEPT_TITLE = '���������' AND SALARY = 2000000);
                
-- ������ ���߿� ��������                
-- ��� �� �ѹ����̰� 300���� �̻� ������ �޴� ���
SELECT DEPT_CODE, SALARY
FROM EMPLOYEE
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE = '�ѹ���' AND SALARY >= 3000000;

SELECT *
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, SALARY
                                                FROM EMPLOYEE
                                                         JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
                                                WHERE DEPT_TITLE = '�ѹ���' AND SALARY >= 3000000);

-- ������, ��������߿� ���������� �÷����� ���Ұ�.
-- WHERE, FROM���� ���(��������߿��� FROM���� ���� ��� = INLINE VIEW)
SELECT EMP_NAME, (SELECT DEPT_CODE, SALARY
                                                FROM EMPLOYEE
                                                         JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
                                                WHERE DEPT_TITLE = '�ѹ���' AND SALARY >= 3000000) AS TEST -- �÷����� 1���� ROW�� �־����
FROM EMPLOYEE;

-- ��� ��������
-- ���������� ������ �� ���������� ���� ������ ����ϰ� ����
-- ���������� ���� ���������� ����� ������ �ְ�, ���������� ����� ���������� ����� ������ ��
-- ������ ���� �μ��� ��� ���� ��ȸ�ϱ�
-- �����, �μ��ڵ�, �����
SELECT COUNT(*) FROM EMPLOYEE WHERE DEPT_CODE = 'D9'; -- ������ �μ� ��� ��

SELECT EMP_NAME, DEPT_CODE, (SELECT COUNT(*) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE) AS �����
FROM EMPLOYEE E;

-- WHERE�� ��� �������� �̿��ϱ�
-- EXISTS(��������) : ���������� ����� 1�� �̻��̸� TRUE, 0���̸� FALSE -> �ִ�?
SELECT *
FROM EMPLOYEE E
--WHERE EXISTS(SELECT DEPT_CODE FROM EMPLOYEE WHERE DEPT_CODE = 'D9'); -- TRUE
WHERE EXISTS(SELECT 1 FROM EMPLOYEE WHERE E.EMP_ID = MANAGER_ID); -- ������ ������ �������� ��

-- �ּ� �޿��� �޴� ��� ��ȸ�ϱ�
SELECT *
FROM EMPLOYEE E
-- WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);
WHERE NOT EXISTS(SELECT 1 FROM EMPLOYEE WHERE E.SALARY > SALARY);

-- ��� ����� ��� ��ȣ, �̸�, �Ŵ��� ���̵�, �Ŵ��� �̸� ��ȸ�ϱ�
-- ���������� Ǯ���
SELECT EMP_NO, EMP_NAME, MANAGER_ID, (SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_ID = M.MANAGER_ID)
FROM EMPLOYEE M;

-- ����� �̸�, �޿�, �μ���, �ҼӺμ� �޿���� ��ȸ�ϱ�
SELECT EMP_NAME, SALARY,(SELECT DEPT_TITLE FROM DEPARTMENT WHERE DEPT_ID = E.DEPT_CODE) AS �μ���,
            FLOOR((SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE)) AS ���
FROM EMPLOYEE E;

SELECT EMP_NAME,SALARY,DEPT_TITLE,
            TO_CHAR(FLOOR((SELECT AVG(SALARY) FROM EMPLOYEE WHERE E.DEPT_CODE=DEPT_CODE)),'FML999,999,999') 
            AS �ҼӺμ����
FROM EMPLOYEE E
             JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID;
-- ������ J1�� �ƴ� ��� �߿��� �ڽ��� �μ��� ��� �޿����� �޿��� ���� �޴� ��� ��ȸ�ϱ�
SELECT *
FROM EMPLOYEE E
WHERE JOB_CODE != 'J1' AND SALARY < (SELECT AVG(SALARY) FROM EMPLOYEE WHERE E.DEPT_CODE = DEPT_CODE);
-- �ڽ��� ���� ������ ��ձ޿����� ���� �޴� ������ �̸�, ��å��, �޿��� ��ȸ�ϱ�
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E
--        JOIN JOB USING (JOB_CODE)
        JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE WHERE E.JOB_CODE = JOB_CODE);

-- FROM���� �������� �̿��ϱ�
-- INLINE VIEW
-- FROM���� ����ϴ� ���������� ��κ� ��������߿� �������� ���
-- RESULT SET�� �ϳ��� ���̺�ó�� ����ϰ� �ϴ� ��
-- �����÷��� �����ϰ� �ְų�, JOIN�� ����� SELECT���� ���
-- VIEW : INLINE VIEW, STORED VIEW
-- EMPLOYEE���̺� ������ �߰��ؼ� ����ϱ�
SELECT E.*,  DECODE(SUBSTR(EMP_NO, 8,1), '1', '��', '2', '��', '3', '��', '4', '��') AS GENDER -- *, �����÷� �Բ� ���X ����ϱ� ���ؼ� ��Ī �ο�
FROM EMPLOYEE E;

-- ���ڸ� ���
SELECT E.*,  DECODE(SUBSTR(EMP_NO, 8,1), '1', '��', '2', '��', '3', '��', '4', '��') AS GENDER -- *, �����÷� �Բ� ���X ����ϱ� ���ؼ� ��Ī �ο�
FROM EMPLOYEE E
WHERE DECODE(SUBSTR(EMP_NO, 8,1), '1', '��', '2', '��', '3', '��', '4', '��') = '��';

-- INLINE VIEW �̿��ϱ�
SELECT *
FROM (
    SELECT E.*,  DECODE(SUBSTR(EMP_NO, 8,1), '1', '��', '2', '��', '3', '��', '4', '��') AS GENDER
    FROM EMPLOYEE E -- FROM�� �ȿ� �״�� �������� ���ָ� ���̺�ó�� ��� ����
) 
WHERE GENDER = '��'; -- ���̺�ó�� ����ϱ⶧���� �����÷��� �÷����� ��� ����







