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

