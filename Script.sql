



SELECT * FROM EMP;

-- 특정 컬럼만 선택해서 조회
SELECT EMPNO, ENAME, DEPTNO FROM EMP;

--  사원번호와 부서번호만 나오도록 SQL 작성
SELECT EMPNO, DEPTNO FROM EMP;

-- 한눈에 보기 좋게 별칭 부여하기
SELECT ENAME, SAL, COMM, SAL * 12 + COMM
        FROM EMP;
        
SELECT ENAME "사원 이름", SAL AS "급여", COMM AS "성과급", SAL * 12 "연봉"
        FROM EMP;

-- 중복 제거하는 DISTINCT, 데이터를 조회할 때 중복되는 행이 여러 행이 조회 될 때, 중복된 행을 한 개씩만 선택
SELECT DISTINCT deptno 
FROM EMP
ORDER BY DEPTNO;

-- 컬럼값을 계산하는 산술 연산자
SELECT ename, sal, sal * 12, sal * 12 + comm
    FROM EMP;
    
-- 연습문제 :  job을 중복제거하고 출력하기
SELECT DISTINCT job FROM EMP;