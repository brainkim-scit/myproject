drop table myAnimal;
drop sequence myAnimal_seq;
create table myAnimal(
    animalNo number primary key,
    email varchar2(60) references myMember(email) on delete cascade,
    desertionNo varchar2(100) unique,
    age varchar2(20),
    careAddr varchar2(200),
    careNm varchar2(50),
    careTel varchar2(50),
    colorCd varchar2(30),
    happenDt varchar2(50),
    happenPlace varchar2(200),
    kindCd varchar2(50),
    processState varchar2(50),
    sexCd varchar2(20),
    specialMark varchar2(200),
    weight varchar2(20),
    neuterYn varchar2(20),
    popfile varchar2(200),
    insertDate date default sysdate
    );

create sequence myAnimal_seq;
