select @@hostname;
set SQL_SAFE_UPDATES=0;
-- 이 창은 메모장처럼 사용됨
-- 스크립트를 1줄씩 실행하는 것이 기본임 (ctrl + enter)
-- 만약 더미데이터를 20개를 입력한다!!! (블럭설정 ctrl + shift + enter)

use sakila; -- sakila 데이터베이스에 가서 사용할께!!!
-- select * 은 실무에서는 사용하기 힘들다. 이미 아주 많이 존재하는 모든 열과 행을 가져오는 과정이 매우 길어지고 무거워지기 때문.
select * from actor; -- actor 테이블에 모든 값을 가져와~

use world; -- world 데이터베이스에 가서 사용할께!!!
select * from city; -- city 테이블에 모든 값을 가져와~

-- doitsql 이라는 스키마를 생성해라.
create database DoitSQL;

-- 그 스키마를 사용하도록 연다
use doitsql;

-- doti_dml이라는 테이블을 생성해라. 생성하면서 '열'을 만든다.
create table doit_dml(
col_1 int,
col_2 varchar(50),
col_3 datetime
);

-- doit_dml 테이블에 열을 기반으로 한 '행(데이터)'을 생성한다.(데이터 삽입)
insert into doit_dml (col_1, col_2, col_3) values (1,'doitsql','2023-01-01');
select * from doit_dml;

insert into doit_dml values (2,'열 이름 생략','2023-01-02');
insert into doit_dml (col_1, col_2) values (3, 'col_3값 생략');
insert into doit_dml values (4,'다중임력','2023-01-03'),(5,'다중입력','2023-01-04'),(6,'다중입력','2023-01-05');


-- 테이블의 모든 행에 col_2열에 해당되는 값을 '데이터 수정'으로 변경한다.
update doit_dml set col_2 = '데이터 수정'
where col_1 = 4; -- 단, col_1 열의 값이 4 숫자인 경우에만

-- 테이블의 모든 행에 col_1열에 해당되는 값을 변경해라. 조건이 없으므로 모든 행에 그대로 적용.
update doit_dml set col_1 = col_1 + 10;


-- 테이블 doit_dml을 삭제해라. 단, col_1 = 14 는 조건에 해당되는 행만 삭제.
delete from doit_dml where col_1 = 14;
delete from doit_dml;

drop table doit_dml;

use sakila;

select * from customer order by first_name asc;