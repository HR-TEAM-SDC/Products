\c postgres;

DROP DATABASE IF EXISTS products;

CREATE DATABASE products;

\c products;

CREATE TABLE product (
  id SERIAL PRIMARY KEY,
  name VARCHAR(500) NOT NULL,
  slogan TEXT NULL,
  description TEXT NULL,
  category VARCHAR(255) NOT NULL,
  default_price INT NOT NULL
);

COPY product(id, name, slogan, description, category, default_price)
FROM '/Users/thha3203/Documents/SDC_Data/productTest.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE related (
  id SERIAL PRIMARY KEY,
  current_product_id INT NOT NULL,
  related_product_id INT NOT NULL,
  FOREIGN KEY (current_product_id) REFERENCES product (id),
  FOREIGN KEY (related_product_id) REFERENCES product (id)
);

COPY related(id, current_product_id, related_product_id)
FROM '/Users/thha3203/Documents/SDC_Data/relatedTest.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE features (
  id SERIAL PRIMARY KEY,
  product_id INT NOT NULL,
  feature VARCHAR(100) NOT NULL,
  value VARCHAR(255) NULL,
  FOREIGN KEY (product_id) REFERENCES product (id)
);

COPY features(id, product_id, feature, value)
FROM '/Users/thha3203/Documents/SDC_Data/featuresTest.csv'
DELIMITER ','
NULL AS 'null'
CSV HEADER;

CREATE TABLE styles (
  id SERIAL PRIMARY KEY,
  productId INT NOT NULL,
  name VARCHAR(500) NOT NULL,
  sale_price INT NULL DEFAULT 0,
  original_price INT NULL DEFAULT 0,
  default_style SMALLINT DEFAULT 0,
  FOREIGN KEY (productId) REFERENCES product (id)
);

COPY styles(id, productId, name, sale_price, original_price, default_style)
FROM '/Users/thha3203/Documents/SDC_Data/stylesTest.csv'
DELIMITER ','
NULL AS 'null'
CSV HEADER;

CREATE TABLE photos (
  id SERIAL PRIMARY KEY,
  styleId INT NOT NULL,
  url TEXT NULL,
  thumbnail_url TEXT NULL,
  FOREIGN KEY (styleId) REFERENCES styles (id)
);

COPY photos(id, styleId, url, thumbnail_url)
FROM '/Users/thha3203/Documents/SDC_Data/photosTest.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE skus (
  id SERIAL PRIMARY KEY,
  styleId INT NOT NULL,
  size VARCHAR(50) NOT NULL,
  quantity INT NOT NULL DEFAULT 0,
  FOREIGN KEY (styleId) REFERENCES styles (id)
);

COPY skus(id, styleId, size, quantity)
FROM '/Users/thha3203/Documents/SDC_Data/skusTest.csv'
DELIMITER ','
CSV HEADER;