-- 상품 테이블
create table pet_product(
   p_num number(5) primary key,         -- 상품 번호
   p_name varchar2(50) not null,         -- 상품명
   p_category_fk varchar2(10) not null,   -- 상품 카테고리 //카테고리 코드로 들어감
   p_age varchar2(10)                      -- 상품 추천 나이
        constraint age_check check(p_age in('전연령','퍼피','어덜트','시니어')),                  
   p_kind_fk varchar2(20),               -- 품종 카테고리
   p_wetdry varchar2(10)                -- 사료유형(건식/습식)
      constraint wetdry_check check(p_wetdry in('전체','건식','습식')),                
   p_size varchar2(10)                -- 추천 크기
      constraint size_check check(p_size in('전체','초소형','소형','중형','대형','초대형')),               
   p_neutering varchar2(10)            -- 중성화 여부
      constraint neutering_check check(p_neutering in('전체','true', 'false')),            
   p_company varchar2(100),            -- 상품 제조사
   p_image varchar2(200),               -- 상품 이미지
   p_price number(10) default 0,         -- 상품 가격
   p_qty number(5) default 0,            -- 상품 수량
   p_spec varchar2(30),               -- 상품 스펙(일반,인기,최신,추천)
   p_content varchar2(1000),            -- 상품 설명
   p_point number(6) default 0,         -- 상품 포인트
   p_inputdate date                  -- 상품 입고일
);