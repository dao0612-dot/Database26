# LMS에 대한 테이블을 생성 하고 더미데이터 입력(CRUD)

SHOW databases; #lms만 보인다.

USE LMS; # LMS를 사용하겠다.

select * from members;
select * from scores;
select * from boards;






drop table members;

create table members (  # members 테이블 생성

    # 필드명      타입   옵션
	id			int auto_increment primary key,
    #           정수   자동번호 생성기     기본키 (다른 테이블과 연결용)
    uid			varchar(50) not null unique,
    #           가변문자(50자) 공백 비허용 유일한 값
    password	varchar(255) not null,
    name		varchar(50) not null,
    role		enum('admin','manager','user') default 'user',
    #      		열거타입(괄호안에 글자만 허용)			기본값은 user
    active		boolean default true,
    #			불린타입 		    기본값
    created_at	datetime default current_timestamp
    # 생성일     날짜시간타입          기본값은 시스템 시간
);


# 더미데이터 입력
insert into members (uid, password, name, role, active)
values('kkw','1234','김기원','admin',true);

insert into members (uid, password, name, role, active)
values('kkw','1234','김기원','admin',true),
('lhj','5678','임효정','manager',true),
('kdg','1111','김도균','user',true),
('ksb','2222','김수빈','user',true),
('kjy','3333','김지영','user',true);


# 더미데이터 출력
select * from members;

#로그인 할 때 
select * from members where uid = 'kkw' and password = '1234' and active = true;

# 더미데이터 수정
update members set password = '1234' where uid = 'kkw';
update members set role = 'manager' where uid = 'lhj';

# 회원삭제
delete from members where uid = 'kkw';
update members set active = false where uid = 'kkw'; # 회원 비활성화


drop table scroes;
create table scores (
	id			int auto_increment primary key,
    member_id 	int not null,
    korean 		int not null,
    english  	int not null,
    math		int not null,
    total 		int not null,
    average		float not null,
    grade		char(1) not null,
    create_at 	datetime default current_timestamp,
    
    foreign key (member_id) references members(id)
    # 외래키생성   내가 갖은 필드와   연결     테이블  필드
);

# 후보키 : 공백이 없고, 유일해야 되는 필드들(학번, 주민번호, id, email....)
# primary key는 기본키로 공백이 없고, 유일해야되고, 인덱싱이 되어 있는 옵션
# 인덱싱 : db에서 빠른 찾기를 위한 옵션
# 외래키(foreign key) : 다른 테이블과 연결이 되는 키!!!!
# 외래키는 자식이고 기본키는 부모
# members가 부모임으로 kkw 계정이 있어야 scores 테이블에 kkw 점수를 넣을 수 있다.
# members 테이블에 id와 scores 테이블의 member_id는 타입 일치 필수


insert into scores (member_id, korean, english, math, total, average, grade)
values (1,99,99,99,297,99,'A');
insert into scores (member_id, korean, english, math, total, average, grade)
values (2,88,88,88,264,88,'B');
insert into scores (member_id, korean, english, math, total, average, grade)
values (3,77,77,77,231,77,'C');
insert into scores (member_id, korean, english, math, total, average, grade)
values (4,66,66,66,198,66,'F');
insert into scores (member_id, korean, english, math, total, average, grade)
values (5,80,80,80,240,80,'B');

select * from scores;

# 기본 정보 조회(INNER JOIN)
# 성적 데이터가 존재하는 회원만 조회합니다. 이름, 과목 점수, 평균, 등급을 가져오는 쿼리.
select
	m.name as 이름,
    m.uid as 아이디,
    s.korean as 국어,
    s.english as 영어,
    s.math as 수학,
    s.total as 총점,
    s.average as 평균,
    s.grade as 등급
from members m
# aliasing (별칭) : members m 처럼 테이블 이름 뒤에 한 글자 별칭을 주면 쿼리가 훨씬 간편해짐.
join scores s on m.id = s.member_id;
# on 조건 : m.id = s.member_id와
# 같이 두 테이블을 연결하는 핵심 키(pk-fk)를 정확히 지정.

delete from scores where member_id = 2;

# 성적이 없는 회원도 포함 조회 (LEFT JOIN)
# 성적표가 아직 작성되지 않은 회원까지 모두 포함하여 명단을 만들 때 사용합니다. 성적이 없으면 null로 표시됩니다.
select
	m.name as 이름,
    m.role as 역할,
    s.average as 평균,
    s.grade as 등급,
    ifnull(s.grade, '미산출') as 상태 # 성적이 없으면 '미산출' 표시
from members m
left join scores s on m.id = s.member_id;

#게시물 목록 조회
drop table boards;
create table boards (
	id			int auto_increment primary key,
    member_id 	int not null,
    title 		varchar(200) not null,
    content 	text not null,
    create_at 	datetime default current_timestamp,
    
    foreign key (member_id) references members(id)
    
);

insert into boards (member_id, title, content) 
values (2, '제목1','내용1');
insert into boards (member_id, title, content) 
values (3, '제목2','내용2');
insert into boards (member_id, title, content) 
values (3, '제목3','내용3');
insert into boards (member_id, title, content) 
values (4, '제목4','내용4');

select * from boards;

select
	b.id as 글번호,
    b.title as 제목,
    m.name as 작성자, -- members 테이블에서 가져옴
    b.content as 내용,
    b.create_at as 작성일
    
from boards b
inner join members m on m.id = b.member_id
order by b.create_at desc;

# 특정 사용자의 글만 조회 (where 절 조합)
select
	b.title,
    b.content,
    m.name as 작성자, -- members 테이블에서 가져옴
    b.create_at
from boards b
join members m on b.member_id = m.id
where m.uid = 'lhj'; -- 특정 아이디를 가진 유저의 글만 필터링

#관리자용 : 통계 조회 (group by 조합)
select
	m.name,
    m.uid,
    count(b.id) as 작성글수 # group by와 셋트
from members m
left join boards b on m.id = b.member_id
group by m.id; # 기준점은 m.id이고, 다른 것을 지정하면 오류 발생 


# 작성자 이름으로 검색하기 (like 활용)
select
	b.id as 글번호,
    b.title as 제목,
    m.name as 작성자,
    b.create_at as 작성일
from boards b
inner join members m on b.member_id = m.id

where m.name like '%효정%'
order by b.create_at desc;

# where m.name like '%검색어%' or b.title like '%검색어%'



select
a.uid,
a.name,
b.title,
a.created_at as '가입일',
b.create_at as '게시글 등록일'

from members a
inner join boards b on a.id = b.member_id
where b.member_id in (select b.member_id from boards where b.title in ('제목4','제목3'));


