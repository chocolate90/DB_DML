--CTAS (사본테이블) PK, FK와 같은 키는 복사하지 않는다. (NULL의 여부만 복사)

CREATE TABLE DEPTS AS (SELECT * FROM DEPARTMENTS /*WHERE 1 = 2* (틀만 복사)*/);

SELECT * FROM DEPTS;