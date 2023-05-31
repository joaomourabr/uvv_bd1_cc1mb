-- Criação do banco de dados 'uvv'
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'uvv')
CREATE DATABASE uvv;
GO

USE uvv;
GO

-- Criação do login 'joaom' com a senha '2211'
IF NOT EXISTS (SELECT name FROM sys.syslogins WHERE name = 'joaom')
CREATE LOGIN joaom WITH PASSWORD = '2211';
GO

-- Criação do usuário 'joaom' associado ao login 'joaom'
IF NOT EXISTS (SELECT name FROM sys.sysusers WHERE name = 'joaom')
CREATE USER joaom FOR LOGIN joaom;
GO

-- Concessão de permissões para o usuário 'joaom' no banco de dados 'uvv'
ALTER ROLE db_owner ADD MEMBER joaom;
GO

-- Criação do esquema 'lojas'
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'lojas')
EXEC('CREATE SCHEMA lojas');
GO

USE uvv;
GO

-- Criação da tabela 'produtos'
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'produtos') AND type in (N'U'))
CREATE TABLE produtos (
    produto_id NUMERIC(38) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    preco_unitario NUMERIC(10,2),
    detalhes VARBINARY(MAX),
    imagem VARBINARY(MAX),
    imagem_mime_type VARCHAR(512),
    imagem_arquivo VARCHAR(512),
    imagem_charset VARCHAR(512),
    imagem_ultima_atualizacao DATE,
    CONSTRAINT pk_produto PRIMARY KEY (produto_id)
);
GO

-- Criação da tabela 'clientes'
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'clientes') AND type in (N'U'))
CREATE TABLE clientes (
    cliente_id NUMERIC(38) NOT NULL,
    email VARCHAR(255) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    telefone_1 VARCHAR(20),
    telefone_2 VARCHAR(20),
    telefone_3 VARCHAR(20),
    CONSTRAINT pk_clientes PRIMARY KEY (cliente_id)
);
GO

-- Criação da tabela 'lojas'
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'lojas') AND type in (N'U'))
CREATE TABLE lojas (
    loja_id NUMERIC(38) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    endereco_web VARCHAR(100),
    endereco_fisico VARCHAR(512),
    latitude NUMERIC,
    longitude NUMERIC,
    logo VARBINARY(MAX),
    logo_mime_type VARCHAR(512),
    logo_arquivo VARCHAR(512),
    logo_charset VARCHAR(512),
    logo_ultima_atualizacao DATE,
    CONSTRAINT pk_loja PRIMARY KEY (loja_id)
);
GO

-- Criação da tabela 'estoques'
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'estoques') AND type in (N'U'))
CREATE TABLE estoques (
    estoque_id NUMERIC(38) NOT NULL,
    loja_id NUMERIC(38) NOT NULL,
    produto_id NUMERIC(38) NOT NULL,
    quantidade NUMERIC(38) NOT NULL,
    CONSTRAINT pk_estoques PRIMARY KEY (estoque_id),
    CONSTRAINT fk_lojas FOREIGN KEY (loja_id) REFERENCES lojas (loja_id),
    CONSTRAINT fk_produtos FOREIGN KEY (produto_id) REFERENCES produtos (produto_id)
);
GO


-- Tabela produtos
ALTER TABLE produtos
    ADD CONSTRAINT preco_negativo_check CHECK (preco_unitario >= 0),
    ADD CONSTRAINT produto_id_check CHECK (produto_id >= 0);

-- Tabela estoques
ALTER TABLE estoques
    ADD CONSTRAINT quantidade_negativa_check CHECK (quantidade >= 0),
    ADD CONSTRAINT estoque_id_check CHECK (estoque_id >= 0),
    ADD CONSTRAINT loja_id2_check CHECK (loja_id >= 0),
    ADD CONSTRAINT produto_id2_check CHECK (produto_id >= 0);

-- Tabela pedidos_itens
ALTER TABLE pedidos_itens
    ADD CONSTRAINT quantidade_negativa2_check CHECK (quantidade >= 0),
    ADD CONSTRAINT preco_negativo2_check CHECK (preco_unitario >= 0),
    ADD CONSTRAINT pedido_id2_check CHECK (pedido_id >= 0),
    ADD CONSTRAINT produto_id3_check CHECK (produto_id >= 0),
    ADD CONSTRAINT envio_id3_check CHECK (envio_id  >= 0);

-- Tabela lojas
ALTER TABLE lojas
    ADD CONSTRAINT endereco_check CHECK (endereco_web IS NOT NULL OR endereco_fisico IS NOT NULL),
    ADD CONSTRAINT loja_id_check CHECK (loja_id >= 0);

-- Tabela pedidos
ALTER TABLE pedidos
    ADD CONSTRAINT status_pedido_check CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO')),
    ADD CONSTRAINT pedido_id_check CHECK (pedido_id >= 0),
    ADD CONSTRAINT cliente_id3_check CHECK (cliente_id >= 0), 
    ADD CONSTRAINT loja_id3_check CHECK (loja_id  >= 0);

-- Tabela envios
ALTER TABLE envios
    ADD CONSTRAINT status_envio_check CHECK (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE')),
    ADD CONSTRAINT envio_id2_check CHECK (envio_id >= 0),
    ADD CONSTRAINT loja_id3_check CHECK (loja_id >= 0),
    ADD CONSTRAINT cliente_id2_check CHECK (cliente_id >= 0);  

-- Tabela clientes
ALTER TABLE clientes
    ADD CONSTRAINT cliente_id_check CHECK (cliente_id >= 0);
