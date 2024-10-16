-- 함수 : 특정 결과 데이터를 얻기 위해 데이터를 입력할 수 있는 특수명령어를 의미
-- 함수에는 내장 함수와 사용자 정의 함수가 있음
-- 내장 함수에는 단일행 함수와 다중행 함수(집계 함수)로 나누어짐
-- 단일행 함수 : 데이터가 한 행씩 입력되고 결과가 한 행씩 나오는 함수
-- 다중행 함수 : 여러 행이 입력되어서 하나의 행으로 결과가 반환되는 것  
-- 숫자 함수 : 수학 계산식을 처리하기 위한 함수

SELECT -10, abs(-10) FROM dual;	--dual은 간단한 계산을 출력하기 위한 더미 테이블

-- ROUND(숫자, 반올림할 위치) : 반올림한 결과를 반환하는 함수
SELECT ROUND(1234.5678) AS ROUND, -- 소수점 첫째 자리에 반올림해서 결과를 반환 : 1,235
	ROUND(1234.5678, 0) AS ROUND_0, -- 소수점 첫째 자리에서 반올림해서 결과를 반환 : 1,235
	ROUND(1234.5678, 1) AS ROUND_1, -- 소수점 두번째 자리에서 반올림해서 소수점 1자리 표시 : 1,234.6
	ROUND(1234.5678, 2) AS ROUND_2, -- 소수점 세번째 자리에서 반올림해서 소수점 2자리 표시 : 1,234.57
	ROUND(1234.5678, -1) AS ROUND_MINUS1, -- 정수 첫번째 자리를 반올림 : 1,230
	ROUND(1234.5678, -2) AS ROUND_MINUS2 -- 정수 두번쨰 자리를 반올림 : 1,200
FROM dual;


-- TRUNC : 버림을 한 결과를 반환하는 함수, 자리수 지정 가능

SELECT TRUNC(1234.5678) AS TRUNC, -- 소수점 첫째 자리에 버림해서 결과를 반환 : 1,234
	TRUNC(1234.5678, 0) AS TRUNC_0, -- 소수점 첫째 자리에서 버림해서 결과를 반환 : 1,234
	TRUNC(1234.5678, 1) AS TRUNC_1, -- 소수점 두번째 자리에서 버림해서 소수점 1자리 표시 : 1,234.5
	TRUNC(1234.5678, 2) AS TRUNC_2, -- 소수점 세번째 자리에서 버림해서 소수점 2자리 표시 : 1,234.56
	TRUNC(1234.5678, -1) AS TRUNC_MINUS1, -- 정수 첫번째 자리를 버림 : 1,230
	TRUNC(1234.5678, -2) AS TRUNC_MINUS2 -- 정수 두번쨰 자리를 버림 : 1,200
FROM dual;

-- MOD : 나누기한 후 나머지를 반환하는 함수
SELECT MOD(21,5) FROM dual;

-- CEIL : 소수점 이하를 올림
SELECT CEIL(12.345) FROM dual;

-- FLOOR : 소수점 이하를 날림
SELECT FLOOR(12.345) FROM dual;

-- POWER : 제곱하는 함수
SELECT POWER(3,4) FROM dual; 

-- DUAL : SYS 계정에서 제공하는 테이블, 테이블 참조 없이 실행해보기 위해 FROM절에 사용하는 더미 테이블
SELECT 20*30 FROM dual;


-- 문자함수 : 문자 데이터로부터 특정 결과를 얻고자 할 때 사용하는 경우
SELECT ename, UPPER(ENAME), LOWER(ename), INITCAP(ename)
FROM emp;

-- UPPER 함수로 문자열 비교하기
SELECT * FROM EMP
	WHERE UPPER(ename) LIKE UPPER('%james%');

-- 문자열 길이를 구하는 LENGTH함수, LENGTHB 함수
--  LENGTH : 문자열의 길이를 반환
-- LENGTHB : 문자열의 바이트를 반환 
SELECT LENGTH(ename), LENGTHB(ename)	
	FROM EMP;

SELECT LENGTH('하니'), LENGTHB('하니')	-- ORACLE XE 에서 한글은 기본적으로 3바이트 차지
	FROM dual; 

-- 직책 이름의 길이가 6글자 이상이고, COMM이 있는 사원의 모든 정보 출력
SELECT * FROM EMP
	WHERE COMM IS NOT NULL
	AND comm != 0
	AND LENGTH(job) >= 6;  

-- SUBSTR(대상, 선택, 개수) / SUBSTRB : 시작 위치로 부터 선택 개수만큼의 문자를 반환하는 함수, 인덱스는 1부터 시작
SELECT job, SUBSTR(job, 1, 2), SUBSTR(job, 3, 2), SUBSTR(job,5) 
	FROM EMP;  

-- SUBSTR 함수와 다른 함수 함께 사용
SELECT job,
	SUBSTR(job, -LENGTH(job)),
	SUBSTR(job, -LENGTH(job),2),
	SUBSTR(job, -3)
	FROM EMP;

-- INSTR : 문자열 데이터 안에 특정 문자나 문자열이 어디에 포함되어 있는지를 알고자 할 때 사용
SELECT INSTR('HELLO, ORACLE', 'L') AS INSTR_1,	-- 'L'문자의 위치 : 3
	INSTR('HELLO, ORACLE', 'L', 5) AS INSTR_2,	-- 5번째 위치에서 시작해서 L문자의 위치 찾기 : 12
	INSTR('HELLO, ORACLE', 'L', 2, 2) AS INSTR_3,
	INSTR('S','O') AS INSTR_0
	-- 2번째 위치에서 시작해서 2번째 나타나는 문자의 위치 찾기 : 4
	FROM dual; 
	

-- 특정 문자가 포함된 행 찾기
SELECT * FROM emp
	WHERE INSTR(ename, 'S') > 0;	-- LIKE 대신 'S'라는 문자가 포함된 행 출력



SELECT * FROM EMP
	WHERE ename LIKE '%S%';

-- REPLACE : 특정 문자열 데이터에 포함된 문자를 다른 문자로 대체 할 때 사용 
-- 대체할 문자를 지정하지 않으면 삭제
SELECT '010-5006-4146' AS "변경 이전",
	REPLACE('010-5006-4146', '-', '/') AS  "변경 이후 1",
	REPLACE('010-5006-4146', '-') AS  "변경 이후 2"
	FROM dual;

-- LPAD / RPAD : 기준 공간 칸수를 지정하고 빈칸 만큼을 특정 문자로 채우는 함수
SELECT LPAD('ORACLE', 10, '+') LPAD,
	RPAD('ORACLE', 10, '+') RPAD 
FROM dual;

SELECT RPAD('010203-', 14, '*') AS RPAD_JUMIN,
	RPAD('010-5006-', 13, '*') AS RPAD_PHONE
	FROM dual;
	

-- 두 문자열을 합치는 concat 함수
SELECT CONCAT(empno, ename) "사원정보",
	CONCAT(empno,CONCAT(' : ', ename)) "사원정보:"
	FROM EMP 
	WHERE ename = 'JAMES';


-- TRIM / LTRIM / RTRIM : 문자열 데이터에서 특정 문자를 지우기 위해 사용, 문자를 지정하지 않으면 공백제거
SELECT '['||TRIM('  _ORACLE_  ') || ']' AS TRIM,
	'['||LTRIM('  _ORACLE_  ') || ']' AS LTRIM,
	'['||RTRIM('  _ORACLE_  ') || ']' AS RTRIM
FROM dual;



































	
	
	
	
	
	
	