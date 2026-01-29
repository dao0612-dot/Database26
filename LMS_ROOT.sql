# 파이썬과 mysql 병합 작업을 위한 sql 페이지

# 절차 일반적으로 system(root)계정은 개발용으로 사용하지 않는다.
# mysql에 사용할 id와 pw의 권한을 부여하고 db를 생성한다.

CREATE USER 'mbc'@'localhost' identified by '1234';
# 사용자계정생성  id     접속pc                    암호
#           'lhj' @ 192.168.0.154           '5678'  ->  임효정씨가 154주소로 들어옴
#           'lhj' @ 192.168.0.%   -> 192.168.0.1 ~ 192.168.0.255 
#           'lhj' @ %             -> 전체ip(외부에서도 접속된 -> 보안에 좋지 않음)
# 사용자 계정 생성은 id가 중복되어도 됨 -> 대신 접속 PC를 다중처리할 수 있음
# CREATE USER 'mbc'@'192.168.0.%' identified by '5678';
# CREATE USER 'mbc'@'%' identified by 'Mbc320!!';


# 사용자를 삭제
drop user 'mbc'@'localhost';

# mbc사용자에게 lms 권한 부여
# 1. 데이터베이스 생성 -> 2. 계정에 권한을 준다.
create database lms default character set utf8mb4 collate utf8mb4_general_ci;
# lms 데이터베이스를 생성                      한국어 지원 utf-8
# collate : 문자 집합에 포함된 문자들을 어떻게 비교하고 정렬할지 정의하는 키워드
# 데이터 비교 시 대소문자 구분, 문자 간의 정렬 순서, 언어별 특수문자 처리 방식 지원
# utf8mb4 : 문자집합
# general : 비교규칙(간단한 일반비교)
# ci : Case Insensitive(대소문자 구분하지 않음)
# collate utf8mb4_bin (대소문자 구분 함)

# mbc라는 계정에 lms를 사용할 수 있게 권한부여
GRANT ALL PRIVILEGES ON LMS.* TO 'mbc'@'localhost';
#                       DB명.테이블  id     접속pc
# ALL PRIVILEGES -> 모든 권한 부여
# GRANT select, insert on LMS.* TO 'mbc'@'localhost'
#       READ    CREATE

# 권한 즉시 반영
FLUSH PRIVILEGES;

use MYSQL; # MYSQL 최고 DB에 접속
select * from user;