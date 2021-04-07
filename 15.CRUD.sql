--insert문

--테이블 구조 확인

desc departments;
desc employees;

--1st
insert into departments(department_id, department_name, manager_id, location_id)
values (290, '개발자', 200, 1700);

insert into departments(department_id, department_name, location_id)
values (300, '디자이너', 1700);

insert into departments(department_id, department_name, manager_id)
values (310, 'DBA', 200);

insert into departments(department_name, department_id)
values ('서버관리자', 320);


--2nd

insert into departments values(330, '퍼블리셔', 200, 1700);
insert into departments values(340, '데이터분석가', 200, 1800);

select *
from departments;

--DML문장은 트랜젝션을 통해서 DML이전으로 되돌릴 수 있다.
ROLLBACK;
SELECT * FROM DEPARTMENTS;


--테이블 구조 복사

CREATE TABLE MANAGERS AS (SELECT * FROM EMPLOYEES WHERE 1 = 2);

SELECT *
FROM MANAGERS;


--3ND (다른 테이블의 특정 행, 서브쿼리절 INSERT)

INSERT INTO MANAGERS (SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');

INSERT INTO MANAGERS (EMPLOYEE_ID, LAST_NAME, EMAIL, JOB_ID, HIRE_DATE)
(SELECT EMPLOYEE_ID, LAST_NAME, EMAIL, JOB_ID, HIRE_DATE FROM EMPLOYEES WHERE JOB_ID = 'FI_ACCOUNT');

SELECT * FROM MANAGERS;


--UPDATE문

DESC EMPLOYEES;

--사본 테이블 생성(데이터까지 복사) - 키 복사X
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES WHERE 1=1);

SELECT * FROM EMPS;

UPDATE EMPS
SET SALARY = 30000; --전부 다 바뀜
ROLLBACK;

--UPDATE문은 조건절을 반드시 명시한다.
SELECT * FROM EMPS WHERE EMPLOYEE_ID = 100;

UPDATE EMPS
SET SALARY = SALARY * 1.1
WHERE EMPLOYEE_ID = 100; --PK기준

UPDATE EMPS
SET PHONE_NUMBER = '511.123.111', 
    HIRE_DATE = SYSDATE, 
    COMMISSION_PCT = 0.1
WHERE EMPLOYEE_ID = 100;

--JOB_ID가 IT_PROG인 사람의 커미션 0.1로 업데이트

UPDATE EMPS
SET COMMISSION_PCT = 0.1
WHERE JOB_ID = 'IT_PROG';

--WHERE절에 서브쿼리
UPDATE EMPS
SET COMMISSION_PCT = 0.2
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM EMPS WHERE FIRST_NAME = 'Donald');

SELECT * 
FROM EMPS 
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM EMPS WHERE FIRST_NAME = 'Donald');

--SET 절에 서브쿼리
--UPDATE EMPS SET (컬럼대상) = (서브쿼리) WHERE 조건
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

--EMPLOYEES 테이블에서 50번 부서를 참조하여 사용중이므로 삭제 불가
--참조 무결성 제약 조건 위배
SELECT * FROM DEPARTMENTS;

DELETE FROM DEPARTMENTS
WHERE DEPARTMENT_ID = 50; 


--DELETE를 수행하기전 SELECT문으로 반드시 확인
SELECT * FROM EMPS WHERE EMPLOYEE_ID = 100;

DELETE FROM EMPS
WHERE EMPLOYEE_ID = 105;


--WHERE절의 서브쿼리

--부서명 shipping의 부서번호
SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'Shipping';

DELETE FROM EMPS
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'Shipping');

ROLLBACK;

---------

SELECT * FROM EMPLOYEES;

DELETE FROM EMPLOYEES WHERE EMPLOYEE_ID = 100;