-- JOIN�� ���� �˾ƺ���
-- �� �� �̻��� ���̺��� Ư���÷��� �������� �������ִ� ���
-- JOIN�� ũ�� �� ������ ����
-- 1. INNER JOIN : ������ �Ǵ� ���� ��ġ�ϴ� ROW�� �������� JOIN 
-- 2. OUTER JOIN :  ������ �Ǵ� ���� ��ġ���� ���� ROW�� �������� JOIN * ���� �ʿ�

-- JOIN�� �ۼ��ϴ� ��� 2����
-- 1. ����Ŭ ���ι�� : , �� WHERE���� �ۼ�
-- 2. ANSI ǥ�� ���ι�� : JOIN, ON || USING ���� ����ؼ� �ۼ�

-- EMPLOYEE���̺�� DEPARTMENT���̺� JOIN�ϱ�
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT; -- ������ �� ã��

-- ����Ŭ ������� JOIN�ϱ�
SELECT *
FROM EMPLOYEE, DEPARTMENT -- ���̺� ���°Ŷ� FROM�� �Ʒ���(FROM����) �ۼ�
WHERE EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID;

-- ANSI ǥ������ JOIN�ϱ�
SELECT *
FROM EMPLOYEE JOIN DEPARTMENT ON EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID;

-- ����� ���� �����, �̸���, ��ȭ��ȣ, �μ��� ��ȸ�ϱ�
SELECT EMP_NAME, EMAIL, PHONE, DEPT_TITLE
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- JOIN�������� WHERE�� ����ϱ�
-- �μ��� �ѹ����� ����� �����, ����, ���ʽ�, �μ��� ��ȸ�ϱ�
SELECT EMP_NAME, SALARY, BONUS, DEPT_TITLE
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE = '�ѹ���';

-- JOIN������ GROUP BY�� ����ϱ�
-- �μ��� ��ձ޿��� ����ϱ� �μ���, ��ձ޿�
SELECT DEPT_TITLE, AVG(SALARY)
FROM EMPLOYEE
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
GROUP BY DEPT_TITLE
HAVING AVG(SALARY) >= 3000000;

-- JOIN�� �� ������ �Ǵ� �÷����� �ߺ��ȴٸ� �ݵ�� ��Ī�� �ۼ��ؾ��Ѵ�.
-- �����, �޿�, ���ʽ�, ��å���� ��ȸ�ϱ�
SELECT *
FROM EMPLOYEE E
        JOIN JOB J ON E.JOB_CODE = J.JOB_CODE -- �ߺ��� �÷��� �� �� ��µ�(E, J)
WHERE E.JOB_CODE = 'J3'; -- WHERE�������� ��Ī �ο��ؾ���

-- �ߺ��Ǵ� �÷������� JOIN�� ���� USING�� �̿��� �� �ִ�
SELECT *
FROM EMPLOYEE 
        JOIN JOB USING(JOB_CODE) -- �ߺ��� �÷� �� �� ��µ�(JOB_CODE �ϳ�)
WHERE JOB_CODE = 'J3'; -- USING ���� ��Ī(�ĺ���) ��� X

-- ��å�� ������ ����� �̸�, ��å��, ��å�ڵ�, ������ ��ȸ�ϼ���
SELECT EMP_NAME, JOB_NAME, JOB_CODE, SALARY
FROM EMPLOYEE 
        JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����';

SELECT COUNT(*)
FROM EMPLOYEE
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID -- INNER JOIN�� �� NULL�� ������ ����X
WHERE DEPT_CODE IS NULL; -- �̹� ������ NULL�� ����

-- OUTER JOIN ����ϱ�
-- �÷��� ���� ���Ϻ񱳸� ���� �� ���� ROW�� ������ִ� JOIN
-- (��� �����͸� �����)������ �Ǵ� ���̺��� ����������Ѵ�.
-- LEFT OUTER JOIN : JOIN�� �������� ���ʿ� �ִ� ���̺��� �������� ����
-- RIGHT OUTER JOIN : JOIN�� �������� �����ʿ� �ִ� ���̺��� �������� ����
-- ��ġ�ϴ� ROW�� ���� ��� ��� �÷��� NULL�� ǥ����
SELECT * 
FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID; -- OUTER��������
        
SELECT *
FROM EMPLOYEE RIGHT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- CROSS JOIN : ��� ROW�� �������ִ� JOIN
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE CROSS JOIN DEPARTMENT
ORDER BY 1;

-- SELF JOIN : �� ���� ���̺� �ٸ� �÷��� ���� ������ �ִ� ��� �� �� �� �÷��� �̿��ؼ� JOIN
SELECT * FROM EMPLOYEE;
-- MANAGER�� �ִ� ����� �̸�, MANAGER_ID, MANAGER�����ȣ, MANAGER�̸� ��ȸ
SELECT E.EMP_NAME, E.MANAGER_ID, M.EMP_ID, M.EMP_NAME
FROM EMPLOYEE E
        JOIN EMPLOYEE M ON E.MANAGER_ID = M.EMP_ID;
-- ����̸�, �Ŵ������̵�, �Ŵ��������ȣ, �Ŵ��� �̸� ��ȸ
-- �Ŵ����� ������ ������ ����ϱ�
SELECT E.EMP_NAME, NVL(E.MANAGER_ID, '����'), NVL(M.EMP_ID, '����'), NVL(M.EMP_NAME, '����')
FROM EMPLOYEE E
        LEFT OUTER JOIN EMPLOYEE M ON E.MANAGER_ID = M.EMP_ID;

SELECT * FROM EMPLOYEE;

-- �������� ����񱳸� �ؼ� ó����. ON �÷��� = �÷���
-- �񵿵����ο� ���� �˾ƺ���
-- ������ ���̺��� �������� �������Ѵ�.
SELECT * FROM SAL_GRADE;
SELECT *
FROM EMPLOYEE
        JOIN SAL_GRADE ON SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- ȸ����� ����Ʈ��, ��ǰ���(����), ��� ���� ���� ȸ�����

-- ���������� �� �� �ִ�.
-- �� �� �̻��� ���̺��� �����ؼ� ����ϱ�
-- ����� �����, ��å��, �μ����� ��ȸ�ϱ�
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE
FROM EMPLOYEE 
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
        JOIN JOB USING(JOB_CODE);

-- ����� �����, �μ���, ��å��, �ٹ�����(LOCAL_NAME) ��ȸ�ϱ�
-- �μ����� ������ ���, �ٹ������� ������ ���߷��� ����ϱ�
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM JOB;
SELECT * FROM LOCATION;

SELECT EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME
FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
        JOIN JOB USING(JOB_CODE)
        LEFT JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;