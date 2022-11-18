const dotenv = require('dotenv');
dotenv.config();

const MONGO_URL = String(process.env.MONGO_URL) || '';
const MONGO_DB = String(process.env.MONGO_DB) || '';

module.exports = {
    MONGO_URL,
    MONGO_DB
};