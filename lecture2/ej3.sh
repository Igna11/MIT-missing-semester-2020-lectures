#!/usr/bin/env bash

# Defino el contador
CONTADOR=0

# borro el file de logs de la corrida anterior
rm run_logs.log

# while loop que se rompe cuando el stderr pasa al stdoup como error con el if de abajo
while true; do
    echo "intento #$CONTADOR"
    ((CONTADOR++))
    
    #In Bash, 2 is the file descriptor for the standard error stream (stderr), while 1 is the file descriptor
    # for the standard output stream (stdout). The notation 2>&1 is used to redirect stderr to stdout. It 
    #basically means "make file descriptor 2 (stderr) refer to the same file descriptor as 1 (stdout)".
    DATE=$(date -u +"%d/%m/%Y - %H:%M:%S.%3N - UTC")
    echo "$DATE - INFO - run $CONTADOR successfull" >> run_logs.log
    OUTPUT=$(./random_bug.sh 2>&1)
    
    if [[ $? -ne 0 ]]; then
        echo "acá falló, en la vez numero: $CONTADOR"
        echo "$DATE - ERROR - run $CONTADOR failed: $OUTPUT" >> run_logs.log
        exit
    fi
done

