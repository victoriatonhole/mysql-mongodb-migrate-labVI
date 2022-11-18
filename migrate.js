const mongoConn = require('./connections/mongodb');

const collectionPedidos = require('./data/collections/pedidos.json');
const collectionSetores = require('./data/collections/setor.json');

(async function migrate() {
  try {
    await mongoConn.connect();
    const db = mongoConn.db('lab_vi');
  
    const pedidos = db.collection('pedidos');
    const tvShows = db.collection('setores');
  
    await pedidos.insertMany(collectionPedidos);
    await tvShows.insertMany(collectionSetores);
  } catch (err) {
    console.log(err);
  } finally {
    mongoConn.close();
  }
})();
