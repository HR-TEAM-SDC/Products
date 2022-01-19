const { Pool } = require('pg');
// const { createClient } = require('redis');

// const client = createClient({
//   url: 'redis://@18.144.171.187:6379'
// });

// client.connect();

// client.on('connect', () => console.log('Redis connected'));
// client.on('error', (error) => console.log('Redis Error', error));

// const pool1 = new Pool({
//   host: '54.67.112.18',
//   port: 5432,
//   user: 'postgres',
//   password: 'password',
//   database: 'products',
//   max: 50,
//   idleTimeoutMillis: 30000,
//   connectionTimeoutMillis: 2000
// });

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
  pool: pool2
};
