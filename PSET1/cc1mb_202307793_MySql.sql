DROP DATABASE IF EXISTS uvv;

DROP USER IF EXISTS joaom;

CREATE USER 'joaom'@'%' IDENTIFIED BY '2211';

CREATE DATABASE uvv;
GRANT ALL PRIVILEGES ON uvv.* TO 'joaom'@'%';


USE uvv;


CREATE TABLE produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes LONGBLOB,
                imagem LONGBLOB,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                PRIMARY KEY (produto_id)
);

ALTER TABLE produtos COMMENT 'Tabela sobre os produtos vendidos na loja';

ALTER TABLE produtos MODIFY COLUMN produto_id NUMERIC(38) COMMENT 'PK da tabela. Número de ID de cada produto vendido nas lojas';

ALTER TABLE produtos MODIFY COLUMN nome VARCHAR(255) COMMENT 'Nome de cada produto vendido na loja';

ALTER TABLE produtos MODIFY COLUMN preco_unitario NUMERIC(10, 2) COMMENT 'Preço de cada produto vendido na loja';

ALTER TABLE produtos MODIFY COLUMN detalhes BLOB COMMENT 'O BLOB que representa os detalhes de cada produto';

ALTER TABLE produtos MODIFY COLUMN imagem BLOB COMMENT 'O BLOB da imagem do produto na loja ou site da loja';

ALTER TABLE produtos MODIFY COLUMN imagem_mime_type VARCHAR(512) COMMENT 'O tipo de MIME que a imagem tem';

ALTER TABLE produtos MODIFY COLUMN imagem_arquivo VARCHAR(512) COMMENT 'O nome do arquivo que a imagem dos produtos está';

ALTER TABLE produtos MODIFY COLUMN imagem_charset VARCHAR(512) COMMENT 'Charset da imagem do produto';

ALTER TABLE produtos MODIFY COLUMN imagem_ultima_atualizacao DATE COMMENT 'A data da ultima atualização que a imagem do produto teve';


CREATE TABLE clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone_1 VARCHAR(20),
                telefone_2 VARCHAR(20),
                telefone_3 VARCHAR(20),
                PRIMARY KEY (cliente_id)
);

ALTER TABLE clientes COMMENT 'Tabela com os dados dos clientes cadastrados nas lojas';

ALTER TABLE clientes MODIFY COLUMN cliente_id NUMERIC(38) COMMENT ' clientes registrados na tabela';

ALTER TABLE clientes MODIFY COLUMN email VARCHAR(255) COMMENT 'Email de contato dos clientes';

ALTER TABLE clientes MODIFY COLUMN nome VARCHAR(255) COMMENT 'Nome de cada cliente';

ALTER TABLE clientes MODIFY COLUMN telefone_1 VARCHAR(20) COMMENT 'Opção número 1 de telefone do cliente';

ALTER TABLE clientes MODIFY COLUMN telefone_2 VARCHAR(20) COMMENT 'Opção número 2 de telefone do cliente';

ALTER TABLE clientes MODIFY COLUMN telefone_3 VARCHAR(20) COMMENT 'Opção número 3 de telefone do cliente';


CREATE TABLE lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo LONGBLOB,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                PRIMARY KEY (loja_id)
);

ALTER TABLE lojas COMMENT 'Tabela sobre as lojas registradas';

ALTER TABLE lojas MODIFY COLUMN loja_id NUMERIC(38) COMMENT 'PK da tabela. Número de ID de cada loja registrada';

ALTER TABLE lojas MODIFY COLUMN nome VARCHAR(255) COMMENT 'Nome da cada Loja registrada';

ALTER TABLE lojas MODIFY COLUMN endereco_web VARCHAR(100) COMMENT 'O endereço web do site da loja';

ALTER TABLE lojas MODIFY COLUMN endereco_fisico VARCHAR(512) COMMENT 'O endereço físico da loja, como rua, bairro, etc.';

ALTER TABLE lojas MODIFY COLUMN latitude NUMERIC COMMENT 'Número da localização geográfica por latitude de cada loja';

ALTER TABLE lojas MODIFY COLUMN longitude NUMERIC COMMENT 'Número da localização geográfica por longitude de cada loja';

ALTER TABLE lojas MODIFY COLUMN logo BLOB COMMENT 'O Binary Large Object que corresponde ao Logo da loja';

ALTER TABLE lojas MODIFY COLUMN logo_mime_type VARCHAR(512) COMMENT 'O tipo de valor que o MIME da logo tem';

ALTER TABLE lojas MODIFY COLUMN logo_arquivo VARCHAR(512) COMMENT 'O nome do arquivo onde está a logo';

ALTER TABLE lojas MODIFY COLUMN logo_charset VARCHAR(512) COMMENT 'O ChARSET do logo da loja';

ALTER TABLE lojas MODIFY COLUMN logo_ultima_atualizacao DATE COMMENT 'Data de quando a última alteração da logo foi feita';


CREATE TABLE estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                PRIMARY KEY (estoque_id)
);

ALTER TABLE estoques COMMENT 'Tabela sobre os estoques da loja';

ALTER TABLE estoques MODIFY COLUMN estoque_id NUMERIC(38) COMMENT 'Número de ID do estoque da loja';

ALTER TABLE estoques MODIFY COLUMN loja_id NUMERIC(38) COMMENT 'estoque estoque é';

ALTER TABLE estoques MODIFY COLUMN produto_id NUMERIC(38) COMMENT 'ue';

ALTER TABLE estoques MODIFY COLUMN quantidade NUMERIC(38) COMMENT 'Número da quantidade de produtos tem naquele estoque';


CREATE TABLE envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                PRIMARY KEY (envio_id)
);

ALTER TABLE envios COMMENT 'Tabela sobre o envio de produtos';

ALTER TABLE envios MODIFY COLUMN envio_id NUMERIC(38) COMMENT 'PK da tabela. Número de ID do envio do produto pela loja';

ALTER TABLE envios MODIFY COLUMN loja_id NUMERIC(38) COMMENT 'enviado';

ALTER TABLE envios MODIFY COLUMN cliente_id NUMERIC(38) COMMENT ' loja para onde o produto foi enviado';

ALTER TABLE envios MODIFY COLUMN endereco_entrega VARCHAR(512) COMMENT 'egue';

ALTER TABLE envios MODIFY COLUMN status VARCHAR(15) COMMENT 'cusado, etc.';


CREATE TABLE pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora DATETIME NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                PRIMARY KEY (pedido_id)
);

ALTER TABLE pedidos COMMENT 'Tabela sobre os pedidos dos clientes as lojas';

ALTER TABLE pedidos MODIFY COLUMN pedido_id NUMERIC(38) COMMENT 'pedidos de cada cliente';

ALTER TABLE pedidos MODIFY COLUMN data_hora TIMESTAMP COMMENT 'Data e a hora que o pedido do cliente foi realizado';

ALTER TABLE pedidos MODIFY COLUMN cliente_id NUMERIC(38) COMMENT 'iente que fez o pedido';

ALTER TABLE pedidos MODIFY COLUMN status VARCHAR(15) COMMENT 'endo preparado, etc.';

ALTER TABLE pedidos MODIFY COLUMN loja_id NUMERIC(38) COMMENT 'edido foi realizado';


CREATE TABLE pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                PRIMARY KEY (pedido_id, produto_id)
);

ALTER TABLE pedidos_itens COMMENT 'Tabela com os itens pedidos pelos clientes';

ALTER TABLE pedidos_itens MODIFY COLUMN pedido_id NUMERIC(38) COMMENT 'feito';

ALTER TABLE pedidos_itens MODIFY COLUMN produto_id NUMERIC(38) COMMENT 'PFK da tabela produtos. Número do produto pedido';

ALTER TABLE pedidos_itens MODIFY COLUMN numero_da_linha NUMERIC(38) COMMENT 'Número da linha onde o pedido foi feito';

ALTER TABLE pedidos_itens MODIFY COLUMN preco_unitario NUMERIC(10, 2) COMMENT 'O preço de cada pedido feito na loja';

ALTER TABLE pedidos_itens MODIFY COLUMN quantidade NUMERIC(38) COMMENT 'A quantidade de produtos pedidos na loja';

ALTER TABLE pedidos_itens MODIFY COLUMN envio_id NUMERIC(38) COMMENT 'a loja';


ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;




ALTER TABLE produtos
    ADD CONSTRAINT preco_negativo_check CHECK (preco_unitario >= 0),
    ADD CONSTRAINT produto_id_check CHECK (produto_id >= 0);

ALTER TABLE estoques
    ADD CONSTRAINT quantidade_negativa_check CHECK (quantidade >= 0),
    ADD CONSTRAINT estoque_id_check CHECK (estoque_id >= 0),
    ADD CONSTRAINT loja_id2_check CHECK (loja_id >= 0),
    ADD CONSTRAINT produto_id2_check CHECK (produto_id >= 0);

ALTER TABLE pedidos_itens
    ADD CONSTRAINT quantidade_negativa2_check CHECK (quantidade >= 0),
    ADD CONSTRAINT preco_negativo2_check CHECK (preco_unitario >= 0),
    ADD CONSTRAINT pedido_id2_check CHECK (pedido_id >= 0),
    ADD CONSTRAINT produto_id3_check CHECK (produto_id >= 0),
    ADD CONSTRAINT envio_id3_check CHECK (envio_id  >= 0);

ALTER TABLE lojas
    ADD CONSTRAINT endereco_check CHECK (endereco_web IS NOT NULL OR endereco_fisico IS NOT NULL),
    ADD CONSTRAINT loja_id_check CHECK (loja_id >= 0);
    

ALTER TABLE pedidos
    ADD CONSTRAINT status_pedido_check CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO')),
    ADD CONSTRAINT pedido_id_check CHECK (pedido_id >= 0),
    ADD CONSTRAINT cliente_id3_check CHECK (cliente_id >= 0), 
    ADD CONSTRAINT loja_id3_check CHECK (loja_id  >= 0);

ALTER TABLE envios
    ADD CONSTRAINT status_envio_check CHECK (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE')),
    ADD CONSTRAINT envio_id2_check CHECK (envio_id >= 0),
    ADD CONSTRAINT loja_id3_check CHECK (loja_id >= 0),
    ADD CONSTRAINT cliente_id2_check CHECK (cliente_id >= 0);  
 
ALTER TABLE clientes
    ADD CONSTRAINT cliente_id_check CHECK (cliente_id >= 0);
    

    


    



       
    
    
