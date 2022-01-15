const { Pool } = require('pg');

const pool1 = new Pool({
  host: '54.67.112.18',
  port: 5432,
  user: 'postgres',
  password: 'password',
  database: 'products',
  max: 50,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000
});

const pool2 = new Pool({
  host: '54.193.71.67',
  port: 5432,
  user: 'postgres',
  password: 'password',
  database: 'products',
  max: 50,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000
});

// const pool = new Pool({
//   host: 'localhost',
//   port: 5432,
//   user: 'thha3203',
//   database: 'products',
//   max: 50,
//   idleTimeoutMillis: 30000,
//   connectionTimeoutMillis: 2000
// });

module.exports = {
  pool1: pool1,
  pool2: pool2
};
