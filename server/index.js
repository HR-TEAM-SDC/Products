const express = require('express');
const pool = require('../db/connect.js');

const app = express();

app.use(express.json());

app.get('/loaderio-e9f580e8a80c6e044a1cd39a98edd43f', (req, res) => {
  res.send('loaderio-e9f580e8a80c6e044a1cd39a98edd43f');
});

app.get('/products', (req, res) => {
  let page = req.query.page || 1;
  let count = req.query.count || 5;
  pool.query(`SELECT * FROM product LIMIT ${count}`)
    .then(result => {
      res.json(result.rows);
    })
    .catch(err => {
      console.log(err);
      res.send(err.message);
    });
});

app.get('/products/:product_id', (req, res) => {
  const { product_id } = req.params;
  let queryString = `SELECT p.*, json_agg(DISTINCT jsonb_build_object('value', f.value, 'feature', f.feature)) AS features FROM product p LEFT JOIN features f ON f.product_id = p.id WHERE p.id = ${product_id} GROUP BY p.id`;
  pool.query(queryString)
    .then(result => {
      res.header('Content-Type', 'application/json');
      res.send(JSON.stringify(result.rows[0], null, 2));
    })
    .catch(err => {
      console.log(err);
      res.send(err.message);
    });
});

app.get('/products/:product_id/styles', (req, res) => {
  const { product_id } = req.params;
  let result = {
    product_id: product_id,
    results: []
  };
  let queryString = `SELECT s.id AS style_id, s.name, s.original_price, s.sale_price, s.default_style AS default,
  json_agg(DISTINCT jsonb_build_object('url', p.url, 'thumbnail_url', p.thumbnail_url)) as photos,
  json_object_agg(COALESCE(sk.id::VARCHAR, 'null'), jsonb_build_object('size', sk.size, 'quantity', sk.quantity)) as skus
  FROM styles as s
  LEFT JOIN photos as p ON p.styleId = s.id
  LEFT JOIN skus as sk ON sk.styleId = s.id
  WHERE s.productId = ${product_id}
  GROUP BY s.id`;

  pool.query(queryString)
    .then(data => {
      result.results = data.rows;
      res.header('Content-Type', 'application/json');
      res.send(JSON.stringify(result, null, 2));
    })
    .catch(err => {
      console.log(err);
      res.send(err.message);
    });
});

app.get('/products/:product_id/related', (req, res) => {
  const { product_id } = req.params;
  let queryString = `SELECT ARRAY (SELECT related_product_id FROM related WHERE related.current_product_id = ${product_id})`;
  pool.query(queryString)
    .then(data => {
      res.header('Content-Type', 'application/json');
      res.send(data.rows[0]['array']);
    })
    .catch(err => {
      console.log(err);
      res.send(err.message);
    });
});

const port = 3000;
app.listen(port, () => {
  console.log(`Listening on port ${port}`);
});
