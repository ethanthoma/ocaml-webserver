CREATE TABLE blogs (
    slug        VARCHAR(255) NOT NULL UNIQUE,
    title       VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    content     TEXT NOT NULL,
    date        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (slug)
);

CREATE TABLE tags (
    tag_id      INTEGER PRIMARY KEY AUTOINCREMENT,
    tag_name    VARCHAR(255) NOT NULL UNIQUE
);

INSERT INTO tags (tag_name) VALUES('Nix');
INSERT INTO tags (tag_name) VALUES('Htmx');
INSERT INTO tags (tag_name) VALUES('webdev');
INSERT INTO tags (tag_name) VALUES('Bazel');
INSERT INTO tags (tag_name) VALUES('Pulumi');
INSERT INTO tags (tag_name) VALUES('Turso');

CREATE TABLE blog_tags (
    blog_id     VARCHAR(255) NOT NULL,
    tag_id      INTEGER NOT NULL,
    PRIMARY KEY (blog_id, tag_id),
    FOREIGN KEY (blog_id) REFERENCES blogs(slug) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES tags(tag_id) ON DELETE CASCADE
);
