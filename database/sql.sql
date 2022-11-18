
DROP DATABASE lab_vi;
CREATE DATABASE lab_vi;
use lab_vi;

CREATE TABLE clientes(
	id_cliente INT(10) NOT NULL PRIMARY KEY,
	nome_cliente VARCHAR(255) NOT NULL,
	documento VARCHAR(20) NOT NULL,
	razao_social VARCHAR(255) NOT NULL,
	endereco VARCHAR(255) NOT NULL,
	tipo VARCHAR(255) NOT NULL,
	status VARCHAR(255) NOT NULL
);
CREATE TABLE produtos(
	id_produto INT(10) NOT NULL PRIMARY KEY,
	nome_produto VARCHAR(255) NOT NULL,
	valor FLOAT NOT NULL,
	descricao VARCHAR(255) NOT NULL,
	quantidade_estoque INT(10) NOT NULL
);

CREATE TABLE pedidos(
	id_pedido INT(10) NOT NULL PRIMARY KEY,
	id_produto INT(10) NOT NULL,
	id_cliente INT(10) NOT NULL,
	data_pedido DATE NOT NULL,
	data_entrega DATE NOT NULL,
	observacao VARCHAR(255),
	quantidade_produto INT(10) NOT NULL,
	valor_total_pedido FLOAT NOT NULL,
	status VARCHAR(255) NOT NULL,
	CONSTRAINT fk_id_cliente_pedido FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
	CONSTRAINT fk_id_produto_pedido FOREIGN KEY (id_produto) REFERENCES produtos (id_produto)
);


CREATE TABLE carregamentos(
	id_carregamento INT(10) NOT NULL PRIMARY KEY,
	id_pedido INT(10) NOT NULL,
	data_carregamento DATE,
	status VARCHAR(255) NOT NULL,
	CONSTRAINT fk_id_pedido_carregamento FOREIGN KEY (id_pedido) REFERENCES pedidos (id_pedido)
);

CREATE TABLE setores(
	id_setor INT(10) NOT NULL PRIMARY KEY,
	nome_setor VARCHAR(255) NOT NULL,
	descricao VARCHAR(255) NOT NULL
);

CREATE TABLE linhas_producao(
	id_linha_producao INT(10) NOT NULL PRIMARY KEY,
	nome_linha VARCHAR(255) NOT NULL,
	id_produto INT(10) NOT NULL,
	id_setor INT(10) NOT NULL,
	CONSTRAINT fk_id_produto_linha FOREIGN KEY (id_produto) REFERENCES produtos (id_produto),
	CONSTRAINT fk_id_setor_linha FOREIGN KEY (id_setor) REFERENCES setores (id_setor)
);

CREATE TABLE maquinas(
	id_maquina INT(10) NOT NULL PRIMARY KEY,
	id_linha_producao INT(10) NOT NULL,
	nome_maquina VARCHAR(255) NOT NULL,
	descricao VARCHAR(255) NOT NULL,
	status VARCHAR(255) NOT NULL,
	CONSTRAINT fk_id_linha_producao_maquina FOREIGN KEY (id_linha_producao) REFERENCES linhas_producao (id_linha_producao)
);

CREATE TABLE funcionarios(
	id_funcionario INT(10) NOT NULL PRIMARY KEY,
	nome_funcionario VARCHAR(255) NOT NULL,
	id_setor INT(10) NOT NULL,
	cpf VARCHAR(20) NOT NULL,
	data_nascimento DATE NOT NULL,
	data_contratacao DATE NOT NULL,
	salario FLOAT NOT NULL,
	status VARCHAR(255) NOT NULL,
	CONSTRAINT fk_id_setor_funcionario FOREIGN KEY (id_setor) REFERENCES setores (id_setor)
);


-- INSERTS

select * from clientes;
INSERT INTO clientes VALUES (1, 'VICTORIA', 1312321312, 'VICTORIA MINAS', 'RUA DAS FLORES', 'JURIDICO', 'ATIVO');
INSERT INTO clientes VALUES (2, 'PEDRO', 1312321315, 'PEDRO MINAS', 'RUA DAS ROSAS', 'JURIDICO', 'ATIVO');
INSERT INTO clientes VALUES (3, 'JOAO', 48464545684, 'JOAO MINAS', 'RUA DAS ALELUIAS', 'JURIDICO', 'ATIVO');
INSERT INTO clientes VALUES (4, 'MARCIA', 2343243232, 'MARCIA DO CORTE', 'RUA DOS CACTOS', 'JURIDICO', 'INATIVO');
INSERT INTO clientes VALUES (5, 'ROGERIA', 34543634637, 'REG', 'RUA DOS DEUSES', 'FISICO', 'ATIVO');

INSERT INTO produtos VALUES (1, 'CELULAR 1', 1000.00, '256GB 8GB 5G', 1000);
INSERT INTO produtos VALUES (2, 'CELULAR 2', 2000.00, '256GB 10GB 5G', 1000);
INSERT INTO produtos VALUES (3, 'CELULAR 3', 3000.00, '256GB 12GB 5G', 1000);
INSERT INTO produtos VALUES (4, 'CELULAR 4', 1500.00, '128GB 6GB 5G', 1000);
INSERT INTO produtos VALUES (5, 'CELULAR 5', 1000.00, '128GB 8GB 5G', 1000);

INSERT INTO pedidos VALUES (1, 1, 1, '2022-08-08', '2022-08-08', 'ENTREGUE DE MANHA', 10, 100000.00, 'FINALIZADO');
INSERT INTO pedidos VALUES (2, 2, 2, '2022-10-15', '2022-10-22', 'ENTREGUE DE MANHA', 10, 200000.00, 'FINALIZADO');
INSERT INTO pedidos VALUES (3, 3, 3, '2022-11-14', '2022-11-21', 'ENTREGUE DE NOITE', 10, 300000.00, 'EM TRANSITO');
INSERT INTO pedidos VALUES (4, 4, 4, '2022-12-10', '2022-12-18', 'ENTREGUE DE TARDE', 10, 400000.00, 'EM TRANSITO');

INSERT INTO carregamentos VALUES (1, 1, '2022-10-15', 'AGUARDANDO');
INSERT INTO carregamentos VALUES (2, 2, '2022-10-15', 'FINALIZADO');
INSERT INTO carregamentos VALUES (3, 3, '2022-10-15', 'EM TRANSITO');
INSERT INTO carregamentos VALUES (4, 4, '2022-10-15', 'FINALIZADO');

INSERT INTO setores VALUES (1, 'MONTAGEM', 'MONTAGEM DOS APARELHOS');
INSERT INTO setores VALUES (2, 'PACOTE', 'EMBALANDO OS APARELHOS');
INSERT INTO setores VALUES (3, 'TESTES', 'TESTANDO OS APARELHOS E OS COMPONENTES');
INSERT INTO setores VALUES (4, 'MANUTENÇÃO', 'MANUTENÇÃO DE APARELHOS E COMPONENTES');

INSERT INTO linhas_producao VALUES (1, 'LINHA 1', 1, 1);
INSERT INTO linhas_producao VALUES (2, 'LINHA 2', 2, 2);
INSERT INTO linhas_producao VALUES (3, 'LINHA 3', 3, 3);
INSERT INTO linhas_producao VALUES (4, 'LINHA 4', 4, 4);

INSERT INTO maquinas VALUES (1, 1, 'ESTEIRA', 'ESTEIRA DA LINHA DE PRODUCAO', 'ATIVA');
INSERT INTO maquinas VALUES (2, 2, 'EMPILHADEIRA', 'EMPILHADEIRA', 'ATIVA');
INSERT INTO maquinas VALUES (3, 3, 'MAQUINA PRINCIPAL', 'PRINCIPAL DA LINHA DE PRODUÇÃO', 'ATIVA');
INSERT INTO maquinas VALUES (4, 4, 'MAQUINA DE EMBALAGEM', 'MAQUINA DE EMBALAGEM DA LINHA DE PRODUCAO', 'ATIVA');

INSERT INTO funcionarios VALUES (1, 'ROBERTO', 1, 1231231232, '1999-01-01', '2022-01-01', 1200, 'ATIVO');
INSERT INTO funcionarios VALUES (2, 'MARCOS', 1, 1212121211, '1989-01-01', '2022-01-01', 1200, 'ATIVO');
INSERT INTO funcionarios VALUES (3, 'CLEYTON', 2, 11111111111, '1987-01-01', '2022-01-01', 1200, 'ATIVO');
INSERT INTO funcionarios VALUES (4, 'JUNIOR', 2, 2222222222, '1986-01-01', '2022-01-01', 1200, 'ATIVO');
INSERT INTO funcionarios VALUES (5, 'MARIA', 3, 33333333333, '1985-01-01', '2022-01-01', 2000, 'ATIVO');
INSERT INTO funcionarios VALUES (6, 'JOANA', 3, 444444444444, '1984-01-01', '2022-01-01', 2000, 'ATIVO');
INSERT INTO funcionarios VALUES (7, 'JOSE', 4, 555555555555, '1973-01-01', '2022-01-01', 1300, 'ATIVO');




mongoimport --uri mongodb+srv://dbuser:dbuser2022x@cluster0.dabvt0d.mongodb.net/lab_vi --collection migration --jsonArray --file clientes.json 