-- DML (Data Manipulation Language) : INSERT(입력), UPDATE(수정), DELETE(삭제)

CREATE TABLE DEPT_TEMP
AS SELECT * FROM dept;

SELECT * FROM DEPT_TEMP;

DROP TABLE dept_temp; -- 생성된 테이블을 삭제하고 싶을 때

-- 테이블에 테이터를 추가하는 INSERT 문
-- insert into 테이블명(컬럼명...) values(데이터...)

INSERT INTO dept_TEMP(deptno, dname, loc) VALUES (50,'DATABASE','SEOUL');

INSERT INTO dept_TEMP VALUES (60,'BACKEND','BUSAN');

INSERT INTO dept_TEMP(deptno) VALUES (70);

INSERT INTO dept_TEMP VALUES (80,'FRONTEND','INCHEON');

INSERT INTO dept_temp(dname, loc) VALUES ('APP','DAEGU')

DELETE FROM dept_temp
WHERE deptno = 70;

INSERT INTO DEPT_TEMP VALUES (70,'웹개발','')

CREATE TABLE EMP_TEMP
AS SELECT * 
FROM emp
WHERE 1 != 1;

SELECT * FROM EMP_TEMP;

INSERT INTO EMP_TEMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
	VALUES(9001, '나영석', 'PD', NULL, '2020/01/01', 9900, 1000, 50);

INSERT INTO EMP_TEMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
	VALUES(9002, '강호동', 'MC', NULL, TO_date('2021/01/02','YYYY/MM/DD'), 8000, 1000, 60);

INSERT INTO EMP_TEMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
	VALUES(9003, '서장훈', 'MC', NULL, sysdate, 9000, 1000, 70);

DELETE FROM emp_temp
WHERE ename = ;

ROLLBACK;

UPDATE DEPT_TEMP
	SET dname = 'WEB-PROGRAM',
		loc = 'SUWON'
	WHERE deptno = 70;




















