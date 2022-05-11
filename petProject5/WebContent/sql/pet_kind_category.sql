-- 품종 카테고리 테이블
create table pet_kind_category(
   category_num number(5) primary key,      -- 품종 카테고리 번호
   category_code varchar2(10) not null,   -- 품종 카테고리 코드
   category_name varchar2(100) not null   -- 품종 카테고리 이름