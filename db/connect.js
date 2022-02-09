const { Pool } = require('pg');
// const { createClient } = require('redis');

// const client = createClient({
//   url: 'redis://@REMOTE_IP_HERE:6379'
// });

// client.connect();

// client.on('connect', () => console.log('Redis connected'));
// client.on('error', (error) => console.log('Redis Error', error));

const pool = new Pool({
  host: 'POSTGRES_DB_IP_HERE',
  port: 5432,
  user: 'DB_USERNAME',
  password: 'USERNAME_PASSWORD',
  database: 'products',
  max: 50,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000
});

module.exports = {
  pool: pool
};
