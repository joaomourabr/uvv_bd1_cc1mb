DROP DATABASE IF EXISTS uvv;

DROP USER IF EXISTS "JoaoM";

CREATE USER JoaoM WITH
  CREATEDB
  CREATEROLE
  PASSWORD '22112003';

CREATE DATABASE uvv
  OWNER JoaoM
  TEMPLATE template0
  ENCODING 'UTF8'
  LC_COLLATE 'pt_BR.UTF-8'
  LC_CTYPE 'pt_BR.UTF-8'
  CONNECTION LIMIT -1;
  

CREATE SCHEMA lojas;

SELECT CURRENT_SCHEMA();

SET SEARCH_PATH TO lojas, "$user", public;

ALTER USER JoaoM SET SEARCH_PATH TO lojas, "$user", public;

SET SESSION AUTHORIZATION computacao@raiz;


CREATE TABLE produtos (
    produto_id NUMERIC(38) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    preco_unitario NUMERIC(10,2),
    detalhes BYTEA,
    imagem BYTEA,
    imagem_mime_type VARCHAR(512),
    imagem_arquivo VARCHAR(512),
    imagem_charset VARCHAR(512),
    imagem_ultima_atualizacao DATE,
    CONSTRAINT produto_id PRIMARY KEY (produto_id)
);
COMMENT ON TABLE produtos IS 'Tabela sobre os produtos vendidos na loja';
COMMENT ON COLUMN produtos.produto_id IS 'PK da tabela. Número de ID de cada produto vendido nas lojas';
COMMENT ON COLUMN produtos.nome IS 'Nome de cada produto vendido na loja';
COMMENT ON COLUMN produtos.preco_unitario IS 'Preço de cada produto vendido na loja';
COMMENT ON COLUMN produtos.detalhes IS 'O BLOB que representa os detalhes de cada produto';
COMMENT ON COLUMN produtos.imagem IS 'O BLOB da imagem do produto na loja ou site da loja';
COMMENT ON COLUMN produtos.imagem_mime_type IS 'O tipo de MIME que a imagem tem';
COMMENT ON COLUMN produtos.imagem_arquivo IS 'O nome do arquivo que a imagem dos produtos está';
COMMENT ON COLUMN produtos.imagem_charset IS 'Charset da imagem do produto';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'A data da ultima atualização que a imagem do produto teve';

CREATE TABLE clientes (
    cliente_id NUMERIC(38) NOT NULL,
    email VARCHAR(255) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    telefone_1 VARCHAR(20),
    telefone_2 VARCHAR(20),
    telefone_3 VARCHAR(20),
    CONSTRAINT cliente_id PRIMARY KEY (cliente_id)
);
COMMENT ON TABLE clientes IS 'Tabela com os dados dos clientes cadastrados nas lojas';
COMMENT ON COLUMN clientes.cliente_id IS 'Primary Key da tabela. Mostra o numero de identificação  dos clientes registrados na tabela';
COMMENT ON COLUMN clientes.email IS 'Email de contato dos clientes';
COMMENT ON COLUMN clientes.nome IS 'Nome de cada cliente';
COMMENT ON COLUMN clientes.telefone_1 IS 'Opção número 1 de telefone do cliente';
COMMENT ON COLUMN clientes.telefone_2 IS 'Opção número 2 de telefone do cliente';
COMMENT ON COLUMN clientes.telefone_3 IS 'Opção número 3 de telefone do cliente';

CREATE TABLE lojas (
    loja_id NUMERIC(38) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    endereco_web VARCHAR(100),
    endereco_fisico VARCHAR(512),
    latitude NUMERIC,
    longitude NUMERIC,
    logo BYTEA,
    logo_mime_type VARCHAR(512),
    logo_arquivo VARCHAR(512),
    logo_charset VARCHAR(512),
    logo_ultima_atualizacao DATE,
    CONSTRAINT loja_id PRIMARY KEY (loja_id)
);
COMMENT ON TABLE lojas IS 'Tabela sobre as lojas registradas';
COMMENT ON COLUMN lojas.loja_id IS 'PK da tabela. Número de ID de cada loja registrada';
COMMENT ON COLUMN lojas.nome IS 'Nome da cada Loja registrada';
COMMENT ON COLUMN lojas.endereco_web IS 'O endereço web do site da loja';
COMMENT ON COLUMN lojas.endereco_fisico IS 'O endereço físico da loja, como rua, bairro, etc.';
COMMENT ON COLUMN lojas.latitude IS 'Número da localização geográfica por latitude de cada loja';
COMMENT ON COLUMN lojas.longitude IS 'Número da localização geográfica por longitude de cada loja';
COMMENT ON COLUMN lojas.logo IS 'O Binary Large Object que corresponde ao Logo da loja';
COMMENT ON COLUMN lojas.logo_mime_type IS 'O tipo de valor que o MIME da logo tem';
COMMENT ON COLUMN lojas.logo_arquivo IS 'O nome do arquivo onde está a logo';
COMMENT ON COLUMN lojas.logo_charset IS 'O ChARSET do logo da loja';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao IS 'Data de quando a última alteração da logo foi feita';

CREATE TABLE estoques (
    estoque_id NUMERIC(38) NOT NULL,
    loja_id NUMERIC(38) NOT NULL,
    produto_id NUMERIC(38) NOT NULL,
    quantidade NUMERIC(38) NOT NULL,
    CONSTRAINT estoque_id PRIMARY KEY (estoque_id)
);
COMMENT ON TABLE estoques IS 'Tabela sobre os estoques da loja';
COMMENT ON COLUMN estoques.estoque_id IS 'Número de ID do estoque da loja';
COMMENT ON COLUMN estoques.loja_id IS 'FK da tabela lojas. Mostra o número de ID de qual loja esse estoque estoque é';
COMMENT ON COLUMN estoques.produto_id IS 'FK da tabela produtos. Número de ID de cada produto no estoque';
COMMENT ON COLUMN estoques.quantidade IS 'Número da quantidade de produtos tem naquele estoque';

CREATE TABLE envios (
    envio_id NUMERIC(38) NOT NULL,
    loja_id NUMERIC(38) NOT NULL,
    cliente_id NUMERIC(38) NOT NULL,
    endereco_entrega VARCHAR(512) NOT NULL,
    status VARCHAR(15) NOT NULL,
    CONSTRAINT envio_id PRIMARY KEY (envio_id)
);
COMMENT ON TABLE envios IS 'Tabela sobre o envio de produtos';
COMMENT ON COLUMN envios.envio_id IS 'PK da tabela. Número de ID do envio do produto pela loja';
COMMENT ON COLUMN envios.loja_id IS 'FK da tabela lojas. Número de ID de qual loja o produto foi enviado';
COMMENT ON COLUMN envios.cliente_id IS 'FK da tabela clientes. Número de ID do cliente registrado na loja para onde o produto foi enviado';
COMMENT ON COLUMN envios.endereco_entrega IS 'Mostra o endereço para onde o produto enviado deve ser entregue';
COMMENT ON COLUMN envios.status IS 'Mostra o status do envio do produto. Se ele foi recebido, recusado, etc.';

CREATE TABLE pedidos (
    pedido_id NUMERIC(38) NOT NULL,
    data_hora TIMESTAMP NOT NULL,
    cliente_id NUMERIC(38) NOT NULL,
    status VARCHAR(15) NOT NULL,
    loja_id NUMERIC(38) NOT NULL,
    CONSTRAINT pedido_id PRIMARY KEY (pedido_id)
);
COMMENT ON TABLE pedidos IS 'Tabela sobre os pedidos dos clientes às lojas';
COMMENT ON COLUMN pedidos.pedido_id IS 'Primary Key da tabela. Mostra o número de identificação dos pedidos de cada cliente';
COMMENT ON COLUMN pedidos.data_hora IS 'Data e a hora em que o pedido do cliente foi realizado';
COMMENT ON COLUMN pedidos.cliente_id IS 'Foreign Key da tabela clientes. Mostra o número de ID do cliente que fez o pedido';
COMMENT ON COLUMN pedidos.status IS 'Status de envio do pedido do cliente. Se foi enviado, está sendo preparado, etc.';
COMMENT ON COLUMN pedidos.loja_id IS 'Foreign Key da tabela lojas. Mostra a ID de qual loja esse pedido foi realizado';

CREATE TABLE pedidos_itens (
    pedido_id NUMERIC(38) NOT NULL,
    produto_id NUMERIC(38) NOT NULL,
    numero_da_linha NUMERIC(38) NOT NULL,
    preco_unitario NUMERIC(10,2) NOT NULL,
    quantidade NUMERIC(38) NOT NULL,
    envio_id NUMERIC(38),
    CONSTRAINT pedido_id PRIMARY KEY (pedido_id, produto_id)
);
COMMENT ON TABLE pedidos_itens IS 'Tabela com os itens pedidos pelos clientes';
COMMENT ON COLUMN pedidos_itens.pedido_id IS 'PFK da tabela pedidos. Mostra o número de qual foi o pedido feito';
COMMENT ON COLUMN pedidos_itens.produto_id IS 'PFK da tabela produtos. Número do produto pedido';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 'Número da linha onde o pedido foi feito';
COMMENT ON COLUMN pedidos_itens.preco_unitario IS 'O preço de cada pedido feito na loja';
COMMENT ON COLUMN pedidos_itens.quantidade IS 'A quantidade de produtos pedidos na loja';
COMMENT ON COLUMN pedidos_itens.envio_id IS 'FK da tabela envios. Mostra o número do envio do produto pela loja';

ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
    FOREIGN KEY (produto_id)
    REFERENCES produtos (produto_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
    FOREIGN KEY (produto_id)
    REFERENCES produtos (produto_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
    FOREIGN KEY (cliente_id)
    REFERENCES clientes (cliente_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
    FOREIGN KEY (cliente_id)
    REFERENCES clientes (cliente_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
    FOREIGN KEY (loja_id)
    REFERENCES lojas (loja_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
    FOREIGN KEY (loja_id)
    REFERENCES lojas (loja_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
    FOREIGN KEY (loja_id)
    REFERENCES lojas (loja_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
    FOREIGN KEY (envio_id)
    REFERENCES envios (envio_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
    FOREIGN KEY (pedido_id)
    REFERENCES pedidos (pedido_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE pedidos
    ADD CONSTRAINT status_pedido_check CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));
    
ALTER TABLE envios
     ADD CONSTRAINT status_envio_check CHECK (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));

ALTER TABLE produtos
     ADD CONSTRAINT preco_negativo_check CHECK (preco_unitario >= 0);
  
ALTER TABLE estoques  
    ADD CONSTRAINT quantidade_negativa_check CHECK (quantidade >= 0);
    
ALTER TABLE  pedidos_itens  
    ADD CONSTRAINT quantidade_negativa_check CHECK (quantidade >= 0);
    ADD CONSTRAINT preco_negativo_check CHECK (preco_unitario >= 0);
  
    
