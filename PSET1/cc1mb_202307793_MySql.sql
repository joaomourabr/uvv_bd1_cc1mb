DROP DATABASE IF EXISTS uvv;

DROP USER IF EXISTS joaom;

CREATE USER 'joaom'@'%' IDENTIFIED BY '2211';

CREATE DATABASE uvv;
GRANT ALL PRIVILEGES ON uvv.* TO 'joaom'@'%';


USE uvv;

CREATE TABLE produtos (
    produto_id DECIMAL(38, 0) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    preco_unitario DECIMAL(10, 2),
    detalhes LONGBLOB,
    imagem LONGBLOB,
    imagem_mime_type VARCHAR(512),
    imagem_arquivo VARCHAR(512),
    imagem_charset VARCHAR(512),
    imagem_ultima_atualizacao DATE,
    PRIMARY KEY (produto_id)
);

CREATE TABLE clientes (
    cliente_id DECIMAL(38, 0) NOT NULL,
    email VARCHAR(255) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    telefone_1 VARCHAR(20),
    telefone_2 VARCHAR(20),
    telefone_3 VARCHAR(20),
    PRIMARY KEY (cliente_id)
);

CREATE TABLE lojas (
    loja_id DECIMAL(38, 0) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    endereco_web VARCHAR(100),
    endereco_fisico VARCHAR(512),
    latitude DECIMAL(10, 7),
    longitude DECIMAL(10, 7),
    logo LONGBLOB,
    logo_mime_type VARCHAR(512),
    logo_arquivo VARCHAR(512),
    logo_charset VARCHAR(512),
    logo_ultima_atualizacao DATE,
    PRIMARY KEY (loja_id)
);

CREATE TABLE estoques (
    estoque_id DECIMAL(38, 0) NOT NULL,
    loja_id DECIMAL(38, 0) NOT NULL,
    produto_id DECIMAL(38, 0) NOT NULL,
    quantidade DECIMAL(38, 0) NOT NULL,
    PRIMARY KEY (estoque_id),
    FOREIGN KEY (produto_id) REFERENCES produtos (produto_id),
    FOREIGN KEY (loja_id) REFERENCES lojas (loja_id)
);

CREATE TABLE envios (
    envio_id DECIMAL(38, 0) NOT NULL,
    loja_id DECIMAL(38, 0) NOT NULL,
    cliente_id DECIMAL(38, 0) NOT NULL,
    endereco_entrega VARCHAR(512) NOT NULL,
    status VARCHAR(15) NOT NULL,
    PRIMARY KEY (envio_id),
    FOREIGN KEY (loja_id) REFERENCES lojas (loja_id),
    FOREIGN KEY (cliente_id) REFERENCES clientes (cliente_id)
);

CREATE TABLE pedidos (
    pedido_id DECIMAL(38, 0) NOT NULL,
    data_hora TIMESTAMP NOT NULL,
    cliente_id DECIMAL(38, 0) NOT NULL,
    status VARCHAR(15) NOT NULL,
    loja_id DECIMAL(38, 0) NOT NULL,
    PRIMARY KEY (pedido_id),
    FOREIGN KEY (cliente_id) REFERENCES clientes (cliente_id),
    FOREIGN KEY (loja_id) REFERENCES lojas (loja_id)
);

CREATE TABLE pedidos_itens (
    pedido_id DECIMAL(38, 0) NOT NULL,
    produto_id DECIMAL(38, 0) NOT NULL,
    numero_da_linha DECIMAL(38, 0) NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    quantidade DECIMAL(38, 0) NOT NULL,
    envio_id DECIMAL(38, 0),
    PRIMARY KEY (pedido_id, numero_da_linha),
    FOREIGN KEY (pedido_id) REFERENCES pedidos (pedido_id),
    FOREIGN KEY (produto_id) REFERENCES produtos (produto_id),
    FOREIGN KEY (envio_id) REFERENCES envios (envio_id)
);

ALTER TABLE produtos
    ADD CONSTRAINT preco_negativo_check CHECK (preco_unitario >= 0);

ALTER TABLE estoques
    ADD CONSTRAINT quantidade_negativa_check CHECK (quantidade >= 0);

ALTER TABLE pedidos_itens
    ADD CONSTRAINT quantidade_negativa2_check CHECK (quantidade >= 0),
    ADD CONSTRAINT preco_negativo2_check CHECK (preco_unitario >= 0);

ALTER TABLE lojas
    ADD CONSTRAINT endereco_check CHECK (endereco_web IS NOT NULL OR endereco_fisico IS NOT NULL);

ALTER TABLE pedidos
    ADD CONSTRAINT status_pedido_check CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

ALTER TABLE envios
    ADD CONSTRAINT status_envio_check CHECK (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));
