create table pet_free(
   free_no number(5) primary key,      -- 게시판 글 번호
   free_writer varchar2(30) not null,  -- 게시판 글 작성자
   free_title varchar2(1000) not null, -- 게시판 글 제목
   free_cont varchar2(2000) not null,  -- 게시판 글 내용
   free_pwd varchar2(30) not null,     -- 게시판 글 비밀번호
   free_hit number(10) default 0,      -- 게시판 글 조회수
   free_date date,                     -- 게시판 글 작성일자
   free_update date,                   -- 게시판 글 수정일자
   free_group number(5),               -- 게시판 글 그룹
   free_step number(5),                -- 게시판 글 답변 단계
   free_indent number(5)               -- 게시판 답변글 들여쓰기
);