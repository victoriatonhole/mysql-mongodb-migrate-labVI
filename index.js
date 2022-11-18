const fs = require('fs');

const { clientes } = require('./data/raw/clientes.json');
const { pedidos } = require('./data/raw/pedidos.json');
const { produtos } = require('./data/raw/produtos.json');
const { linhas_producao } = require('./data/raw/linhas-producao.json');
const { setores } = require('./data/raw/setores.json');
const { maquinas } = require('./data/raw/maquinas.json');
const { funcionarios } = require('./data/raw/funcionarios.json');
const { carregamentos } = require('./data/raw/carregamentos.json');

(function load() {
    console.log('\n\n\n\n', '------------- PEDIDOS -------------', '\n\n\n\n');

    const collectionPedidos = pedidos.map((pedido) => ({
        ...pedido,
        produto: produtos.find(item => item.id_produto === pedido.id_produto),
        cliente: clientes.filter(item => item.id_cliente === pedido.id_cliente),
        carregamento: carregamentos.filter(item => item.id_pedido === pedido.id_pedido),
    }));

    fs.writeFile('./data/collections/pedidos.json', JSON.stringify(collectionPedidos), (err) => {
        if (err) throw err;
    });

    console.log(collectionPedidos);

    console.log('\n\n\n\n', '------------- SETORES -------------', '\n\n\n\n');

    const collectionSetores = setores.map((setor) => ({
        ...setor,
        linhas: {
            ...linhas_producao.find(item => item.id_setor === setor.id_setor),
            maquinas: maquinas.filter(item => item.id_linha_producao === linhas_producao
                .find(item => item.id_setor === setor.id_setor)
                .id_linha_producao),
            produtos: produtos.filter(item => item.id_produto === linhas_producao
                .find(item => item.id_setor === setor.id_setor).id_produto),
        },
        funcionarios: funcionarios.filter(item => item.id_setor === setor.id_setor),
    }));

    console.log(collectionSetores);

    fs.writeFile('./data/collections/setor.json', JSON.stringify(collectionSetores), (err) => {
        if (err) throw err;
    });
})();
