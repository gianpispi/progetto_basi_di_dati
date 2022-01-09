Menoo
Per questo progetto si è utilizzato **PostgreSQL** 11.11 (Postgres) come DBMS.

Strumenti aggiuntivi
Per eseguire le query SQL, è stato utilizzato il programma TablePlus (https://tableplus.com).

Hosting
Inizialmente si era installato Postgres in locale, ma si è vista la necessità di accederci anche da remoto. Si è quindi utilizzato ElephantSQL (https://www.elephantsql.com), per avere una istanza fully managed online. Con il seguente comando si può vedere su che sistema gira l’istanza.

SELECT version(); // PostgreSQL 11.11 (Ubuntu 11.11-1.pgdg20.04+1) on x86_64-pc-linux-gnu, compiled by gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0, 64-bit

Riproduzione del database
In allegato è presente un file "menoo.sql", che contiene il dump del database. È stato generato tramite ElephantSQL, dal momento che non si ha accesso all bash, e poi scompattato tramite "lzop".
Per prima cosa si deve creare il database. Via SQL basterà eseguire:
CREATE DATABASE menoo;

Se si vuole utilizzare postgresql, invece:
createdb menoo

Una volta creato il database, si vanno a creare le relazioni e le entità, con i vari dati. Si può fare in tre modi diversi:

Manualmente
Si possono eseguire le istruzioni SQL che si trovano nel file `menoo-manuale.sql`, scritto a mano mentre si implementava il database.

Manualmente tramite il dump
È possibile eseguire tutte le istruzioni contenute nel file `menoo.sql`.

Tramite il dump (Non eseguibile se si utilizza ElephantSQL)
Eseguendo pg_restore (https://www.postgresql.org/docs/9.3/app-pgrestore.html) con il seguente comando Bash:
pg_restore --dbname="menoo" --schema="public" --file="menoo.sql"


Operazioni
Le operazioni più significative da eseguire sul database, si possono trovare nel file menoo_operations.sql.


----
menoo command line tool
È stato implementato anche un programma a linea di comando (situato nella cartella Menoo), chiamato menoo, per effettuare le operazioni principali visibili nella relazione. Il tool è stato scritto in Swift. Le librerie utilizzate sono "PostgresClientKit" (https://github.com/codewinsdotcom/PostgresClientKit) (simile a JDBC su Java), per parlare con il DBMS, "Rainbow" (https://github.com/onevcat/Rainbow) per colorare l’output sul terminale e "swift-argument-parser" (https://github.com/apple/swift-argument-parser) per implementare facilmente la lettura e la gestione degli argomenti e dei sottocomandi.

Come utilizzare menoo
Per utilizzare menoo ci sono due modi:
1. eseguire il programma menoo presente al link (https://drive.google.com/drive/folders/14aWHSnj2NFyb7KcuUM27DaeBpkSdHwZZ?usp=sharing)
Eseguire il programma già compilato è più semplice, soprattutto se non si ha Xcode installato; basterà navigare nella cartella dove è contenuto il programma, ed eseguirlo tramite ./menoo con eventuali argomenti che verranno discussi successivamente.

ATTENZIONE: se l’esecuzione del programma viene bloccata dal sistema perchè non sicura, basterà andare in Preferenze di sistema > Sicurezza e privacy > Generale e premere sul pulsante che ne forza l’apertura. Provando ad eseguire nuovamente il programma, si potrà decidere se eseguirlo o meno.

2. compilare il programma
Per compilare il programma si necessita di Xcode, un software per lo sviluppo di applicazioni Apple (Si può compilare anche su Linux, dove serve la Swift toolchain (https://www.swift.org/download/)).
Per creare l'eseguibile, spostarsi nella cartella “Menoo”, ed eseguire il comando "make". Questo compila l'eseguibile, e lo sposta nella cartella attuale.

Durante l’utilizzo del programma, è possibile che venga richiesta la password del computer. Questo è dato dal fatto che la password per accedere al DBMS viene salvata nel Keychain del sistema in modo sicuro, e serve la password per accederci.

menoo CLI ha alcuni comandi disponibili, che verranno analizzati qui di seguito.

Login
Il comando "login" va effettuato all’inizio, e serve per effettuare il login al DBMS. I dati vengono salvati in memoria per essere utilizzati ogni volta che si esegue una operazione sul DBMS.
./menoo login host.example.com username password [-d databaseName]

Setup
Il comando "setup" implementa il setup del database. Verranno create e popolate tutte le entità e le relazioni. Tutte le operazioni eseguite saranno quelle che si trovano nel file "menoo-manuale.sql".
./menoo setup

Query
Il comando "query" viene utilizzato per eseguire una query personalizzata.
./menoo query "SELECT * FROM UTENTE WERE NOME LIKE 'Giulio%';"

Operations
"operations" implementa le operazioni più significative, visibili nel capitolo “Operazioni previste dalla base di dati”.
Lista delle operazioni eseguibili: 
menoo operations -l

La lista mostra il nome dell’operazione, e i parametri che servono per eseguirla. Ad esempio, un’operazione è:
ristorantiInZona: città

L’esecuzione sarà quindi:
menoo operations ristorantiInZona trento

L'argomento "-c" impone una lunghezza limite alle colonne durante la stampa del risultato.

Signout
Il comando signout elimina tutti i dati salvati durante il login.
./menoo signout

Per tutti i comandi esiste un’opzione "--no-color" che disattiva il testo colorato.

