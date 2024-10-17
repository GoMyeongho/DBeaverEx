-- JOIN : 여러 테이블을 하나의 테이블처럼 사용 하는 것
-- 이 때 필요한 것 PK(Primary Key)와 테이블간 공통 값인 FK(Foreign Key) 사용
-- JOIN의 종류
-- Inner Join (동등 조인) : 두 테이블에서 일치하는 데이터만 선택
-- Left Join : 왼쪽 테이블의 모든 데이터와 일치하는 데이터 선택 
-- Right Join : 오른쪽 테이블의 모든 데이터와 일치하는 데이터 선택
-- Full Outer Join : 두 테이블의 모든 데이터 선택


-- 카테시안의 곱 : 두 개의 테이블을 조인 할 때 기준 열을 지정하지 않으면, 모든 행 * 모든 행

SELECT *
FROM emp, dept
ORDER BY empno;


-- 등가 조인(Inner Join) : 일치하는 열이 존재, 가장 일반적인 조인 방식
-- 오라클 조인 방식
SELECT empno, ename, job, sal, e.deptno
FROM EMP e, DEPT d 
WHERE e.DEPTNO = d.DEPTNO
ORDER BY empno;

-- ANSI 조인
SELECT empno, ename, job, sal, e.deptno
FROM EMP e JOIN DEPT d
ON e.DEPTNO  = d.DEPTNO
ORDER BY empno;

-- DEPT 테이블과 emp 테이블은 N:1 관계를 지님(부서 테이블의 부서번호에는 여러명의 사원이 올 수 있음)
-- 조인에서 출력 범위 설정하기
SELECT empno, ename, sal, d.deptno, dname, loc
FROM EMP e JOIN DEPT d 
ON e.DEPTNO = d.DEPTNO 
WHERE sal >= 3000;


-- MP 테이블 별칭을 E로, DEPT 테이블 별칭은 D로 하여 다음과 같이 
-- 등가 조인을 했을 때 급여가 2500 이하이고 
-- 사원 번호가 9999 이하인 사원의 정보가 출력되도록 작성
SELECT *
FROM EMP e JOIN DEPT d 
ON e.DEPTNO = d.DEPTNO 
WHERE sal <= 2500 AND empno <= 9999
ORDER BY empno;


-- 비등가 조인 : 동일한 컬럼이 존재하지 않는 경우 조인할 때 사용, 일반적인 방식은 아님
SELECT *
FROM SALGRADE s;

SELECT ename, sal, grade
FROM EMP e JOIN SALGRADE s 
ON sal BETWEEN losal AND hisal;	-- 급여와 losal ~ hisal 비등가 조인

-- 자체 조인(Self Join) : 자기자신의 테이블과 자기자신의 테이블을 조인하는 경우 (같은 테이블을 두번 사용)

SELECT e1.empno AS "사원 번호", e1.ename AS "사원 이름", e1.mgr AS "상관 사원 번호", 
	e2.empno AS "상관 사원 번호",
	e2.ename AS "상관 이름"
FROM EMP e1 join EMP e2
ON e1.mgr = e2.empno;


-- 외부 조인(Outer Join) : Left, Right, Full

SELECT e.ename, e.deptno, d.dname
FROM emp e JOIN dept d
ON e.deptno = d.deptno
ORDER BY e.deptno;

SELECT e.ename, e.deptno, d.dname
FROM emp e RIGHT OUTER JOIN dept d
ON e.deptno = d.deptno
ORDER BY e.deptno;

SELECT e.ename, e.deptno, d.dname
FROM emp e LEFT OUTER JOIN dept d
ON e.deptno = d.deptno
ORDER BY e.deptno;

SELECT e.ename, e.deptno, d.dname
FROM emp e FULL OUTER JOIN dept d
ON e.deptno = d.deptno
ORDER BY e.deptno;

-- NATURAL JOIN : 등가 조인과 비슷하지만 WHERE 조건절 (ON 절) 없이 사용 
-- 두 테이블의 동일한 이름이 있는 열을 자동으로 찾아서 JOIN 해줌

SELECT empno, ename, deptno, dname
FROM EMP e NATURAL JOIN DEPT d;

-- JOIN ~ USING : 등가 조인을 대신하는 조인 방식

SELECT e.empno, e.ename, e.job, deptno, d.dname, d.loc
FROM EMP e JOIN DEPT d USING(deptno)
ORDER BY e.empno;

-- 1. 급여 2000 초과인 사원들의 부서 정보, 사원정보 출력

SELECT e.deptno, dname, empno, ename, sal
FROM EMP e JOIN DEPT d
ON e.DEPTNO = d.DEPTNO
WHERE sal > 2000
ORDER BY DEPTNO;

-- 2. 각 부서별 평균 급여, 최대급여, 최소급여, 사원수를 출력
-- (부서번호, 부서이름, ~)

SELECT e.deptno, dname, TRUNC(avg(sal)), max(sal), min(sal), count(*)
FROM EMP e JOIN DEPT d 
ON e.DEPTNO = d.DEPTNO 
GROUP BY e.DEPTNO, dname; 

-- 모든 부서정보와 사원정보 출력 (부서 번호와 부서 이름순으로 정렬), 모든 부서가 나와야 함

SELECT *
FROM DEPT d  LEFT OUTER JOIN EMP e 
ON e.DEPTNO = d.DEPTNO
ORDER BY e.DEPTNO , dname;
























