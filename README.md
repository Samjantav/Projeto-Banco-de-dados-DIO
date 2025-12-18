# 🛒 E-Commerce: Refinamento de Projeto Conceitual de Banco de Dados

[![Database](https://img.shields.io/badge/Database-MySQL-blue)]()
[![Status](https://img.shields.io/badge/Status-Finalizado-brightgreen)]()

## 📝 Descrição do Projeto
Este projeto consiste no refinamento de um modelo de banco de dados para um sistema de E-commerce. O objetivo principal foi aplicar conceitos avançados de modelagem, como **Especialização (Herança)**, gestão de múltiplas formas de pagamento e controle logístico de entregas.

O desafio faz parte da formação de Banco de Dados da [Nome da Instituição/DIO], focando na transição do modelo conceitual para o lógico.

---

## 🚀 Melhorias Implementadas

Para tornar o sistema mais robusto e próximo da realidade de grandes players do mercado, foram adicionados os seguintes pontos:

### 1. Clientes PF e PJ
- **Regra:** Uma conta de cliente pode ser Pessoa Física (PF) ou Pessoa Jurídica (PJ), mas nunca ambas simultaneamente.
- **Solução:** Implementada técnica de **Especialização** (Generalização/Especialização), onde a tabela pai `Cliente` compartilha atributos comuns, e as tabelas filhas `PessoaFisica` e `PessoaJuridica` contêm atributos específicos (CPF/CNPJ).

### 2. Gestão de Pagamentos
- **Regra:** Um cliente pode cadastrar múltiplas formas de pagamento para facilitar o checkout.
- **Solução:** Criação de uma entidade separada `FormaPagamento` vinculada ao `Cliente` (1:N), permitindo armazenar cartões, chaves Pix ou informações de boleto.

### 3. Logística de Entrega
- **Regra:** Controle total sobre o envio, com status dinâmico e rastreio.
- **Solução:** Adicionada a entidade `Entrega` vinculada ao `Pedido`. Nela, armazenamos o `status_entrega` (Ex: Em trânsito, Entregue) e o `codigo_rastreio`.



## 🛠️ Tecnologias Utilizadas
- **Modelagem:**  MySQL Workbench 
- **Linguagem:** SQL (DDL)
- **Documentação:** Markdown

---

## 📁 Estrutura do Repositório
- `/sql`: Contém os scripts de criação do banco de dados (`creation.sql`) e inserção de dados.
- `/diagramas`: Contém o arquivo do modelo conceitual/lógico.
- `README.md`: Documentação principal do projeto.

---

## 🔍 Exemplo de Query
Para validar o modelo de entregas e clientes PJ:
```sql
SELECT 
    pj.razao_social, 
    p.id_pedido, 
    e.status_entrega, 
    e.codigo_rastreio
FROM PessoaJuridica pj
JOIN Pedido p ON pj.id_pj = p.id_cliente
JOIN Entrega e ON p.id_pedido = e.id_pedido;
