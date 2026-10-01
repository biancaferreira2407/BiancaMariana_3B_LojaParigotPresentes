
CREATE TABLE cargo (
    id_cargo integer NOT NULL PRIMARY KEY,
    nome_cargo VARCHAR(45)
);


CREATE TABLE pessoa (
    cpf_pessoa VARCHAR(20) NOT NULL PRIMARY KEY,
    nome_pessoa VARCHAR(60),
    data_nascimento_pessoa date,
    endereco_pessoa VARCHAR(150),
    senha_pessoa VARCHAR(50),
    email_pessoa VARCHAR(75)
);


CREATE TABLE cliente (
    pessoa_cpf_pessoa VARCHAR(20) NOT NULL PRIMARY KEY,
    renda_cliente double precision,
    data_cadastro_cliente date,
    foreign key (pessoa_cpf_pessoa) references pessoa(cpf_pessoa)
);


CREATE TABLE forma_pagamento (
    id_forma_pagamento integer NOT NULL PRIMARY KEY,
    nome_forma_pagamento VARCHAR(100)
);


CREATE TABLE funcionario (
    pessoa_cpf_pessoa VARCHAR(20) NOT NULL PRIMARY KEY,
    salario_funcionario double precision,
    cargo_id_cargo integer,
    porcentagem_comissao_funcionario double precision,
    foreign key (pessoa_cpf_pessoa) references pessoa(cpf_pessoa),
    foreign key (cargo_id_cargo) references cargo(id_cargo)
);


CREATE TABLE categoria (
    id_categoria integer NOT NULL PRIMARY KEY,
    nome_categoria VARCHAR(30)
);


CREATE TABLE unidade_medida (
    id_unidade_medida VARCHAR(2) NOT NULL PRIMARY KEY,
    nome_unidade_medida VARCHAR(30)
);


CREATE TABLE produto (
    id_produto integer NOT NULL PRIMARY KEY,
    nome_produto VARCHAR(45),
    quantidade_estoque_produto integer,
    preco_unitario_produto double precision,
    id_unidade_medida VARCHAR(2),
    id_categoria INTEGER,
    FOREIGN KEY (id_unidade_medida) REFERENCES unidade_medida(id_unidade_medida),
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);


CREATE TABLE pedido (
    id_pedido SERIAL PRIMARY KEY,
    data_pedido date,
    cliente_pessoa_cpf_pessoa VARCHAR(20),
    funcionario_pessoa_cpf_pessoa VARCHAR(20),
    FOREIGN KEY (cliente_pessoa_cpf_pessoa) REFERENCES pessoa(cpf_pessoa),
    FOREIGN KEY (funcionario_pessoa_cpf_pessoa) REFERENCES pessoa(cpf_pessoa)
);


CREATE TABLE pedido_has_produto (
    produto_id_produto integer NOT NULL,
    pedido_id_pedido integer NOT NULL,
    quantidade integer,
    preco_unitario double precision,
    foreign key (pedido_id_pedido) references pedido(id_pedido),
    foreign key (produto_id_produto) references produto(id_produto)
);


CREATE TABLE pagamento (
    pedido_id_pedido integer NOT NULL PRIMARY KEY,
    data_pagamento timestamp without time zone,
    valor_total_pagamento double precision,
    FOREIGN KEY (pedido_id_pedido) REFERENCES pedido(id_pedido)
);


CREATE TABLE pagamento_has_forma_pagamento (
    pagamento_id_pedido integer NOT NULL,
    forma_pagamento_id_forma_pagamento integer NOT NULL,
    valor_pago double precision,
    foreign key (pagamento_id_pedido) references pagamento(pedido_id_pedido),
    foreign key (forma_pagamento_id_forma_pagamento) references forma_pagamento(id_forma_pagamento)
);


-- =========================================
-- INSERTS DA TABELA CARGO
-- =========================================

INSERT INTO cargo (id_cargo, nome_cargo) VALUES
(0, 'Vendedor online'),
(1, 'Vendedor'),
(2, 'Gerente'),
(3, 'Caixa'),
(4, 'Supervisor'),
(5, 'Atendente'),
(6, 'Repositor'),
(7, 'Conferente'),
(8, 'Assistente'),
(9, 'Auxiliar'),
(10, 'Diretor');


-- =========================================
-- INSERTS DA TABELA PESSOA
-- =========================================
INSERT INTO pessoa
(cpf_pessoa, nome_pessoa, data_nascimento_pessoa, endereco_pessoa, senha_pessoa, email_pessoa)
VALUES
('10101010101', 'Juliana Dias', '1989-10-25', 'lins, 352 ssss', '1111', 'juliana@email.com'),
('44444444444', 'Ana Lima', '1995-04-25', 'Alameda do medo, 4534 apto 13', '.123456', 'ana@email.com'),
('55555555555', 'Lucas Mendes', '1988-05-30', 'Rua sexta_feira, 13 _ apto 666', '.123456', 'lucas@email.com'),
('66666666666', 'Fernanda Costa', '1993-06-05', 'muito longe, 243', '.123456', 'fernanda@email.com'),
('77777777777', 'Ricardo Alves', '1987-07-10', 'far far faraway, 34', '.123456', 'ricardo@email.com'),
('88888888888', 'Patrícia Gomes', '1994-08-15', 'acolá, 54', '.123456', 'patricia@email.com'),
('99999999999', 'Marcos Rocha', '1991-09-20', 'kaxa prego _ ilha de itaparica', '.123456', 'marcos@email.com'),
('22222222222', 'Maria Souza', '1985-02-15', 'lá longe, 1234', '.123456', 'maria@email.com'),
('12387980903', 'Berola', '2005-10-16', 'Lá onde Judas perdeu a unha, s/n', '12345', 'berola@gmail.com'),
('12345678910', 'Alice Reis', '2000-01-01', 'Loja', 'abc123', 'online@gmail.com'),
('33333333333', 'Carlos Pereira', '1992-03-20', 'Rua que Judas perdeu as botas, 234', '123456x', 'carlos@email.com'),
('05703371945', 'Quétima da Silva Reis Ferreira', '1980-09-19', 'Rua Xambrê, 64', 'dhiellys123', 'quetimareis@gmail.com'),
('92929292929', 'Renato Marinho Ferreira', '1982-09-19', 'Rua Xambrê, 64', '310606', 'renatomarinho@hotmail.com'),
('12381980903', 'Bianca Mariana Reis Ferreira', '2009-07-24', 'UTFPR, 32', '300606', 'biancamariana@gmail.com'),
('12388899903', 'Dhiellys Gabrieli Reis Ferreira', '2006-06-30', 'Rua Coroaves UEM, 23', '300606', 'dhireis@gmail.com');


-- =========================================
-- INSERTS DA TABELA FUNCIONARIO
-- =========================================

INSERT INTO funcionario
(pessoa_cpf_pessoa, salario_funcionario, cargo_id_cargo, porcentagem_comissao_funcionario)
VALUES
('92929292929', 3000.00, 3, 3),
('66666666666', 4000.00, 4, 5),
('55555555555', 5000.00, 5, 9),
('88888888888', 6000.00, 6, 8),
('44444444444', 7000.00, 7, 5),
('12388899903', 8000.00, 8, 0.5),
('77777777777', 9000.00, 9, 1),
('05703371945', 10000.00, 10, 0),
('12381980903', 2000.00, 0, 2),
('99999999999', 20000.00, 1, 10),
('10101010101', 2000.00, 2, 0);


-- =========================================
-- INSERTS DA TABELA CLIENTE
-- =========================================

INSERT INTO cliente
(pessoa_cpf_pessoa, renda_cliente, data_cadastro_cliente)
VALUES
('33333333333', 4675.98, '2020-09-08'),
('22222222222', 8000.00, '2023-07-08'),
('12387980903', 1500.00, '2020-09-08'),
('12345678910', 32000.00, '2020-09-08'),
('99999999999', 20000.00, '2026-09-08'),
('12381980903', 2000.00, '2020-09-08'),
('10101010101', 3500.00, '2026-09-15'),
('44444444444', 4200.00, '2026-09-16'),
('55555555555', 5100.00, '2026-09-17'),
('66666666666', 2800.00, '2026-09-18');


-- =========================================
-- INSERTS DA TABELA CATEGORIA
-- =========================================

INSERT INTO categoria (id_categoria, nome_categoria) VALUES
(1, 'papelaria'),
(2, 'acessório'),
(3, 'utensílio'),
(4, 'perfumaria'),
(5, 'vestimenta'),
(6, 'decoração'),
(7, 'pelúcias'),
(8, 'bolsas e mochilas'),
(9, 'colecionáveis'),
(10, 'presentes');


-- =========================================
-- INSERTS DA TABELA UNIDADE_MEDIDA
-- =========================================

INSERT INTO unidade_medida
(id_unidade_medida, nome_unidade_medida)
VALUES
('UN', 'Unidade'),
('PC', 'Pacote'),
('DZ', 'Dúzia'),
('CX', 'Caixa'),
('M', 'Metro'),
('KG', 'Quilograma'),
('LT', 'Litro'),
('CM', 'Centímetro'),
('ML', 'Mililitro'),
('JG', 'Jogo');


-- =========================================
-- INSERTS DA TABELA PRODUTO
-- =========================================

INSERT INTO produto
(id_produto, nome_produto, quantidade_estoque_produto, preco_unitario_produto, id_unidade_medida, id_categoria)
VALUES
(1, 'caderno brochura grande', 11, 13.00, 'UN', 1),
(2, 'caderno brochura pequeno', 19, 7.00, 'UN', 1),
(3, 'caderno espiral 10 matérias', 5, 29.00, 'UN', 1),
(4, 'caderno espiral 15 matérias', 8, 35.00, 'UN', 1),
(5, 'caderneta 96 folhas', 9, 10.00, 'UN', 1),
(6, 'caneta bic azul', 29, 2.00, 'UN', 1),
(7, 'caneta bic preta', 80, 2.00, 'UN', 1),
(8, 'kit caneta colorida', 20, 15.00, 'UN', 1),
(9, 'mochila', 7, 120.00, 'UN', 1),
(10, 'ramona marrom', 100, 1.00, 'DZ', 2),
(11, 'ramona preta', 30, 1.00, 'DZ', 2),
(12, 'presilha de cabelo', 10, 10.00, 'CX', 2),
(13, 'piranha de cabelo', 8, 15.00, 'UN', 2),
(14, 'bolsa', 3, 79.00, 'UN', 2),
(15, 'travessa', 4, 80.00, 'UN', 3),
(16, 'lixeira', 2, 20.00, 'UN', 3),
(17, 'escumadeira', 3, 10.00, 'UN', 3),
(18, 'concha', 1, 7.00, 'UN', 3),
(19, 'colônia luna feminino', 2, 189.00, 'UN', 4),
(20, 'colônia kaiak masculino', 3, 199.00, 'UN', 4),
(21, 'colônia kaiak feminino', 2, 199.00, 'UN', 4),
(22, 'colônia humor feminino', 1, 189.00, 'UN', 4),
(23, 'creme corporal tododia', 8, 78.00, 'UN', 4),
(24, 'sabonete corporal tododia', 7, 33.00, 'CX', 4),
(25, 'óleo corporal ekos', 3, 79.00, 'UN', 4);


-- =========================================
-- INSERTS DA TABELA FORMA_PAGAMENTO
-- =========================================

INSERT INTO forma_pagamento
(id_forma_pagamento, nome_forma_pagamento)
VALUES
(1, 'Dinheiro'),
(2, 'Cartão de Crédito'),
(3, 'Cartão de Débito'),
(4, 'Pix'),
(5, 'Boleto'),
(6, 'Vale Alimentação'),
(7, 'Transferência Bancária'),
(8, 'Cheque'),
(9, 'Crédito Loja'),
(10, 'Gift Card');


-- =========================================
-- INSERTS DA TABELA PEDIDO
-- =========================================

INSERT INTO pedido
(id_pedido, data_pedido, cliente_pessoa_cpf_pessoa, funcionario_pessoa_cpf_pessoa)
VALUES
(1, '2026-09-10', '33333333333', '92929292929'),
(2, '2026-09-11', '22222222222', '66666666666'),
(3, '2026-09-12', '12387980903', '55555555555'),
(4, '2026-09-13', '12345678910', '88888888888'),
(5, '2026-09-14', '99999999999', '12381980903'),
(6, '2026-09-15', '10101010101', '92929292929'),
(7, '2026-09-16', '44444444444', '66666666666'),
(8, '2026-09-17', '55555555555', '55555555555'),
(9, '2026-09-18', '66666666666', '88888888888'),
(10, '2026-09-19', '88888888888', '12388899903');


-- =========================================
-- INSERTS DA TABELA PEDIDO_HAS_PRODUTO
-- =========================================

INSERT INTO pedido_has_produto
(produto_id_produto, pedido_id_pedido, quantidade, preco_unitario)
VALUES
(1, 1, 2, 13.00),
(6, 1, 5, 2.00),
(9, 1, 1, 120.00),
(14, 2, 1, 79.00),
(19, 3, 1, 189.00),
(24, 3, 3, 33.00),
(20, 4, 1, 199.00),
(7, 4, 10, 2.00),
(23, 5, 2, 78.00),
(15, 5, 1, 80.00),
(2, 6, 2, 7.00),
(6, 6, 3, 2.00),
(9, 7, 1, 120.00),
(20, 8, 1, 199.00),
(16, 9, 2, 20.00),
(14, 10, 2, 79.00);


-- =========================================
-- INSERTS DA TABELA PAGAMENTO
-- =========================================

INSERT INTO pagamento
(pedido_id_pedido, data_pagamento, valor_total_pagamento)
VALUES
(1, '2026-09-10 10:30:00', 156.00),
(2, '2026-09-11 14:15:00', 79.00),
(3, '2026-09-12 16:40:00', 288.00),
(4, '2026-09-13 11:20:00', 219.00),
(5, '2026-09-14 15:50:00', 236.00),
(6, '2026-09-15 10:15:00', 20.00),
(7, '2026-09-16 13:30:00', 120.00),
(8, '2026-09-17 15:45:00', 199.00),
(9, '2026-09-18 11:10:00', 40.00),
(10, '2026-09-19 16:20:00', 158.00);


-- =========================================
-- INSERTS DA TABELA PAGAMENTO_HAS_FORMA_PAGAMENTO
-- =========================================

INSERT INTO pagamento_has_forma_pagamento
(pagamento_id_pedido, forma_pagamento_id_forma_pagamento, valor_pago)
VALUES
(1, 4, 156.00),
(2, 2, 79.00),
(3, 1, 288.00),
(4, 3, 219.00),
(5, 4, 236.00),
(6, 4, 20.00),
(7, 2, 120.00),
(8, 1, 199.00),
(9, 3, 40.00),
(10, 4, 158.00);


-- Atualiza a sequence do pedido após os novos INSERTs.
SELECT setval(
    pg_get_serial_sequence('public.pedido', 'id_pedido'),
    COALESCE(MAX(id_pedido), 0) + 1,
    false
)
FROM public.pedido;
