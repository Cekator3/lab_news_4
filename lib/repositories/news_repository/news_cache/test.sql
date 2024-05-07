CREATE TABLE news
(
    id              TEXT   PRIMARY KEY,
    title           TEXT   NOT NULL,
    author          TEXT   NOT NULL,
    published_at    TEXT   NOT NULL,
    content         TEXT   NOT NULL,
    url             TEXT   NOT NULL,
    is_watched      INT    NOT NULL
);
