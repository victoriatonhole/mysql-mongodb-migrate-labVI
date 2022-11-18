const fs = require("fs")

let clientes = require('./data/raw/clientes.json');
let pedidos = require('./data/raw/pedidos.json');
let produtos = require('./data/raw/produtos.json');
let linhas_producao = require('./data/raw/linhas_producao.json');
let setores = require('./data/raw/setores.json');
let maquinas = require('./data/raw/maquinas.json');
let funcionarios = require('./data/raw/funcionarios.json');
let carregamentos = require('./data/raw/carregamentos.json');

function load() {
    console.log('-----------------------------------');
    console.log('------------- PEDIDOS -------------');
    console.log('-----------------------------------');

    let collection_pedidos = [];
    pedidos.pedidos.map(pedido => {
        pedido['produto'] = produtos.produtos.find(item => item.id_produto === pedido.id_produto);
        pedido['cliente'] = clientes.clientes.filter(item => item.id_cliente === pedido.id_cliente);
        pedido['carregamento'] = carregamentos.carregamentos.filter(item => item.id_pedido === pedido.id_pedido);
        
        collection_pedidos.push(pedido);

    });

    fs.writeFile('./data/collections/pedidos.json', JSON.stringify(collection_pedidos), (err) => {
        if (err) throw err;
        console.log('pedidos saved!');
    });

    console.log(collection_pedidos);

    console.log('-----------------------------------');
    console.log('------------- SETORES -------------');
    console.log('-----------------------------------');

    let collection_setores = [];
    setores.setores.map(setor => {
        let Linhas = [];
        let Maquinas = [];    
        setor['linhas'] = [];

        Linhas['linhas'] = linhas_producao.linhas_producao.find(item => item.id_setor === setor.id_setor);

        Maquinas = maquinas.maquinas.filter(item => item.id_linha_producao === Linhas['linhas'].id_linha_producao);
        
        Linhas['linhas']['maquinas'] = Maquinas;
        Linhas['linhas']['produtos'] = produtos.produtos.filter(item => item.id_produto === Linhas['linhas'].id_produto);;

        setor['funcionarios'] = funcionarios.funcionarios.filter(item => item.id_setor === setor.id_setor);
        setor['linhas'] = Linhas['linhas'];

        collection_setores.push(setor);
    });

    console.log(collection_setores);

    fs.writeFile('./data/collections/setor.json', JSON.stringify(collection_setores), (err) => {
        if (err) throw err;
        console.log('setor saved!');
    });
}

load();