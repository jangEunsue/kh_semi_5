-- 상품 테이블
create table pet_product(
	p_num number(5) primary key,			-- 상품 번호
	p_name varchar2(70) not null,			-- 상품명
	p_category_fk varchar2(10) not null,	-- 상품 카테고리
	p_age varchar2(10)                      -- 상품 추천 나이
        constraint age_check check(p_age in('전연령','퍼피','어덜트','시니어')),						
	p_kind_fk varchar2(20),					-- 품종 카테고리
	p_wetdry varchar2(10) 					-- 사료유형(건식/습식)
		constraint wetdry_check check(p_wetdry in('전체','건식','습식')),				 	
	p_size varchar2(10) 					-- 추천 크기
		constraint size_check check(p_size in('전체','초소형','소형','중형','대형','초대형')),					
	p_neutering varchar2(10)				-- 중성화 여부
		constraint neutering_check check(p_neutering in('전체','true', 'false')),				
	p_company varchar2(100),				-- 상품 제조사
	p_image varchar2(200),					-- 상품 이미지
	p_price number(10) default 0,			-- 상품 가격
	p_qty number(5) default 0,				-- 상품 수량
	p_spec varchar2(30),					-- 상품 스펙(일반,인기,최신,추천)
	p_content varchar2(1000),				-- 상품 설명
	p_point number(6) default 0,			-- 상품 포인트
	p_inputdate date						-- 상품 입고일
);

-- 상품 카테고리 테이블
create table pet_product_category{
	category_num number(5) primary key,		-- 상품 카테고리 번호
	category_code varchar2(10) not null,	-- 상품 카테고리 코드
	category_name varchar2(100) not null	-- 상품 카테고리 이름
};

-- 품종 카테고리 테이블
create table pet_kind_category{
	category_num number(5) primary key,		-- 품종 카테고리 번호
	category_code varchar2(10) unique not null,	-- 품종 카테고리 코드
	category_name varchar2(100) not null	-- 품종 카테고리 이름
};

-- Q&A 게시판
create table pet_QandA( 
    QA_no number(5) primary key,                --글 번호
    QA_writer varchar2(30) not null,             -- 글 작성자
    QA_title varchar2(100) not null,             -- 제목
    QA_cont varchar2(3000),                      -- 글 내용
    QA_userID varchar2(30) not null,            -- 이용자 아이디
    QA_date date,                               -- 작성일
    QA_update date,                             -- 수정일 
    QA_group number(5) not null,                -- 글 그룹
    QA_step number(5),                          -- 글 답변
    QA_indent number(5)                         --글 들여쓰기
);

-- 회원 테이블
create table pet_member(
    m_num number(7) primary key,     -- 회원번호
    m_id varchar2(30) not null,      -- 회원아이디
    m_pwd varchar2(30) not null,     -- 회원 비밀번호
    m_name varchar2(30) not null,    -- 회원 이름 
    m_birth varchar2(100),               -- 회원 생년월일
    m_email varchar2(200) not null,     -- 회원 이메일
    m_phone varchar2(30) not null,     -- 회원 전화번호
    m_addr varchar2(200),            -- 회원 주소
    m_mileage number(10) not null,   -- 회원 마일리지
    m_regdate date not null          -- 회원 가입일
);

-- 자유게시판
create table pet_free(
   free_no number(5) primary key,      -- 게시판 글 번호
   free_id varchar2(10) not null, 
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

-- 상품 리뷰
create table pet_review(
    review_no number(5) primary key,            -- 리뷰 번호
    pnum number(5) not null,                    -- 상품번호
    review_cont varchar2(100),                  -- 리뷰 내용
    userID varchar2(10) not null,               -- 이용자 아이디 (리뷰 작성자)
    rimage varchar2(100),                       -- 리뷰 이미지
    review_date date,                           -- 작성일
    review_group number(5) not null,            -- 글 그룹
    review_step number(5),                      -- 글 답변
    review_indent number(5),                    -- 글 답변 들여쓰기
    sale_no number(20),							-- 주문 번호
    sale_date date								-- 주문 일자
);

-- 장바구니 테이블
create table pet_cart(
   cart_no number(5) primary key,         --카트 번호
   cart_pno number(5) not null,         --상품 제품 번호
   cart_Id varchar2(30) not null,      --회원 아이디
   cart_pname varchar2(100) not null,      --상품 이름
   cart_pqty number(5) not null,         --상품 수량
   cart_price number(8) not null,         --상품 가격
   cart_pspec varchar2(30) not null,      --상품 정보
   cart_pimage varchar2(500),         --상품 이미지
    cart_point number(8)
);

-- 결제 테이블
create table pet_sales(
   sales_no number(20) primary key,      -- 상품 주문번호
    sales_id varchar2(30) not null,         -- 구매자 아이디
    sales_serial number(30) not null,     --주문 일련번호
    sales_name varchar2(30) not null,       --수령인 이름
   sales_phone varchar2(20) not null,      -- 수령인 연락처
   sales_addr varchar2(200) not null,      -- 수령인 주소
   sales_p_no number(20) not null,          --상품번호
   sales_pname varchar2(100) not null,      -- 상품명
   sales_pimage varchar2(500) not null,   -- 상품 이미지 
   sales_price number(10) not null,      -- 상품 가격
   sales_pqty number(10) not null,         -- 상품 수량
   sales_transcost number(10) not null,   -- 상품 배송비
    sales_payment varchar2(40) not null,   --결제 수단
    sales_comments varchar(200),            --배송메시지
   sales_mileage number(5) not null,      -- 상품 마일리지
   sales_date varchar2(30)                        -- 판매일
);

-- 관리자 정보 테이블
create table admin_pet(
    m_id varchar2(30) not null,      -- 관리자아이디
    m_pwd varchar2(30) not null,     -- 관리자 비밀번호
    m_name varchar2(30) not null,    -- 관리자 이름 
    m_email varchar2(200) not null,  -- 관리자 이메일
    m_regdate date not null          -- 관리자 등록일
);

-- 공지사항 테이블
create table pet_notice(
   notice_no number(5) primary key,      -- 공지사항 글 번호
   notice_writer varchar2(30) not null,  -- 공지사항 글 작성자
   notice_title varchar2(1000) not null, -- 공지사항 글 제목
   notice_cont varchar2(2000) not null,  -- 공지사항 글 내용
   notice_pwd varchar2(30) not null,     -- 공지사항 글 비밀번호
   notice_hit number(10) default 0,      -- 공지사항 글 조회수
   notice_date date,                     -- 공지사항 글 작성일자
   notice_update date,                   -- 공지사항 글 수정일자
   notice_group number(5),               -- 공지사항 글 그룹
   notice_step number(5),                -- 공지사항 글 답변 단계
   notice_indent number(5)               -- 공지사항 답변글 들여쓰기
);
