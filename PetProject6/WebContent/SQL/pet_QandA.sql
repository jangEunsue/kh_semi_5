-- Q&A 게시판
create table pet_QandA( 
    QA_no number(5) primary key,                -- 글 번호
    QA_title varchar2(10) not null,             -- 제목
    QA_cont varchar2(100),                      -- 글 내용
    QA_userID varchar2(10) not null,            -- 이용자 아이디
    QA_date date,                               -- 작성일
    QA_update date,                             -- 수정일 
    QA_group number(5) not null,                -- 글 그룹
    QA_step number(5),                          -- 글 답변
    QA_indent number(5)                         --글 답변 들여쓰기
);