--==========================
--member table 생성
--===========================

CREATE TABLE MEMBER (
    MEMBER_ID VARCHAR2(20) NOT NULL ,
    MEMBER_NAME VARCHAR2(50) NOT NULL,
    PASSWORD VARCHAR2(300) NOT NULL,
    MEMBER_ROLE CHAR(1) DEFAULT 'M' NOT NULL,
    BIRTHDAY DATE NULL,
    EMAIL VARCHAR2(300)    NOT NULL,
    PHONE CHAR(11)    NULL,
    ENROLL_DATE    DATE DEFAULT SYSDATE NOT NULL    ,
    STATUS CHAR(1) DEFAULT 'Y' NOT NULL ,
    WARNING_COUNT NUMBER    DEFAULT 0 NULL ,
    PHOTO VARCHAR2(100) NULL,
    QUIT_DATE DATE NULL
);

comment on column member.MEMBER_id is '회원아이디';
comment on column member.MEMBER_NAME is '이름';
comment on column member.PASSWORD is '비밀번호';
comment on column member.MEMBER_ROLE is '회원권한';
comment on column member.BIRTHDAY is '생년월일';
comment on column member.EMAIL is '이메일';
comment on column member.PHONE is '연락처';
comment on column member.ENROLL_DATE is '가입일';
comment on column member.STATUS is '회원상태';
comment on column member.WARNING_COUNT is '경고횟수';
comment on column member.PHOTO is '프로필사진';
comment on column member.QUIT_DATE is '탈퇴일';

ALTER TABLE MEMBER ADD CONSTRAINT PK_MEMBER PRIMARY KEY (
    MEMBER_ID
);

ALTER TABLE MEMBER ADD CONSTRAINT CK_MEMBER_MEMBER_ROLE CHECK(MEMBER_ROLE IN ('M', 'A'));
ALTER TABLE MEMBER ADD CONSTRAINT CK_MEMBER_STATUS CHECK(STATUS IN ('Y', 'N', 'B'));


----------------------------------------------------
-- BOARD_CATEGORY 테이블 및 시퀀스 생성
----------------------------------------------------
create table BOARD_CATEGORY(
    board_code varchar2(2) not null,
    board_name varchar2(30),
    constraint pk_board_category_board_code primary key(board_code)
);
create sequence SEQ_BOARD_CATEGORY_NO;

----------------------------------------------------
-- BOARD_CATEGORY 샘플 코드 입력
----------------------------------------------------
insert into board_category values ('01', '나를찾아줘');
insert into board_category values ('02', '커뮤니티');
insert into board_category values ('03', '봉사게시판');
insert into board_category values ('04', '공지사항');
insert into board_category values ('05', '입양임보');
insert into board_category values ('06', '1:1문의'); 

-------------------------------
--1:1문의 테이블
-------------------------------
CREATE TABLE ASK_BOARD (
    INQUIRY_NO NUMBER    NOT NULL,
    BOARD_CODE VARCHAR2(2) DEFAULT '06' NOT NULL,
    WRITER VARCHAR2(20) NOT NULL,
    STATUS CHAR(1) DEFAULT 'D' NULL,
    INQUIRY_TITLE VARCHAR2(100) NOT NULL,
    INQUIRY_CONTENT VARCHAR2(2000) NOT NULL,
    ENROLL_DATE DATE DEFAULT SYSDATE NOT NULL,
    ANSWER CLOB    NULL,
    ANSWER_DATE DATE NULL,
    ADMIN_ID VARCHAR2(20) NULL
);

COMMENT ON COLUMN ASK_BOARD.INQUIRY_NO IS '문의번호';
COMMENT ON COLUMN ASK_BOARD.BOARD_CODE IS '게시판코드';
COMMENT ON COLUMN ASK_BOARD.WRITER IS '작성자';
COMMENT ON COLUMN ASK_BOARD.STATUS IS '문의상태';
COMMENT ON COLUMN ASK_BOARD.INQUIRY_TITLE IS '문의제목';
COMMENT ON COLUMN ASK_BOARD.INQUIRY_CONTENT IS '문의내용';
COMMENT ON COLUMN ASK_BOARD.ENROLL_DATE IS '등록일';
COMMENT ON COLUMN ASK_BOARD.ANSWER IS '관리자답변';
COMMENT ON COLUMN ASK_BOARD.ANSWER_DATE IS '답변일';
COMMENT ON COLUMN ASK_BOARD.ADMIN_ID IS '답변관리자';

ALTER TABLE ASK_BOARD ADD CONSTRAINT PK_ASK_BOARD PRIMARY KEY(INQUIRY_NO);
ALTER TABLE ASK_BOARD ADD CONSTRAINT CK_ASK_BOARD_STATUS CHECK(STATUS IN ('D', 'C', 'I', 'F'));

CREATE SEQUENCE SEQ_ASK_BOARD_INQUIRY_NO; 

-------------------------------
--공지사항 테이블
-------------------------------
CREATE TABLE NOTICE_BOARD (
    NO NUMBER    NOT NULL,
    WRITER VARCHAR2(20) NOT NULL,
    TITLE VARCHAR2(100) NULL,
    CONTENT CLOB NULL,
    ENROLL_DATE DATE NULL,
    VIEW_NUM NUMBER DEFAULT 0 NULL,
    BOARD_CODE VARCHAR2(2) DEFAULT '04' NOT NULL
);

COMMENT ON COLUMN NOTICE_BOARD.NO IS '번호';
COMMENT ON COLUMN NOTICE_BOARD.WRITER IS '작성자';
COMMENT ON COLUMN NOTICE_BOARD.TITLE IS '게시글제목';
COMMENT ON COLUMN NOTICE_BOARD.CONTENT IS '게시글내용';
COMMENT ON COLUMN NOTICE_BOARD.ENROLL_DATE IS '게시글작성일시';
COMMENT ON COLUMN NOTICE_BOARD.VIEW_NUM IS '조회수';
COMMENT ON COLUMN NOTICE_BOARD.BOARD_CODE IS '게시판코드';

ALTER TABLE NOTICE_BOARD ADD CONSTRAINT PK_NOTICE_BOARD PRIMARY KEY(NO);

CREATE SEQUENCE SEQ_NOTICE_BOARD_NO;

----------------------------------------------------
-- 봉사 게시판 테이블 생성 1차 211025
----------------------------------------------------

CREATE TABLE VOLUNTEER (
    NO NUMBER NOT NULL,
    TITLE VARCHAR2(100) NOT NULL,
    CENTER_NAME VARCHAR2(50) NOT NULL,
    CONTENT CLOB NOT NULL,
    START_DATE DATE NOT NULL,
    END_DATE DATE NOT NULL,
    EMAIL VARCHAR2(300) NOT NULL,
    PHONE CHAR(11) NOT NULL,
    APPROVAL_YN CHAR(1) DEFAULT 'N' NULL,
    DELETE_YN CHAR(1) DEFAULT 'N' NULL,
    CAPACITY NUMBER NOT NULL,
    PLACE VARCHAR2(50) NOT NULL,
    DEADLINE_DATE DATE NOT NULL,
    REG_DATE DATE DEFAULT SYSDATE NULL,
    TIME VARCHAR2(50) NULL,
    DAY VARCHAR2(50) NULL,
    BOARD_CODE VARCHAR2(2) NOT NULL,
    WRITER VARCHAR2(20) NOT NULL,
    ENROLL_YN CHAR(1) DEFAULT 'Y' NULL,
    THUMBNAIL VARCHAR2(100)     NULL,
    CONSTRAINT PK_VOLUNTEER_NO PRIMARY KEY(NO),
    CONSTRAINT FK_VOLUNTEER_WRITER FOREIGN KEY(WRITER) REFERENCES MEMBER(MEMBER_ID) ON DELETE SET NULL,
    CONSTRAINT CK_VOLUNTEER_APPROVAL_YN CHECK(APPROVAL_YN IN ('Y', 'N', 'W')),
    CONSTRAINT CK_VOLUNTEER_DELETE_YN CHECK(DELETE_YN IN ('Y', 'N')),
    CONSTRAINT CK_VOLUNTEER_ENROLL_YN CHECK(ENROLL_YN IN ('Y', 'N'))
);

-- 시퀀스 생성
CREATE SEQUENCE SEQ_VOLUNTEER_NO;
COMMENT ON COLUMN VOLUNTEER.NO IS '글번호';
COMMENT ON COLUMN VOLUNTEER.TITLE IS '봉사게시글제목';
COMMENT ON COLUMN VOLUNTEER.CENTER_NAME IS '센터명';
COMMENT ON COLUMN VOLUNTEER.CONTENT IS '봉사게시글내용';
COMMENT ON COLUMN VOLUNTEER.START_DATE IS '봉사 시작일';
COMMENT ON COLUMN VOLUNTEER.END_DATE IS '봉사 종료일';
COMMENT ON COLUMN VOLUNTEER.EMAIL IS '이메일';
COMMENT ON COLUMN VOLUNTEER.PHONE IS '휴대폰번호(작성자와 다른번호를 입력할 수 있어서 컬럼유지)';
COMMENT ON COLUMN VOLUNTEER.APPROVAL_YN IS '관리자승인(Y) 미승인(N) 승인보류(W)';
COMMENT ON COLUMN VOLUNTEER.DELETE_YN IS '삭제여부(Y/N)';
COMMENT ON COLUMN VOLUNTEER.CAPACITY IS '모집인원';
COMMENT ON COLUMN VOLUNTEER.PLACE IS '장소';
COMMENT ON COLUMN VOLUNTEER.DEADLINE_DATE IS '신청마감일(마감일 지날시 신청하지 못하게 막음)';
COMMENT ON COLUMN VOLUNTEER.REG_DATE IS '봉사게시글등록일';
COMMENT ON COLUMN VOLUNTEER.TIME IS '봉사시간(select option으로 시간협의, 직접입력 등 제시)';
COMMENT ON COLUMN VOLUNTEER.DAY IS '봉사요일(select option으로 요일협의,평일, 주말, 직접입력 등 제시)';
COMMENT ON COLUMN VOLUNTEER.BOARD_CODE IS '게시판코드';
COMMENT ON COLUMN VOLUNTEER.WRITER IS '작성자';
COMMENT ON COLUMN VOLUNTEER.ENROLL_YN IS '신청자접수취소여부 접수(Y) 취소(N)';
COMMENT ON COLUMN VOLUNTEER.THUMBNAIL IS '썸네일사진';

----------------------------------------------------
-- 봉사 신청 테이블 생성 1차 211029
----------------------------------------------------

-- 이름, 휴대폰, 이메일 컬럼 기존거 제거 함
CREATE TABLE VOLUNTEER_APPLICATION (
    NO NUMBER NOT NULL,
    APPROVAL_YN CHAR(1)    DEFAULT 'N' NULL,
    APPLICATION_YN CHAR(1) DEFAULT 'Y'    NULL,
    REG_DATE DATE DEFAULT SYSDATE    NULL,
    BOARD_NO NUMBER     NOT NULL,
    BOARD_CODE VARCHAR2(10) NOT NULL,
    APPLICANT VARCHAR2(20) NOT NULL,
    CONSTRAINT PK_VOLUNTEER_APPLICATION_NO PRIMARY KEY(NO),
    CONSTRAINT FK_VOLUNTEER_APPLICATION_BOARD_NO FOREIGN KEY(BOARD_NO) REFERENCES VOLUNTEER(NO) ON DELETE SET NULL,
    CONSTRAINT FK_VOLUNTEER_APPLICATION_APPLICANT FOREIGN KEY(APPLICANT) REFERENCES MEMBER(MEMBER_ID) ON DELETE SET NULL,
    CONSTRAINT CK_VOLUNTEER_APPLICATION_APPROVAL_YN CHECK(APPROVAL_YN IN ('Y', 'N')),
    CONSTRAINT CK_VOLUNTEER_APPLICATION_APPLICATION_YN CHECK(APPLICATION_YN IN ('Y', 'N'))
);

-- 시퀀스 생성
CREATE SEQUENCE SEQ_VOLUNTEER_APPLICATION_NO;

COMMENT ON COLUMN VOLUNTEER_APPLICATION.NO IS '신청번호';
COMMENT ON COLUMN VOLUNTEER_APPLICATION.APPROVAL_YN IS '봉사신청 승인(Y) 미승인(N)';
COMMENT ON COLUMN VOLUNTEER_APPLICATION.APPLICATION_YN IS '봉사신청상태 신청(Y) 취소(N)';
COMMENT ON COLUMN VOLUNTEER_APPLICATION.REG_DATE IS '봉사신청등록일';
COMMENT ON COLUMN VOLUNTEER_APPLICATION.BOARD_NO IS '봉사게시글번호';
COMMENT ON COLUMN VOLUNTEER_APPLICATION.BOARD_CODE IS '게시판코드';
COMMENT ON COLUMN VOLUNTEER_APPLICATION.APPLICANT IS '신청자아이디';

----------------------------------------
-- 댓글
-- 댓글부분 on delete cascade 안한건 원댓글이 삭제되도 대댓글은 보일수있게 하기 위함이다. 댓글을 삭제했으면 '삭제된 댓글입니다' 만 보이게 자바코드에서 수정하기 위한 방안.
----------------------------------------
create table board_comment (
    no number,
    writer varchar2(20) not null,
    comment_level number default 1 not null, -- 댓글 1, 대댓글 2
    content varchar2(2000) not null,
    comment_ref number, -- 대댓글인 경우 참조하는 댓글번호(no)
    reg_date date default sysdate,
    delete_yn char(1) default 'N' not null,
    board_code varchar2(2) not null,
    board_no number not null,
    constraint pk_board_comment_no primary key(no),
    constraint fk_board_comment_writer foreign key(writer) references member(member_id),
    constraint fk_board_comment_ref foreign key(comment_ref) references board_comment(no)
);

comment on column board_comment.no is '댓글번호';
comment on column board_comment.writer is '댓글 작성자';
comment on column board_comment.comment_level is '댓글 레벨';
comment on column board_comment.content is '댓글내용';
comment on column board_comment.comment_ref is '댓글 참조번호';
comment on column board_comment.reg_date is '댓글 작성일';
comment on column board_comment.delete_yn is '삭제여부(Y/N)';
comment on column board_comment.board_code is '게시판코드';
comment on column board_comment.board_no is '게시글번호';

create sequence seq_board_comment_no;

----------------------------------------------------
-- 자유 게시판 테이블 생성 211102
----------------------------------------------------

CREATE TABLE BULLETIN_BOARD (
    NO NUMBER NOT NULL,
    BOARD_CODE VARCHAR2(2)    NOT NULL,
    WRITER VARCHAR2(20) NOT NULL,
    TITLE VARCHAR2(100) NULL,
    CONTENT CLOB NOT NULL,
    ENROLL_DATE    DATE DEFAULT SYSDATE NULL,
    VIEW_NUM VARCHAR2(300) DEFAULT 0 NULL,
    SCRAP_NUM NUMBER DEFAULT 0 NOT NULL,
    LIKE_NUM VARCHAR(255) DEFAULT 0 NOT NULL,
    ANIMAL_TYPE    CHAR(1)    NOT NULL,
    DETAIL CHAR(1) NOT NULL,
    CATEGORY VARCHAR(255) NOT NULL,
    DELETE_YN CHAR(1) DEFAULT 'N' NULL,
    NOTICE_YN CHAR(1) DEFAULT 'N' NULL
);

create sequence seq_BULLETIN_BOARD_NO; 
--테이블에 내용 삽입 '

----- COMMENT ON COLUMN
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
----- 제약조건
ALTER TABLE BULLETIN_BOARD ADD CONSTRAINT PK_BULLETIN_BOARD_NO PRIMARY KEY (NO);
ALTER TABLE BULLETIN_BOARD ADD CONSTRAINT FK_BULLETIN_BOARD_BOARD_CODE FOREIGN KEY(BOARD_CODE) REFERENCES BOARD_CATEGORY(BOARD_CODE);
ALTER TABLE BULLETIN_BOARD ADD CONSTRAINT FK_BULLETIN_BOARD_WRITER FOREIGN KEY(WRITER) REFERENCES MEMBER(MEMBER_ID);
ALTER TABLE BULLETIN_BOARD ADD CONSTRAINT CK_BULLETIN_BOARD_ANIMAL_TYPE CHECK(ANIMAL_TYPE IN ('D', 'C', 'F'));
ALTER TABLE BULLETIN_BOARD ADD CONSTRAINT CK_BULLETIN_BOARD_DETAIL CHECK(DETAIL IN ('G','Q','I'));
ALTER TABLE BULLETIN_BOARD ADD CONSTRAINT CK_BULLETIN_BOARD_CATEGORY CHECK(CATEGORY IN ('B','G'));
ALTER TABLE BULLETIN_BOARD ADD CONSTRAINT CK_BULLETIN_BOARD_DELETE_YN CHECK(DELETE_YN IN ('Y','N')); 
ALTER TABLE BULLETIN_BOARD ADD CONSTRAINT CK_BULLETIN_BOARD_NOTICE_YN CHECK(NOTICE_YN IN ('Y','N'));

----------------------------------------------------
-- Attachment 테이블 및 시퀀스 생성
----------------------------------------------------
CREATE TABLE "ATTACHMENT" (
    "NO"    NUMBER        NOT NULL,
    "ORIGINAL_FILENAME"    VARCHAR2(255)        NOT NULL,
    "RENAMED_FILENAME"    VARCHAR2(255)        NOT NULL,
    "REG_DATE"    DATE    DEFAULT SYSDATE    NULL,
    "BOARD_CODE"    VARCHAR2(2)        NOT NULL,
    "BOARD_NO"    NUMBER        NOT NULL
);

COMMENT ON COLUMN "ATTACHMENT"."NO" IS '번호';
COMMENT ON COLUMN "ATTACHMENT"."ORIGINAL_FILENAME" IS '기존파일명';
COMMENT ON COLUMN "ATTACHMENT"."RENAMED_FILENAME" IS '수정파일명';
COMMENT ON COLUMN "ATTACHMENT"."REG_DATE" IS '첨부파일등록일';
COMMENT ON COLUMN "ATTACHMENT"."BOARD_CODE" IS '게시판코드';
COMMENT ON COLUMN "ATTACHMENT"."BOARD_NO" IS '게시글번호';

ALTER TABLE "ATTACHMENT" ADD CONSTRAINT "PK_ATTACHMENT" PRIMARY KEY ("NO");
ALTER TABLE "ATTACHMENT" ADD CONSTRAINT "FK_ATTACHMENT_BOARD_CODE" FOREIGN KEY(BOARD_CODE)
 REFERENCES BOARD_CATEGORY(BOARD_CODE);
CREATE SEQUENCE SEQ_ATTACHMENT_NO; 

----------------------------------------------------
-- FindMe_board 게시판 테이블 생성
----------------------------------------------------
CREATE TABLE "FIND_ME_BOARD" (
    "BOARD_CODE"    VARCHAR2(2)        NOT NULL,
    "NO"    NUMBER        NOT NULL,
    "TITLE"    VARCHAR2(100)        NOT NULL,
    "WRITER"    VARCHAR2(20)        NOT NULL,
    "PHONE"    VARCHAR2(11)        NOT NULL,
    "ENROLL_DATE"    DATE    DEFAULT SYSDATE    NOT NULL,
    "GENDER"    VARCHAR2(9)        NOT NULL,
    "WEIGHT"    NUMBER        NOT NULL,
    "COLOR"    VARCHAR2(100)        NOT NULL,
    "CHARACTER"    VARCHAR2(500)        NOT NULL,
    "MISS_DATE"    DATE    DEFAULT SYSDATE     NOT NULL,
    "CONTENT"    CLOB        NOT NULL,
    "STATUS"    VARCHAR2(30)    DEFAULT '실종'    NOT NULL,
    "DELETE_YN"    CHAR(1)    DEFAULT 'N'    NOT NULL,
    "COMPLETE_YN"    CHAR(1)    DEFAULT 'N'    NOT NULL,
    "LATITUDE"    NUMBER        NOT NULL,
    "LONGITUDE"    NUMBER        NOT NULL,
    "ADDRESS"    VARCHAR2(120)        NOT NULL,
    "NOTICE_YN"    CHAR(1)    DEFAULT 'N'    NOT NULL,
    "ANIMAL_TYPE"    VARCHAR2(30)        NOT NULL,
    "BREED"    VARCHAR2(60)        NOT NULL
);

----------------------------------------------------
-- FindMe_board 게시판 커멘트
----------------------------------------------------
COMMENT ON COLUMN "FIND_ME_BOARD"."NO" IS '번호';
COMMENT ON COLUMN "FIND_ME_BOARD"."TITLE" IS '제목';
COMMENT ON COLUMN "FIND_ME_BOARD"."WRITER" IS '작성자';
COMMENT ON COLUMN "FIND_ME_BOARD"."PHONE" IS '휴대폰번호(작성자와 다른번호를 입력할 수 있어서 컬럼유지)';
COMMENT ON COLUMN "FIND_ME_BOARD"."ENROLL_DATE" IS '작성일';
COMMENT ON COLUMN "FIND_ME_BOARD"."GENDER" IS '애완동물 성별(미확인/수컷/암컷)';
COMMENT ON COLUMN "FIND_ME_BOARD"."WEIGHT" IS '몸무게';
COMMENT ON COLUMN "FIND_ME_BOARD"."COLOR" IS '털색';
COMMENT ON COLUMN "FIND_ME_BOARD"."CHARACTER" IS '특징';
COMMENT ON COLUMN "FIND_ME_BOARD"."MISS_DATE" IS '실종일';
COMMENT ON COLUMN "FIND_ME_BOARD"."CONTENT" IS '내용';
COMMENT ON COLUMN "FIND_ME_BOARD"."BOARD_CODE" IS '게시판코드';
COMMENT ON COLUMN "FIND_ME_BOARD"."STATUS" IS '처리상태(실종/목격/보호)';
COMMENT ON COLUMN "FIND_ME_BOARD"."DELETE_YN" IS '삭제여부(Y/N)';
COMMENT ON COLUMN "FIND_ME_BOARD"."COMPLETE_YN" IS '완료여부(Y/N)';
COMMENT ON COLUMN "FIND_ME_BOARD"."LATITUDE" IS '위도';
COMMENT ON COLUMN "FIND_ME_BOARD"."LONGITUDE" IS '경도';
COMMENT ON COLUMN "FIND_ME_BOARD"."NOTICE_YN" IS '공지여부(Y/N)';
COMMENT ON COLUMN "FIND_ME_BOARD"."ANIMAL_TYPE" IS '강아지/고양이/기타';
COMMENT ON COLUMN "FIND_ME_BOARD"."BREED" IS '기본값(강아지/고양이/기타)';
COMMENT ON COLUMN "FIND_ME_BOARD"."ADDRESS" IS '상세위치';

ALTER TABLE "FIND_ME_BOARD" ADD CONSTRAINT "PK_FIND_ME_BOARD_NO" PRIMARY KEY ("NO");
ALTER TABLE "FIND_ME_BOARD" ADD CONSTRAINT "FK_FIND_ME_BOARD_BOARD_CODE" FOREIGN KEY(BOARD_CODE)
 REFERENCES BOARD_CATEGORY(BOARD_CODE);
ALTER TABLE "FIND_ME_BOARD" ADD CONSTRAINT "FK_FIND_ME_BOARD_WRITER" FOREIGN KEY(WRITER)
 REFERENCES MEMBER(MEMBER_ID); 
 
ALTER TABLE "FIND_ME_BOARD" ADD CONSTRAINT CK_FINDME_BOARD_GENDER CHECK (GENDER IN('미확인','수컷','암컷'));
ALTER TABLE "FIND_ME_BOARD" ADD CONSTRAINT CK_FINDME_BOARD_STATUS CHECK (STATUS IN('실종','목격','보호'));
ALTER TABLE "FIND_ME_BOARD" ADD CONSTRAINT CK_FINDME_BOARD_DELETE_YN CHECK ("DELETE_YN" IN('실종','목격','보호'));
ALTER TABLE "FIND_ME_BOARD" ADD CONSTRAINT CK_FINDME_BOARD_COMPLETE_YN CHECK ("COMPLETE_YN" IN('실종','목격','보호'));

----------------------------------------------------
-- FindMe_board 게시판 시퀀스 생성
----------------------------------------------------
create sequence SEQ_TB_FIND_ME_NO;