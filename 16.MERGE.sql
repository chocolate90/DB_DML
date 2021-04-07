CREATE TABLE EMPS_IT AS (SELECT * FROM EMPLOYEES WHERE 1=2);

DESC EMPS_IT;

INSERT INTO EMPS_IT(EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES (100, 'Gildong', 'kkk', SYSDATE, 'IT_PROG');

SELECT * FROM EMPS_IT;

--MERGE INTO Ÿ�� �����
--USING (���ս�ų ���̺��� ������)
--ON (�� ���̺��� ���� ����)
--WHEN MATCHED THEN (��ġ�� ��� ������ �۾�)
--WHEN NOT MATCHED THEN (��ġ���� ���� ��� ������ �۾�); 

MERGE INTO EMPS_IT A
USING (SELECT EMPLOYEE_iD,
              FIRST_NAME,
              LAST_NAME,
              EMAIL,
              PHONE_NUMBER,
              MANAGER_ID,
              DEPARTMENT_ID,
              JOB_ID,
              HIRE_DATE
       FROM EMPLOYEES 
       WHERE JOB_ID = 'IT_PROG') B
ON (A.EMPLOYEE_ID = B.EMPLOYEE_ID)
WHEN MATCHED THEN 
    UPDATE SET 
        A.FIRST_NAME = B.FIRST_NAME,
        A.LAST_NAME = B.LAST_NAME,
        A.EMAIL = B.EMAIL,
        A.PHONE_NUMBER = B.PHONE_NUMBER,
        A.MANAGER_ID = B.MANAGER_ID,
        A.DEPARTMENT_ID = B.DEPARTMENT_ID
WHEN NOT MATCHED THEN
    INSERT (EMPLOYEE_ID,
            FIRST_NAME,
            LAST_NAME,
            EMAIL,
            PHONE_NUMBER,
            MANAGER_ID,
            DEPARTMENT_ID,
            JOB_ID,
            HIRE_DATE)
    VALUES 
        (B.EMPLOYEE_ID,
         B.FIRST_NAME,
         B.LAST_NAME,
         B.EMAIL,
         B.PHONE_NUMBER,
         B.MANAGER_ID,
         B.DEPARTMENT_ID,
         B.JOB_ID,
         B.HIRE_DATE);
         
SELECT * FROM EMPS_IT;


--�ǽ�
--EMPLOYEES ���̺��� �Ź� �����Ǵ� ���̺��̶�� ����
--�ָ��� EMPS_IT�� ������Ʈ
--������ �����ʹ� EMAIL, PHONE_NUMBER, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID�� ����
--���� ���Ե� �����ʹ� ��� �÷��� �״�� �߰�
INSERT INTO EMPS_IT (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES (102, 'ȫ', '�浿', 'Hong', '01/04/06', 'AD_VP');

INSERT INTO EMPS_IT (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES (101, 'Ŵ', '�ϳ�', 'Kim', '20/03/04', 'AD_VP');

SELECT * FROM EMPS_IT;

SELECT * FROM EMPLOYEES;

MERGE INTO EMPS_IT A
USING (SELECT * FROM EMPLOYEES) B
ON (A.EMPLOYEE_ID = B.EMPLOYEE_ID)
WHEN MATCHED THEN
    UPDATE SET 
        A.EMAIL = B.EMAIL,
        A.PHONE_NUMBER = B.PHONE_NUMBER,
        A.SALARY = B.SALARY,
        A.COMMISSION_PCT = B.COMMISSION_PCT,
        A.MANAGER_ID = B.MANAGER_ID,
        A.DEPARTMENT_ID = B.DEPARTMENT_ID
WHEN NOT MATCHED THEN --���� �� ���� ��� INSERT (��������) VALUES 
    INSERT (EMPLOYEE_iD,
            FIRST_NAME,
            LAST_NAME,
            EMAIL,
            PHONE_NUMBER,
            HIRE_DATE,
            JOB_ID,
            SALARY,
            COMMISSION_PCT,
            MANAGER_ID,
            DEPARTMENT_ID)
    VALUES (B.EMPLOYEE_ID,
            B.FIRST_NAME,
            B.LAST_NAME,
            B.EMAIL,
            B.PHONE_NUMBER,
            B.HIRE_DATE,
            B.JOB_ID,
            B.SALARY,
            B.COMMISSION_PCT,
            B.MANAGER_ID,
            B.DEPARTMENT_ID);
            
SELECT * FROM EMPS_IT;
