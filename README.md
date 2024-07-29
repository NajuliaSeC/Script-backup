
# Script de Backup usando Bash

## Descrição
 Este projeto contém um script Bash projetado para automatizar o processo de backup de um banco de dados MySQL e enviar o arquivo de backup para um servidor remoto.

## Estrutura do Script
|Funções criadas | Funcionalidade |
|------|----------|
|ChecaConexao |Verifica se a conexão com o servidor remoto está ativa antes de iniciar o backup. |
|logger   | Gera logs detalhados do processo de backup.|
|dumpMysql | Cria um dump do banco de dados MySQL especificado.|
|CompactaArquivos | Compacta os arquivos de backup em um arquivo tar.gz.|
|envioNuvem | Transfere o arquivo de backup para um servidor remoto.|
|ChecarIntegridade | Compara os hashes MD5 dos arquivos locais e remotos para garantir a integridade dos dados transferidos. |

## Exemplo de Utilização
O ip da máquina linux (root) deve ser alterado para aquele a ser usado pelo usuário.
~~~
ssh root@10.0.0.2 ls >/dev/null 2>&1
~~~
É importante que o banco e a tabela já estejam criados para geração do dump.
~~~
 mysqldump Produtos --tables vendas >dump.sql  2>/dev/null
~~~

## Tecnologias Usadas Neste Projeto
| Tecnologia | Descrição                                                                 |
|-------------|-------------------------------------|
| Bash        |Shell scripting e linguagem de programação para automação e manipulação de tarefas em ambientes Unix/Linux.                                            |
| MySQL       | Banco de dados relacional utilizado no backup.                             |
| mysqldump   | Utilitário para criar dumps do banco de dados MySQL.                       |
| scp         | Utilitário para copiar arquivos entre hosts na rede.                       |
| md5sum      | Ferramenta para gerar hashes MD5 para verificação de integridade de arquivos. |
| SSH         | Protocolo para acesso seguro e transferência de arquivos.                   |

## Contribuições
Contribuições são muito bem-vindas. Caso você encontre erros, bugs ou queira adicionar novas funções, sinta-se à vontade.
