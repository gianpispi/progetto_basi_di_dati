-- Allergeni utente sapendo id
SELECT
	AL.id,
	AL.nome,
	AL.descrizione
FROM
	ALLERGIA AS A,
	ALLERGENE AS AL
WHERE
	A.utente = '5A2E0F66-F568-4B58-A596-9CC10DBFD51D'
	AND A.allergene = AL.id;
	
-- Piatti di un menù che non contengono gli allergeni di un utente conosciuta la chiave dell'utente e quella del menù.
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
PM.menu = 'eba64392-2f4c-4fb4-842b-f22e402eee68'
AND PM.piatto = P.id
AND P.id NOT IN(
	SELECT
		PA.piatto FROM PIATTO_ALLERGENE AS PA, ALLERGIA
	WHERE
		utente = '91c1e2cd-63da-4f8e-893b-c8bcb58a131b'
		AND ALLERGIA.allergene = PA.allergene);

-- Tutti i ristoranti in una città, con media delle recensioni, se esistono, NULL altrimenti.
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
	R.CITTA ILIKE 'Trento';

-- Menù attivo con i piatti conosciuto l’id del ristorante
SELECT
	P.id,
	M.id AS id_menu
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
	M.ristorante = '976a3f01-62a7-421d-88f6-ffd7cc79131f'
	AND M.attivo = TRUE
	AND PM.menu = M.id
	AND PM.piatto = P.id
	AND P.portata = PO.id;
	
-- Ristoranti con annessi menù di una specifica città
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
	R.citta ILIKE 'Trento'
	AND R.id = M.ristorante
	AND M.attivo = TRUE
	AND M.id = PM.menu
	AND PM.piatto = P.id
	AND P.portata = PO.id
ORDER BY
	R.id ASC, PO.ordine ASC;

-- Recensioni di un ristorante conosciuto il suo id, con relativo nome dell’utente che l’ha scritta
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
	R.ristorante = '976a3f01-62a7-421d-88f6-ffd7cc79131f'
	AND R.utente = U.id;

-- Scrittura di una recensione da parte di un utente
INSERT INTO 
	RECENSIONE 
VALUES 
	('976A3F01-62A7-421D-88F6-FFD7CC79131F', '304635E6-DEE2-47F0-B41B-4B71BA3A0EC4', 'abbiamo mangiato molto bene', 4.0);

-- Aggiunta di un piatto da parte di un ristorante
INSERT INTO 
	PIATTO (ID, RISTORANTE, NOME, PREZZO, FOTO, DESCRIZIONE, VEGANO, VEGETARIANO, PORTATA)
VALUES 
	('2F30706F-5E79-47D0-9298-24798EB71336', '976A3F01-62A7-421D-88F6-FFD7CC79131F', 'Jack e lo speck', 16.5, '', 'Costine dal gusto leggermente affumicato. Ricoperte con salsa tradizionale Trentina, fatta da noi con base di mele e sfumata al Jack Daniel. Poi guarnite con speck croccante, servite con le nostre patate della casa.', false, false, '3E81CF7A-4FA1-4E6D-96A8-1C471CC78F8D');

-- Conteggio ristoranti in una città
SELECT COUNT(*)
	FROM RISTORANTE
WHERE
	citta ILIKE 'Trento';

-- Inserire un nuovo ristorante, con annesso gestore
WITH NEW_RISTORANTE AS (
	INSERT INTO ristorante (NOME,
			CAP,
			ACCETTA_PRENOTAZIONI,
			CITTA,
			INDIRIZZO)
			VALUES ('Da Luigi',
				'70123',
				TRUE,
				'trento',
				'via bao, 22')
		RETURNING
			id
	) INSERT INTO GESTIONE
SELECT
	id,
	'id_utente'
FROM
	NEW_RISTORANTE;
	
-- Aggiornare il nome di un piatto conoscendo il suo id
UPDATE
	PIATTO
SET
	NOME = 'Non è una Tatin, non è una Sacher e à ghe anche l’amareina'
WHERE
	ID = '3a214a1d-6c2f-4f34-992b-e2ff297fac17';
	
-- Aggiornare il prezzo di un piatto dato il suo id
UPDATE
	PIATTO
SET
	PREZZO = 75.0
WHERE
	ID = '3a214a1d-6c2f-4f34-992b-e2ff297fac17';
	
-- Rimuovere un piatto da un menu conoscendo id di entrambi. Dal momento che il piatto è legato al ristorante, e può essere utilizzato in altri menù, verrà eliminata solo la relazione tra il piatto e il menù.
DELETE FROM 
	PIATTO_MENU 
WHERE 
	MENU='d17a7b54-d74e-4d29-815c-8ccc5134bab6' 
	AND PIATTO='3a214a1d-6c2f-4f34-992b-e2ff297fac17';
	
-- Rimuovere una recensione di un utente conosciuto il suo id e quello del ristorante.
DELETE FROM 
	RECENSIONE 
WHERE 
	RISTORANTE='976a3f01-62a7-421d-88f6-ffd7cc79131f' 
	AND UTENTE='c45a85d6-47bc-480b-9861-4c42642e4c77';
	
DELETE FROM 
	RISTORANTE
WHERE 
	ID='b2ed7cf3-a59e-4e90-8572-3ef356bfb106';