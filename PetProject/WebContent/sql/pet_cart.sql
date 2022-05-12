create table pet_cart(
	cart_no number(5) primary key,			--카트 번호
	cart_pno number(5) not null,			--상품 제품 번호
	cart_Id varchar2(30) not null,		--회원 아이디
	cart_pname varchar2(100) not null,		--상품 이름
	cart_pqty number(5) not null,			--상품 수량
	cart_price number(8) not null,			--상품 가격
	cart_pcont varchar2(20) not null,		--상품 정보
	cart_pimage varchar2(500)			--상품 이미지
);