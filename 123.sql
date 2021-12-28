--데이터 초기화
drop table member cascade constraints;
drop table category1 cascade constraints;
drop sequence seq_category1;
drop table category2 cascade constraints;
drop sequence seq_category2;
drop table category3 cascade constraints;
drop sequence seq_category3;
drop table product cascade constraints;
drop sequence seq_product;
drop table comments cascade constraints;
drop sequence seq_comment;
drop table wish cascade constraints;
drop sequence seq_wish;
drop table notice;
drop sequence seq_notice;
drop table review cascade constraints;
drop sequence seq_review;

--멤버 테이블
create table member(id varchar2(50) primary key,
		   pwd varchar2(20) not null,
		   name varchar2(20) not null,
		   tel varchar2(20) not null,
		   addr number not null,
		   nick varchar2(50) not null,
		   type number not null,
		   rate number not null);

--대분류 테이블
create table category1(
             category1_num number primary key,
		     category1_name varchar2(20) not null);

create sequence seq_category1;

--중분류 테이블
create table category2( category2_num number primary key,
		     category2_name varchar2(20) not null,
		     parent_category_num number,
             constraint category2_cate1_fk foreign key(parent_category_num) references category1(category1_num) on delete cascade);
            
create sequence seq_category2;

--소분류 테이블
create table category3(category3_num number  primary key,
		     category3_name varchar2(20) not null,
		     parent_category_num number,
             constraint category3_cate2_fk foreign key(parent_category_num) references category2(category2_num) on delete cascade);

create sequence seq_category3;

--제품 테이블
create table product(product_num number primary key,
		  product_writer varchar2(50),
		  title varchar2(50) not null,
		  price number not null, 
		  content varchar2(50),
		  category_1 number not null,
		  category_2 number not null,
		  category_3 number not null,
		  type number default 0 ,
		  product_date date not null,	
		  product_hit number default 0,
          constraint pro_writer_fk foreign key(product_writer) references member(id) on delete cascade,
          constraint pro_cate_1_fk foreign key(category_1) references category1(category1_num),
          constraint pro_cate_2_fk foreign key(category_2) references category2(category2_num),
          constraint pro_cate_3_fk foreign key(category_3) references category3(category3_num));
          
create sequence seq_product;

--찜목록 테이블
create table wish(wish_num number primary key,
	          product_num number,
	          member_id varchar2(50),
              constraint wish_pro_fk foreign key(product_num) references product(product_num)  on delete cascade,
              constraint wish_mem_fk foreign key(member_id) references member(id)  on delete cascade);
	
create sequence seq_wish;

--댓글 테이블
create table comments( comment_num number primary key,
		product_num number,
		member_id varchar2(50),
		comments_date date not null,
		comments_content varchar2(500) not null,
		top_comment_num number,
        constraint comment_pro_fk foreign key(product_num) references product(product_num)  on delete cascade,
        constraint comment_mem_fk foreign key(member_id) references member(id)  on delete cascade);

create sequence seq_comment;



--후기 테이블
create table review(review_num number  primary key,
		    member_id varchar2(50),
		    product_id varchar2(50),
		    star number  not null,
		    review_content varchar2(200) not null,
		    review_date date not null,
            constraint review_mem_fk foreign key(member_id) references member(id)  on delete cascade,
            constraint review_pro_fk foreign key(product_id) references member(id)  on delete cascade);
create sequence seq_review;

--공지 테이블
create table notice(notice_num number primary key,
		notice_title varchar2(50) not null,
		notice_content varchar2(500) not null,
		notice_date date);
create sequence seq_notice;

commit;

수정

2차 수정