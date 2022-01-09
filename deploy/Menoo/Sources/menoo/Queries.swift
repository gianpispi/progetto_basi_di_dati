//
//  File.swift
//  
//
//  Created by Gianpiero Spinelli on 07/01/22.
//

import Foundation

// Dal momento che non si possono integrare file di supporto nel bundle di una command line app, questo è una buona alternativa

struct QueryElement {
    var name: String
    var arguments: [String]? = nil
    var body: String
}

extension Menoo {
    static let queries: [QueryElement] = [QueryElement(name: "Installo uuid-ossp, per generare uuid come valore di default".bold, body: """
    -- Installo uuid-ossp, per generare uuid come valore di default
    CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
    """), QueryElement(name: "Creo la tabella per allergene".bold, body: """
    -- Creo la tabella per allergene
    CREATE TABLE ALLERGENE (
        ID SMALLSERIAL PRIMARY KEY,
        NOME VARCHAR(60) NOT NULL,
        DESCRIZIONE TEXT NOT NULL
    );
    """), QueryElement(name: "Creo la tabella per portata".bold, body: """
    -- Creo la tabella per portata
    CREATE TABLE PORTATA (
        ID UUID PRIMARY KEY NOT NULL DEFAULT uuid_generate_v1(),
        NOME VARCHAR(60) NOT NULL,
        ORDINE SMALLINT NOT NULL DEFAULT 0
    );
    """), QueryElement(name: "Creo la tabella per gli utenti".bold, body: """
    -- Creo la tabella per gli utenti
    CREATE TABLE UTENTE (
        ID UUID NOT NULL PRIMARY KEY DEFAULT uuid_generate_v1(),
        EMAIL TEXT NOT NULL,
        NOME VARCHAR(60) NOT NULL,
        PASSWORD TEXT NOT NULL,
        DATA_ISCRIZIONE TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        IMMAGINE_PROFILO TEXT,
        CONSTRAINT utente_email_check CHECK (EMAIL ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$' )
    );
    """), QueryElement(name: "Creo un indice per la mail, in modo da verificare le email in lowercase".bold, body: """
    -- Creo un indice per la mail, in modo da verificare le email in lowercase
    CREATE UNIQUE INDEX USER_UNIQUE_LOWER_EMAIL_INDEX on UTENTE (lower(EMAIL));
    """), QueryElement(name: "Creo la tabella per ristoratore".bold, body: """
    -- Creo la tabella per i ristoratori
    CREATE TABLE RISTORATORE (
        ID UUID NOT NULL PRIMARY KEY DEFAULT uuid_generate_v1(),
        EMAIL TEXT NOT NULL,
        NOME VARCHAR(60) NOT NULL,
        PASSWORD TEXT NOT NULL,
        DATA_ISCRIZIONE TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        IMMAGINE_PROFILO TEXT,
        CONSTRAINT ristoratore_email_check CHECK (EMAIL ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$' )
    );
    """), QueryElement(name: "CREATE UNIQUE INDEX RISTORATORE_UNIQUE_LOWER_EMAIL_INDEX on RISTORATORE (lower(EMAIL));".bold, body: """
    CREATE UNIQUE INDEX RISTORATORE_UNIQUE_LOWER_EMAIL_INDEX on RISTORATORE (lower(EMAIL));
    """), QueryElement(name: "Creo la tabella per ristorante".bold, body: """
    -- Creo la tabella per ristorante
    CREATE TABLE RISTORANTE (
        ID UUID PRIMARY KEY DEFAULT uuid_generate_v1(),
        NOME VARCHAR(60) NOT NULL,
        CAP VARCHAR(15) NOT NULL,
        SITO_WEB TEXT,
        TELEFONO TEXT,
        COVER TEXT,
        LOGO TEXT,
        ACCETTA_PRENOTAZIONI BOOL NOT NULL,
        ACCETTA_RECENSIONI BOOL NOT NULL DEFAULT TRUE,
        CITTA VARCHAR(100) NOT NULL,
        INDIRIZZO TEXT NOT NULL,
        DATA_AGGIUNTA TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        CONSTRAINT ristorante_sito_web_check CHECK (SITO_WEB ~ 'https?:\\/\\/(www\\.)?[-a-zA-Z0-9@:%._\\+~#=]{2,255}\\.[a-z]{2,9}\\y([-a-zA-Z0-9@:%_\\+.~#?&//=]*)$'),
        CONSTRAINT ristorante_telefono_check CHECK (TELEFONO ~ '^[\\+]?[(]?[0-9]{3}[)]?[-\\s\\.]?[0-9]{3}[-\\s\\.]?[0-9]{4,6}$'),
        CONSTRAINT ristorante_cap_check CHECK (CAP ~ '^\\d{5}(?:[-\\s]\\d{4})?$'),
        CONSTRAINT UNIQUE_ADDRESS UNIQUE (CAP, INDIRIZZO, NOME)
    );
    """), QueryElement(name: "Creo la tabella per recensione".bold, body: """
    -- Creo la tabella per recensione
    CREATE TABLE RECENSIONE (
        RISTORANTE UUID NOT NULL REFERENCES RISTORANTE(ID) ON DELETE CASCADE,
        UTENTE UUID NOT NULL REFERENCES UTENTE(ID) ON DELETE CASCADE,
        TESTO TEXT NOT NULL,
        VALUTAZIONE NUMERIC NOT NULL,
        DATA TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        CONSTRAINT recensione_valutazione_check CHECK (VALUTAZIONE <= 5.0 AND VALUTAZIONE > 0.0 AND ((VALUTAZIONE * 10) % 5 = 0)),
        PRIMARY KEY (RISTORANTE, UTENTE)
    );
    """), QueryElement(name: "Creo la tabella per la relazione tra utente e allergene".bold, body: """
    -- Creo la tabella per la relazione tra utente e allergene
    CREATE TABLE ALLERGIA (
        UTENTE UUID NOT NULL REFERENCES UTENTE(ID) ON DELETE CASCADE,
        ALLERGENE INT NOT NULL REFERENCES ALLERGENE(ID),
        DATA_AGGIUNTA TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (UTENTE, ALLERGENE)
    );
    """), QueryElement(name: "Creo la tabella per menu".bold, body: """
    -- Creo la tabella per menu
    CREATE TABLE MENU (
        ID UUID NOT NULL PRIMARY KEY DEFAULT uuid_generate_v1(),
        RISTORANTE UUID NOT NULL REFERENCES RISTORANTE(ID) ON DELETE CASCADE,
        NOME VARCHAR(100) NOT NULL,
        ATTIVO BOOL NOT NULL DEFAULT FALSE,
        DATA_CREAZIONE TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        ULTIMO_AGGIORNAMENTO TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        CONSTRAINT MENU_RISTORANTE_NOME UNIQUE(RISTORANTE, NOME)
    );
    """), QueryElement(name: "Creo la tabella per piatto".bold, body: """
    -- Creo la tabella per piatto
    CREATE TABLE PIATTO (
        ID UUID NOT NULL PRIMARY KEY DEFAULT uuid_generate_v1(),
        RISTORANTE UUID NOT NULL REFERENCES RISTORANTE(ID) ON DELETE CASCADE,
        NOME VARCHAR NOT NULL,
        PREZZO NUMERIC NOT NULL,
        FOTO TEXT,
        DESCRIZIONE TEXT,
        VEGANO BOOL NOT NULL,
        VEGETARIANO BOOL NOT NULL,
        PORTATA UUID NOT NULL REFERENCES PORTATA(ID) ON DELETE RESTRICT,
        DATA_AGGIUNTA TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        CONSTRAINT PIATTO_RISTORANTE_NOME UNIQUE (RISTORANTE, NOME)
    );
    """), QueryElement(name: "Creo la tabella per piatto_allergene".bold, body: """
    -- Creo la tabella per piatto_allergene
    CREATE TABLE PIATTO_ALLERGENE (
        PIATTO UUID NOT NULL REFERENCES PIATTO(ID) ON DELETE CASCADE,
        ALLERGENE INT NOT NULL REFERENCES ALLERGENE(ID),
        DISPONIBILE_SENZA BOOL NOT NULL DEFAULT FALSE, 
        DATA_AGGIUNTA TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (PIATTO, ALLERGENE)
    );
    """), QueryElement(name: "Creo la tabella per la relazione piatto-menu".bold, body: """
    -- Creo la tabella per la relazione piatto_menu
    CREATE TABLE PIATTO_MENU (
        MENU UUID NOT NULL REFERENCES MENU(ID) ON DELETE CASCADE,
        PIATTO UUID NOT NULL REFERENCES PIATTO(ID) ON DELETE CASCADE,
        POSIZIONE INT NOT NULL,
        DATA_AGGIUNTA TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (MENU, PIATTO)
    );
    """), QueryElement(name: "Creo tabella per gestione".bold, body: """
    -- Creo tabella per gestione
    CREATE TABLE GESTIONE (
        RISTORANTE UUID NOT NULL REFERENCES RISTORANTE(ID) ON DELETE CASCADE PRIMARY KEY,
        RISTORATORE UUID NOT NULL REFERENCES RISTORATORE(ID) ON DELETE RESTRICT,
        DATA_ASSEGNAZIONE TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        CONSTRAINT RISTORATORE_CON UNIQUE (RISTORATORE)
    );
    """), QueryElement(name: "CREATE OR REPLACE FUNCTION CREATE_TRIGGER_FOR_PLATE_MENU_ACTIVITY()".bold, body: """
    CREATE OR REPLACE FUNCTION CREATE_TRIGGER_FOR_PLATE_MENU_ACTIVITY()
    RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
        menu_restaurant_id UUID;
        piatto_restaurant_id UUID;
    BEGIN
        SELECT M.ristorante INTO menu_restaurant_id FROM MENU as M WHERE M.id = NEW.MENU LIMIT 1;
        SELECT P.ristorante INTO piatto_restaurant_id FROM PIATTO as P WHERE P.id = NEW.PIATTO LIMIT 1;
        
        IF menu_restaurant_id != piatto_restaurant_id
        THEN
            RAISE EXCEPTION 'Menu e piatto utilizzati non appartengono allo stesso ristorante.'
                    USING HINT = 'Per cortesia controllare gli id di piatto e menu.';
            RETURN NULL;
        END IF;
        RETURN NEW;
    END;
    $$;
    """), QueryElement(name: "CREATE TRIGGER PLATE_MENU_INSERT_ACTIVITY".bold, body: """
    CREATE TRIGGER PLATE_MENU_INSERT_ACTIVITY
        BEFORE INSERT ON PIATTO_MENU
        FOR EACH ROW
        EXECUTE PROCEDURE CREATE_TRIGGER_FOR_PLATE_MENU_ACTIVITY();
    """), QueryElement(name: "CREATE TRIGGER PLATE_MENU_UPDATE_ACTIVITY".bold, body: """
    CREATE TRIGGER PLATE_MENU_UPDATE_ACTIVITY
        BEFORE UPDATE ON PIATTO_MENU
        FOR EACH ROW
        WHEN (OLD.MENU IS DISTINCT FROM NEW.MENU OR OLD.PIATTO IS DISTINCT FROM NEW.PIATTO)
        EXECUTE PROCEDURE CREATE_TRIGGER_FOR_PLATE_MENU_ACTIVITY();
    """), QueryElement(name: "Controllo inserimento e aggiornamento recensione".bold, body: """
    -- Controllo inserimento e aggiornamento recensione
    CREATE OR REPLACE FUNCTION CREATE_TRIGGER_FOR_REVIEW_ACTIVITY()
    RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
        restaurant_accepts_review BOOL;
    BEGIN
        IF OLD.RISTORANTE IS DISTINCT FROM NEW.RISTORANTE
        THEN
            SELECT R.ACCETTA_RECENSIONI INTO restaurant_accepts_review FROM RISTORANTE as R WHERE R.id = NEW.RISTORANTE LIMIT 1;
            IF restaurant_accepts_review = FALSE
            THEN
                RAISE EXCEPTION 'Il ristorante per cui si sta inserendo la recensione non accetta recensioni'
                    USING HINT = 'Per cortesia controllare gli id del ristorante.';
                RETURN NULL;
            END IF;
        END IF;
        
        RETURN NEW;
    END;
    $$;
    """), QueryElement(name: "Creo il trigger per gli aggiornamenti della tabella".bold, body: """
    -- Creo il trigger per gli aggiornamenti della tabella
    CREATE TRIGGER RECENSIONE_UPDATE_ACTIVITY
        BEFORE UPDATE ON RECENSIONE
        FOR EACH ROW
        EXECUTE PROCEDURE CREATE_TRIGGER_FOR_REVIEW_ACTIVITY();
    """), QueryElement(name: "Creo il trigger per gli inserimenti nella tabella".bold, body: """
    -- Creo il trigger per gli inserimenti nella tabella
    CREATE TRIGGER RECENSIONE_INSERT_ACTIVITY
        BEFORE INSERT ON RECENSIONE
        FOR EACH ROW
        EXECUTE PROCEDURE CREATE_TRIGGER_FOR_REVIEW_ACTIVITY();
    """), QueryElement(name: "Inserisco gli allergeni nella tabella".bold, body: """
    -- Inserisco gli allergeni nella tabella
    INSERT INTO ALLERGENE VALUES (1, 'Glutine', 'Cereali, grano, segale, orzo, avena, farro, kamut, inclusi ibridati e derivati.'),
    (2, 'Crostacei e derivati', 'Sia quelli marini che d’acqua dolce: gamberi, scampi, aragoste, granchi, paguri e simili.'),
    (3, 'Uova e derivati', 'Tutti i prodotti composti con uova, anche in parte minima. Tra le più comuni: maionese, frittata, emulsionanti, pasta all’uovo, biscotti e torte anche salate, gelati e creme ecc.'),
    (4, 'Pesce e derivati', 'Inclusi i derivati, cioè tutti quei prodotti alimentari che si compongono di pesce, anche se in piccole percentuali.'),
    (5, 'Arachidi e derivati', 'Snack confezionati, creme e condimenti in cui vi sia anche in piccole dosi.'),
    (6, 'Soia e derivati', 'Latte di soia, tofu, spaghetti, etc.'),
    (7, 'Latte e derivati', 'Yogurt, biscotti e torte, gelato e creme varie. Ogni prodotto in cui viene usato il latte.'),
    (8, 'Frutta a guscio e derivati', 'Tutti i prodotti che includono: mandorle, nocciole, noci comuni, noci di acagiù, noci pecan e del Brasile e Queensland, pistacchi.'),
    (9, 'Sedano e derivati', 'Presente in pezzi ma pure all’interno di preparati per zuppe, salse e concentrati vegetali.'),
    (10, 'Senape e derivati', 'Si può trovare nelle salse e nei condimenti, specie nella mostarda.'),
    (11, 'Semi di sesamo e derivati', 'Oltre ai semi interi usati per il pane, possiamo trovare tracce in alcuni tipi di farine.'),
    (12, 'Anidride solforosa e solfiti', 'In concentrazioni superiori a 10 mg/kg o 10 mg/l espressi come SO2. Usati come conservanti, possiamo trovarli in: conserve di prodotti ittici, in cibi sott’aceto, sott’olio e in salamoia, nelle marmellate, nell’aceto, nei funghi secchi e nelle bibite analcoliche e succhi di frutta.'),
    (13, 'Lupino e derivati', 'Presente ormai in molti cibi vegan, sotto forma di arrosti, salamini, farine e similari che hanno come base questo legume, ricco di proteine.'),
    (14, 'Molluschi e derivati', 'Canestrello, cannolicchio, capasanta, cuore, dattero di mare, fasolaro, garagolo, lumachino, cozza, murice, ostrica, patella, tartufo di mare, tellina e vongola etc.');
    """), QueryElement(name: "Inserisco le portate nella tabella".bold, body: """
    -- Inserisco le portate nella tabella
    INSERT INTO PORTATA VALUES
    ('19CB3E0A-3ABD-4465-8FF6-6DAD85715EF4', 'Antipasti', 0),
    ('F0D37588-804E-4CFD-B823-36CFFBE6A02E', 'Antipasti di carne', 1),
    ('138562C1-B56B-408D-A502-04E57B5142D0', 'Antipasti di pesce', 2),
    ('541E5711-BA4B-4FB3-89CA-1351207F25C2', 'Primi', 3),
    ('D105187C-AF84-40DE-9EE7-01E7A9A0F484', 'Primi di carne', 4),
    ('6D167893-ADE5-4F8C-B252-676F04EE08B7', 'Primi di pesce', 5),
    ('3E81CF7A-4FA1-4E6D-96A8-1C471CC78F8D', 'Secondi', 6),
    ('DCAD11A7-9153-4209-A6F6-59F2C4FBFC0E', 'Secondi di carne', 7),
    ('150FA2C6-7FA9-4308-B558-222AF9B5F9C0', 'Secondi di pesce', 8),
    ('AAAE687E-CE71-443E-8F44-7216F174B625', 'Contorni', 9),
    ('4492352B-0484-46E2-935C-471AE36F2100', 'Pizze', 10),
    ('FB570E7B-C61B-430C-853C-A541EA8EDF07', 'Hamburger', 11),
    ('5411C029-867F-4CBA-9AB3-57B8EBA93370', 'Insalate', 12),
    ('31BBD71E-BF1B-42A0-B726-445E83076671', 'Dolci', 13),
    ('0250923C-420D-4810-9FF6-A9E62F6BE3A9', 'Bevande', 14),
    ('07914830-720C-4A87-8E76-93BEDB843E55', 'Caffè e ammazzacaffè', 15);
    """), QueryElement(name: "Inserisco gli utenti nella tabella".bold, body: """
    -- Inserisco gli utenti nella tabella
    -- Password encoded in sha1
    INSERT INTO UTENTE VALUES
    ('304635E6-DEE2-47F0-B41B-4B71BA3A0EC4', 'text@example.com', 'Giulio Arnoldi', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8'), -- password
    ('5A2E0F66-F568-4B58-A596-9CC10DBFD51D', 'alessio@capuzzisrl.it', 'Alessio Capuzzi', 'cde2e7655fd33b3ff5e34d351627c7f6143b6f73'), -- passwordcapuzzi
    ('91C1E2CD-63DA-4F8E-893B-C8BCB58A131B', 'gianni@gtrail.it', 'Gianni Alessandrini', '836fa98d6ff36bc487d708a03f865a629053ec98'), -- alessandr1n1
    ('80B36196-3292-495C-9F9E-0230F8E0C27C', 'troy@trin.com', 'Troy Bakari', '02a7e819d96cbb5c43ecf976b573756ca2382f0e'), -- troybak
    ('30E3A798-D16F-4B5F-BB93-750FDCD652BB', 'rebecca@gmeil.com', 'Rebecca Mazzi', 'a4244dfc49a0a4ea9602cfcc1201be91fe44b8a8'),
    ('C45A85D6-47BC-480B-9861-4C42642E4C77', 'gabriella@gmeil.com', 'Gabriella Fiorentino', '7d26fd159a71c72852facac0ea994134650b9f1d'),
    ('7551E169-356D-4E62-A600-48B60861AA82', 'liber0@gmeil.com', 'Libero Moretti', '78fdfe88a13b0249a30de57d1c34e42986c05e3b'),
    ('921E903E-2930-445A-9490-319325B6619D', 'fosca@gmeil.com', 'Fosca Siciliani', 'd757590b93d617e8ff6318897878cd90003f137f'),
    ('E7EDF825-47C5-4BFA-909D-103D2BAD33C7', 'augusta@gmeil.com', 'Augusta Capon', '5f83437018cce9eb7a6b3ed1e9b1678f1e472e9c'),
    ('893401BB-A0BB-4296-AA39-6241B137AF1B', 'erica@gmeil.com', 'Erica Lo Duca', '5ac109e09f6cb3803bf189604b86ff0864887232'),
    ('B71E4BAF-44F6-4CC7-B82D-CE7691856096', 'divo@gmeil.com', 'Divo Trentino', 'a0b4b67e5e7b4dc1cc134d45eff57d750f433bb9'),
    ('02F53330-BCA8-442A-8047-89636114CB14', 'ermanno@gmeil.com', 'Ermanno Bellucci', '42bb3112b3012440bdd01da30efab462961d73ac'),
    ('E48F7FFE-CFD4-401D-BD95-825E8BD73437', 'ciro@gmeil.com', 'Ciro Calabrese', 'b5b767e83bc7e5cee1d8da9c7175ce2078aaad4f'),
    ('4919F131-67E2-4D9A-BF9A-E5EA20E9123E', 'lionello@gmeil.com', 'Lionello De Luca', '1ee68473c0efaaa65175dd06880e308caf6a707c');
    """), QueryElement(name: "Inserisco i ristoratori nella tabella".bold, body: """
    -- Inserisco i ristoratori nella tabella
    -- Password encoded in sha1
    INSERT INTO RISTORATORE VALUES
    ('1442D1E5-240F-4088-B744-BF28C1B0D8CF', 'ale@typical.it', 'Alessandro di Giovanni', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8'), -- password
    ('BC4BE297-1235-42F5-A2CE-4983141BF853', 'rodolfo@loto.it', 'Rodolfo Andreini', 'a4958053d36c0f96daa380a48335c69751f652bf'), -- rodolfix
    ('6EE16A66-8354-4CC9-9B09-9754C66DE9B1', 'massimo@osteriafranzeschina.it', 'Massimo Bottara', 'f7aa433b92152760080e6bcf14eaf54a505f4b15'); -- massimino
    """), QueryElement(name: "Inserisco i ristoranti nella tabella".bold, body: """
    -- Inserisco i ristoranti nella tabella
    INSERT INTO RISTORANTE VALUES
    ('976A3F01-62A7-421D-88F6-FFD7CC79131F', 'Typical', '38122', 'https://typical.it', '04611975804', '', '', true, true, 'Trento', 'Via Calepina, 28'),
    ('74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', 'Loto', '38123', 'https://loto.it', '04611975804', '', '', true, true, 'Trento', 'Via Bolghera, 23'),
    ('3896862D-51B6-495E-8536-98310D93B39D', 'Auguri', '38122', 'https://www.augurioristorante.it', '0461193454', '', '', true, true, 'Trento', 'Via dietro le mura, B16'),
    ('B2ED7CF3-A59E-4E90-8572-3EF356BFB106', 'Osteria Franzeschina', '41121', 'https://osteriafranzeschina.it', '0591975804', '', '', true, true, 'Modena', 'Via Alghero, 54/A');
    """), QueryElement(name: "Inserisco le recensioni nella tabella".bold, body: """
    -- Inserisco le recensioni nella tabella
    INSERT INTO RECENSIONE VALUES
    -- Loto
    ('976A3F01-62A7-421D-88F6-FFD7CC79131F', '304635E6-DEE2-47F0-B41B-4B71BA3A0EC4', 'abbiamo mangiato molto bene', 4.0),
    ('976A3F01-62A7-421D-88F6-FFD7CC79131F', '7551E169-356D-4E62-A600-48B60861AA82', 'Locale molto accogliente, personale super gentile e disponibile, attento a tutte le esigenze soprattutto dei più piccoli. Ottimo cibo e prezzi adeguati. Lo consiglio vivamente!', 4.0),
    ('976A3F01-62A7-421D-88F6-FFD7CC79131F', '893401BB-A0BB-4296-AA39-6241B137AF1B', 'Menu vario, tutto buono, servizio perfetto, coccolati e sfamati a prezzo giusto. Ci tornerò. Grazie', 5.0),
    ('976A3F01-62A7-421D-88F6-FFD7CC79131F', 'E48F7FFE-CFD4-401D-BD95-825E8BD73437', 'Buon ristorante-pizzeria con un ottimo servizio al tavolo(complimenti ai ragazzi che se ne occupano), buone le pizze(con costo medio di 12€🤨) dove però sembra si siano dimenticati la "cara e semplice "Margherita"...non tutti amano le pizze farcite!', 4.0),
    ('976A3F01-62A7-421D-88F6-FFD7CC79131F', 'B71E4BAF-44F6-4CC7-B82D-CE7691856096', 'Buon servizio, pulizia, cucina alterna: la pizza mediocre, gli sfrizzoli molto buoni, le carni non eccezionali. Prezzi medio alti, per chi non è abituato a quelli di Trento significa alti.', 4.0),
    ('976A3F01-62A7-421D-88F6-FFD7CC79131F', 'C45A85D6-47BC-480B-9861-4C42642E4C77', 'Pizza super ottimo servizio.', 5.0),
    -- Typical
    ('74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', '5A2E0F66-F568-4B58-A596-9CC10DBFD51D', 'Qualità al primo posto. Cortesia e velocità del personale. Ottimo locale per assaggiare piatti tipici e sfiziosi. In continua evoluzione.', 5.0),
    ('74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', '30E3A798-D16F-4B5F-BB93-750FDCD652BB', 'Le proposte sono sempre varie e innovative, il personale è abbastanza gentile e il locale presenta un ambiente piacevole. A mio avviso si potrebbe lavorare un po’ sul rapporto qualità prezzo.', 4.0),
    ('74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', '893401BB-A0BB-4296-AA39-6241B137AF1B', 'Mi è piaciuta la location, in stile americano. Buonissima la tartare di manzo e il dolce, il tris di semifreddi. Prezzo un po’ elevato', 3.0),
    ('74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', '02F53330-BCA8-442A-8047-89636114CB14', 'L’accoglienza da parte di chi ci ha portato al tavolo è stata abbastanza fredda e un po’ arrogante, arrivati alle 19 e invece di dici guardate signori vi chiedo dato che siete senza prenotazione per le 21 ho bisogno del tavolo libero, invece ci è stato detto entro alle 21 mangiate perché ho bisogno del tavolo. Dove invece al Plan sono molto accoglienti a confortevoli. Preso sfrizzoli molto buoni mio marito la pizza dove lui l’ ha sempre mangiata bene ma questa volta la pizza era  una focaccia… alta senza pomodoro io credo che dovrebbero indicare perché sicuramente avrebbe preso altro. Il tavolo accanto a me di due ragazze quando è arrivata la piazza hanno fatto lo stesso commento di mio marito. Siamo eccellenti noi italiani nella pizza non roviniamola come fanno in America', 2.0),
    ('74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', 'B71E4BAF-44F6-4CC7-B82D-CE7691856096', 'Buon caffe e brioche. Personale gentile e cortese. Inoltre essendo anche ristorante c’è tanto spazio per sedersi. Consigliato', 4.0),
    ('74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', '921E903E-2930-445A-9490-319325B6619D', 'Costine superbe e tenerissime (specie quelle con la salsa bbq homemade) e birra non filtrata eccellente e soprattutto spinata come dio comanda. Consiglio vivamente se vi trovate a Trento!', 5.0),
    -- Osteria franceschina
    ('B2ED7CF3-A59E-4E90-8572-3EF356BFB106', '91C1E2CD-63DA-4F8E-893B-C8BCB58A131B', 'L’esperienza sensoriale migliore della mia vita, servizio attento e discreto, spiegazioni esaurienti. Difficile definirla cucina, è veramente molto di più. L’abbinamento con i vini è irrinunciabile.', 5.0),
    ('B2ED7CF3-A59E-4E90-8572-3EF356BFB106', 'B71E4BAF-44F6-4CC7-B82D-CE7691856096', 'Ho comunicato al ristorante che la mia fidanzata non mangia la pancetta di maiale, ma le hanno dato dei piatti con la pancetta di maiale e mi hanno dato quello senza pancetta di maiale. Prima che me ne andassi, il cameriere alla porta ha aperto la porta e mi ha salutato, il che mi ha reso molto confuso. , sospettavo che stesse pagando online.  Questo mi fa sembrare che voglio sfuggire all’ordine, l’esperienza di servizio non è abbastanza buona.', 3.0),
    ('B2ED7CF3-A59E-4E90-8572-3EF356BFB106', 'E48F7FFE-CFD4-401D-BD95-825E8BD73437', 'Un viaggio in giro per il mondo, nei piatti del menù degustazione si passa dai sapori tipici italiani sino a quelli tipicamente giapponesi. In ogni singolo piatto, sono raccolti in un mix magico retrogusti conosciuti al palato evocati tutti simultaneamente, ciò si traduce in un esplosione per le papille degustative. Il personale è impeccabile e perfetto in tutto e per tutto.', 5.0),
    ('B2ED7CF3-A59E-4E90-8572-3EF356BFB106', '921E903E-2930-445A-9490-319325B6619D', 'Decisamente le 3 stelle rispecchiano la classe del ristorante sia nel menù nella presentazione dei piatti che nel servizio. Location confortevole e ben organizzata nonostante l’aspetto un po’ eccentrico. Chef davvero di alto livello.', 5.0),
    ('B2ED7CF3-A59E-4E90-8572-3EF356BFB106', '30E3A798-D16F-4B5F-BB93-750FDCD652BB', 'Che dire? Dal primo passo che si compie all’interno dell’Osteria, fino all’ultimo saluto al personale di sala, si vive in una nuvola di costante attenzione e premura.', 5.0);
    """), QueryElement(name: "Inserisco le allergie nella tabella".bold, body: """
    -- Inserisco le allergie nella tabella
    INSERT INTO ALLERGIA VALUES
    ('304635E6-DEE2-47F0-B41B-4B71BA3A0EC4', 3),
    ('304635E6-DEE2-47F0-B41B-4B71BA3A0EC4', 7),
    ('5A2E0F66-F568-4B58-A596-9CC10DBFD51D', 12),
    ('304635E6-DEE2-47F0-B41B-4B71BA3A0EC4', 2),
    ('304635E6-DEE2-47F0-B41B-4B71BA3A0EC4', 4),
    ('304635E6-DEE2-47F0-B41B-4B71BA3A0EC4', 8),
    ('91C1E2CD-63DA-4F8E-893B-C8BCB58A131B', 13),
    ('91C1E2CD-63DA-4F8E-893B-C8BCB58A131B', 9),
    ('80B36196-3292-495C-9F9E-0230F8E0C27C', 10),
    ('80B36196-3292-495C-9F9E-0230F8E0C27C', 4),
    ('C45A85D6-47BC-480B-9861-4C42642E4C77', 1),
    ('7551E169-356D-4E62-A600-48B60861AA82', 7),
    ('921E903E-2930-445A-9490-319325B6619D', 11),
    ('893401BB-A0BB-4296-AA39-6241B137AF1B', 14),
    ('893401BB-A0BB-4296-AA39-6241B137AF1B', 4),
    ('B71E4BAF-44F6-4CC7-B82D-CE7691856096', 3),
    ('E48F7FFE-CFD4-401D-BD95-825E8BD73437', 1),
    ('E48F7FFE-CFD4-401D-BD95-825E8BD73437', 7),
    ('4919F131-67E2-4D9A-BF9A-E5EA20E9123E', 11);
    """), QueryElement(name: "Inserisco i menu nella tabella".bold, body: """
    -- Inserisco i menu nella tabella
    INSERT INTO MENU (ID, RISTORANTE, NOME, ATTIVO) VALUES
    ('EBA64392-2F4C-4FB4-842B-F22E402EEE68', '976A3F01-62A7-421D-88F6-FFD7CC79131F', 'inverno_2022', true),
    ('FACE942E-9A0C-4996-AB89-A88B0DE0973F', '976A3F01-62A7-421D-88F6-FFD7CC79131F', 'primavera_2022', false),
    ('967F3C58-EE74-4FBE-BAB8-3E35FA43B179', '74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', 'dicembre 2021', false),
    ('3CBD175F-1829-4526-BE6C-8B1E3C6E8006', '74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', 'gennaio 2022', true),
    ('D17A7B54-D74E-4D29-815C-8CCC5134BAB6', 'B2ED7CF3-A59E-4E90-8572-3EF356BFB106', 'default', true);
    """), QueryElement(name: "Inserisco i piatti nella tabella".bold, body: """
    -- Inserisco i piatti nella tabella
    INSERT INTO PIATTO VALUES
    ('2F30706F-5E79-47D0-9298-24798EB71336', '976A3F01-62A7-421D-88F6-FFD7CC79131F', 'Jack e lo speck', 16.5, '', 'Costine dal gusto leggermente affumicato. Ricoperte con salsa tradizionale Trentina, fatta da noi con base di mele e sfumata al Jack Daniel. Poi guarnite con speck croccante, servite con le nostre patate della casa.', false, false, '3E81CF7A-4FA1-4E6D-96A8-1C471CC78F8D'),
    ('8FCDBAA3-E831-40CE-B69C-28A66FA45AE5', '976A3F01-62A7-421D-88F6-FFD7CC79131F', 'Foresta', 15.0, '', 'Costine dal gusto di montagna. Ricoperte con funghi e il loro sughetto, guarnite con una spolverata di erba cipollina. Servite con le nostre patate della casa.', false, false, '3E81CF7A-4FA1-4E6D-96A8-1C471CC78F8D'),
    ('8DDAD1EE-96B1-4032-B7D4-909931EFD051', '976A3F01-62A7-421D-88F6-FFD7CC79131F', 'Home Style', 15.50, '', 'Costine dal gusto classico. Semplici, saporite, non piccanti, servite con le nostre patate della casa.', false, false, '3E81CF7A-4FA1-4E6D-96A8-1C471CC78F8D'),
    ('A8C9F6FB-AD66-4498-B88E-7ECA76DEFA2F', '976A3F01-62A7-421D-88F6-FFD7CC79131F', 'Trentino Ammerigano', 16.50, '', 'Costine dal gusto piccante. Ricoperte di salsa Barbecue fatta da noi (non è dolciastra in stile americano), servite con le nostre patate della casa.', false, false, '3E81CF7A-4FA1-4E6D-96A8-1C471CC78F8D'),
    ('834D8C9F-501D-43A5-BA5D-44AFA3D6A8DD', '976A3F01-62A7-421D-88F6-FFD7CC79131F', 'Cime nevose', 16.50, '', 'Costine dal gusto deciso. Ricoperte con fondutina di formaggi dolci fatta da noi. Guarnite con una spolverata di delicato pepe affumicato. Servite con le nostre patate della casa.', false, false, '3E81CF7A-4FA1-4E6D-96A8-1C471CC78F8D'),
    ('CDE7DF22-226A-4EFD-BC24-0B151ECCB96C', '976A3F01-62A7-421D-88F6-FFD7CC79131F', 'Ambiez', 11.0, '', 'In un panino artigianale, un hamburger 150gr di solo manzo 100% italiano Handmade, formaggio dolce Latte Trento, insalata, pomodoro, salsa burger del Typical, servito con patatine fritte.', false, false, 'FB570E7B-C61B-430C-853C-A541EA8EDF07'),
    ('9BF5B8E5-C207-430F-8CA0-D7D96787EB69', '976A3F01-62A7-421D-88F6-FFD7CC79131F', 'Yummy Falkner', 11.0, '', 'In un panino artigianale, un hamburger 150gr di solo manzo 100% italiano Handmade, stracciatella di burrata, insalata, pomodoro, salsa BBQ, salsa burger del Typical, servito con patatine fritte.', false, false, 'FB570E7B-C61B-430C-853C-A541EA8EDF07'),
    ('19678566-5CB3-458C-81FD-4AB9A922D2C1', '976A3F01-62A7-421D-88F6-FFD7CC79131F', 'Double Double', 10.80, '', 'In un panino artigianale, due burger di manzo (2x100gr), doppio formaggio, insalata, pomodoro, salsa burger del Typical, servito con patatine fritte.', false, false, 'FB570E7B-C61B-430C-853C-A541EA8EDF07'),
    ('93F2848A-32E8-413E-B9F3-2D71F712F7B9', '976A3F01-62A7-421D-88F6-FFD7CC79131F', 'Boss delle costine', 11.0, '', 'In un panino artigianale, le nostre mitiche costine cotte secondo il metodo Rippen, disossate e sfilacciate, delicata salsa Trentina "dolce" dell’Orso, salsa burger del Typical, servito con patatine fritte.', false, false, 'FB570E7B-C61B-430C-853C-A541EA8EDF07'),
    ('2B4F11E4-64E9-4C3A-94F7-B1C29C1AB4F3', '976A3F01-62A7-421D-88F6-FFD7CC79131F', 'The pulled pork sandwich', 11.0, '', 'In un panino artigianale, la nostra spalla di maiale schiacciato cotto a lungo a bassa temperatura, insalata, salsa burger del Typical e a parte la nostra salsa BBQ, servito con patatine fritte.', false, false, 'FB570E7B-C61B-430C-853C-A541EA8EDF07'),
    ('FECFEE64-3123-4340-9186-BF99C73D2223', '976A3F01-62A7-421D-88F6-FFD7CC79131F', 'The Cheese Lake', 14.90, '', 'Vi serviamo due burger (2x150gr di solo manzo 100% italiano handmade), ricoperti con la nostra fondutina di formaggi dolci, e listarelle di speck croccante. Serviti con le nostre patate della casa e cavoli cappucci conditi alla Trentina.', false, false, '3E81CF7A-4FA1-4E6D-96A8-1C471CC78F8D'),
    ('7178BC45-71F4-4BDE-B77B-5C2830041552', '976A3F01-62A7-421D-88F6-FFD7CC79131F', 'Guardiaboschi burger', 14.90, '', 'Vi serviamo un vero burger di black angus irlandese cotto alla griglia (200gr) ricorperto con funghi e il loro sughetto, una spolverata di delicato pepe affumicato. Servito con le nostre patate della casa e cavoli cappucci conditi alla Trentina.', false, false, '3E81CF7A-4FA1-4E6D-96A8-1C471CC78F8D'),
    ('3B0E8141-C129-42BD-B25C-6D52615FA71A', '976A3F01-62A7-421D-88F6-FFD7CC79131F', 'Quella volta su al maso', 15.20, '', 'Würstel originale Alro Adige (artigianale fatto a mano a Postal BZ). Avvolto in fette di bacon e poi grigliato, accompagnato da una fetta di pane artigianale ricoperta di fonduta di formaggi dolci e fiocchi di cipolla croccante. Servito con le nostre patate della casa e cavoli cappucci conditi alla Trentina.', false, false, '3E81CF7A-4FA1-4E6D-96A8-1C471CC78F8D'),
    ('8CF171CB-39CA-42B7-A6AB-E27C1224141A', '976A3F01-62A7-421D-88F6-FFD7CC79131F', 'Braies', 14.80, '', 'La classica cotoletta di maiale tipica del Südtirol (300gr), servita con le nostre patate della casa e cavoli cappucci conditi alla Trentina.', false, false, '3E81CF7A-4FA1-4E6D-96A8-1C471CC78F8D'),
    ('9DA5633F-0959-4885-9F02-644D1EC4624A', '976A3F01-62A7-421D-88F6-FFD7CC79131F', 'Luserna', 16.40, '', 'La classica cotoletta di maiale tipica del Südtirol (300gr) ricoperta con pomodorini, zucchine grattugiate, formaggio fresco Philadelphia. Servita con le nostre patate della casa e cavoli cappucci conditi alla Trentina.', false, false, '3E81CF7A-4FA1-4E6D-96A8-1C471CC78F8D'),
    ('49D379BB-95B0-4D9E-9F7E-90286208F362', '976A3F01-62A7-421D-88F6-FFD7CC79131F', 'Un vegetariano a Trento', 15.20, '', 'Tortel de patate, formaggio dolce e formaggio stagionato Latte Trento, funghi con il loro sughetto.', false, true, '3E81CF7A-4FA1-4E6D-96A8-1C471CC78F8D'),
    ('F352224B-715B-4B16-B83B-5E6634D12C2A', '976A3F01-62A7-421D-88F6-FFD7CC79131F', 'No boring food', 14.20, '', 'Due fette di pane artigianale tostato ricoperte di pomodorini, una burrata fresca, misticanza, ceci, noci.', false, true, '3E81CF7A-4FA1-4E6D-96A8-1C471CC78F8D'),
    ('F1AB18E8-19AF-4F00-8182-8D34B82780D4', '976A3F01-62A7-421D-88F6-FFD7CC79131F', 'Tony Gallo', 10.20, '', 'Insalata, radicchio, cavoli cappucci conditi, pomodorini, farro, ceci, sesamo, listarelle di pollo, scaglie di parmigiano 24 mesi, noci.', false, false, '5411C029-867F-4CBA-9AB3-57B8EBA93370'),
    ('627AD6C5-B7A3-4485-98CF-8AD3D93CD531', '976A3F01-62A7-421D-88F6-FFD7CC79131F', 'Surfing', 10.20, '', 'Insalata, radicchio, cavoli cappucci conditi, pomodorini, farro, ceci, sesamo, tonno, olive, mozzarella fior di latte.', false, false, '5411C029-867F-4CBA-9AB3-57B8EBA93370'),
    ('FC361367-F1AA-4D74-82E2-36159CAAADA2', '976A3F01-62A7-421D-88F6-FFD7CC79131F', 'Coca cola', 2.50, '', '', false, false, '0250923C-420D-4810-9FF6-A9E62F6BE3A9'),
    ('4398CA0E-290F-415A-ABBC-8925145EF69A', '976A3F01-62A7-421D-88F6-FFD7CC79131F', 'Acqua frizzante/naturale', 1.0, '', '', false, false, '0250923C-420D-4810-9FF6-A9E62F6BE3A9'),
    ('DDF49CC8-C138-4143-85CB-98E2D4613FD3', '976A3F01-62A7-421D-88F6-FFD7CC79131F', 'Birra Skietta', 6.50, '', 'Non pastorizzata e spillata con un metodo totalmente naturale. Una sacca isolante la protegge e non la fa mai entrare in contatto con il gas della spillatrice', false, false, '0250923C-420D-4810-9FF6-A9E62F6BE3A9'),
    -- Loto
    ('62598898-1124-4196-B2C8-0CF2EB8D8247', '74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', 'Pizza Margherita', 10.0, '', 'Pizza con passata di pomodoro, mozzarella di bufala e origano.', false, true, '4492352B-0484-46E2-935C-471AE36F2100'),
    ('82b0f06f-b196-48ac-a9fb-5c1ed7722205', '74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', 'Pizza Diavola', 11.0, '', 'Pizza con passata di pomodoro, mozzarella di bufala, peperoncino piccante e salame piccante.', false, false, '4492352B-0484-46E2-935C-471AE36F2100'),
    ('2BD46D71-BF39-42BE-9AD8-EA2B112DA3FC', '74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', 'Onda calabra', 10.50, '', 'Mozzarella fiordilatte, salsa di pomodoro BIO, melanzane arrostite, scamorza affumicata e salamino Spianata Calabra (leggermente piccante).', false, false, '4492352B-0484-46E2-935C-471AE36F2100'),
    ('E2FA88EE-64E8-458C-9105-E57261FAF48B', '74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', 'Focaccia al rosmarino', 8.0, '', 'Focaccia bianca con una spolverata di rosmarino.', true, true, '4492352B-0484-46E2-935C-471AE36F2100'),
    ('E60EC3B5-4A33-4CB3-AFC8-F2F715775AEE', '74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', 'Una ragazza capricciosa', 12.90, '', 'Passata di pomodoro BIO, mozzarella fiordilatte. Dopo cottura: prosciutto cotto tirolese, olive nostra ricetta, carciofi, pomodoro arrostito e basilico.', false, false, '4492352B-0484-46E2-935C-471AE36F2100'),
    ('83611F6E-C64F-4101-9075-C826D6924B59', '74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', 'Vedi che sei sciupato', 10.50, '', 'Mozzarella fiordilatte, passata di pomodoro BIO, melanzane arrostite e cipolla caramellata. Dopo cottura: formaggio fresco Bressanone, pomodoro fresco e basilico.', false, true, '4492352B-0484-46E2-935C-471AE36F2100'),
    ('7D028FBF-5A62-4BE9-9301-23922AA42DDB', '74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', 'Gianni e rita', 12.80, '', 'Passata di pomodoro BIO. Dopo cottura: rucola, mozzarella di bufala e pomodoro fresco e Crudo di Parma.', false, false, '4492352B-0484-46E2-935C-471AE36F2100'),
    ('72F582FE-702C-4DA9-B5B7-85BAA39F4D3E', '74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', 'La leggenda di totonno', 10.20, '', 'Mozzarella fiordilatte, passata di pomodoro BIO e cipolla caramellata. Dopo cottura: pomodoro fresco, tonno e basilico.', false, false, '4492352B-0484-46E2-935C-471AE36F2100'),
    ('3D1A6BEA-8C06-4C4A-B6EC-456438D56B9B', '74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', 'Sora lella', 10.20, '', 'Mozzarella fiordilatte, salsa di pomodoro BIO, polpettine del Loto e cipolla caramellata. Dopo cottura: Parmigiano a scaglie e basilico.', false, false, '4492352B-0484-46E2-935C-471AE36F2100'),
    ('F34C759C-739C-4E9F-829E-412418F2666B', '74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', 'Bufala', 10.50, '', 'Passata di pomodoro BIO, mozzarella di bufala. Dopo cottura: pomodoro "dolce" arrostito e basilico.', false, true, '4492352B-0484-46E2-935C-471AE36F2100'),
    ('50620722-96A5-457D-98A3-E7155B400974', '74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', 'Focacciamia', 12.90, '', 'Pasta della pizza cotta in forno. Dopo cottura viene piegata e riempita con rucola, pomodoro fresco e mozzarella di bufala. Poi rimessa un attimo in forno e servita con, a parte, crudo di Parma.', false, false, '4492352B-0484-46E2-935C-471AE36F2100'),
    ('57A46159-AA9E-4C6F-9A26-550FEC7F77E2', '74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', 'Il boia di Carpi', 13.70, '', 'Mozzarella fiordilatte, passata di pomodoro BIO, funghi e porcini trifolati (homemade), lucanica a fette (prima sgrassata in forno), cipolla caramellata e salamino. Dopo cottura: gorgonzola dolce lavorato a mano.', false, false, '4492352B-0484-46E2-935C-471AE36F2100'),
    ('B83095FE-5C5B-4F7E-B045-81BACF54F10C', '74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', 'Bondonera', 12.8, '', 'Mozzarella fiordilatte, passata di pomodoro BIO, funghi e porcini trifolati (homemade). Dopo cottura: speck a fette, gorgonzola dolce.', false, false, '4492352B-0484-46E2-935C-471AE36F2100'),
    ('EB7E94B0-9075-4E5A-B605-00C1E9C9FB55', '74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', 'Sfrizzoli Anterselva', 13.50, '', 'Con speck Alto Adige e una burrata.', false, false, '3E81CF7A-4FA1-4E6D-96A8-1C471CC78F8D'),
    ('21AFFE0A-03A1-4DC4-9E5A-23C6DD30D346', '74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', 'Sfrizzoli The original', 13.50, '', 'Prosciutto crudo dolce di Parma e crescenza fresca.', false, true, '3E81CF7A-4FA1-4E6D-96A8-1C471CC78F8D'),
    ('C1694389-BD5B-4A30-8CA7-16359A43F282', '74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', 'Sfrizzoli Dobbiaco', 13.50, '', 'Con prosciutto cotto tirolese e una Burrata', false, false, '3E81CF7A-4FA1-4E6D-96A8-1C471CC78F8D'),
    ('0A08DF84-DD0A-481D-88C0-B32D1DAF382F', '74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', 'Sfrizzoli La bella coppietta', 13.50, '', 'Prosciutto crudo dolce di Parma e burrata fresca.', false, false, '3E81CF7A-4FA1-4E6D-96A8-1C471CC78F8D'),
    ('85B74225-BE8F-45B3-8C9C-E83E45AE4512', '74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', 'Sfrizzoli dolci', 5.5, '', 'La versione originale, la nostra prima ricetta. Accompagnati da una salsina alla cioccolata/nocciola e da una salsa di fragole fatta in casa.', false, true, '31BBD71E-BF1B-42A0-B726-445E83076671'),
    ('F09EE771-E634-4488-94AF-61BD3DA17BB9', '74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', 'Coca cola', 3.0, '', '', false, false, '0250923C-420D-4810-9FF6-A9E62F6BE3A9'),
    ('52E75789-E64B-4DB6-9973-1433C4F3D1CF', '74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', 'Vino bianco della casa in calice', 6.0, '', '', false, false, '0250923C-420D-4810-9FF6-A9E62F6BE3A9'),
    ('2D2B9392-DBEA-46CC-B9F6-7C3FB3FF4D57', '74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', 'Vino rosso della casa in calice', 6.50, '', '', false, false, '0250923C-420D-4810-9FF6-A9E62F6BE3A9'),
    ('D429A3C4-2DB0-4D25-B82C-D2140433AB59', '74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', 'Birra alla spina 0.5l', 5.5, '', '', false, false, '0250923C-420D-4810-9FF6-A9E62F6BE3A9'),
    -- Osteria franceschina
    ('E09452C5-433A-41E7-8A74-2EBD13FE6A3F', 'B2ED7CF3-A59E-4E90-8572-3EF356BFB106', 'Un’anguilla risale il fiume Po', 80.0, '', '', false, false, '19CB3E0A-3ABD-4465-8FF6-6DAD85715EF4'),
    ('0F97573C-F316-4198-806A-3171240FA131', 'B2ED7CF3-A59E-4E90-8572-3EF356BFB106', 'Cinque stagionature del Parmigiano Reggiano in diverse consistenze e temperature', 80.0, '', '', false, true, '19CB3E0A-3ABD-4465-8FF6-6DAD85715EF4'),
    ('C6ACDE94-04A4-4DD5-8FA0-C36353B1CC5B', 'B2ED7CF3-A59E-4E90-8572-3EF356BFB106', 'Croccantino di foie gras in crosta di mandorle di Noto e nocciole del Piemonte con Aceto Balsamico Tradizionale di Modena Villa Manodori', 90.0, '', '', false, false, '19CB3E0A-3ABD-4465-8FF6-6DAD85715EF4'),
    ('901AE351-A67D-48D0-98F1-F396F72EC861', 'B2ED7CF3-A59E-4E90-8572-3EF356BFB106', 'Culatello di Zibello Antiche Razze 42 mesi di stagionatura accompagnato da mostarda di mele Campanine', 80.0, '', '', false, false, '19CB3E0A-3ABD-4465-8FF6-6DAD85715EF4'),
    ('FEF2D68F-7372-4DBF-BD14-A3AABA795A0F', 'B2ED7CF3-A59E-4E90-8572-3EF356BFB106', 'Ravioli di porri, tartufo nero pregiato e foie gras', 90.0, '', '', false, false, '541E5711-BA4B-4FB3-89CA-1351207F25C2'),
    ('E42DFAF6-7C03-4AFD-B4E6-409027AD149B', 'B2ED7CF3-A59E-4E90-8572-3EF356BFB106', 'Tortellini in crema di Parmigiano Reggiano', 80.0, '', '', false, false, '541E5711-BA4B-4FB3-89CA-1351207F25C2'),
    ('08364C83-4295-4638-BD05-732A6DD464DC', 'B2ED7CF3-A59E-4E90-8572-3EF356BFB106', 'Tortellini del dito mignolo in brodo di cappone', 80.0, '', '', false, false, '541E5711-BA4B-4FB3-89CA-1351207F25C2'),
    ('EF0877B1-C63A-4996-A758-FB315DA5942E', 'B2ED7CF3-A59E-4E90-8572-3EF356BFB106', 'Tagliatelle al ragù', 80.0, '', '', false, false, '541E5711-BA4B-4FB3-89CA-1351207F25C2'),
    ('32645233-9ECE-4368-9492-99FC2CF18CCD', 'B2ED7CF3-A59E-4E90-8572-3EF356BFB106', 'Astice in doppia salsa spumosa, acida e dolce', 110.0, '', '', false, false, '3E81CF7A-4FA1-4E6D-96A8-1C471CC78F8D'),
    ('B3CCD249-1535-49F9-8192-FA4625A7F860', 'B2ED7CF3-A59E-4E90-8572-3EF356BFB106', 'Stiamo ancora decidendo che pesce servire!', 110.0, '', '', false, false, '3E81CF7A-4FA1-4E6D-96A8-1C471CC78F8D'),
    ('96D51BE2-D91B-4CBF-B104-7183B03D7980', 'B2ED7CF3-A59E-4E90-8572-3EF356BFB106', 'This little piggy went to the market', 110.0, '', '', false, false, '3E81CF7A-4FA1-4E6D-96A8-1C471CC78F8D'),
    ('607A4037-E284-4D9B-8781-C6117DC5CD26', 'B2ED7CF3-A59E-4E90-8572-3EF356BFB106', 'Un’interpretazione del filetto alla Rossini con foie gras e caviale', 150.0, '', '', false, false, '3E81CF7A-4FA1-4E6D-96A8-1C471CC78F8D'),
    ('2BE5C671-FE24-4345-877A-4CF8A1DD22FE', 'B2ED7CF3-A59E-4E90-8572-3EF356BFB106', 'Zuppa inglese', 60.0, '', '', false, false, '31BBD71E-BF1B-42A0-B726-445E83076671'),
    ('B22CCB15-CFBF-4DD6-81CD-11FE1744A6E0', 'B2ED7CF3-A59E-4E90-8572-3EF356BFB106', 'In and Out of Style', 60.0, '', '', false, false, '31BBD71E-BF1B-42A0-B726-445E83076671'),
    ('3A214A1D-6C2F-4F34-992B-E2FF297FAC17', 'B2ED7CF3-A59E-4E90-8572-3EF356BFB106', '* Non è una Tatin, non è una Sacher e à ghe anche L’amareina *', 60.0, '', '', false, false, '31BBD71E-BF1B-42A0-B726-445E83076671'),
    ('B566F4AA-57AE-46CE-A85C-4E20513090CD', 'B2ED7CF3-A59E-4E90-8572-3EF356BFB106', 'Oops! I dropped the lemon tart', 60.0, '', '', false, false, '31BBD71E-BF1B-42A0-B726-445E83076671');
    """), QueryElement(name: "Inserisco i piatto_allergene nella tabella".bold, body: """
    -- Inserisco i piatto_allergene nella tabella
    INSERT INTO PIATTO_ALLERGENE VALUES
    ('834D8C9F-501D-43A5-BA5D-44AFA3D6A8DD', 7, false),
    ('CDE7DF22-226A-4EFD-BC24-0B151ECCB96C', 1, false),
    ('CDE7DF22-226A-4EFD-BC24-0B151ECCB96C', 7, false),
    ('9BF5B8E5-C207-430F-8CA0-D7D96787EB69', 1, false),
    ('9BF5B8E5-C207-430F-8CA0-D7D96787EB69', 7, false),
    ('19678566-5CB3-458C-81FD-4AB9A922D2C1', 1, false),
    ('19678566-5CB3-458C-81FD-4AB9A922D2C1', 7, false),
    ('93F2848A-32E8-413E-B9F3-2D71F712F7B9', 1, false),
    ('93F2848A-32E8-413E-B9F3-2D71F712F7B9', 7, false),
    ('2B4F11E4-64E9-4C3A-94F7-B1C29C1AB4F3', 1, false),
    ('2B4F11E4-64E9-4C3A-94F7-B1C29C1AB4F3', 7, false),
    ('FECFEE64-3123-4340-9186-BF99C73D2223', 7, true),
    ('3B0E8141-C129-42BD-B25C-6D52615FA71A', 7, true),
    ('8CF171CB-39CA-42B7-A6AB-E27C1224141A', 7, false),
    ('8CF171CB-39CA-42B7-A6AB-E27C1224141A', 1, false),
    ('8CF171CB-39CA-42B7-A6AB-E27C1224141A', 3, false),
    ('9DA5633F-0959-4885-9F02-644D1EC4624A', 7, false),
    ('9DA5633F-0959-4885-9F02-644D1EC4624A', 1, false),
    ('49D379BB-95B0-4D9E-9F7E-90286208F362', 7, false),
    ('49D379BB-95B0-4D9E-9F7E-90286208F362', 1, false),
    ('F352224B-715B-4B16-B83B-5E6634D12C2A', 1, false),
    ('F352224B-715B-4B16-B83B-5E6634D12C2A', 7, true),
    ('F1AB18E8-19AF-4F00-8182-8D34B82780D4', 8, false),
    ('F1AB18E8-19AF-4F00-8182-8D34B82780D4', 11, false),
    ('627AD6C5-B7A3-4485-98CF-8AD3D93CD531', 11, false),
    ('627AD6C5-B7A3-4485-98CF-8AD3D93CD531', 4, false),
    ('62598898-1124-4196-B2C8-0CF2EB8D8247', 7, true),
    ('62598898-1124-4196-B2C8-0CF2EB8D8247', 1, false),
    ('82b0f06f-b196-48ac-a9fb-5c1ed7722205', 7, true),
    ('82b0f06f-b196-48ac-a9fb-5c1ed7722205', 1, false),
    ('2BD46D71-BF39-42BE-9AD8-EA2B112DA3FC', 7, true),
    ('2BD46D71-BF39-42BE-9AD8-EA2B112DA3FC', 1, false),
    ('E2FA88EE-64E8-458C-9105-E57261FAF48B', 1, false),
    ('E2FA88EE-64E8-458C-9105-E57261FAF48B', 7, true),
    ('E60EC3B5-4A33-4CB3-AFC8-F2F715775AEE', 1, false),
    ('E60EC3B5-4A33-4CB3-AFC8-F2F715775AEE', 7, true),
    ('83611F6E-C64F-4101-9075-C826D6924B59', 1, false),
    ('83611F6E-C64F-4101-9075-C826D6924B59', 7, true),
    ('7D028FBF-5A62-4BE9-9301-23922AA42DDB', 1, false),
    ('7D028FBF-5A62-4BE9-9301-23922AA42DDB', 7, true),
    ('72F582FE-702C-4DA9-B5B7-85BAA39F4D3E', 1, false),
    ('72F582FE-702C-4DA9-B5B7-85BAA39F4D3E', 7, true),
    ('72F582FE-702C-4DA9-B5B7-85BAA39F4D3E', 4, true),
    ('3D1A6BEA-8C06-4C4A-B6EC-456438D56B9B', 1, false),
    ('3D1A6BEA-8C06-4C4A-B6EC-456438D56B9B', 7, true),
    ('F34C759C-739C-4E9F-829E-412418F2666B', 1, false),
    ('F34C759C-739C-4E9F-829E-412418F2666B', 7, true),
    ('50620722-96A5-457D-98A3-E7155B400974', 1, false),
    ('50620722-96A5-457D-98A3-E7155B400974', 7, true),
    ('57A46159-AA9E-4C6F-9A26-550FEC7F77E2', 1, false),
    ('57A46159-AA9E-4C6F-9A26-550FEC7F77E2', 7, true),
    ('B83095FE-5C5B-4F7E-B045-81BACF54F10C', 1, false),
    ('B83095FE-5C5B-4F7E-B045-81BACF54F10C', 7, true),
    ('EB7E94B0-9075-4E5A-B605-00C1E9C9FB55', 1, false),
    ('EB7E94B0-9075-4E5A-B605-00C1E9C9FB55', 7, true),
    ('21AFFE0A-03A1-4DC4-9E5A-23C6DD30D346', 1, false),
    ('21AFFE0A-03A1-4DC4-9E5A-23C6DD30D346', 7, true),
    ('C1694389-BD5B-4A30-8CA7-16359A43F282', 1, false),
    ('C1694389-BD5B-4A30-8CA7-16359A43F282', 7, true),
    ('0A08DF84-DD0A-481D-88C0-B32D1DAF382F', 1, false),
    ('0A08DF84-DD0A-481D-88C0-B32D1DAF382F', 7, true),
    ('85B74225-BE8F-45B3-8C9C-E83E45AE4512', 1, false),
    ('85B74225-BE8F-45B3-8C9C-E83E45AE4512', 7, false),
    ('E09452C5-433A-41E7-8A74-2EBD13FE6A3F', 4, false),
    ('0F97573C-F316-4198-806A-3171240FA131', 7, false),
    ('C6ACDE94-04A4-4DD5-8FA0-C36353B1CC5B', 1, false),
    ('C6ACDE94-04A4-4DD5-8FA0-C36353B1CC5B', 8, false),
    ('901AE351-A67D-48D0-98F1-F396F72EC861', 10, false),
    ('FEF2D68F-7372-4DBF-BD14-A3AABA795A0F', 1, false),
    ('FEF2D68F-7372-4DBF-BD14-A3AABA795A0F', 7, false),
    ('E42DFAF6-7C03-4AFD-B4E6-409027AD149B', 1, false),
    ('E42DFAF6-7C03-4AFD-B4E6-409027AD149B', 7, false),
    ('08364C83-4295-4638-BD05-732A6DD464DC', 1, false),
    ('08364C83-4295-4638-BD05-732A6DD464DC', 7, false),
    ('EF0877B1-C63A-4996-A758-FB315DA5942E', 1, false),
    ('32645233-9ECE-4368-9492-99FC2CF18CCD', 4, false),
    ('B3CCD249-1535-49F9-8192-FA4625A7F860', 4, false),
    ('2BE5C671-FE24-4345-877A-4CF8A1DD22FE', 1, false),
    ('2BE5C671-FE24-4345-877A-4CF8A1DD22FE', 7, false),
    ('B22CCB15-CFBF-4DD6-81CD-11FE1744A6E0', 1, false),
    ('B22CCB15-CFBF-4DD6-81CD-11FE1744A6E0', 7, false),
    ('3A214A1D-6C2F-4F34-992B-E2FF297FAC17', 1, false),
    ('3A214A1D-6C2F-4F34-992B-E2FF297FAC17', 7, false),
    ('B566F4AA-57AE-46CE-A85C-4E20513090CD', 1, false),
    ('B566F4AA-57AE-46CE-A85C-4E20513090CD', 7, false);
    """), QueryElement(name: "Inserisco i piatto_menu nella tabella".bold, body: """
    -- Inserisco i piatto_menu nella tabella
    INSERT INTO PIATTO_MENU (MENU, PIATTO, POSIZIONE) VALUES
    -- Typical - inverno
    ('EBA64392-2F4C-4FB4-842B-F22E402EEE68', '2F30706F-5E79-47D0-9298-24798EB71336', 0),
    ('EBA64392-2F4C-4FB4-842B-F22E402EEE68', '8FCDBAA3-E831-40CE-B69C-28A66FA45AE5', 1),
    ('EBA64392-2F4C-4FB4-842B-F22E402EEE68', '8DDAD1EE-96B1-4032-B7D4-909931EFD051', 2),
    ('EBA64392-2F4C-4FB4-842B-F22E402EEE68', 'A8C9F6FB-AD66-4498-B88E-7ECA76DEFA2F', 3),
    ('EBA64392-2F4C-4FB4-842B-F22E402EEE68', '834D8C9F-501D-43A5-BA5D-44AFA3D6A8DD', 4),
    ('EBA64392-2F4C-4FB4-842B-F22E402EEE68', 'CDE7DF22-226A-4EFD-BC24-0B151ECCB96C', 5),
    ('EBA64392-2F4C-4FB4-842B-F22E402EEE68', '9BF5B8E5-C207-430F-8CA0-D7D96787EB69', 6),
    ('EBA64392-2F4C-4FB4-842B-F22E402EEE68', '19678566-5CB3-458C-81FD-4AB9A922D2C1', 7),
    ('EBA64392-2F4C-4FB4-842B-F22E402EEE68', '93F2848A-32E8-413E-B9F3-2D71F712F7B9', 8),
    ('EBA64392-2F4C-4FB4-842B-F22E402EEE68', '2B4F11E4-64E9-4C3A-94F7-B1C29C1AB4F3', 9),
    ('EBA64392-2F4C-4FB4-842B-F22E402EEE68', 'FECFEE64-3123-4340-9186-BF99C73D2223', 10),
    ('EBA64392-2F4C-4FB4-842B-F22E402EEE68', '7178BC45-71F4-4BDE-B77B-5C2830041552', 11),
    ('EBA64392-2F4C-4FB4-842B-F22E402EEE68', '3B0E8141-C129-42BD-B25C-6D52615FA71A', 12),
    ('EBA64392-2F4C-4FB4-842B-F22E402EEE68', '8CF171CB-39CA-42B7-A6AB-E27C1224141A', 13),
    ('EBA64392-2F4C-4FB4-842B-F22E402EEE68', '9DA5633F-0959-4885-9F02-644D1EC4624A', 14),
    ('EBA64392-2F4C-4FB4-842B-F22E402EEE68', '49D379BB-95B0-4D9E-9F7E-90286208F362', 15),
    ('EBA64392-2F4C-4FB4-842B-F22E402EEE68', 'F352224B-715B-4B16-B83B-5E6634D12C2A', 16),
    ('EBA64392-2F4C-4FB4-842B-F22E402EEE68', 'F1AB18E8-19AF-4F00-8182-8D34B82780D4', 17),
    ('EBA64392-2F4C-4FB4-842B-F22E402EEE68', '627AD6C5-B7A3-4485-98CF-8AD3D93CD531', 18),
    ('EBA64392-2F4C-4FB4-842B-F22E402EEE68', 'FC361367-F1AA-4D74-82E2-36159CAAADA2', 19),
    ('EBA64392-2F4C-4FB4-842B-F22E402EEE68', '4398CA0E-290F-415A-ABBC-8925145EF69A', 20),
    ('EBA64392-2F4C-4FB4-842B-F22E402EEE68', 'DDF49CC8-C138-4143-85CB-98E2D4613FD3', 21),
    -- Typical - primavera
    ('FACE942E-9A0C-4996-AB89-A88B0DE0973F', '2F30706F-5E79-47D0-9298-24798EB71336', 0),
    ('FACE942E-9A0C-4996-AB89-A88B0DE0973F', '8FCDBAA3-E831-40CE-B69C-28A66FA45AE5', 1),
    ('FACE942E-9A0C-4996-AB89-A88B0DE0973F', '8DDAD1EE-96B1-4032-B7D4-909931EFD051', 2),
    ('FACE942E-9A0C-4996-AB89-A88B0DE0973F', 'A8C9F6FB-AD66-4498-B88E-7ECA76DEFA2F', 3),
    ('FACE942E-9A0C-4996-AB89-A88B0DE0973F', '834D8C9F-501D-43A5-BA5D-44AFA3D6A8DD', 4),
    ('FACE942E-9A0C-4996-AB89-A88B0DE0973F', 'CDE7DF22-226A-4EFD-BC24-0B151ECCB96C', 5),
    ('FACE942E-9A0C-4996-AB89-A88B0DE0973F', '9BF5B8E5-C207-430F-8CA0-D7D96787EB69', 6),
    ('FACE942E-9A0C-4996-AB89-A88B0DE0973F', '19678566-5CB3-458C-81FD-4AB9A922D2C1', 7),
    ('FACE942E-9A0C-4996-AB89-A88B0DE0973F', '93F2848A-32E8-413E-B9F3-2D71F712F7B9', 8),
    ('FACE942E-9A0C-4996-AB89-A88B0DE0973F', '2B4F11E4-64E9-4C3A-94F7-B1C29C1AB4F3', 9),
    ('FACE942E-9A0C-4996-AB89-A88B0DE0973F', 'FECFEE64-3123-4340-9186-BF99C73D2223', 10),
    ('FACE942E-9A0C-4996-AB89-A88B0DE0973F', '7178BC45-71F4-4BDE-B77B-5C2830041552', 11),
    ('FACE942E-9A0C-4996-AB89-A88B0DE0973F', '3B0E8141-C129-42BD-B25C-6D52615FA71A', 12),
    ('FACE942E-9A0C-4996-AB89-A88B0DE0973F', '8CF171CB-39CA-42B7-A6AB-E27C1224141A', 13),
    ('FACE942E-9A0C-4996-AB89-A88B0DE0973F', '9DA5633F-0959-4885-9F02-644D1EC4624A', 14),
    ('FACE942E-9A0C-4996-AB89-A88B0DE0973F', '627AD6C5-B7A3-4485-98CF-8AD3D93CD531', 15),
    ('FACE942E-9A0C-4996-AB89-A88B0DE0973F', 'FC361367-F1AA-4D74-82E2-36159CAAADA2', 16),
    ('FACE942E-9A0C-4996-AB89-A88B0DE0973F', '4398CA0E-290F-415A-ABBC-8925145EF69A', 17),
    ('FACE942E-9A0C-4996-AB89-A88B0DE0973F', 'DDF49CC8-C138-4143-85CB-98E2D4613FD3', 18),
    -- Loto - gennaio 2022
    ('3CBD175F-1829-4526-BE6C-8B1E3C6E8006', '62598898-1124-4196-B2C8-0CF2EB8D8247', 0),
    ('3CBD175F-1829-4526-BE6C-8B1E3C6E8006', '2BD46D71-BF39-42BE-9AD8-EA2B112DA3FC', 1),
    ('3CBD175F-1829-4526-BE6C-8B1E3C6E8006', 'E2FA88EE-64E8-458C-9105-E57261FAF48B', 2),
    ('3CBD175F-1829-4526-BE6C-8B1E3C6E8006', 'E60EC3B5-4A33-4CB3-AFC8-F2F715775AEE', 3),
    ('3CBD175F-1829-4526-BE6C-8B1E3C6E8006', '83611F6E-C64F-4101-9075-C826D6924B59', 4),
    ('3CBD175F-1829-4526-BE6C-8B1E3C6E8006', '7D028FBF-5A62-4BE9-9301-23922AA42DDB', 5),
    ('3CBD175F-1829-4526-BE6C-8B1E3C6E8006', '72F582FE-702C-4DA9-B5B7-85BAA39F4D3E', 6),
    ('3CBD175F-1829-4526-BE6C-8B1E3C6E8006', '3D1A6BEA-8C06-4C4A-B6EC-456438D56B9B', 7),
    ('3CBD175F-1829-4526-BE6C-8B1E3C6E8006', 'F34C759C-739C-4E9F-829E-412418F2666B', 8),
    ('3CBD175F-1829-4526-BE6C-8B1E3C6E8006', '50620722-96A5-457D-98A3-E7155B400974', 9),
    ('3CBD175F-1829-4526-BE6C-8B1E3C6E8006', '57A46159-AA9E-4C6F-9A26-550FEC7F77E2', 10),
    ('3CBD175F-1829-4526-BE6C-8B1E3C6E8006', 'B83095FE-5C5B-4F7E-B045-81BACF54F10C', 11),
    ('3CBD175F-1829-4526-BE6C-8B1E3C6E8006', 'EB7E94B0-9075-4E5A-B605-00C1E9C9FB55', 12),
    ('3CBD175F-1829-4526-BE6C-8B1E3C6E8006', '21AFFE0A-03A1-4DC4-9E5A-23C6DD30D346', 13),
    ('3CBD175F-1829-4526-BE6C-8B1E3C6E8006', 'C1694389-BD5B-4A30-8CA7-16359A43F282', 14),
    ('3CBD175F-1829-4526-BE6C-8B1E3C6E8006', '0A08DF84-DD0A-481D-88C0-B32D1DAF382F', 15),
    ('3CBD175F-1829-4526-BE6C-8B1E3C6E8006', '85B74225-BE8F-45B3-8C9C-E83E45AE4512', 16),
    ('3CBD175F-1829-4526-BE6C-8B1E3C6E8006', 'F09EE771-E634-4488-94AF-61BD3DA17BB9', 17),
    ('3CBD175F-1829-4526-BE6C-8B1E3C6E8006', '52E75789-E64B-4DB6-9973-1433C4F3D1CF', 18),
    ('3CBD175F-1829-4526-BE6C-8B1E3C6E8006', '2D2B9392-DBEA-46CC-B9F6-7C3FB3FF4D57', 19),
    ('3CBD175F-1829-4526-BE6C-8B1E3C6E8006', 'D429A3C4-2DB0-4D25-B82C-D2140433AB59', 20),
    -- Loto - dicembre 2021
    ('967F3C58-EE74-4FBE-BAB8-3E35FA43B179', '82b0f06f-b196-48ac-a9fb-5c1ed7722205', 0),
    ('967F3C58-EE74-4FBE-BAB8-3E35FA43B179', 'E2FA88EE-64E8-458C-9105-E57261FAF48B', 1),
    ('967F3C58-EE74-4FBE-BAB8-3E35FA43B179', 'E60EC3B5-4A33-4CB3-AFC8-F2F715775AEE', 2),
    ('967F3C58-EE74-4FBE-BAB8-3E35FA43B179', '83611F6E-C64F-4101-9075-C826D6924B59', 3),
    ('967F3C58-EE74-4FBE-BAB8-3E35FA43B179', '7D028FBF-5A62-4BE9-9301-23922AA42DDB', 4),
    ('967F3C58-EE74-4FBE-BAB8-3E35FA43B179', '72F582FE-702C-4DA9-B5B7-85BAA39F4D3E', 5),
    ('967F3C58-EE74-4FBE-BAB8-3E35FA43B179', '3D1A6BEA-8C06-4C4A-B6EC-456438D56B9B', 6),
    ('967F3C58-EE74-4FBE-BAB8-3E35FA43B179', 'F34C759C-739C-4E9F-829E-412418F2666B', 7),
    ('967F3C58-EE74-4FBE-BAB8-3E35FA43B179', '50620722-96A5-457D-98A3-E7155B400974', 8),
    ('967F3C58-EE74-4FBE-BAB8-3E35FA43B179', '57A46159-AA9E-4C6F-9A26-550FEC7F77E2', 9),
    ('967F3C58-EE74-4FBE-BAB8-3E35FA43B179', 'B83095FE-5C5B-4F7E-B045-81BACF54F10C', 10),
    ('967F3C58-EE74-4FBE-BAB8-3E35FA43B179', 'EB7E94B0-9075-4E5A-B605-00C1E9C9FB55', 11),
    ('967F3C58-EE74-4FBE-BAB8-3E35FA43B179', '21AFFE0A-03A1-4DC4-9E5A-23C6DD30D346', 12),
    ('967F3C58-EE74-4FBE-BAB8-3E35FA43B179', 'C1694389-BD5B-4A30-8CA7-16359A43F282', 13),
    ('967F3C58-EE74-4FBE-BAB8-3E35FA43B179', '0A08DF84-DD0A-481D-88C0-B32D1DAF382F', 14),
    ('967F3C58-EE74-4FBE-BAB8-3E35FA43B179', '85B74225-BE8F-45B3-8C9C-E83E45AE4512', 15),
    ('967F3C58-EE74-4FBE-BAB8-3E35FA43B179', 'F09EE771-E634-4488-94AF-61BD3DA17BB9', 16),
    ('967F3C58-EE74-4FBE-BAB8-3E35FA43B179', '52E75789-E64B-4DB6-9973-1433C4F3D1CF', 17),
    ('967F3C58-EE74-4FBE-BAB8-3E35FA43B179', '2D2B9392-DBEA-46CC-B9F6-7C3FB3FF4D57', 18),
    ('967F3C58-EE74-4FBE-BAB8-3E35FA43B179', 'D429A3C4-2DB0-4D25-B82C-D2140433AB59', 19),
    -- Osteria franceschina
    ('D17A7B54-D74E-4D29-815C-8CCC5134BAB6', 'E09452C5-433A-41E7-8A74-2EBD13FE6A3F', 0),
    ('D17A7B54-D74E-4D29-815C-8CCC5134BAB6', '0F97573C-F316-4198-806A-3171240FA131', 1),
    ('D17A7B54-D74E-4D29-815C-8CCC5134BAB6', 'C6ACDE94-04A4-4DD5-8FA0-C36353B1CC5B', 2),
    ('D17A7B54-D74E-4D29-815C-8CCC5134BAB6', '901AE351-A67D-48D0-98F1-F396F72EC861', 3),
    ('D17A7B54-D74E-4D29-815C-8CCC5134BAB6', 'FEF2D68F-7372-4DBF-BD14-A3AABA795A0F', 4),
    ('D17A7B54-D74E-4D29-815C-8CCC5134BAB6', 'E42DFAF6-7C03-4AFD-B4E6-409027AD149B', 5),
    ('D17A7B54-D74E-4D29-815C-8CCC5134BAB6', '08364C83-4295-4638-BD05-732A6DD464DC', 6),
    ('D17A7B54-D74E-4D29-815C-8CCC5134BAB6', 'EF0877B1-C63A-4996-A758-FB315DA5942E', 7),
    ('D17A7B54-D74E-4D29-815C-8CCC5134BAB6', '32645233-9ECE-4368-9492-99FC2CF18CCD', 8),
    ('D17A7B54-D74E-4D29-815C-8CCC5134BAB6', 'B3CCD249-1535-49F9-8192-FA4625A7F860', 9),
    ('D17A7B54-D74E-4D29-815C-8CCC5134BAB6', '96D51BE2-D91B-4CBF-B104-7183B03D7980', 10),
    ('D17A7B54-D74E-4D29-815C-8CCC5134BAB6', '607A4037-E284-4D9B-8781-C6117DC5CD26', 11),
    ('D17A7B54-D74E-4D29-815C-8CCC5134BAB6', '2BE5C671-FE24-4345-877A-4CF8A1DD22FE', 12),
    ('D17A7B54-D74E-4D29-815C-8CCC5134BAB6', 'B22CCB15-CFBF-4DD6-81CD-11FE1744A6E0', 13),
    ('D17A7B54-D74E-4D29-815C-8CCC5134BAB6', '3A214A1D-6C2F-4F34-992B-E2FF297FAC17', 14),
    ('D17A7B54-D74E-4D29-815C-8CCC5134BAB6', 'B566F4AA-57AE-46CE-A85C-4E20513090CD', 15);
    """), QueryElement(name: "Inserisco i record gestione nella tabella".bold, body: """
    -- Inserisco i record gestione nella tabella
    INSERT INTO GESTIONE (RISTORANTE, RISTORATORE) VALUES
    ('976A3F01-62A7-421D-88F6-FFD7CC79131F', '1442D1E5-240F-4088-B744-BF28C1B0D8CF'),
    ('B2ED7CF3-A59E-4E90-8572-3EF356BFB106', '6EE16A66-8354-4CC9-9B09-9754C66DE9B1'),
    ('74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6', 'BC4BE297-1235-42F5-A2CE-4983141BF853');
    """), QueryElement(name: "CREATE OR REPLACE FUNCTION CREATE_TRIGGER_FOR_MENU_ACTIVITY()".bold, body: """
    CREATE OR REPLACE FUNCTION CREATE_TRIGGER_FOR_MENU_ACTIVITY()
    RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        IF OLD.ATTIVO IS DISTINCT FROM NEW.ATTIVO AND NEW.ATTIVO = TRUE
        THEN
            UPDATE MENU
               SET ATTIVO = FALSE
             WHERE RISTORANTE = NEW.RISTORANTE AND ID != NEW.ID;
        END IF;
        
        NEW.ULTIMO_AGGIORNAMENTO = CURRENT_TIMESTAMP;
        
        RETURN NEW;
    END;
    $$;
    """), QueryElement(name: "Creo il trigger per gli aggiornamenti della tabella".bold, body: """
    -- Creo il trigger per gli aggiornamenti della tabella
    CREATE TRIGGER MENU_UPDATE_ACTIVITY
        BEFORE UPDATE ON MENU
        FOR EACH ROW
        EXECUTE PROCEDURE CREATE_TRIGGER_FOR_MENU_ACTIVITY();
    """), QueryElement(name: "Creo il trigger per gli inserimenti nella tabella".bold, body: """
    -- Creo il trigger per gli inserimenti nella tabella
    CREATE TRIGGER MENU_INSERT_ACTIVITY
        BEFORE INSERT ON MENU
        FOR EACH ROW
        WHEN (NEW.ATTIVO is TRUE)
        EXECUTE PROCEDURE CREATE_TRIGGER_FOR_MENU_ACTIVITY();
    """),]

    
    static let operationQueries: [QueryElement] = [QueryElement(name: "ristorantiInZona", arguments: ["città"], body: """
    SELECT
        R.id,
        R.NOME,
        R.CAP,
        R.SITO_WEB,
        R.TELEFONO,
        R.COVER,
        R.LOGO,
        R.ACCETTA_PRENOTAZIONI,
        R.ACCETTA_RECENSIONI,
        R.CITTA,
        R.INDIRIZZO,
        R.DATA_AGGIUNTA,
        avg_valutazione
    FROM
        RISTORANTE AS R LEFT OUTER JOIN (SELECT ristorante, AVG(valutazione)::numeric(10,2) AS avg_valutazione FROM recensione GROUP BY ristorante) REC ON R.id = REC.ristorante
    WHERE
        R.CITTA ILIKE $1;
    """), QueryElement(name: "allergeniDiUtente", arguments: ["id_utente"], body: """
    SELECT
        AL.id,
        AL.nome,
        AL.descrizione
    FROM
        ALLERGIA AS A,
        ALLERGENE AS AL
    WHERE
        A.utente = $1
        AND A.allergene = AL.id;
    """), QueryElement(name: "piattiMenuPerUtente", arguments: ["id_menu", "id_utente"], body: """
    SELECT
        P.id,
        P.nome,
        P.prezzo,
        P.foto,
        P.descrizione,
        P.vegano,
        P.vegetariano,
        P.portata,
        ARRAY (
            SELECT
                a.nome
            FROM
                allergene AS a,
                piatto_allergene AS pa
            WHERE
                P.id = pa.piatto
                AND pa.allergene = a.id) AS nome_allergeni,
        ARRAY (
            SELECT
                a.id
            FROM
                allergene AS a,
                piatto_allergene AS pa
            WHERE
                P.id = pa.piatto
                AND pa.allergene = a.id) AS id_allergeni
    FROM
        PIATTO_MENU AS PM,
        PIATTO AS P
    WHERE
        PM.menu = $1
        AND PM.piatto = P.id
        AND P.id NOT IN(
            SELECT
                PA.piatto FROM PIATTO_ALLERGENE AS PA, ALLERGIA
            WHERE
                utente = $2
                AND ALLERGIA.allergene = PA.allergene);
    """), QueryElement(name: "menuEPiattiPerRistorante", arguments: ["id_ristorante"], body: """
    SELECT
        P.id,
        M.id AS id_menu,
        P.nome,
        P.prezzo,
        P.foto,
        P.descrizione,
        P.vegano,
        P.vegetariano,
        P.portata,
        PO.nome AS nome_portata
    FROM
        PIATTO AS P,
        PORTATA AS PO,
        MENU AS M,
        PIATTO_MENU AS PM
    WHERE
        M.ristorante = $1
        AND M.attivo = TRUE
        AND PM.menu = M.id
        AND PM.piatto = P.id
        AND P.portata = PO.id;
    """), QueryElement(name: "ristorantiEMenuInZona", arguments: ["città"], body: """
    SELECT
        R.id AS id_ristorante,
        R.nome AS nome_ristorante,
        M.id AS id_menu,
        P.id AS id_piatto,
        P.nome AS nome_piatto,
        P.prezzo,
        P.foto,
        P.descrizione,
        P.vegano,
        P.vegetariano,
        P.portata,
        PO.nome AS nome_portata,
        PO.ordine
    FROM
        RISTORANTE AS R,
        MENU AS M,
        PIATTO_MENU AS PM,
        PIATTO AS P,
        PORTATA AS PO
    WHERE
        R.citta ILIKE $1
        AND R.id = M.ristorante
        AND M.attivo = TRUE
        AND M.id = PM.menu
        AND PM.piatto = P.id
        AND P.portata = PO.id
    ORDER BY
        R.id ASC, PO.ordine ASC;
    """), QueryElement(name: "recensioniPerRistorante", arguments: ["id_ristorante"], body: """
    SELECT
        R.ristorante,
        U.nome AS username,
        R.testo,
        R.valutazione,
        R.data
    FROM
        RECENSIONE AS R,
        UTENTE AS U
    WHERE
        R.ristorante = $1
        AND R.utente = U.id;
    """), QueryElement(name: "numeroRistorantiInZona", arguments: ["città"], body: """
    SELECT COUNT(*)
        FROM RISTORANTE
    WHERE
        citta ILIKE $1;
    """), QueryElement(name: "aggiungiRecensione", arguments: ["id_ristorante", "id_utente", "testo", "valutazione"], body: """
    INSERT INTO
        RECENSIONE
    VALUES
        ($1, $2, $3, $4);
    """), QueryElement(name: "aggiungiPiatto", arguments: ["id_ristorante", "nome", "prezzo", "foto", "descrizione", "vegano", "vegetariano", "id_portata"], body: """
    INSERT INTO
        PIATTO (ID, RISTORANTE, NOME, PREZZO, FOTO, DESCRIZIONE, VEGANO, VEGETARIANO, PORTATA)
    VALUES
        ($1, $2, $3, $4, $5, $6, $7, $8, $9);
    """), QueryElement(name: "aggiungiRistorante", arguments: ["nome_ristorante", "cap", "accetta_prenotazioni", "città", "indirizzo", "id_ristoratore"], body: """
    WITH NEW_RISTORANTE AS (
        INSERT INTO ristorante (NOME,
                CAP,
                ACCETTA_PRENOTAZIONI,
                CITTA,
                INDIRIZZO)
                VALUES ($1,
                    $2,
                    $3,
                    $4,
                    $5)
            RETURNING
                id
        ) INSERT INTO GESTIONE
    SELECT
        id,
        $6
    FROM
        NEW_RISTORANTE;
    """)]
}
