CREATE TABLE blogs (
    slug        VARCHAR(255) NOT NULL UNIQUE,
    title       VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    content     TEXT NOT NULL,
    date        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tags        TEXT NOT NULL,
    PRIMARY KEY (slug)
);
