# Banco de Dados de E-Commerce

Bem-vindo ao repositório do Banco de Dados de E-Commerce, onde você encontrará consultas SQL prontas para explorar os dados do nosso negócio virtual fictício! 😄

Este banco de dados foi criado para simular um cenário de e-commerce, incluindo clientes, produtos, pedidos, fornecedores e muito mais.

## Consultas SQL

Aqui estão algumas consultas SQL que você pode usar para explorar nosso banco de dados:

### 1. Quantos pedidos foram feitos por cada cliente?
```sql
SELECT idOrderClient, COUNT(*) AS TotalPedidos
FROM orders
GROUP BY idOrderClient;
```
### 2. Alguns vendedores também são fornecedores?
```sql
SELECT s.SocialName AS Vendedor, IFNULL(sp.SocialName, 'Não') AS ÉFornecedor
FROM seller s
LEFT JOIN product_seller ps ON s.idSeller = ps.idProductSeller
LEFT JOIN supplier sp ON s.CNPJ = sp.CNPJ;
```
### 3. Relação de produtos fornecedores e estoques
```sql
SELECT p.Pname AS Produto, s.SocialName AS Fornecedor, ps.Quantity AS QuantidadeEmEstoque
FROM product_supplier ps
INNER JOIN product p ON ps.idPSProduct = p.idProduct
INNER JOIN supplier s ON ps.idPSSupplier = s.idSupplier;
```
### 4. Relação de nomes dos fornecedores e nomes dos produtos
```sql
SELECT s.SocialName AS Fornecedor, GROUP_CONCAT(p.Pname SEPARATOR ', ') AS ProdutosFornecidos
FROM product_supplier ps
INNER JOIN product p ON ps.idPSProduct = p.idProduct
INNER JOIN supplier s ON ps.idPSSupplier = s.idSupplier
GROUP BY s.SocialName;
```
### 5. Valor médio dos pedidos para cada cliente
```sql
SELECT idOrderClient, AVG(SendValue) AS ValorMédio
FROM orders
GROUP BY idOrderClient;
```
### 6. Pedidos com status "Confirmado" e valor de envio superior a 50
```sql
SELECT * 
FROM orders
WHERE OrdersStatus = 'Confirmado' AND SendValue > 50;
```
### 7. Total de produtos em estoque por local de armazenamento
```sql
SELECT l.Location AS LocalDeArmazenamento, SUM(ps.Quantity) AS TotalEmEstoque
FROM storage_location l
INNER JOIN product_storage ps ON l.idLstorage = ps.idProductStorage
GROUP BY l.Location;
```
### 8. Clientes que fizeram pedidos de produtos classificados como "Eletrônicos"
```sql
SELECT DISTINCT c.Fname, c.Lname
FROM clients c
INNER JOIN orders o ON c.idClient = o.idOrderClient
INNER JOIN product_order po ON o.idOrder = po.idPOorder
INNER JOIN product p ON po.idPOproduct = p.idProduct
WHERE p.Category = 'Eletronico';
```
### 9. Vendedores que não são fornecedores
```sql
SELECT s.SocialName
FROM seller s
LEFT JOIN supplier sp ON s.CNPJ = sp.CNPJ
WHERE sp.idSupplier IS NULL;
```
### 10. Pedidos com pagamento em dinheiro e valor superior a 100
```sql
SELECT *
FROM orders
WHERE PaymentCash = TRUE AND SendValue > 100;

```
## Como Usar
Você pode usar essas consultas SQL diretamente em seu sistema de gerenciamento de banco de dados (como MySQL) ou adaptá-las às suas necessidades específicas.

Fique à vontade para explorar as consultas e usá-las como inspiração para suas próprias análises de dados.

Divirta-se explorando nosso banco de dados de e-commerce!