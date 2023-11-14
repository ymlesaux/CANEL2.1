const { Pool } = require("pg");

const pool = new Pool({
  user: "ymlesaux",
  database: "CANEL",
  password: "erimel9801",
  port: 5432,
  host: "localhost",
});

module.exports = { pool };
