create table pet_member(
    m_num number(7) primary key,     -- 회원번호
    m_id varchar2(30) not null,      -- 회원아이디
    m_pwd varchar2(30) not null,     -- 회원 비밀번호
    m_name varchar2(30) not null,    -- 회원 이름 
    m_birth varchar2(30),               -- 회원 생년월일
    m_email varchar2(200) not null,     -- 회원 이메일
    m_phone varchar2(30) not null,     -- 회원 전화번호
    m_addr varchar2(200),            -- 회원 주소
    m_mileage number(10) not null,   -- 회원 마일리지
    m_regdate date not null          -- 회원 가입일
);