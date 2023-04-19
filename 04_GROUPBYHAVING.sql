-- GROUP BY �� Ȱ���ϱ�
-- �׷��Լ��� ������� �� Ư���������� �÷����� ��� ó���ϴ� �� -> ���� �׷캰 �׷��Լ��� ����� ��µ�
-- SELECT �÷���
-- FROM ���̺��
-- [WHERE ���ǽ�]
-- [GROUP BY �÷��� [, �÷���, �÷���, ...] ]
-- [ORDER BY �÷���]

-- �μ��� �޿� �հ踦 ���Ͻÿ�
SELECT DEPT_CODE,0 SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- ��å�� �޿��� �հ�, ����� ���Ͻÿ�
SELECT JOB_CODE, SUM(SALARY), AVG(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- �μ��� ����� ���ϱ�
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- GROUP BY ������ �ټ��� �÷��� ���� �� �ִ�.
SELECT DEPT_CODE, JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE;

-- GROUP BY�� ����� ������ WHERE�� ��� ����
SELECT DEPT_CODE, SUM(SALARY), COUNT(*)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY DEPT_CODE;

-- �μ��� �ο��� 3�� �̻��� �μ��� ����ϱ�
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
--WHERE COUNT(*) >= 3 -- WHERE������ �׷��Լ� ���X
GROUP BY DEPT_CODE
HAVING COUNT(*) >= 3;

-- ��å �� �ο� ���� 3�� �̻��� ��å ���
SELECT JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING COUNT(*) >= 3;

-- ��ձ޿��� 300���� �̻��� �μ� ����ϱ�
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;

-- �Ŵ����� �����ϴ� ����� 2�� �̻��� �Ŵ��� ���̵� ����ϱ�
SELECT MANAGER_ID, COUNT(*)
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL
GROUP BY MANAGER_ID
HAVING COUNT(*) >= 2;

-- ����, ������ �޿� ����� ���ϰ� �ο� �� ���ϱ�
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '3', '��', '2', '��', '4', '��') AS ����, AVG(SALARY), COUNT(*)
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '3', '��', '2', '��', '4', '��');

--0404
-- �� �׷캰 ����� �� ���踦 �ѹ��� ������ִ� �Լ�
-- ROLLUP(), CUBE()
-- GROUP BY ROLLUP(�÷���)
-- GROUP BY CUBE(�÷���)

-- �μ��� �޿��հ�� �� �հ踦 ��ȸ�ϴ� ����
SELECT SUM(SALARY) -- �� �հ�
FROM EMPLOYEE;

SELECT DEPT_CODE, SUM(SALARY) -- �μ��� �޿��հ�
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, SUM(SALARY) -- ROLLUP �հ� �Ʒ���
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY ROLLUP(DEPT_CODE);

SELECT DEPT_CODE, SUM(SALARY) -- CUBE �հ� ����
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY CUBE(DEPT_CODE);

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
--GROUP BY ROLLUP(JOB_CODE);
GROUP BY CUBE(JOB_CODE);

-- ROLLUP, CUBE �Լ��� �μ��� �� �� �̻��� �÷��� ���� �� �ִ�
-- ROLLUP : �� �� �̻��� �μ��� �������� �� �� �� �÷��� ����, ù ��° �μ��÷��� �Ұ�, ��ü �Ѱ�
-- CUBE : �� �� �̻� �μ��� �������� �� �� �� �÷��� ����, ù ��° �μ��÷��� �Ұ�, �� ��° �μ��÷��� �Ұ�, ��ü �Ѱ�

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE);

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY CUBE(DEPT_CODE, JOB_CODE);

-- �μ���, ��å��, �� ����� �ѹ��� ��ȸ�ϱ�
SELECT DEPT_CODE, JOB_CODE, COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY CUBE(DEPT_CODE, JOB_CODE);

-- GROUPING �Լ��� �̿��ϸ� ������ ����� ���� �б�ó���� �� �� �ִ�.
-- ROLLUP, CUBE�� ����� ROW�� ���� �б�ó��
-- GROUPING �Լ��� �����ϸ� ROLLUP, CUBE�� ����� ROW 1�� ��ȯ �ƴϸ� 0�� ��ȯ
SELECT DEPT_CODE, JOB_CODE, COUNT(*),
        CASE
                WHEN GROUPING(DEPT_CODE) = 0 AND GROUPING(JOB_CODE) = 1 THEN '�μ��� �ο�'
                WHEN GROUPING(DEPT_CODE) = 1 AND GROUPING(JOB_CODE) = 0 THEN '��å�� �ο�'
                WHEN GROUPING(DEPT_CODE) = 0 AND GROUPING(JOB_CODE) = 0 THEN '�μ�_��å�� �ο�'
                WHEN GROUPING(DEPT_CODE) = 1 AND GROUPING(JOB_CODE) = 1 THEN '�� �ο�'
        END AS ���
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY CUBE(DEPT_CODE, JOB_CODE);

-- ���̺��� ��ȸ�� ������ �����ϱ�
-- ORDER BY ������ �����
-- SELECT �÷���...
-- FROM ���̺��
-- [WHERE ���ǽ�]
-- [GROUP BY �÷���]
-- [HAVING ���ǽ�]
-- [ORDER BY �÷��� ���Ĺ��(DESC(����), ACS(����, DEFAULT)) ] / �����̸� ��������

-- �̸��� �������� �����ϱ�
SELECT *
FROM EMPLOYEE
ORDER BY EMP_NAME;

SELECT *
FROM EMPLOYEE
ORDER BY EMP_NAME DESC;

-- ������ ���� ������� ���� ������� �����ϱ�
-- �̸�, �޿�, ���ʽ�
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
ORDER BY SALARY DESC;

-- �μ��ڵ带 �������� �������� �����ϰ� ���� ������ ���� ������������ �����ϱ�
SELECT *
FROM EMPLOYEE
ORDER BY DEPT_CODE ASC, SALARY DESC, EMP_NAME ASC;

-- �������� �� NULL���� ���� ó��
-- BONUS�� ���� �޴� ������� ����ϱ�
SELECT *
FROM EMPLOYEE
--ORDER BY BONUS DESC; -- NULL�� ���� ���� ���
--ORDER BY BONUS ASC; -- NULL�� ���� ���߿� ���
-- �ɼ��� �����ؼ� NULL�� �����ġ�� ������ �� �ִ�.
--ORDER BY BONUS DESC NULLS LAST; -- NULL ����������
ORDER BY BONUS ASC NULLS FIRST; -- NULL ó������

-- ORDER BY�������� ��Ī�� ����� �� �ִ�.
SELECT EMP_NAME, SALARY AS ����, BONUS
FROM EMPLOYEE
ORDER BY ����;

-- SELECT���� �̿��ؼ� �����͸� ��ȸ�ϸ� RESULT SET�� ��µǴµ�
-- RESULT SET�� ��µǴ� �÷����� �ڵ����� INDEX��ȣ�� 1���� �ο��� ��
SELECT *
FROM EMPLOYEE
ORDER BY 2; -- 1 : EMP_ID, 2 : EMP_NAME ...

-- ���տ�����
-- ���� ���� SELECT���� �� ���� ���(RESULT SET)���� ������ִ� ��
-- ���� 1 : ù ��° SELECT���� �÷� ���� ���� SELECT���� �÷� ���� ���ƾ��Ѵ�.
-- ���� 2 : �� �÷��� ������ Ÿ�Ե� �����ؾ� �Ѵ�.

-- UNION : �� �� �̻��� SELECT���� ��ġ�� ������
-- SELECT�� UNION SELECT��
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION -- �ߺ��� ������
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3000000;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL -- �ߺ��� ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3000000;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS -- �ߺ��� ���� �� ���
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3000000;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT -- �ߺ����� ���
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- �� SELECT���� �÷��� �ٸ��� �ȵȴ�.
SELECT EMP_ID, EMP_NAME, SALARY -- �÷� 3
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
--SELECT EMP_ID, EMP_NAME, SALARY, BONUS -- X �÷� 4
--FROM EMPLOYEE
--WHERE SALARY > 3000000;
-- �� ���� SELECT���� �÷��� Ÿ�Ե� ������Ѵ�.
SELECT EMP_ID, EMP_NAME, EMP_NO -- X �÷� 3, �÷��� �ٸ� 
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- �ٸ� ���̺� �ִ� �����͸� ��ġ��
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
UNION 
SELECT DEPT_ID, DEPT_TITLE ,10
FROM DEPARTMENT;

SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
UNION
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT
UNION
SELECT JOB_CODE, JOB_NAME
FROM JOB
MINUS
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5', 'D6', 'D7');

-- GROUPING SET
-- ���� GROUP BY ���� �ִ� ������ �ϳ��� �ۼ��ϰ� ���ִ� ���
-- �μ�, ��å, �Ŵ����� �޿����
SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE, MANAGER_ID;
-- �μ�, ��å�� �޿����
SELECT DEPT_CODE, JOB_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE;
-- �μ�, �Ŵ����� �޿����
SELECT DEPT_CODE, MANAGER_ID, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, MANAGER_ID;

SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, AVG(SALARY)
FROM EMPLOYEE
GROUP BY GROUPING SETS ((DEPT_CODE, JOB_CODE, MANAGER_ID), (DEPT_CODE, JOB_CODE), (DEPT_CODE, MANAGER_ID));
