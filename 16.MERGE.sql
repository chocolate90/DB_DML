CREATE TABLE EMPS_IT AS (SELECT * FROM EMPLOYEES WHERE 1=2);

DESC EMPS_IT;

INSERT INTO EMPS_IT(EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES (100, 'Gildong', 'kkk', SYSDATE, 'IT_PROG');

SELECT * FROM EMPS_IT;

--MERGE INTO 타겟 엘리어스
--USING (병합시킬 테이블의 데이터)
--ON (두 테이블의 연결 조건)
--WHEN MATCHED THEN (일치할 경우 수행할 작업)
--WHEN NOT MATCHED THEN (일치하지 않을 경우 수행할 작업); 

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


--실습
--EMPLOYEES 테이블이 매번 수정되는 테이블이라고 가정
--주마다 EMPS_IT을 업데이트
--기존의 데이터는 EMAIL, PHONE_NUMBER, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID는 업뎃
--새로 유입된 데이터는 모든 컬럼을 그대로 추가
INSERT INTO EMPS_IT (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES (102, '홍', '길동', 'Hong', '01/04/06', 'AD_VP');

INSERT INTO EMPS_IT (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES (101, '킴', '니나', 'Kim', '20/03/04', 'AD_VP');

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
WHEN NOT MATCHED THEN --전부 다 넣을 경우 INSERT (생략가능) VALUES 
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
