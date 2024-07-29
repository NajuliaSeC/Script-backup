#!/bin/bash

#Funcao para testar conexao antes do backup
ChecaConexao(){
#O endereço root pode ser alterado para o ip a ser testado pelo usuário
    ssh root@10.0.0.2 ls >/dev/null 2>&1
    [ $? -eq 0 ] && logger OK "Conexão realizada com sucesso" || logger NOK "Não foi possível se conectar" || exit
}

BACKUP_FILE="backup_$(date +%d-%m-%Y).tar.gz"

# Funcao para gerar log
logger(){
    data=$(date "+%d/%m/%Y-%H:%M:%S")
    echo "[$data] [$1] - $2" >> /var/log/backup.log
}

# Funcao para criar o arquivo .sql
dumpMysql(){
    mysqldump Produtos --tables vendas >dump.sql 2>/dev/null
    [ $? -eq 0 ] && logger OK "Dump gerado com sucesso" || logger NOK "Problema ao gerar o Dump"
}

# Funcao para criar o arquivo .tar.gz
CompactaArquivos(){
    tar -czf $BACKUP_FILE -T lista_arquivos.txt >/dev/null 2>&1
    [ $? -eq 0 ] && logger OK "Tarball gerado com sucesso" || logger NOK "Problema ao gerar o tarball"
}

# Funcao para enviar o remoto do backup
envioNuvem(){
    scp $BACKUP_FILE root@10.0.0.2: >/dev/null 2>&1
    [ $? -eq 0 ] && logger OK "Arquivo enviado com sucesso p/ nuvem" || logger NOK "Erro no envio"
}

# Funcao para checar integridade
ChecarIntegridade(){
    HASH_LOCAL=$(md5sum $BACKUP_FILE | awk '{print $1}')
    HASH_REMOTO=$(ssh root@10.0.0.2 md5sum $BACKUP_FILE | awk '{print $1}')
    [ $HASH_LOCAL = $HASH_REMOTO ] && logger OK "Arquivos idênticos" || logger NOK "Arquivos divergentes"
}

logger INFO "Iniciando backup"
ChecaConexao
dumpMysql
CompactaArquivos
envioNuvem
ChecarIntegridade
logger INFO "Backup finalizado"

