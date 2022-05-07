create table pet_review( -- 상품 리뷰
    review_no number(5) primary key,                -- 리뷰 번호
    pnum number(5) not null,                        -- 상품번호
    review_cont varchar2(100),                      -- 리뷰 내용
    userID varchar2(10) not null,                   -- 이용자 아이디 (리뷰 작성자)
    rimage varchar2(100),				        	-- 리뷰 이미지
    review_date date,                               -- 작성일
    review_group number(5) not null,                -- 글 그룹
    review_step number(5),                          -- 글 답변
    review_indent number(5),                        -- 글 답변 들여쓰기
    sale_no number(20)								-- 주문 번호
);