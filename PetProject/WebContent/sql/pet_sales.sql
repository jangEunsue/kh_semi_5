create table pet_sales(
	sales_no number(20) primary key,		--상품 주문번호
	sales_Id	varchar2(30) not null,		--구매자 아이디
	sales_phone varchar2(20) not null,
	sales_addr varchar2(200) not null,
	sales_pname varchar2(100) not null,		--상품 제품 번호
	sales_pimage varchar2(500) not null,		--상품 이미지 
	sales_price number(10) not null,		--상품 가격
	sales_pqty number(10) not null,		--상품 수량
	sales_transcost number(10) not null,		--상품 배송비
	sales_mileage number(5) not null,		--상품 마일리지
	sales_date date              				--판매일
);