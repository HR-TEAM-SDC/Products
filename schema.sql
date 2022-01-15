\c postgres;

-- DROP DATABASE IF EXISTS products;

-- CREATE DATABASE products;

\c products;

-- CREATE TABLE product (
--   id SERIAL PRIMARY KEY,
--   name VARCHAR(500) NOT NULL,
--   slogan TEXT NULL,
--   description TEXT NULL,
--   category VARCHAR(255) NOT NULL,
--   default_price VARCHAR(255) NOT NULL
-- );

-- COPY product(id, name, slogan, description, category, default_price)
-- FROM '/home/ubuntu/data/product.csv'
-- DELIMITER ','
-- CSV HEADER;

CREATE TABLE related (
  id SERIAL PRIMARY KEY,
  current_product_id INT NOT NULL,
  related_product_id INT NOT NULL,
  FOREIGN KEY (current_product_id) REFERENCES product (id)
);

COPY related(id, current_product_id, related_product_id)
FROM '/home/ubuntu/data/related.csv'
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
FROM '/home/ubuntu/data/features.csv'
DELIMITER ','
NULL AS 'null'
CSV HEADER;

CREATE TABLE styles (
  id SERIAL PRIMARY KEY,
  productId INT NOT NULL,
  name VARCHAR(500) NOT NULL,
  sale_price VARCHAR(255) NULL,
  original_price VARCHAR(255) NOT NULL,
  default_style SMALLINT,
  FOREIGN KEY (productId) REFERENCES product (id)
);

COPY styles(id, productId, name, sale_price, original_price, default_style)
FROM '/home/ubuntu/data/styles.csv'
DELIMITER ','
NULL AS 'null'
CSV HEADER;

ALTER TABLE styles ALTER COLUMN default_style DROP DEFAULT;
ALTER TABLE styles ALTER default_style TYPE bool USING CASE WHEN default_style=0 THEN FALSE ELSE TRUE END;
ALTER TABLE styles ALTER COLUMN default_style SET DEFAULT FALSE;

-- CREATE TABLE photos (
--   id SERIAL PRIMARY KEY,
--   styleId INT NOT NULL,
--   url TEXT NULL,
--   thumbnail_url TEXT NULL,
--   FOREIGN KEY (styleId) REFERENCES styles (id)
-- );

-- COPY photos(id, styleId, url, thumbnail_url)
-- FROM '/home/ubuntu/data/photos.csv'
-- DELIMITER ','
-- CSV HEADER;

-- CREATE TABLE skus (
--   id SERIAL PRIMARY KEY,
--   styleId INT NOT NULL,
--   size VARCHAR(50) NOT NULL,
--   quantity INT NOT NULL DEFAULT 0,
--   FOREIGN KEY (styleId) REFERENCES styles (id)
-- );

-- COPY skus(id, styleId, size, quantity)
-- FROM '/home/ubuntu/data/skus.csv'
-- DELIMITER ','
-- CSV HEADER;


-- CREATE INDEX product_id_index ON product (id);
-- CREATE INDEX related_productId_index ON related (current_product_id);
-- CREATE INDEX features_productId_index ON features (product_id);
-- CREATE INDEX styles_id_index ON styles (id);
-- CREATE INDEX styles_productId_index ON styles (productId);
-- CREATE INDEX photos_styleId_index ON photos (styleId);
-- CREATE INDEX skus_styleId_index ON skus (styleId);