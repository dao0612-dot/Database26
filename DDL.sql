select @@hostname;
set SQL_SAFE_UPDATES=0;
-- 이 창은 메모장처럼 사용됨
-- 스크립트를 1줄씩 실행하는 것이 기본임 (ctrl + enter)
-- 만약 더미데이터를 20개를 입력한다!!! (블럭설정 ctrl + shift + enter)

use sakila; -- sakila 데이터베이스에 가서 사용할께!!!7
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

select col_1 from doit_dml;

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
# where 절로 조건에 맞는 데이터 조회하기 
select * from customer where first_name = 'MARIA';
select * from customer where first_name < 'MARIA';

select * from customer where address_id = 200;
select * from customer where address_id < 200;

select * from payment
where payment_date = '2005-07-09 13:24:07';
select * from payment
where payment_date < '2005-07-09 13:24:07';

select * from customer where address_id between 5 and 10;
select * from payment where payment_date between '2005-06-17' and '2005-07-19';

select * from customer
where first_name between 'M' and 'O';
select * from customer
where first_name not between 'M' and 'O';


select * from city where city = 'Sunnyvale' and country_id = 103;
select * from payment
where payment_date >= '2005-06-01' and payment_date <= '2005-07-05';
select * from customer
where first_name = 'MARIA' or first_name = 'LINDA';
select * from customer
where first_name = 'MARIA' or first_name = 'LINDA' or first_name = 'NANCY';
select * from customer
where first_name in ('MARIA','LINDA','NANCY');
select * from city
where country_id in (103,86) 
and city in ('Cheju','Sunnyvale','Dallas');

select * from address;

select * from address where address2 is null;
select * from address where address2 is not null;
select * from address where address2 = '';


#order by 절로 데이터 정렬하기
select * from customer order by first_name;
select * from customer order by last_name;
select * from customer order by first_name, store_id;
select * from customer order by first_name asc;
select * from customer order by first_name desc;
select * from customer order by store_id desc, first_name asc limit 10;
select * from customer order by customer_id asc limit 100,10;
select * from customer order by customer_id asc limit 10 offset 100;


#와일드 카드로 문자열 조회하기
select * from customer where first_name like 'A%';
select * from customer where first_name like 'AA%';
select * from customer where first_name like '%A';
select * from customer where first_name like '%RA';
select * from customer where first_name like '%A%';
 
with CTE (col_1) as (
select 'A%bc' union all
select 'A_bc' union all
select 'Abc'
)
select * from CTE;

with CTE (col_1) as (
select 'A%bc' union all
select 'A_bc' union all
select 'Abc'
)
select * from CTE where col_1 like '%!%%' escape '!';

select * from customer where first_name like 'A_';
select * from customer where first_name like 'A__';
select * from customer where first_name like '__A';
select * from customer where first_name like 'A__A';
select * from customer where first_name like '_____';

select * from customer where first_name like 'A_R%';
select * from customer where first_name like '__R%';
select * from customer where first_name like 'A%R_';

select * from customer where first_name regexp '^K|N$';
select * from customer where first_name regexp 'K[^L-N]';
select * from customer where first_name like 'S%' and first_name regexp 'A[L-N]';
select * from customer where first_name like '_______'
	and first_name regexp 'A[L-N]'
    and first_name regexp 'O$';
    
#group by 절로 데이터 묶기
select special_features from film group by special_features;
select rating from film group by rating;
select rating from film;
select special_features, rating from film group by special_features, rating;
select special_features, count(*) as cnt from film group by special_features;
select special_features,rating, count(*) as cnt from film 
group by special_features,rating order by special_features,rating, cnt desc;
select special_features,rating from film
group by special_features,rating
having rating = 'G';
select special_features, count(*) as cnt from film
group by special_features
having cnt > 70;
select special_features,rating, count(*) as cnt from film
group by special_features, rating
having rating = 'R' and cnt > 8;

select distinct special_features, rating from film;


#테이블 생성 및 조작하기
create database if not exists dotisql;

use doitsql;

create table doit_increment (
col_1 int auto_increment primary key,
col_2 varchar(50),
col_3 int);

insert into doit_increment (col_2, col_3) values ('1 자동입력', 1);
insert into doit_increment (col_2, col_3) values ('2 자동입력', 2);
insert into doit_increment (col_1, col_2, col_3) values (3,'3 자동입력',3);
insert into doit_increment (col_1, col_2, col_3) values (5,'4 건너뛰고 자동입력',5);
insert into doit_increment (col_2, col_3) values ('어디까지 입력되었을까?',0);
alter table doit_increment auto_increment=100;
insert into doit_increment (col_2, col_3) values ('시작값이 변경되었을가?',0);
set @@auto_increment_increment = 5;
insert into doit_increment (col_2, col_3) values ('5씩 증가할까? (1)',0);
insert into doit_increment (col_2, col_3) values ('5씩 증가할까? (2)',0);

select last_insert_id();
select * from doit_increment;

create table doit_insert_select_from (
col_1 int,
col_2 varchar(10)
);


create table doit_insert_select_to (
col_1 int,
col_2 varchar(10)
);

insert into doit_insert_select_from values (1, 'Do');
insert into doit_insert_select_from values (2, 'It');
insert into doit_insert_select_from values (3,'Mysql');

insert into doit_insert_select_to
select * from doit_insert_select_from;

select * from doit_insert_select_to;

create table doit_insert_select_new as (select * from doit_insert_select_from);
select * from doit_insert_select_new;

# 외래키로 연결되어 있는 테이블 조작하기
create table doit_parent (col_1 int primary key);
create table doit_child (col_1 int);
alter table doit_child
add foreign key (col_1) references doit_parent(col_1);

show create table doit_child;

insert into doit_child values (1); # 부모 테이블 데이터에 먼저 입력해야 한다.

insert into doit_parent values (1); # 부모 테이블 데이터를 먼저 입력 후 자식 테이블 데이터 입력
insert into doit_child values (1);

select * from doit_parent;
select * from doit_child;

delete from doit_parent where col_1 = 1; # 부모 테이블 데이터만 삭제 불가능

delete from doit_child where col_1 = 1; # 자식 테이블 데이터를 먼저 삭제 후 부모 테이블 삭제
delete from doit_parent where col_1 = 1;

drop table doit_child;
drop table doit_parent; 

alter table doit_child
drop constraint doit_child_ibfk_1;
drop table doit_parent;


# 내부 조인
select 
a.customer_id,
a.store_id,
a.first_name,
a.last_name,
a.email,
a.address_id as a_address_id,
b.address_id as b_address_id,
b.address,
b.district,
b.city_id,
b.postal_code,
b.phone,
b.location
from customer as a
inner join address as b on a.address_id = b.address_id
where a.first_name = 'ROSA';

select
a.customer_id,
a.first_name,
a.last_name,
b.address_id,
b.address,
b.district,
b.postal_code,
c.city_id,
c.city
from customer as a
inner join address as b on a.address_id = b.address_id
inner join city as c on b.city_id = c.city_id
where a.first_name = 'ROSA';

# 외부 조인 (left/right/full outer join)
select
a.address,
a.address_id as a_address_id,
b.address_id as b_address_id,
b.store_id
from address as a
left join store as b on a.address_id = b.address_id
where b.address_id is not null;

# 서브 쿼리
select * from customer
where customer_id in (select customer_id from customer where first_name in('ROSA','ANA'));

select
a.film_id, a.title
from film as a
inner join film_category as b on a.film_id = b.film_id
inner join category as c on b.category_id = c.category_id
where c.name = 'Action';

select
a.film_id,
a.title,
a.special_features,
c. name
from film as a
inner join film_category as b on a.film_id = b.film_id
inner join category as c on b.category_id = c.category_id
where a.film_id > 10 and a.film_id < 20;