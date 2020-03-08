drop table animalReply;
create table animalReply(
    animalReplyNum number primary key,
    desertionNo varchar2(100),
    email varchar2(60) references myMember(email) on delete cascade,
    username varchar2(10) not null,
    replyContent varchar2(1000) not null,
    replyDate date default sysdate
    );

create sequence animalReply_seq;
