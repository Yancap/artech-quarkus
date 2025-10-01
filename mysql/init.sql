CREATE SCHEMA IF NOT EXISTS artech;

USE artech;

DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS credits;
DROP TABLE IF EXISTS articles_tags;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS articles;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS managements;


CREATE TABLE categories (
  id bigint NOT NULL AUTO_INCREMENT,
  category varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
);


CREATE TABLE users (
  id bigint NOT NULL AUTO_INCREMENT,
  email varchar(255) DEFAULT NULL,
  name varchar(255) DEFAULT NULL,
  password varchar(255) DEFAULT NULL,
  urlAvatar varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE managements (
  id bigint NOT NULL AUTO_INCREMENT,
  email varchar(255) DEFAULT NULL,
  name varchar(255) DEFAULT NULL,
  password varchar(255) DEFAULT NULL,
  role varchar(255) DEFAULT NULL,
  url_avatar varchar(255) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY UK3okmvakw3dritp4c3275sj90c (email)
);

CREATE TABLE articles (
  category_id bigint DEFAULT NULL,
  created_at datetime(6) DEFAULT NULL,
  id bigint NOT NULL AUTO_INCREMENT,
  manager_id bigint DEFAULT NULL,
  updated_at datetime(6) DEFAULT NULL,
  current_state varchar(255) DEFAULT NULL,
  image_url varchar(255) DEFAULT NULL,
  slug varchar(255) DEFAULT NULL,
  subtitle varchar(255) DEFAULT NULL,
  text varchar(255) DEFAULT NULL,
  title varchar(255) DEFAULT NULL,
  PRIMARY KEY (id),
  KEY FK7i4rryg7kqwyyrr08temnc71e (category_id),
  KEY FKca8y1ipm11dpjn9mjvrrnpgs3 (manager_id),
  CONSTRAINT FK7i4rryg7kqwyyrr08temnc71e FOREIGN KEY (category_id) REFERENCES categories (id),
  CONSTRAINT FKca8y1ipm11dpjn9mjvrrnpgs3 FOREIGN KEY (manager_id) REFERENCES managements (id) ON DELETE CASCADE
);

CREATE TABLE articles_tags (
  article_id bigint NOT NULL,
  tag_id bigint NOT NULL,
  PRIMARY KEY (article_id,tag_id)
);


CREATE TABLE comments (
  article_id bigint DEFAULT NULL,
  created_at datetime(6) DEFAULT NULL,
  id bigint NOT NULL AUTO_INCREMENT,
  user_id bigint DEFAULT NULL,
  text varchar(255) DEFAULT NULL,
  PRIMARY KEY (id),
  KEY FKk4ib6syde10dalk7r7xdl0m5p (article_id),
  KEY FK8omq0tc18jd43bu5tjh6jvraq (user_id),
  CONSTRAINT FK8omq0tc18jd43bu5tjh6jvraq FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT FKk4ib6syde10dalk7r7xdl0m5p FOREIGN KEY (article_id) REFERENCES articles (id) ON DELETE CASCADE
);

CREATE TABLE credits (
  article_id bigint DEFAULT NULL,
  id bigint NOT NULL AUTO_INCREMENT,
  link varchar(255) DEFAULT NULL,
  name varchar(255) DEFAULT NULL,
  PRIMARY KEY (id),
  KEY FKoa99g9lqippwlikj9wvki34ir (article_id),
  CONSTRAINT FKoa99g9lqippwlikj9wvki34ir FOREIGN KEY (article_id) REFERENCES articles (id) ON DELETE CASCADE
);


CREATE TABLE tags (
  id bigint NOT NULL AUTO_INCREMENT,
  tag varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
);


INSERT INTO managements (id, email, name, password, role, url_avatar)
	VALUES (1, "yan@email.com", "Yan Gabriel ", "123", "Admin", "");

INSERT INTO managements (id, email,name,password,role,url_avatar)
  VALUES(100, "johndoe@email.com","John Doe","123","Author","");

INSERT INTO users (id, email, name, password, urlAvatar)
  VALUES (100, "usuario@email.com", "John Usuario", "123", "");

INSERT INTO categories (category) VALUES ('front-end');
INSERT INTO categories (category) VALUES ('back-end');
INSERT INTO categories (category) VALUES ('mobile');

-- front-end: category_id = 1
INSERT INTO articles (category_id, created_at, updated_at, manager_id, current_state, image_url, slug, subtitle, text, title)
VALUES (1, NOW(), NOW(), 100, 'draft', '', 'front-article-1', 'Intro to Frontend', 'Content 1', 'Frontend Article 1');

INSERT INTO articles (category_id, created_at, updated_at, manager_id, current_state, image_url, slug, subtitle, text, title)
VALUES (1, NOW(), NOW(), 100, 'active', '', 'front-article-2', 'Advanced Frontend', 'Content 2', 'Frontend Article 2');

-- back-end: category_id = 2
INSERT INTO articles (category_id, created_at, updated_at, manager_id, current_state, image_url, slug, subtitle, text, title)
VALUES (2, NOW(), NOW(), 100, 'active', '', 'back-article-1', 'Intro to Backend', 'Content 3', 'Backend Article 1');

INSERT INTO articles (category_id, created_at, updated_at, manager_id, current_state, image_url, slug, subtitle, text, title)
VALUES (2, NOW(), NOW(), 100, 'disabled', '', 'back-article-2', 'Advanced Backend', 'Content 4', 'Backend Article 2');

-- mobile: category_id = 3
INSERT INTO articles (category_id, created_at, updated_at, manager_id, current_state, image_url, slug, subtitle, text, title)
VALUES (3, NOW(), NOW(), 100, 'active', '', 'mobile-article-1', 'Intro to Mobile', 'Content 5', 'Mobile Article 1');

INSERT INTO articles (category_id, created_at, updated_at, manager_id, current_state, image_url, slug, subtitle, text, title)
VALUES (3, NOW(), NOW(), 100, 'disabled', '', 'mobile-article-2', 'Advanced Mobile', 'Content 6', 'Mobile Article 2');

INSERT INTO credits (article_id, link, name) VALUES (1, 'https://source1.com', 'Author 1');
INSERT INTO credits (article_id, link, name) VALUES (2, 'https://source2.com', 'Author 2');
INSERT INTO credits (article_id, link, name) VALUES (3, 'https://source3.com', 'Author 3');
INSERT INTO credits (article_id, link, name) VALUES (4, 'https://source4.com', 'Author 4');
INSERT INTO credits (article_id, link, name) VALUES (5, 'https://source5.com', 'Author 5');
INSERT INTO credits (article_id, link, name) VALUES (6, 'https://source6.com', 'Author 6');

-- Criando 10 tags genéricas
INSERT INTO tags (tag) VALUES ('html');
INSERT INTO tags (tag) VALUES ('css');
INSERT INTO tags (tag) VALUES ('javaScript');
INSERT INTO tags (tag) VALUES ('nodejs');
INSERT INTO tags (tag) VALUES ('express');
INSERT INTO tags (tag) VALUES ('reactnative');
INSERT INTO tags (tag) VALUES ('swift');
INSERT INTO tags (tag) VALUES ('kotlin');
INSERT INTO tags (tag) VALUES ('sql');
INSERT INTO tags (tag) VALUES ('api');

-- article_id = 1 (Frontend)
INSERT INTO articles_tags (article_id, tag_id) VALUES (1, 1);
INSERT INTO articles_tags (article_id, tag_id) VALUES (1, 2);
INSERT INTO articles_tags (article_id, tag_id) VALUES (1, 3);

-- article_id = 2 (Frontend)
INSERT INTO articles_tags (article_id, tag_id) VALUES (2, 3);
INSERT INTO articles_tags (article_id, tag_id) VALUES (2, 9);
INSERT INTO articles_tags (article_id, tag_id) VALUES (2, 10);

-- article_id = 3 (Backend)
INSERT INTO articles_tags (article_id, tag_id) VALUES (3, 4);
INSERT INTO articles_tags (article_id, tag_id) VALUES (3, 5);
INSERT INTO articles_tags (article_id, tag_id) VALUES (3, 9);

-- article_id = 4 (Backend)
INSERT INTO articles_tags (article_id, tag_id) VALUES (4, 10);
INSERT INTO articles_tags (article_id, tag_id) VALUES (4, 4);
INSERT INTO articles_tags (article_id, tag_id) VALUES (4, 5);

-- article_id = 5 (Mobile)
INSERT INTO articles_tags (article_id, tag_id) VALUES (5, 6);
INSERT INTO articles_tags (article_id, tag_id) VALUES (5, 7);

-- article_id = 6 (Mobile)
INSERT INTO articles_tags (article_id, tag_id) VALUES (6, 8);
INSERT INTO articles_tags (article_id, tag_id) VALUES (6, 6);

-- article_id = 1
INSERT INTO comments (article_id, created_at, user_id, text) VALUES (1, NOW(), 100, 'Comentário 1-1');
INSERT INTO comments (article_id, created_at, user_id, text) VALUES (1, NOW(), 100, 'Comentário 1-2');

-- article_id = 2
INSERT INTO comments (article_id, created_at, user_id, text) VALUES (2, NOW(), 100, 'Comentário 2-1');

-- article_id = 3
INSERT INTO comments (article_id, created_at, user_id, text) VALUES (3, NOW(), 100, 'Comentário 3-1');
INSERT INTO comments (article_id, created_at, user_id, text) VALUES (3, NOW(), 100, 'Comentário 3-2');
INSERT INTO comments (article_id, created_at, user_id, text) VALUES (3, NOW(), 100, 'Comentário 3-3');

-- article_id = 4
INSERT INTO comments (article_id, created_at, user_id, text) VALUES (4, NOW(), 100, 'Comentário 4-1');

-- article_id = 5
INSERT INTO comments (article_id, created_at, user_id, text) VALUES (5, NOW(), 100, 'Comentário 5-1');
INSERT INTO comments (article_id, created_at, user_id, text) VALUES (5, NOW(), 100, 'Comentário 5-2');
INSERT INTO comments (article_id, created_at, user_id, text) VALUES (5, NOW(), 100, 'Comentário 5-3');
INSERT INTO comments (article_id, created_at, user_id, text) VALUES (5, NOW(), 100, 'Comentário 5-4');

-- article_id = 6
INSERT INTO comments (article_id, created_at, user_id, text) VALUES (6, NOW(), 100, 'Comentário 6-1');


