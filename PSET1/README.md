
# Design e Desenvolvimento de Bancos de Dados

## PSET1

### Aluno: João Moura Brasileiro

### Professor: Abrantes Araújo Silva Filho

### Monitora: Suellen Miranda Amorim

### Turma: CC1Mb

# **1. Introdução**

O trabalho tem como foco principal a implementação de um banco de dados de modelo empresarial sobre as **lojas da UVV**,  apresentado na prova de primeiro bimestre do primeiro período de Ciências da Computação. O Banco de Dados apresentava diversas tabelas e colunas sobre os diversos níveis necessários para uma loja funcionar. Com isso em mente segui essa estrutura apresentada no [guia do PSET1:](https://github.com/joaomourabr/uvv_bd1_cc1mb/blob/main/PSET1/Documenta%C3%A7%C3%A3o/Guia%20para%20o%20pset1.pdf/) 

> -   Projeto Lógico
> -   Implementação no PostgreSQL
> -   Implementação no MariaBD/MySQL

Usei essas ferramentas para a realização do **PSET:**

> -   SQL Power Architect (Utilizada para a criação do Projeto Lógico)
> -   DBeaver (Usada para verificar e gerenciar o Banco de Dados)
> -   Oracle VM VirtualBox 


# **2. Projeto Lógico**


 Usando a ferramenta SQL Power Architect iniciamos a construção do projeto lógico da tabela do **Banco de Dados das Lojas UVV**.


![](https://github.com/joaomourabr/uvv_bd1_cc1mb/blob/main/PSET1/Imgs/Banco%20de%20Dados%20UVV%20PA.png?raw=true)




## 2.1 Transformação do script para implementação no POSTGRES


Após a construção das tabelas, colunas, referências e os comentários utilizei a ferramenta do próprio SQL Power Architect  chamada **Foward Engineer SQL Script** para a transformação dessas tabelas em um código SQL que poderia ser implementado no **POSTGRESQL**.



![](https://github.com/joaomourabr/uvv_bd1_cc1mb/blob/main/PSET1/Imgs/SQL%20FE.png?raw=true)



Após aplicar para qual tipo de DB quero que o código SQL seja criado (nesse caso o Postgres) ele me gerou o código já pronto para ser implementado no Script SQL.



![](https://github.com/joaomourabr/uvv_bd1_cc1mb/blob/main/PSET1/Imgs/Criar%20Script.png?raw=true)



Essa ferramenta é extremamente útil, e já dá uma grande ajuda na realização do **PSET**. Faltando apenas adicionar alguns ajustes, como adicionar algumas **constraints** e comandos de **criação**.




## 2.2 Transformação do script para implementação no MySql/MARIADB 



Como parte **opcional** fiz a realização do mesmo código SQL só que utilizando o bando de dados **MySQL/MARIADB**. Para a transformação do código utilizei a mesma ferramenta da Foward Enginner somente com a diferença do tipo de DB



![](https://github.com/joaomourabr/uvv_bd1_cc1mb/blob/main/PSET1/Imgs/Print%20MARIADB%20FE.png?raw=true)



Ele também me gerou um código pronto para implementação, também adaptado para o **MySQL**.



![](https://github.com/joaomourabr/uvv_bd1_cc1mb/blob/main/PSET1/Imgs/Criar%20Script%20MySQL.png?raw=true)




# **3. Implementação no PostgreSQL**



Após gerar, ajustar e corrigir o código, ele está pronto para ser implementado em um Script. Para isso criei o [arquivo](https://github.com/joaomourabr/uvv_bd1_cc1mb/blob/main/PSET1/cc1mb_202307793_postgresql.sql)  que ira rodar o script no terminal e gerar o banco de dados na **máquina virtual**.



![](https://github.com/joaomourabr/uvv_bd1_cc1mb/blob/main/PSET1/Imgs/Console%20SQL%20postgres.png?raw=)



Digitei a senha do usuário postgres e o script **funcionou sem problemas**.



![](https://github.com/joaomourabr/uvv_bd1_cc1mb/blob/main/PSET1/Imgs/Criacao%20do%20BD%20Postgres%201.png?raw=true)



Podemos checar se o banco de dados foi criado com sucesso usando o DBeaver.



![](https://github.com/joaomourabr/uvv_bd1_cc1mb/blob/main/PSET1/Imgs/DBeaver%20postgres.png?raw=true)



**Banco de Dados usando o postgres criado com sucesso!**



# **4. Implementação no MySql/MARIADB**




Agora com o Script do Postgres gerado e funcionando, apenas adaptei o código para funcionar no banco de dados MySql, como, remover as configurações dos squemas, mudar os comandos de criação de tabelas e colunas e modificar as constraints. Com o código devidamente adaptado agora só criar o [arquivo](https://github.com/joaomourabr/uvv_bd1_cc1mb/blob/main/PSET1/cc1mb_202307793_MySql.sql)  que ira rodar o script no terminal e gerar o banco de dados na **máquina virtual**.



![](https://github.com/joaomourabr/uvv_bd1_cc1mb/blob/main/PSET1/Imgs/Console%20SQL%20My%20Sql.png?raw=true)



Digitei a senha do usuário MySqle o script **funcionou sem problemas**. Porém, ele não mostra um log igual a versão postgres, então iremos usar o DBeaver para checar se foi criado.  



![](https://github.com/joaomourabr/uvv_bd1_cc1mb/blob/main/PSET1/Imgs/criacao%20do%20BD%20MySql.png?raw=true)



Checando no DBeaver



![](https://github.com/joaomourabr/uvv_bd1_cc1mb/blob/main/PSET1/Imgs/DBeaver%20MySql.png?raw=true)



**Banco de Dados usando o MySql criado com sucesso!**



# **5. Conclusão**



Bom com isso o **PSET1 está finalizado!** Esse projeto foi uma gande forma de aprender mais sobre o conteúdo de **Banco de Dados** e tudo que o envolve. Fui um projeto difícil, pois tive que me esforçar bastante para aprender duas linguagens SQl para a realização dos scripts, o Postgres e o MySql, e para fazer eles funcionarem sem erros e criar os bancos de dados nos lugares certos foi uma aventura por si só. Enfim foi uma experiência única de aprendizado, além de ter sido um grande desafio que foi extremamente satisfatório de ser superado.
