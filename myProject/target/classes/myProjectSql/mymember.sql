drop table myMember;
create table myMember(
    memberno number primary key,
    email varchar2(60) unique,
    username varchar2(10) not null,
    pw varchar2(20) not null,
    address varchar2(50) not null,
    sido varchar2(20) not null,
    sigungu varchar2(20) not null,
    sidocode varchar(20) not null,
    sigungucode varchar2(20) not null);
    
create sequence memberno_seq;
