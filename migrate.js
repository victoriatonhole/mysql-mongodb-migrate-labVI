const { MONGO_DB } = require('./constants');
const mongoConn = require('./connections/mongodb');

const collection_pedidos = require('./data/collections/pedidos.json');
const collection_setores = require('./data/collections/setor.json');

async function migrate() {
  await mongoConn.connect();
  const db = mongoConn.db('lab_vi');

  const pedidos = db.collection('pedidos');
  const tvShows = db.collection('setores');

  let data = [];
  try {
    data['pedidos'] = await pedidos.insertMany(collection_pedidos);
    data['setores'] = await tvShows.insertMany(collection_setores);
  } catch(err) {
    throw err;
  }
  return data;
}

migrate().then((data) => {
  console.log(data);
}).catch(err => {
  console.log(err);
}).finally(() => {
  mongoConn.close();
});