--insert��

--���̺� ���� Ȯ��

desc departments;
desc employees;

--1st
insert into departments(department_id, department_name, manager_id, location_id)
values (290, '������', 200, 1700);

insert into departments(department_id, department_name, location_id)
values (300, '�����̳�', 1700);

insert into departments(department_id, department_name, manager_id)
values (310, 'DBA', 200);

insert into departments(department_name, department_id)
values ('����������', 320);


--2nd

insert into departments values(330, '�ۺ���', 200, 1700);
insert into departments values(340, '�����ͺм���', 200, 1800);

select *
from departments;

--DML������ Ʈ�������� ���ؼ� DML�������� �ǵ��� �� �ִ�.
ROLLBACK;
SELECT * FROM DEPARTMENTS;


--���̺� ���� ����

CREATE TABLE MANAGERS AS (SELECT * FROM EMPLOYEES WHERE 1 = 2);

SELECT *
FROM MANAGERS;


--3ND (�ٸ� ���̺��� Ư�� ��, ���������� INSERT)

INSERT INTO MANAGERS (SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');

INSERT INTO MANAGERS (EMPLOYEE_ID, LAST_NAME, EMAIL, JOB_ID, HIRE_DATE)
(SELECT EMPLOYEE_ID, LAST_NAME, EMAIL, JOB_ID, HIRE_DATE FROM EMPLOYEES WHERE JOB_ID = 'FI_ACCOUNT');

SELECT * FROM MANAGERS;


--UPDATE��

DESC EMPLOYEES;

--�纻 ���̺� ����(�����ͱ��� ����) - Ű ����X
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES WHERE 1=1);

SELECT * FROM EMPS;

UPDATE EMPS
SET SALARY = 30000; --���� �� �ٲ�
ROLLBACK;

--UPDATE���� �������� �ݵ�� ����Ѵ�.
SELECT * FROM EMPS WHERE EMPLOYEE_ID = 100;

UPDATE EMPS
SET SALARY = SALARY * 1.1
WHERE EMPLOYEE_ID = 100; --PK����

UPDATE EMPS
SET PHONE_NUMBER = '511.123.111', 
    HIRE_DATE = SYSDATE, 
    COMMISSION_PCT = 0.1
WHERE EMPLOYEE_ID = 100;

--JOB_ID�� IT_PROG�� ����� Ŀ�̼� 0.1�� ������Ʈ

UPDATE EMPS
SET COMMISSION_PCT = 0.1
WHERE JOB_ID = 'IT_PROG';

--WHERE���� ��������
UPDATE EMPS
SET COMMISSION_PCT = 0.2
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM EMPS WHERE FIRST_NAME = 'Donald');

SELECT * 
FROM EMPS 
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM EMPS WHERE FIRST_NAME = 'Donald');

--SET ���� ��������
--UPDATE EMPS SET (�÷����) = (��������) WHERE ����
SELECT DEPARTMENT_ID, MANAGER_ID, COMMISSION_PCT, SALARY, JOB_ID 
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 103;

UPDATE EMPS
SET (DEPARTMENT_ID, MANAGER_ID, COMMISSION_PCT, SALARY, JOB_ID) = 
    (SELECT DEPARTMENT_ID, MANAGER_ID, COMMISSION_PCT, SALARY, JOB_ID 
     FROM EMPLOYEES
     WHERE EMPLOYEE_ID = 103)
WHERE EMPLOYEE_ID = 102;

SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 103 UNION ALL
SELECT * FROM EMPS WHERE EMPLOYEE_ID = 102;

ROLLBACK;

--DELETE

--EMPLOYEES ���̺��� 50�� �μ��� �����Ͽ� ������̹Ƿ� ���� �Ұ�
--���� ���Ἲ ���� ���� ����
SELECT * FROM DEPARTMENTS;

DELETE FROM DEPARTMENTS
WHERE DEPARTMENT_ID = 50; 


--DELETE�� �����ϱ��� SELECT������ �ݵ�� Ȯ��
SELECT * FROM EMPS WHERE EMPLOYEE_ID = 100;

DELETE FROM EMPS
WHERE EMPLOYEE_ID = 105;


--WHERE���� ��������

--�μ��� shipping�� �μ���ȣ
SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'Shipping';

DELETE FROM EMPS
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'Shipping');

ROLLBACK;

---------

SELECT * FROM EMPLOYEES;

DELETE FROM EMPLOYEES WHERE EMPLOYEE_ID = 100;