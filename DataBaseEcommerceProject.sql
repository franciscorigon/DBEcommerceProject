-- criacao do banco de dados para o cenario de e-commerce

CREATE DATABASE e_commerce;
USE e_commerce;

-- criar tabela cliente
CREATE TABLE clients(
	idClient INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(15),
    Minit CHAR(3),
    Lname VARCHAR (20),
    CPF CHAR(11) NOT NULL,
    Address VARCHAR(45),
    CONSTRAINT unique_cpf_client UNIQUE (CPF)
);

-- criar tabela produto
CREATE TABLE product(
	idProduct INT AUTO_INCREMENT PRIMARY KEY,
    Pname VARCHAR(15) NOT NULL,
    Classification_kids BOOL,
    Category ENUM ('Eletronico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Moveis'),
    Assessment FLOAT DEFAULT 0,
    Size VARCHAR(10)
);

-- criar tabela pagamentos
CREATE TABLE payments(
	idClient INT,
    idPayment INT,
    TypePayment enum('Dinheiro', 'Boleto', 'Dois cartões'),
    LimitAvailable FLOAT,
    PRIMARY KEY(idClient, idPayment)
);

-- criar tabela pedido
CREATE TABLE orders(
	idOrder INT AUTO_INCREMENT PRIMARY KEY,
    idOrderClient INT,
    OrdersStatus enum('Cancelado', 'Confirmado', 'Processando') DEFAULT 'Processando',
    OrderDescription VARCHAR(255),
    SendValue FLOAT DEFAULT 10,
    PaymentCash BOOL DEFAULT FALSE,
    CONSTRAINT fk_orders_client FOREIGN KEY (idOrderClient) REFERENCES clients(idClient)
		ON UPDATE CASCADE
);

-- criar tabela estoque
CREATE TABLE product_storage(
	idProductStorage INT AUTO_INCREMENT PRIMARY KEY,
    StorageLocation VARCHAR(255),
    Quantity INT DEFAULT 0
);

-- criar tabela fornecedor
CREATE TABLE supplier(
	idSupplier INT AUTO_INCREMENT PRIMARY KEY,
    SocialName VARCHAR(255) NOT NULL,
    CNPJ VARCHAR(15) NOT NULL,
    Contact VARCHAR(11) NOT NULL,
    CONSTRAINT unique_supplier UNIQUE (CNPJ)
);

-- criar tabela vendedor
CREATE TABLE seller(
	idSeller INT AUTO_INCREMENT PRIMARY KEY,
    SocialName VARCHAR(255) NOT NULL,
    AbstractName VARCHAR(255),
    CNPJ VARCHAR(15),
    CPF VARCHAR(11),
    Location VARCHAR(255),
    Contact VARCHAR(11) NOT NULL,
    CONSTRAINT unique_cnpj_seller UNIQUE (CNPJ),
    CONSTRAINT unique_cpf_seller UNIQUE (CPF)
);

-- criar tabela produtos/vendedor
CREATE TABLE product_seller(
	idProductSeller INT,
    idProduct INT,
    ProdQuantity INT DEFAULT 1,
    PRIMARY KEY (idProductSeller, idProduct),
    CONSTRAINT fk_product_seller FOREIGN KEY (idProductSeller) REFERENCES seller(idSeller),
    CONSTRAINT fk_product_product FOREIGN KEY (idProduct) REFERENCES product(idProduct)
);


-- criar tabela produto/pedido
CREATE TABLE product_order(
	idPOproduct INT,
    idPOorder INT,
    POQuantity INT DEFAULT 1,
    POStatus enum ('Disponivel', 'Sem estoque') DEFAULT 'Disponivel',
    PRIMARY KEY (idPOproduct, idPOorder),
    CONSTRAINT fk_product_order_seller FOREIGN KEY (idPOproduct) REFERENCES product(idProduct),
    CONSTRAINT fk_product_order_orders FOREIGN KEY (idPOorder) REFERENCES orders(idOrder)
);


-- criar tabela local de armazenamento
CREATE TABLE storage_location(
	idLproduct INT,
    idLstorage INT,
    Location VARCHAR(255) NOT NULL,
    PRIMARY KEY (idLproduct, idLstorage),
    CONSTRAINT fk_storage_location_product FOREIGN KEY (idLproduct) REFERENCES product(idProduct),
    CONSTRAINT fk_storage_location_storage FOREIGN KEY (idLstorage) REFERENCES product_storage(idProductStorage)
);

CREATE TABLE product_supplier(
	idPSSupplier INT,
    idPSProduct INT,
    Quantity INT NOT NULL,
    PRIMARY KEY (idPSSupplier, idPSProduct),
    CONSTRAINT fk_product_supplier_supplier FOREIGN KEY (idPSSupplier) REFERENCES supplier(idSupplier),
    CONSTRAINT fk_product_supplier_product FOREIGN KEY (idPSProduct) REFERENCES product(idProduct)
);

ALTER TABLE clients AUTO_INCREMENT = 1;

-----------------------------------------------------------------------------------------------------------------

-- INSERINDO DADOS --

INSERT INTO clients (Fname, Minit, Lname, CPF, Address) VALUES
    ('João', 'A.', 'Silva', '12345678901', 'Rua 1, Bairro A, São Paulo'),
    ('Maria', 'B.', 'Santos', '23456789012', 'Avenida 2, Bairro B, São Paulo'),
    ('Carlos', 'C.', 'Ferreira', '34567890123', 'Rua 3, Bairro C, São Paulo'),
    ('Ana', 'D.', 'Oliveira', '45678901234', 'Avenida 4, Bairro D, São Paulo'),
    ('Pedro', 'E.', 'Rocha', '56789012345', 'Rua 5, Bairro E, São Paulo'),
    ('Laura', 'F.', 'Almeida', '67890123456', 'Avenida 6, Bairro F, São Paulo'),
    ('Marcos', 'G.', 'Pereira', '78901234567', 'Rua 7, Bairro G, Rio de Janeiro'),
    ('Beatriz', 'H.', 'Gomes', '89012345678', 'Avenida 8, Bairro H, Rio de Janeiro'),
    ('Felipe', 'I.', 'Rodrigues', '90123456789', 'Rua 9, Bairro I, Rio de Janeiro'),
    ('Julia', 'J.', 'Costa', '01234567890', 'Avenida 10, Bairro J, Rio de Janeiro'),
    ('Lucas', 'K.', 'Martins', '98765432101', 'Rua 11, Bairro K, Rio de Janeiro'),
    ('Larissa', 'L.', 'Fernandes', '87654321012', 'Avenida 12, Bairro L, Belo Horizonte'),
    ('Miguel', 'M.', 'Sousa', '76543210923', 'Rua 13, Bairro M, Belo Horizonte'),
    ('Amanda', 'N.', 'Ribeiro', '65432109834', 'Avenida 14, Bairro N, Belo Horizonte'),
    ('Rafael', 'O.', 'Carvalho', '54321098745', 'Rua 15, Bairro O, Salvador'),
    ('Camila', 'P.', 'Machado', '43210987656', 'Avenida 16, Bairro P, Salvador'),
    ('Eduardo', 'Q.', 'Oliveira', '32109876567', 'Rua 17, Bairro Q, Brasília'),
    ('Isabella', 'R.', 'Santana', '21098765478', 'Avenida 18, Bairro R, Brasília');

INSERT INTO product (Pname, Classification_kids, Category, Assessment, Size) VALUES
    ('Smartphone X1', false, 'Eletronico', 4.5, '5.5 inches'),
    ('Laptop Y2', false, 'Eletronico', 4.2, '15.6 inch'),
    ('Camiseta Casual', true, 'Vestimenta', 3.8, 'M'),
    ('Tênis Esportivo', true, 'Vestimenta', 4.0, 'US 10'),
    ('Boneca Pelúcia', true, 'Brinquedos', 4.7, 'Small'),
    ('Quebra-Cabeça', true, 'Brinquedos', 4.4, 'Large'),
    ('Chocolate Leite', true, 'Alimentos', 4.9, '100g'),
    ('Café Gourmet', false, 'Alimentos', 4.6, '250g'),
    ('Sofá Confy', false, 'Moveis', 4.3, '3-Seater'),
    ('Mesa de Jantar', false, 'Moveis', 4.1, '6-Person'),
    ('Fone Bluetooth', false, 'Eletronico', 4.8, 'One Size'),
    ('Vestido Noite', false, 'Vestimenta', 4.2, 'L'),
    ('Bola de Futebol', true, 'Brinquedos', 4.5, 'Official'),
    ('Lego', true, 'Brinquedos', 4.3, 'Medium'),
    ('Barra Cereal', true, 'Alimentos', 4.7, '10-Pack'),
    ('Vinho Tinto', false, 'Alimentos', 4.9, '750ml'),
    ('Poltrona Recl', false, 'Moveis', 4.0, 'One Size'),
    ('Roupeiro Mod', false, 'Moveis', 4.6, 'Large'),
    ('Câmera Digital', false, 'Eletronico', 4.4, 'One Size'),
    ('Camisa Polo', true, 'Vestimenta', 4.0, 'XL'),
    ('Carrinho', true, 'Brinquedos', 4.8, 'Small'),
    ('Queijo Cheddar', true, 'Alimentos', 4.7, '200g'),
    ('Notebook Fino', false, 'Eletronico', 4.6, '13.3 inch'),
    ('Calça Jeans', true, 'Vestimenta', 4.1, '30W x 32L'),
    ('Puzzle 3D', true, 'Brinquedos', 4.5, 'Large'),
    ('Café Expresso', false, 'Alimentos', 4.3, '250g'),
    ('Cama King Size', false, 'Moveis', 4.2, 'King Size'),
    ('Mesa de Centro', false, 'Moveis', 4.4, 'Medium'),
    ('Tablet Android', false, 'Eletronico', 4.7, '10 inches'),
    ('Blusa de Lã', true, 'Vestimenta', 4.0, 'S'),
    ('Carro Contr Rem', true, 'Brinquedos', 4.8, 'Medium'),
    ('Pipoca Micro', true, 'Alimentos', 4.5, '3-Pack'),
    ('Smart TV 4K', false, 'Eletronico', 4.6, '55 inches'),
    ('Vestido Verão', true, 'Vestimenta', 4.2, 'M'),
    ('Quebra-Cabeça', true, 'Brinquedos', 4.4, 'Large'),
    ('Choco Sortidos', true, 'Alimentos', 4.7, '250g'),
    ('Sofá de Canto', false, 'Moveis', 4.1, '4-Seater'),
    ('Mesa de Vidro', false, 'Moveis', 4.5, '8-Person');

INSERT INTO orders (idOrderClient, OrdersStatus, OrderDescription, SendValue, PaymentCash) VALUES
    (1, 'Confirmado', 'Pedido de eletrônicos', 15.99, true),
    (2, 'Processando', 'Pedido de roupas', 25.50, false),
    (3, 'Processando', 'Pedido de brinquedos', 30.75, true),
    (4, 'Confirmado', 'Pedido de alimentos', 12.99, false),
    (5, 'Cancelado', 'Pedido de móveis', 55.25, true),
    (6, 'Confirmado', 'Pedido de eletrônicos', 75.99, false),
    (7, 'Processando', 'Pedido de roupas', 42.50, true),
    (8, 'Cancelado', 'Pedido de brinquedos', 28.75, false),
    (9, 'Processando', 'Pedido de alimentos', 8.99, true),
    (10, 'Confirmado', 'Pedido de móveis', 65.25, false);

INSERT INTO product_order (idPOproduct, idPOorder, POQuantity, POStatus) VALUES
    (1, 1, 2, 'Disponivel'),
    (2, 2, 3, 'Disponivel'),
    (3, 3, 1, 'Sem estoque'),
    (4, 4, 4, 'Disponivel'),
    (5, 5, 2, 'Sem estoque'),
    (6, 6, 1, 'Disponivel'),
    (7, 7, 3, 'Disponivel'),
    (8, 8, 2, 'Sem estoque'),
    (9, 9, 1, 'Disponivel'),
    (10, 10, 4, 'Disponivel');

INSERT INTO product_storage (StorageLocation, Quantity) VALUES
    ('São Paulo', 1000),
    ('Rio de Janeiro', 500),
    ('Belo Horizonte', 750),
    ('Porto Alegre', 2000),
    ('Curitiba', 100),
    ('Salvador', 300),
    ('São Paulo', 1500), -- Cidade repetida
    ('Fortaleza', 800);

INSERT INTO storage_location (idLproduct, idLstorage, Location) VALUES
    (1, 1, 'SP'),   
    (2, 2, 'RJ'),   
    (3, 3, 'MG'),   
    (4, 4, 'RS'),   
    (5, 5, 'PR'),   
    (6, 6, 'BA'),   
    (7, 7, 'SP'),   
    (8, 8, 'CE');   
drop table supplier;
SELECT idPSSupplier FROM product_supplier;

INSERT INTO supplier (SocialName, CNPJ, Contact) VALUES
    (1, '12345678201234', '11987654321'),
    (2, '88789012345678', '11987651234'),
    (3, '11123456789012', '11981234567'),
    (4, '22567890123456', '11982345678'),
    (5, '44890123456789', '11983456789'),
    (6, '00234567890123', '11984567890'),
    (7, '22456789012345', '11985678901'),
    (8, '44678901234567', '11986789012'),
    (9, '77901234567890', '11987890123'),
    (10, '12287678901834', '11988901234');

INSERT INTO product_supplier (idPSSupplier, idPSProduct, Quantity) VALUES
    (66, 1, 100),
    (16, 2, 50),
    (63, 3, 75),
    (70, 4, 200),
    (61, 5, 10),
    (11, 6, 30),
    (20, 7, 150),
    (67, 8, 80),
    (64, 9, 60),
    (13, 10, 120);

INSERT INTO seller (SocialName, AbstractName, CNPJ, CPF, Location, Contact) VALUES
    ('Loja Eletrônicos XYZ', 'Eletrônicos XYZ', '12345678000100', '12345678901', 'São Paulo, SP', '11987654321'),
    ('Moda Fashion Ltda', 'Moda Fashion', '98765432000199', '98765432109', 'Rio de Janeiro, RJ', '21987654321'),
    ('Casa dos Brinquedos', NULL, '56789012000188', NULL, 'Belo Horizonte, MG', '31987654321'),
    ('Supermercado ABC', NULL, '34567890000177', '34567890123', 'Porto Alegre, RS', '51987654321'),
    ('Móveis de Luxo', 'Móveis Luxo', '65432109876543', NULL, 'Salvador, BA', '71987654321'),
    ('Loja de Informática', NULL, '89012345000166', '89012345101', 'Recife, PE', '81987654321'),
    ('Alimentos Naturais', NULL, '43210987654321', NULL, 'Curitiba, PR', '41987654321'),
    ('Joalheria Elegância', 'Elegância Joias', '10987654321098', NULL, 'Fortaleza, CE', '85987654321'),
    ('Decorações Vintage', 'Vintage Decorações', '98765432100123', '98765432111', 'Brasília, DF', '61987654321'),
    ('Loja de Esportes', NULL, '87654321000134', '87654321012', 'Belém, PA', '91987654321');

INSERT INTO product_seller (idProductSeller, idProduct, ProdQuantity) VALUES
    (1, 1, 50),
    (2, 2, 30),
    (3, 3, 25),
    (4, 4, 40),
    (5, 5, 20),
    (6, 6, 15),
    (7, 7, 60),
    (8, 8, 10),
    (9, 9, 35),
    (10, 10, 45);