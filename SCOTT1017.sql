-- 다중행 함수 : 여러 행에 대해서 함수가 적용되어 하나의 결과를 나타내는 함수

SELECT deptno, sum(sal)
FROM emp
GROUP BY deptno; --각 부서별로 합계를 나타냄

-- 다중행 함수의 종류
-- SUM() : 지정한 데이터의 합을 반환
-- COUNT() : 지정한 데이터의 개수를 반환
-- MAX() : 지정한 데이터의 최대값 반환
-- MIN() : 지정한 데이터의 최소값 반환
-- AVG() : 지정한 데이터의 평균값 반환
-- 집계함수(다중행함수)는 NULL값이 포함되어 있으면 무시 
SELECT SUM(DISTINCT sal), SUM(sal)
FROM emp;

-- 모든 사원에 대해서 급여와 추가 수당의 합을 구하기
SELECT sum(sal), sum(comm)
FROM emp;

-- 부서별 모든 사원에 대해서 급여와 추가 수당의 합을 구하기
SELECT deptno, sum(sal), sum(comm)
FROM EMP
GROUP BY DEPTNO;


-- 각 직책별로 급여와 추가 수당의 합 구하기
SELECT job, sum(sal), sum(comm)
FROM EMP
GROUP BY job

-- 각 부서별 최대 급여를 출력하기
SELECT max(sal), deptno
FROM EMP
GROUP BY DEPTNO


-- group by 없이 출력하려면

SELECT max(sal), 10 AS DEPTNO FROM EMP WHERE DEPTNO = 10
UNION ALL
SELECT max(sal), 20 AS DEPTNO FROM EMP WHERE DEPTNO = 20
UNION ALL 
SELECT max(sal), 30 AS DEPTNO FROM EMP WHERE DEPTNO = 30;

-- 부서번호가 20인 사원중 입사일이 가장 최근인 입사자 출력하기

SELECT max(hiredate)
FROM EMP
WHERE DEPTNO = 20;

-- 서브 쿼리 사용하기 : 각 부서별 최대<MAX()> 급여 받는 사원의 사원번호, 이름, 직책, 부서번호

SELECT empno, ename, job, deptno
FROM EMP e 
WHERE sal = (
	SELECT max(sal)
	FROM EMP e2
	WHERE e2.deptno = e.deptno
);

-- HAVING 절 : 그룹화 되어있는 대상에 대한 출력제한
-- GROUP BY 존재할 때만 사용할 수 있음
-- WHERE 조건절과 동일하게 동작하지만, 그룹화된 결과 값의 범위를 제한 할 때 사용

SELECT deptno, job, avg(sal)
FROM EMP
GROUP BY deptno, job
	HAVING AVG(sal) >= 2000
ORDER BY deptno;


-- WHERE 절과 HAVING 절을 함께 사용하기
SELECT deptno, job, avg(sal)		-- 5. 출력할 열 제한
FROM EMP							-- 1. 먼저 테이블을 가져옴
WHERE sal <= 3000					-- 2. 급여 기준으로 행을 제한함
GROUP BY deptno, JOB 				-- 3. DEPTNO와 JOB에 따라 그룹화
	HAVING avg(sal) >= 2000			-- 4. 그중 평균 급여 기준으로 행을 제한
ORDER BY DEPTNO, JOB; 				-- 6. DEPTNO와 JOB의 오름차순으로 정렬


-- HAVING절을 사용하여 EMP 테이블의 부서별 직책의 평균 급여가 500 이상인
-- 사원들의 부서 번호, 직책, 부서별 평균 급여가 출력

SELECT deptno, job, avg(sal)
FROM EMP
GROUP BY DEPTNO, JOB 
	HAVING avg(SAL) >= 500;

-- 2. EMP 테이블을 이용하여 부서번호, 평균급여, 최고급여, 최저급여, 사원수를 출력,
-- 단, 평균 급여를 출력 할 때는 소수점 제외하고 부서 변호별로 출력

SELECT deptno, TRUNC(avg(sal)) AS "평균 급여", max(sal) AS "최고 급여", 
	min(sal) AS "최소 급여", count(*) AS "사원수"
FROM EMP
GROUP BY DEPTNO
ORDER BY deptno;

-- 3. 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원을 출력

SELECT deptno, count(*) AS "사원수"
FROM EMP
GROUP BY DEPTNO
	HAVING count(*) >= 3;


-- 4. 사원들의 입사 연도를 기준으로 부서별로 몇 명이 입사했는지 출력

SELECT deptno, EXTRACT(YEAR FROM hiredate) AS "입사 연도", count(*) AS "사원수"
FROM EMP
GROUP BY deptno, EXTRACT(YEAR FROM hiredate)
ORDER BY EXTRACT(YEAR FROM hiredate), deptno;


-- 5. 추가 수당을 받는 사원 수와 받지 않는 사원 수를 출력 (O, X 로 표기 필요)

SELECT deptno, NVL2(comm,'O','X') AS "추가 수당 유 / 무", count(*) AS "사원수"
FROM EMP
GROUP BY deptno, NVL2(comm,'O','X');


-- 6. 각 부서의 입사 연도별 사원 수, 최고 급여, 급여 합, 평균 급여를 출력

SELECT deptno, EXTRACT(YEAR FROM hiredate) AS "입사 연도", count(*) AS "사원수", 
	max(sal) AS "최고 급여", sum(sal) AS "급여 합", TRUNC(avg(sal)) AS "평균 급여"
FROM EMP
GROUP BY DEPTNO, EXTRACT(YEAR FROM hiredate);




SELECT deptno, 
CASE 
	WHEN comm IS NULL THEN 'X'
	WHEN comm = 0 THEN 'X'
	ELSE 'O'
END AS "추가 수당 유 / 무",
count(*) AS "사원수"
FROM EMP
GROUP BY deptno, CASE 
	WHEN comm IS NULL THEN 'X'
	WHEN comm = 0 THEN 'X'
	ELSE 'O'
END;

-- 그룹화 관련 기타 함수 : ROLLUP
SELECT NVL(TO_CHAR(deptno),'전체 부서') AS "부서번호",
	NVL(job,'부서별 직책') AS "직책",
	COUNT(*) AS "사원수",
	MAX(sal) AS "최대 급여",
	MIN(sal) AS "최대 급여",
	ROUND(AVG(sal)) AS "평균 급여"
FROM EMP
GROUP BY ROLLUP (deptno, job)
ORDER BY "부서번호", "직책";


-- 집합 연산자 : 두개 이상의 쿼리 결과를 하나로 결합하는 연산자(수직적 처리)
-- 여러개의 SELECT 문을 하나로 연결하는 기능
-- 집합 연산자로 결합하는 결과의 컬럼은 데이터 타입이 동일해야 한다.(열의 개수도 동일해야 함)
-- 합집합 : UNION
SELECT empno, ename, sal, deptno
FROM EMP
WHERE deptno = 10
UNION 
SELECT empno, ename, sal, deptno
FROM EMP
WHERE deptno = 20
UNION
SELECT empno, ename, sal, deptno
FROM EMP
WHERE deptno = 30;


-- 교집합 : INTERSECT
-- 여러 개의 SQL문의 결과에 대한 교집합을 반환
SELECT empno, ename, sal
FROM EMP
WHERE sal > 1000	-- 1001 ~
INTERSECT 			-- 1001 ~ 1999
SELECT empno, ename, sal
FROM EMP
WHERE sal < 2000;	-- ~ 1999

-- 차집합 : MINUS, 중복행에 대한 결과를 하나의 결과로 보여줌

SELECT empno, ename, sal
FROM EMP
MINUS
SELECT empno, ename, sal
FROM EMP
WHERE sal > 2000;

































