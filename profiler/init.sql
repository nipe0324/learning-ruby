CREATE TABLE users (
    id     serial primary key,
    email  varchar(256) not null unique,
    name   varchar(16)  not null
);

INSERT INTO users (email, name) VALUES ('test1@example.com', 'test1');
INSERT INTO users (email, name) VALUES ('test2@example.com', 'test2');
