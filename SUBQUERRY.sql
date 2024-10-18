-- 서브 쿼리 : 다른 SQL 쿼리문 내에 포함되는 쿼리문을 말함
-- 주로 데이터를 필터링 하거나 데이터 집계에 사용
-- 서브쿼리는 SELECT, INSERT, UPDATE, DELETE문에 모두 사용 가능
-- 단일행 서브 쿼리 (단 하나의 행으로 결과가 반환)와 다중행 서브 쿼리 (여러 행의 결과가 반환)가 있음

-- 특정한 사원의 소속 부서의 이름을 가져오기

SELECT dname AS "부서 이름"
FROM DEPT d 
WHERE DEPTNO = (
	SELECT DEPTNO 
	FROM EMP
	WHERE ename = 'KING'
);

-- 등가 조인을 사용해 구현 

SELECT dname AS "부서 이름"
FROM EMP e 
JOIN DEPT d 
ON e.DEPTNO = d.DEPTNO 
WHERE ename = 'KING';

-- 서브 쿼리로 'JONES' 의 급여보다 높은 급여를 받는 사원 정보 출력

SELECT * 
FROM EMP
WHERE sal > (
	SELECT sal
	FROM EMP
	WHERE ename = 'JONES'
);

-- 자체 조인(SELF)로 풀기

SELECT e1.*
FROM EMP e1
JOIN EMP e2
ON e1.sal > e2.sal
WHERE e2.ename = 'JONES';

-- 서브 쿼리는 연산자와 같은 비교 또는 조회 대상의 오른쪽에 놓이며 괄호'()'로 묶어서 표현
-- 특정한 경우를 제외하고는 ORDER BY 절을 사용할 수 없음 (성능적인 이유)
-- 서브 쿼리의 SELECT 절에 명시한 열은 메인 쿼리 비교 대상과 같은 자료형과 같은 개수로 지정해야 함 (일반적으로는 한개씩 비교)


-- 문제 : 서브쿼리를 사용하여 EMP 테이블의 사원 정보 중에서 사원 이름이 ALLEN인 사원의 추가 수당보다 
-- 많은 추가 수당을 받는 사원 정보를 구하도록 코드 작성

SELECT * FROM EMP
WHERE comm > (
	SELECT comm FROM EMP
	WHERE ename = 'ALLEN'
);

-- 문제 : JAMES 보다 먼저 입사한 사원들의 정보 출력

SELECT * FROM EMP
WHERE hiredate < (
	SELECT HIREDATE FROM EMP e 
	WHERE ename = 'JAMES'
);

-- 문제 : 20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 높은 급여를 받는 사원 정보와 소속부서 조회
-- 

SELECT  empno, ename, job, sal, d.deptno, dname, loc 
FROM EMP e 
JOIN dept d
ON e.DEPTNO = d.DEPTNO 
WHERE e.DEPTNO = 20 
AND sal > (
SELECT avg(sal) 
FROM EMP
);


-- 실행 결과가 여러개인 다중행 서브 쿼리 ()
-- IN : 메인 쿼리의 데이터가 서브 쿼리의 결과 중 하나라도 일치 데이터가 있다면 true
-- ANY, SOME : 메인 쿼리의 조건식을 만족하는 서브쿼리의 결과가 하나 이상이면 true
-- ALL : 메인 쿼리의 조건식을 서브쿼리의 결과 모두가 만족하면 true
-- EXISTS : 서브 쿼리의 결과가 존재하면(즉, 1개 이상의 행이 결과를 만족하면) true

-- 메인 쿼리에 급여가 서브 쿼리에서 각 부서의 최대 급여가 같은 사원의 모든 정보가 출력

SELECT *
FROM EMP 
WHERE sal IN (
	SELECT MAX(sal)
	FROM EMP
	GROUP BY DEPTNO
);

SELECT empno, ename, sal
FROM EMP
WHERE sal > ANY (
	SELECT sal 
	FROM emp	
	WHERE job = 'SALESMAN'
);

SELECT empno, ename, sal, job
FROM EMP 
WHERE sal = SOME (
	SELECT SAL
	FROM EMP e
	WHERE job = 'SALESMAN'
);

-- 30번 부서 사원들의 급여 보다 적은 급여를 받는 사원 정보 출력 

SELECT empno, ename, sal, deptno
FROM EMP
WHERE sal < (
	SELECT min(SAL)
	FROM EMP
	WHERE deptno = 30
);

SELECT empno, ename, sal, deptno
FROM emp
WHERE sal < ALL (
	SELECT SAL
	FROM emp
	WHERE deptno = 30
);



































