# Trabalho Final – Banco de Dados 2

Este projeto foi desenvolvido como **trabalho final da disciplina de Banco de Dados 2**, no curso de Engenharia da Computação – Uniube.

O sistema simula o banco de dados de uma loja de artigos de pesca chamada **Pescador Experiente**, abrangendo modelagem, inserção de dados, consultas e rotinas avançadas em SQL Server.

## Estrutura do Banco

- **Produtos**: catálogo com 30 produtos e atributos como nome, descrição, preço e estoque.
- **Funcionários**: equipe da loja com dados como nome, cargo, salário e data de admissão.
- **Fornecedores**: lista com dados de contato e vínculo com produtos fornecidos.
- **Clientes**: informações básicas dos clientes.
- **Pedidos e Detalhes do Pedido**: relacionamento cliente-produto com controle de itens, quantidades e preços.
- **Pagamentos**: registros de transações por método e valor.
- **Feedbacks e Comentários**: opiniões de clientes e avaliações internas dos funcionários.

## Funcionalidades Implementadas

- **Função `VerificarQuantidadeEmEstoque`**: retorna status de estoque do produto.
- **Trigger `AtualizarEstoque`**: atualiza automaticamente o estoque após inserção no pedido.
- **Procedure `EstoquePequeno`**: imprime se um produto está disponível ou não.
- **Laços com `WHILE`** para varreduras e impressões de pedidos e comentários.
- **Consulta com `CASE`** para classificar pedidos como pequeno, médio ou grande.
- **Criação de índice em cliente-pedido para otimizar buscas.**

## Observações

O projeto utiliza comandos **DDL, DML, DCL e rotinas programadas em T-SQL**, refletindo um sistema de comércio completo com manipulação de dados realista.

---

**Arquivo principal:** `trabalho-final-bd2.sql`

**Autor:** José Cleber Alves da Cruz Mendes  
**Curso:** Engenharia da Computação – Uniube
