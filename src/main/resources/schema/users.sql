create table if not exists users
(
    id        bigint       not null
        primary key,
    password  varchar(255) null,
    roles     varchar(255) null,
    user_name varchar(255) null
);

create table if not exists users_SEQ
(
    next_val bigint null
);

insert into users_SEQ (next_val) values (1);