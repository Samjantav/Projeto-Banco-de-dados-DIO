-- Criação do Banco de Dados para E-commerce Refinado
CREATE DATABASE IF NOT EXISTS ecommerce_refinado;
USE ecommerce_refinado;

-- 1. Tabela Base: Cliente
CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    endereco VARCHAR(255),
    email VARCHAR(100) NOT NULL UNIQUE,
    telefone VARCHAR(20)
);

-- 2. Especialização: Pessoa Física (PF)
CREATE TABLE PessoaFisica (
    id_pf INT PRIMARY KEY,
    cpf CHAR(11) NOT NULL UNIQUE,
    nome_completo VARCHAR(150) NOT NULL,
    data_nascimento DATE,
    FOREIGN KEY (id_pf) REFERENCES Cliente(id_cliente) ON DELETE CASCADE
);

-- 3. Especialização: Pessoa Jurídica (PJ)
CREATE TABLE PessoaJuridica (
    id_pj INT PRIMARY KEY,
    cnpj CHAR(14) NOT NULL UNIQUE,
    razao_social VARCHAR(150) NOT NULL,
    nome_fantasia VARCHAR(100),
    FOREIGN KEY (id_pj) REFERENCES Cliente(id_cliente) ON DELETE CASCADE
);

-- 4. Formas de Pagamento (Um cliente pode ter várias)
CREATE TABLE FormaPagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    tipo_pagamento ENUM('Cartão de Crédito', 'Cartão de Débito', 'Boleto', 'Pix') NOT NULL,
    detalhes_cartao VARCHAR(50), -- Apenas máscara ou token
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- 5. Pedido
CREATE TABLE Pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    status_pedido ENUM('Confirmado', 'Cancelado', 'Processando') DEFAULT 'Processando',
    descricao VARCHAR(255),
    frete FLOAT DEFAULT 10,
    total FLOAT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- 6. Entrega (Relacionada ao Pedido)
CREATE TABLE Entrega (
    id_entrega INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT UNIQUE,
    status_entrega ENUM('Em processamento', 'Postado', 'Em trânsito', 'Entregue') DEFAULT 'Em processamento',
    codigo_rastreio VARCHAR(50) UNIQUE,
    data_postagem DATETIME,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido)
);

-- 7. Produto
CREATE TABLE Produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(45),
    valor FLOAT NOT NULL,
    descricao TEXT
);

-- 8. Itens do Pedido (Relacionamento N:M entre Pedido e Produto)
CREATE TABLE ItemPedido (
    id_pedido INT,
    id_produto INT,
    quantidade INT DEFAULT 1,
    PRIMARY KEY (id_pedido, id_produto),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);
