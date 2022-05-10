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
    sales_payment varchar2(20) not null,   --결제 수단
    sales_comments varchar(200),            --배송메시지
   sales_mileage number(5) not null,      -- 상품 마일리지
   sales_date varchar2(30)                        -- 판매일
);