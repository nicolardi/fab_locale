# Welcome to a basic LAMP Docker environment

# Pre-requisiti

Il pre-requisito è avere installato Docker sul vostro sistema operativo.
A tale riguardo ho creato una [guida](https://docs.google.com/document/d/1ajQ6AcAxoSe6N-IBc7AVt-EllnT1fpk_L6fMos3077w/edit?usp=sharing) per **Windows** e per **MacOsX**

## Cosa contiene questo repo

Il repo crea un ambiente con

- PHP7.4 con xDebug
- Maria DB
- phpMyAdmin
- Apache con document root nella directory web

## Lancio dell'ambiente di sviluppo

aprire un terminale e entrare nella directory del progetto
Eseguire questo comando:

    docker-compose up

Al termine del lancio del sistema sarà possibile

- sviluppare usando una IDE qualsiasi (consiglio vscode)
- accedere al sito mediante [http://localhost:8000](http://localhost:8000)
- accedere a phpMyAdmin mediante [http://localhost:8001](http://localhost:8001)


Per entrare nel container web lanciare in un nuovo terminale (sempre dalla directory del progetto)

    docker-compose run -i web bash

Le password del database sono:

    
    user: db
    pass: tiger
    

L'indirizzo del server (per collegarsi da PHP) è:

    
    host: db
    




