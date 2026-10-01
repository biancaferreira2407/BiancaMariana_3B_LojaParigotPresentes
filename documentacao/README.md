# Sistema de Gerenciamento da Loja Parigot Presentes

## Descrição

Este projeto consiste em um sistema web desenvolvido para o
gerenciamento da loja de presentes **Parigot Presentes**. O sistema
permite cadastrar, consultar, alterar e excluir informações de
diferentes entidades da loja, além de possibilitar o cadastro de
pedidos, consulta de pedidos realizados, gerenciamento de estoque e
associação de imagens aos produtos.

O sistema possui uma interface web desenvolvida com HTML, CSS e
JavaScript, um back-end desenvolvido com Node.js e Express.js e um banco
de dados PostgreSQL.

------------------------------------------------------------------------

## Tecnologias Utilizadas

### Front-end

-   HTML5
-   CSS3
-   JavaScript

### Back-end

-   Node.js
-   Express.js

### Banco de Dados

-   PostgreSQL

### Bibliotecas e dependências

-   `pg` --- conexão com o PostgreSQL
-   `express` --- criação do servidor e das rotas da API
-   `cors` --- permitir a comunicação entre front-end e back-end
-   `dotenv` --- carregamento das configurações do arquivo `.env`
-   `multer` --- recebimento de arquivos enviados pelo formulário
-   `sharp` --- processamento e redimensionamento das imagens dos
    produtos
-   `nodemon` --- reinicialização automática do servidor durante o
    desenvolvimento

### Ferramentas

-   Visual Studio Code
-   Live Server
-   pgAdmin 4
-   Git e GitHub


## Funcionalidades

### Menu Principal

O `index.html` direciona o usuário para o menu principal do sistema.

No menu estão disponíveis os módulos:

-   Produtos
-   Pedidos
    -   Novo pedido
    -   Pedidos realizados
-   Cargos
-   Unidades de Medida
-   Pessoas
-   Categorias
-   Formas de Pagamento

------------------------------------------------------------------------

### Cargo

Permite gerenciar os cargos cadastrados no sistema.

Funcionalidades:

-   Consultar um cargo pelo ID;
-   Inserir um novo cargo quando o ID não estiver cadastrado;
-   Alterar os dados de um cargo existente;
-   Excluir um cargo;
-   Listar os cargos cadastrados.

------------------------------------------------------------------------

### Categoria

Permite gerenciar as categorias utilizadas nos produtos.

Funcionalidades:

-   Consultar uma categoria pelo ID;
-   Inserir uma nova categoria;
-   Alterar uma categoria existente;
-   Excluir uma categoria;
-   Listar as categorias cadastradas.

------------------------------------------------------------------------

### Forma de Pagamento

Permite gerenciar as formas de pagamento disponíveis para os pedidos.

Funcionalidades:

-   Consultar uma forma de pagamento pelo ID;
-   Inserir uma nova forma de pagamento;
-   Alterar uma forma de pagamento existente;
-   Excluir uma forma de pagamento;
-   Listar as formas de pagamento cadastradas.

As formas de pagamento cadastradas podem ser utilizadas no cadastro de
novos pedidos.

------------------------------------------------------------------------

### Pessoa

Permite cadastrar e gerenciar as pessoas do sistema utilizando o CPF
como identificador.

Funcionalidades:

-   Consultar uma pessoa pelo CPF;
-   Inserir uma nova pessoa;
-   Alterar os dados de uma pessoa;
-   Excluir uma pessoa;
-   Listar as pessoas cadastradas.

O cadastro de pessoa também permite indicar se a pessoa é:

-   **Funcionário**, com cargo, salário e porcentagem de comissão;
-   **Cliente**, com renda mensal e data de cadastro.

Dessa forma, os dados de clientes e funcionários são gerenciados a
partir do cadastro de pessoas.

------------------------------------------------------------------------

### Produto

Permite gerenciar os produtos e seus dados de estoque.

Funcionalidades:

-   Consultar um produto pelo ID;
-   Inserir um novo produto;
-   Alterar um produto existente;
-   Excluir um produto;
-   Listar os produtos cadastrados;
-   Informar a unidade de medida;
-   Informar a categoria;
-   Informar a quantidade em estoque;
-   Informar o preço unitário;
-   Adicionar ou alterar a imagem do produto.

#### Imagens dos produtos

As imagens ficam armazenadas na pasta `imagens/`.

Ao enviar uma imagem pelo sistema, ela é processada pelo back-end
utilizando a biblioteca `sharp`, sendo redimensionada para **300 × 300
pixels** e armazenada em formato JPEG.

Quando uma imagem não é encontrada, o sistema pode utilizar a imagem de
silhueta como imagem padrão.

------------------------------------------------------------------------

### Unidade de Medida

Permite gerenciar as unidades de medida utilizadas nos produtos.

Funcionalidades:

-   Consultar uma unidade pelo ID/sigla;
-   Inserir uma nova unidade;
-   Alterar uma unidade existente;
-   Excluir uma unidade;
-   Listar as unidades cadastradas.

A sigla da unidade possui limite de dois caracteres.

------------------------------------------------------------------------

### Pedido

O módulo de pedidos é dividido em **Novo Pedido** e **Pedidos
Realizados**.

#### Novo Pedido

Permite cadastrar uma nova venda.

Durante o cadastro é possível:

-   Gerar automaticamente o ID do pedido;
-   Informar a data do pedido;
-   Selecionar um cliente;
-   Selecionar um funcionário;
-   Adicionar um ou mais produtos;
-   Informar a quantidade de cada produto;
-   Consultar o preço unitário e o subtotal;
-   Calcular o total do pedido;
-   Selecionar uma ou mais formas de pagamento;
-   Informar o valor pago em cada forma de pagamento;
-   Conferir o total pago e o valor restante.

O sistema verifica se existe estoque suficiente para a quantidade
solicitada. Ao finalizar o pedido, a quantidade dos produtos vendidos é
descontada do estoque.

O valor dos pagamentos deve corresponder ao total do pedido para que o
cadastro seja concluído.

#### Pedidos Realizados

Permite consultar os pedidos já cadastrados.

A tela apresenta:

-   ID do pedido;
-   Data;
-   Cliente;
-   Funcionário;
-   Total;
-   Ação para visualizar os detalhes.

Também possui um campo de pesquisa que permite filtrar os pedidos por
informações como:

-   ID;
-   Cliente;
-   Data.

Ao abrir os detalhes de um pedido, são exibidos os produtos,
quantidades, valores e formas de pagamento utilizadas.

**Observação:** o módulo de pedidos implementado atualmente permite
criar e consultar pedidos e visualizar seus detalhes. Não há operações
de alteração e exclusão de pedidos disponíveis na interface.

------------------------------------------------------------------------

## Funcionamento do Sistema

O sistema utiliza uma arquitetura dividida entre front-end, back-end e
banco de dados.

1.  O usuário acessa o `index.html`.
2.  O `index.html` direciona para o menu principal.
3.  O usuário escolhe o módulo que deseja utilizar.
4.  O JavaScript do front-end envia requisições HTTP para o servidor
    Node.js utilizando a **Fetch API**.
5.  O servidor Express recebe as requisições por meio das rotas
    correspondentes.
6.  Os controllers processam as operações solicitadas.
7.  O arquivo `database.js` realiza a comunicação com o PostgreSQL.
8.  O banco de dados executa as consultas de inserção, consulta,
    alteração ou exclusão.
9.  O back-end retorna os resultados ao front-end, normalmente em
    formato JSON.
10. O JavaScript processa as respostas e atualiza a interface do
    sistema.

------------------------------------------------------------------------

## API

As principais rotas da API são:

``` text
/produto
/unidade_medida
/categoria
/cargo
/forma_pagamento
/pessoa
/cliente
/funcionario
/pedido
```

As entidades com CRUD completo possuem operações de consulta, inserção,
alteração e exclusão.

O módulo de pedidos possui atualmente operações para:

-   Criar pedido;
-   Listar pedidos;
-   Consultar os detalhes de um pedido.

------------------------------------------------------------------------

## Banco de Dados

O banco de dados é criado a partir do arquivo:

``` text
documentacao/dw_proj_3b.sql
```

O script SQL cria as seguintes tabelas:

-   `cargo`
-   `pessoa`
-   `cliente`
-   `forma_pagamento`
-   `funcionario`
-   `categoria`
-   `unidade_medida`
-   `produto`
-   `pedido`
-   `pedido_has_produto`
-   `pagamento`
-   `pagamento_has_forma_pagamento`

### Relacionamentos principais

-   `cliente` utiliza `pessoa` como referência;
-   `funcionario` utiliza `pessoa` como referência;
-   `funcionario` possui relação com `cargo`;
-   `produto` possui relação com `categoria`;
-   `produto` possui relação com `unidade_medida`;
-   `pedido` possui relação com cliente e funcionário;
-   `pedido_has_produto` relaciona pedidos e produtos;
-   `pagamento` está relacionado ao pedido;
-   `pagamento_has_forma_pagamento` relaciona pagamentos e formas de
    pagamento.

O arquivo SQL também contém dados iniciais para as tabelas utilizadas
pelo sistema.

------------------------------------------------------------------------

## Como Executar o Projeto

### 1. Clonar o repositório

``` bash
git clone URL_DO_REPOSITORIO
```

Depois, entre na pasta do projeto:

``` bash
cd 3B_SistemaDeGerenciamentoLoja
```

------------------------------------------------------------------------

### 2. Restaurar o banco de dados

Abra o PostgreSQL pelo **pgAdmin 4**.

Crie ou selecione o banco de dados que será utilizado pelo projeto e
execute o arquivo:

``` text
documentacao/dw_proj_3b.sql
```

O script cria as tabelas e insere os dados iniciais.

------------------------------------------------------------------------

### 3. Configurar o arquivo `.env`

O arquivo `.env` deve ficar dentro da pasta `backend/`.

Configure as informações de conexão com o PostgreSQL:

``` env
DB_HOST=
DB_PORT=
DB_NAME=
DB_USER=
DB_PASSWORD=

PORT=3001
```

Os nomes das variáveis devem ser mantidos exatamente dessa forma, pois
são os nomes utilizados pelo código do projeto.

------------------------------------------------------------------------

### 4. Instalar as dependências

Abra o terminal na **pasta raiz do projeto**, onde está localizado o
`package.json`.

Execute:

``` bash
npm install express pg cors dotenv
```

Esse comando instala as dependências necessárias para o back-end e para
o processamento das imagens.

------------------------------------------------------------------------

### 5. Iniciar o servidor

Ainda na pasta raiz do projeto, execute:

``` bash
npm start
```

O comando inicia:

``` text
backend/server.js
```

O servidor ficará disponível, por padrão, em:

``` text
http://localhost:3001
```

Durante a inicialização, o sistema também testa a conexão com o banco de
dados PostgreSQL.

------------------------------------------------------------------------

### 6. Abrir o sistema

Com o servidor em execução, abra no navegador:

``` text
http://localhost:3001/index.html
```

O `index.html` direcionará automaticamente para o menu principal.

Também é possível utilizar o **Live Server** do Visual Studio Code para
abrir o front-end, porém o servidor Node.js e a conexão com o PostgreSQL
precisam continuar em execução para que as funcionalidades que utilizam
a API funcionem corretamente.

------------------------------------------------------------------------

## Tecnologias de Comunicação

O sistema utiliza:

-   **Fetch API** para comunicação entre o front-end e o back-end;
-   **JSON** para troca de dados entre as partes do sistema;
-   **Express.js** para criação do servidor e das rotas;
-   **PostgreSQL** para armazenamento dos dados;
-   **CORS** para permitir requisições entre diferentes origens durante
    o desenvolvimento.

------------------------------------------------------------------------

## Observações

-   O sistema atual **não possui uma tela de autenticação**.
-   Os pedidos possuem cadastro e consulta, mas não possuem alteração ou
    exclusão pela interface atual.
-   As imagens dos produtos são armazenadas na pasta `imagens/`.
