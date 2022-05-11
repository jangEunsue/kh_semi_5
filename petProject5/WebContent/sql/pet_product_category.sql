-- 상품 카테고리 테이블
create table pet_product_category(
   category_num number(5) primary key,      -- 상품 카테고리 번호
   category_code varchar2(10) not null,   -- 상품 카테고리 코드
   category_name varchar2(100) not null   -- 상품 카테고리 이름
);