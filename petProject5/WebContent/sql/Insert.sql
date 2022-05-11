-- 품종 카테고리 insert SQL문
insert into pet_kind_category 
	values(0, 'P0000000', '전체');

insert into pet_kind_category 
	values(1, 'P0000001', '닥스훈트');
	
insert into pet_kind_category 
	values(2, 'P0000002', '말티즈');
	
insert into pet_kind_category 
	values(3, 'P0000003', '슈나우저');
	
insert into pet_kind_category 
	values(4, 'P0000004', '비숑프리제');
	
insert into pet_kind_category 
	values(5, 'P0000005', '시츄');
	
insert into pet_kind_category 
	values(6, 'P0000006', '요크셔테리어');
	
insert into pet_kind_category 
	values(7, 'P0000007', '포메라니안');
	
insert into pet_kind_category 
	values(8, 'P0000008', '푸들');
	
insert into pet_kind_category 
	values(9, 'P0000009', '프렌치불독');
	
-- 상품 카테고리 insert SQL문
insert into pet_product_category
	values(1, 'E0000001', '사료');
	
insert into pet_product_category
	values(2, 'E0000002', '스틱 및 개껌');
	
insert into pet_product_category
	values(3, 'E0000003', '비스킷');
	
insert into pet_product_category
	values(4, 'E0000004', '육포 및 어포');
	
insert into pet_product_category
	values(5, 'E0000005', '캔');
	
insert into pet_product_category
	values(6, 'E0000006', '트릿');
	
insert into pet_product_category
	values(7, 'E0000007', '펫밀크');
	
-- 결제 태이블 insert 문
insert into pet_sales
	values(1, 'eun1234', 000000000001, '은종엽', '010-2521-3804', '서울시 강서구 등촌로', 1, 
			'주빼 바닐라 비스킷 700g', '주빼 바닐라 비스킷.jpg', 10500, 1, 3000, '카드', '빨리오세요', 105, sysdate);
insert into pet_sales
	values(2, 'hhe2011', 000000000002, '은혜현', '010-4747-3804', '하남시 위례중앙로', 1, 
			'주빼 바닐라 비스킷 700g', '주빼 바닐라 비스킷.jpg', 10500, 3, 3000, '현금', '문앞에 놔주세요', 105, sysdate);
insert into pet_sales
	values(3, 'dlrudals123', 000000000003, '이경민', '010-4133-2897', '서울시 양천구 목동중앙북로', 1, 
			'주빼 바닐라 비스킷 700g', '주빼 바닐라 비스킷.jpg', 10500, 8, 3000, '카드', '전화주세요', 105, '22/05/19');
insert into pet_sales
	values(4, 'ehfpal13579', 000000000004, '도레미', '010-5620-6264', '서울시 중구 명동', 2, 
			'로얄캐닌 초대형견사료 맥시 (어덜트/10kg)', '초대형견 사료15.PNG', 89000, 1, 3000, '카드', '', 890, '22/06/18');
insert into pet_sales
	values(5, 'gamer151', 000000000005, '이승훈', '010-8916-6512', '충주시 단월동', 2, 
			'로얄캐닌 초대형견사료 맥시 (어덜트/10kg)', '초대형견 사료15.PNG', 89000, 4, 3000, '카드', '조심히 오세요', 890, '22/07/12');
insert into pet_sales
	values(6, 'cus32814', 000000000006, '이지용', '010-4927-3766', '서울시 서초구 방배로', 2, 
			'주빼 바닐라 비스킷 700g', '주빼 바닐라 비스킷.jpg', 10500, 2, 3000, '현금', '취급주의', 105, '22/07/12');
insert into pet_sales
	values(7, 'cus32814', 000000000006, '이지용', '010-4927-3766', '서울시 서초구 방배로', 2, 
			'로얄캐닌 초대형견사료 맥시 (어덜트/10kg)', '초대형견 사료15.PNG', 89000, 2, 3000, '현금', '취급주의', 890, '22/07/12');
	