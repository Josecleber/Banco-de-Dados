# Exercício – Banco de Dados ClassicModels

Este exercício utiliza o banco de dados de exemplo **ClassicModels**, amplamente usado em treinamentos e estudos de SQL. O foco está na criação completa da estrutura do banco, seguida pela implementação de uma procedure e várias funções com uso de cursores.

## Estrutura do Banco

- **Tabelas criadas**:
  - `productlines`
  - `products`
  - `offices`
  - `employees`
  - `customers`
  - `payments`
  - `orders`
  - `orderdetails`

As tabelas são interligadas com chaves primárias e estrangeiras, modelando um sistema comercial com produtos, clientes, pedidos, funcionários e pagamentos.

## Funcionalidades Implementadas

- **Procedure `UpdateStockQuantity`**  
  Usa um cursor para somar a quantidade em estoque de todos os produtos com até 1000 unidades.

- **Funções com cursor**:
  - `CalculateOrderTotal`: calcula o valor total de um pedido.
  - `CountProductsByProductLine`: conta quantos produtos há em uma linha de produtos.
  - `GetProductCodesByProductLine`: retorna os códigos de produtos separados por ponto e vírgula.
  - `CalculateTotalPaymentsByCustomer`: soma os pagamentos de um cliente.
  - `GetTwoLowestStockProductsPerProductLine`: retorna os dois produtos com menor estoque por linha de produto.

## Objetivo

Esse exercício visa fortalecer os conhecimentos em:
- Modelagem relacional
- Criação de banco de dados no SQL Server
- Uso de **cursores em procedures e functions**
- Lógica de agregação e concatenação

---

**Arquivo principal:** `classicmodels.sql`  


**Autor:** José Cleber Alves da Cruz Mendes  
**Curso:** Engenharia da Computação – Uniube
