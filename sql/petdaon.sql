
--page처리

select *
from(
    select row_number() over(order by no desc) rnum, b.* from BULLETIN_BOARD b
)
where rnum between ? and ?;


---------------
-- 자유게시판
---------------
CREATE TABLE BULLETIN_BOARD (
	NO NUMBER NOT NULL,
	BOARD_CODE VARCHAR2(2)	NOT NULL,
	WRITER VARCHAR2(20) NOT NULL,
	TITLE VARCHAR2(100) NULL,
	CONTENT CLOB NOT NULL,
	ENROLL_DATE	DATE DEFAULT SYSDATE NULL,
	VIEW_NUM VARCHAR2(300) DEFAULT 0 NULL,
	SCRAP_NUM NUMBER DEFAULT 0 NOT NULL,
	LIKE_NUM VARCHAR(255) DEFAULT 0 NOT NULL,
	ANIMAL_TYPE	CHAR(1)	NOT NULL,
	DETAIL CHAR(1) NOT NULL,
	CATEGORY VARCHAR(255) NOT NULL,
	DELETE_YN CHAR(1) DEFAULT 'N' NULL,
	NOTICE_YN CHAR(1) DEFAULT 'N' NULL
);

create sequence seq_BULLETIN_BOARD_NO;

--테이블에 내용 삽입 '
--게시판 코드: 01- 나를찾아줘   02- 커뮤니티   03- 봉사게시판   04- 공지사항   05- 임양임보   06- 1:1 문의
insert into petdaon.bulletin_board (no,board_code,writer,title,content,enroll_date,view_num,scrap_num,like_num,animal_type,detail,category,delete_yn,notice_yn) 
values (SEQ_BULLETIN_BOARD_NO.nextval,'02','liam','유기견 봉사가실분 사람구해요','반갑습니다. 함께 가실분 모집합니다',to_date('21/08/07','RR/MM/DD'),0, 0, 0,'F','G','B','N','N');
insert into petdaon.bulletin_board (no,board_code,writer,title,content,enroll_date,view_num,scrap_num,like_num,animal_type,detail,category,delete_yn,notice_yn) 
values (SEQ_BULLETIN_BOARD_NO.nextval,'02','sophia','사료 순위(21년 9월) 이건 꼭 먹여야해','이번달 정말 괜찮은 사료 추천드립립니다 여러분!',to_date('21/09/12','RR/MM/DD'),0, 0, 0,'F','G','B','N','N');
insert into petdaon.bulletin_board (no,board_code,writer,title,content,enroll_date,view_num,scrap_num,like_num,animal_type,detail,category,delete_yn,notice_yn) 
values (SEQ_BULLETIN_BOARD_NO.nextval,'02','noah','서울 친절한 병원','우리 댕댕이들를 위한 친절한 병원을 소개해드려요~',to_date('21/08/12','RR/MM/DD'),0, 0, 0,'F','G','B','N','N');
insert into petdaon.bulletin_board (no,board_code,writer,title,content,enroll_date,view_num,scrap_num,like_num,animal_type,detail,category,delete_yn,notice_yn) 
values (SEQ_BULLETIN_BOARD_NO.nextval,'02','lucas','사랑스런 퍼그~','귀여운 사진으로 힐링하세요~',to_date('21/10/22','RR/MM/DD'),0, 0, 0,'F','G','B','N','N');
insert into petdaon.bulletin_board (no,board_code,writer,title,content,enroll_date,view_num,scrap_num,like_num,animal_type,detail,category,delete_yn,notice_yn) 
values (SEQ_BULLETIN_BOARD_NO.nextval,'02','grayson','안녕하세요 인사드려요','안녕하세요 여러분 날씨도 이제 제법 쌀쌀해지네요',to_date('21/10/21','RR/MM/DD'),0, 0, 0,'F','G','B','N','N');
insert into petdaon.bulletin_board (no,board_code,writer,title,content,enroll_date,view_num,scrap_num,like_num,animal_type,detail,category,delete_yn,notice_yn) 
values (SEQ_BULLETIN_BOARD_NO.nextval,'02','jackson','가입인사','새로 회원가입 했습니다. 잘부탁드립니다~~',to_date('21/09/09','RR/MM/DD'),0, 0, 0,'F','G','B','N','N');


select * from(select row_number() over(order by no desc) rnum, b.* from BULLETIN_BOARD b) where rnum between 1 and 10;

--게시글 첨부파일있을때 별도의 테이블로 관리
create table attachment (
    no number,
    board_no number not null,
    original_filename varchar2(255) not null,
    renamed_filename varchar2(255) not null,
    reg_date date default sysdate,
    constraint pk_attachment_no primary key(no),
    constraint fk_attachment_board_no foreign key(board_no) references bulletin_board(no) on delete cascade
);

create sequence seq_attachment_no;
-------------------------------------

comment on column BULLETIN_BOARD.NO is '';
comment on column BULLETIN_BOARD.BOARD_CODE is '게시판코드';
comment on column BULLETIN_BOARD.WRITER is '작성자';
comment on column BULLETIN_BOARD.TITLE is '게시글제목';
comment on column BULLETIN_BOARD.CONTENT is '게시글내용';
comment on column BULLETIN_BOARD.ENROLL_DATE is '게시글작성일시';
comment on column BULLETIN_BOARD.VIEW_NUM is '조회수';
comment on column BULLETIN_BOARD.SCRAP_NUM is '스크랩수';
comment on column BULLETIN_BOARD.LIKE_NUM is '좋아요수';
comment on column BULLETIN_BOARD.ANIMAL_TYPE is '강아지D 고양이C 자유F';
comment on column BULLETIN_BOARD.DETAIL is '일반G 질문Q 정보공유I';
comment on column BULLETIN_BOARD.CATEGORY is '펫다온게시판B 펫다온갤러리G';
comment on column BULLETIN_BOARD.DELETE_YN is '삭제여부Y/N';
comment on column BULLETIN_BOARD.NOTICE_YN is '공지여부Y/N';

comment on column attachment.no is '첨부파일번호(PK)';
comment on column attachment.board_no is '게시판글번호(FK)';
comment on column attachment.original_filename is '업로드한 첨부파일명';
comment on column attachment.renamed_filename is '서버에 저장된 첨부파일명';
comment on column attachment.reg_date is '첨부파일업로드일시';


ALTER TABLE BULLETIN_BOARD ADD CONSTRAINT PK_BULLETIN_BOARD_NO PRIMARY KEY (NO);
ALTER TABLE BULLETIN_BOARD ADD CONSTRAINT FK_BULLETIN_BOARD_BOARD_CODE FOREIGN KEY(BOARD_CODE) REFERENCES BOARD_CATEGORY(BOARD_CODE);
ALTER TABLE BULLETIN_BOARD ADD CONSTRAINT FK_BULLETIN_BOARD_WRITER FOREIGN KEY(WRITER) REFERENCES MEMBER(MEMBER_ID);
ALTER TABLE BULLETIN_BOARD ADD CONSTRAINT CK_BULLETIN_BOARD_ANIMAL_TYPE CHECK(ANIMAL_TYPE IN ('D', 'C', 'F'));
ALTER TABLE BULLETIN_BOARD ADD CONSTRAINT CK_BULLETIN_BOARD_DETAIL CHECK(DETAIL IN ('G','Q','I'));
ALTER TABLE BULLETIN_BOARD ADD CONSTRAINT CK_BULLETIN_BOARD_CATEGORY CHECK(CATEGORY IN ('B','G'));
ALTER TABLE BULLETIN_BOARD ADD CONSTRAINT CK_BULLETIN_BOARD_DELETE_YN CHECK(DELETE_YN IN ('Y','N')); 
ALTER TABLE BULLETIN_BOARD ADD CONSTRAINT CK_BULLETIN_BOARD_NOTICE_YN CHECK(NOTICE_YN IN ('Y','N'));

--인덱스와 제약조건을 한번에 삭제하고 싶을 때 
ALTER TABLE BULLETIN_BOARD DROP PRIMARY KEY DROP INDEX;
--항상 제약조건만 삭제하고 인덱스는 남겨 놓고 싶을 때
ALTER TABLE BULLETIN_BOARD DROP PRIMARY KEY KEEP INDEX;

--------------
--제약조건 조회
select
    ucc.*,
    uc.constraint_type,
    uc.search_condition
from
    user_constraints uc join user_cons_columns ucc
    on uc.constraint_name = ucc.constraint_name
where
    uc.table_name = 'BULLETIN_BOARD';
--제약조건 삭제
--ALTER TABLE BULLETIN_BOARD DROP CONSTRAINT PK_BULLETIN_BOARD;
DROP TABLE BULLETIN_BOARD;

select * from BULLETIN_BOARD;

select 
*
from
USER_COL_COMMENTS; --현재 사용자의 스키마에 있는 테이블에 대한 컬럼 코멘트 조회






--=============================================
-- 관리자계정
--=============================================
-- student계정 생성
-- c## 없는 일반사용자 생성
alter session set "_oracle_script" = true;

create user petdaon
identified by petdaon
default tablespace users; -- 데이터저장영역(tablespace)를 users로 지정

grant connect, resource to petdaon;

alter user petdaon quota unlimited on users; -- 용량설정 

-----------------------------------------------------------------
--수업시간 member테이블 참고
--create table member(
--    id varchar2(20),
--    name varchar2(100) not null,
--    gender char(1),
--    birthday date,
--    email varchar2(500),
--    address varchar2(1000),
--    reg_date timestamp default systimestamp,
--    constraint pk_member_id primary key(id),
--    constraint uq_member_email unique(email),
--    constraint ck_member_gender check(gender in ('M', 'F'))
--);

--테이블 삭제
--drop table member;

--CREATE TABLE MEMBER (
--    MEMBER_ID VARCHAR2(20) NOT NULL ,
--    MEMBER_NAME VARCHAR2(50) NOT NULL,
--    PASSWORD VARCHAR2(300) NOT NULL,
--    MEMBER_ROLE CHAR(1) DEFAULT 'M' NOT NULL,
--    BIRTHDAY DATE NULL,
--    EMAIL VARCHAR2(300)    NOT NULL,
--    PHONE CHAR(11)    NULL,
--    ENROLL_DATE    DATE DEFAULT SYSDATE NOT NULL    ,
--    STATUS CHAR(1) DEFAULT 'Y' NOT NULL ,
--    WARNING_COUNT NUMBER    DEFAULT 0 NULL ,
--    PHOTO VARCHAR2(100) NULL,
--    QUIT_DATE DATE NULL
--);
--
--comment on column member.MEMBER_id is '회원아이디';
--comment on column member.MEMBER_NAME is '이름';
--comment on column member.PASSWORD is '비밀번호';
--comment on column member.MEMBER_ROLE is '회원권한';
--comment on column member.BIRTHDAY is '생년월일';
--comment on column member.EMAIL is '이메일';
--comment on column member.PHONE is '연락처';
--comment on column member.ENROLL_DATE is '가입일';
--comment on column member.STATUS is '회원상태';
--comment on column member.WARNING_COUNT is '경고횟수';
--comment on column member.PHOTO is '프로필사진';
--comment on column member.QUIT_DATE is '탈퇴일';
--
--ALTER TABLE MEMBER ADD CONSTRAINT PK_MEMBER PRIMARY KEY (
--    MEMBER_ID
--);
--
--ALTER TABLE MEMBER ADD CONSTRAINT CK_MEMBER_MEMBER_ROLE CHECK(MEMBER_ROLE IN ('M', 'A'));
--ALTER TABLE MEMBER ADD CONSTRAINT CK_MEMBER_STATUS CHECK(STATUS IN ('Y', 'N', 'B'));

--제약조건 조회
select
    ucc.*,
    uc.constraint_type,
    uc.search_condition
from
    user_constraints uc join user_cons_columns ucc
    on uc.constraint_name = ucc.constraint_name
where
    uc.table_name = 'MEMBER';
--제약조건 삭제
--ALTER TABLE MEMBER DROP CONSTRAINT CK_MEMBER_ROLE;
------------------------------------------------------------------이진표 예시
