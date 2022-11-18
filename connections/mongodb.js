const { MONGO_URL } = require('../constants');
const { MongoClient } = require('mongodb');

const mongoConn = new MongoClient(MONGO_URL);

module.exports = mongoConn;