--
-- PostgreSQL database dump
--

-- Dumped from database version 13.5 (Ubuntu 13.5-2.pgdg20.04+1)
-- Dumped by pg_dump version 13.5 (Ubuntu 13.5-2.pgdg20.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: btree_gin; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS btree_gin WITH SCHEMA public;


--
-- Name: EXTENSION btree_gin; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION btree_gin IS 'support for indexing common datatypes in GIN';


--
-- Name: btree_gist; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS btree_gist WITH SCHEMA public;


--
-- Name: EXTENSION btree_gist; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION btree_gist IS 'support for indexing common datatypes in GiST';


--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- Name: cube; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS cube WITH SCHEMA public;


--
-- Name: EXTENSION cube; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION cube IS 'data type for multidimensional cubes';


--
-- Name: dblink; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS dblink WITH SCHEMA public;


--
-- Name: EXTENSION dblink; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dblink IS 'connect to other PostgreSQL databases from within a database';


--
-- Name: dict_int; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS dict_int WITH SCHEMA public;


--
-- Name: EXTENSION dict_int; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dict_int IS 'text search dictionary template for integers';


--
-- Name: dict_xsyn; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS dict_xsyn WITH SCHEMA public;


--
-- Name: EXTENSION dict_xsyn; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dict_xsyn IS 'text search dictionary template for extended synonym processing';


--
-- Name: earthdistance; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS earthdistance WITH SCHEMA public;


--
-- Name: EXTENSION earthdistance; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION earthdistance IS 'calculate great-circle distances on the surface of the Earth';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- Name: intarray; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS intarray WITH SCHEMA public;


--
-- Name: EXTENSION intarray; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION intarray IS 'functions, operators, and index support for 1-D arrays of integers';


--
-- Name: ltree; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS ltree WITH SCHEMA public;


--
-- Name: EXTENSION ltree; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION ltree IS 'data type for hierarchical tree-like structures';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: pgrowlocks; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgrowlocks WITH SCHEMA public;


--
-- Name: EXTENSION pgrowlocks; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgrowlocks IS 'show row-level locking information';


--
-- Name: pgstattuple; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgstattuple WITH SCHEMA public;


--
-- Name: EXTENSION pgstattuple; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgstattuple IS 'show tuple-level statistics';


--
-- Name: tablefunc; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;


--
-- Name: EXTENSION tablefunc; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION tablefunc IS 'functions that manipulate whole tables, including crosstab';


--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: xml2; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS xml2 WITH SCHEMA public;


--
-- Name: EXTENSION xml2; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION xml2 IS 'XPath querying and XSLT';


--
-- Name: create_trigger_for_menu_activity(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.create_trigger_for_menu_activity() RETURNS trigger
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


-- Name: create_trigger_for_plate_menu_activity(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.create_trigger_for_plate_menu_activity() RETURNS trigger
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

--
-- Name: create_trigger_for_review_activity(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.create_trigger_for_review_activity() RETURNS trigger
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


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: allergene; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.allergene (
    id smallint NOT NULL,
    nome character varying(60) NOT NULL,
    descrizione text NOT NULL
);


--
-- Name: allergene_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.allergene_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: allergene_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.allergene_id_seq OWNED BY public.allergene.id;


--
-- Name: allergia; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.allergia (
    utente uuid NOT NULL,
    allergene integer NOT NULL,
    data_aggiunta timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: gestione; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gestione (
    ristorante uuid NOT NULL,
    ristoratore uuid NOT NULL,
    data_assegnazione timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: menu; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.menu (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    ristorante uuid NOT NULL,
    nome character varying(100) NOT NULL,
    attivo boolean DEFAULT false NOT NULL,
    data_creazione timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ultimo_aggiornamento timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: piatto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.piatto (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    ristorante uuid NOT NULL,
    nome character varying NOT NULL,
    prezzo numeric NOT NULL,
    foto text,
    descrizione text,
    vegano boolean NOT NULL,
    vegetariano boolean NOT NULL,
    portata uuid NOT NULL,
    data_aggiunta timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: piatto_allergene; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.piatto_allergene (
    piatto uuid NOT NULL,
    allergene integer NOT NULL,
    disponibile_senza boolean DEFAULT false NOT NULL,
    data_aggiunta timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: piatto_menu; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.piatto_menu (
    menu uuid NOT NULL,
    piatto uuid NOT NULL,
    posizione integer NOT NULL,
    data_aggiunta timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: portata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.portata (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    nome character varying(60) NOT NULL,
    ordine smallint DEFAULT 0 NOT NULL
);


--
-- Name: recensione; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.recensione (
    ristorante uuid NOT NULL,
    utente uuid NOT NULL,
    testo text NOT NULL,
    valutazione numeric NOT NULL,
    data timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT recensione_valutazione_check CHECK (((valutazione <= 5.0) AND (valutazione > 0.0) AND (((valutazione * (10)::numeric) % (5)::numeric) = (0)::numeric)))
);


--
-- Name: ristorante; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ristorante (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    nome character varying(60) NOT NULL,
    cap character varying(15) NOT NULL,
    sito_web text,
    telefono text,
    cover text,
    logo text,
    accetta_prenotazioni boolean NOT NULL,
    accetta_recensioni boolean DEFAULT true NOT NULL,
    citta character varying(100) NOT NULL,
    indirizzo text NOT NULL,
    data_aggiunta timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT ristorante_cap_check CHECK (((cap)::text ~ '^\d{5}(?:[-\s]\d{4})?$'::text)),
    CONSTRAINT ristorante_sito_web_check CHECK ((sito_web ~ 'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,255}\.[a-z]{2,9}\y([-a-zA-Z0-9@:%_\+.~#?&//=]*)$'::text)),
    CONSTRAINT ristorante_telefono_check CHECK ((telefono ~ '^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$'::text))
);


--
-- Name: ristoratore; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ristoratore (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    email text NOT NULL,
    nome character varying(60) NOT NULL,
    password text NOT NULL,
    data_iscrizione timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    immagine_profilo text,
    CONSTRAINT ristoratore_email_check CHECK ((email ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$'::text))
);


--
-- Name: utente; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.utente (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    email text NOT NULL,
    nome character varying(60) NOT NULL,
    password text NOT NULL,
    data_iscrizione timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    immagine_profilo text,
    CONSTRAINT utente_email_check CHECK ((email ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$'::text))
);


--
-- Name: allergene id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.allergene ALTER COLUMN id SET DEFAULT nextval('public.allergene_id_seq'::regclass);


--
-- Data for Name: allergene; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.allergene (id, nome, descrizione) FROM stdin;
1	Glutine	Cereali, grano, segale, orzo, avena, farro, kamut, inclusi ibridati e derivati.
2	Crostacei e derivati	Sia quelli marini che d’acqua dolce: gamberi, scampi, aragoste, granchi, paguri e simili.
3	Uova e derivati	Tutti i prodotti composti con uova, anche in parte minima. Tra le più comuni: maionese, frittata, emulsionanti, pasta all’uovo, biscotti e torte anche salate, gelati e creme ecc.
4	Pesce e derivati	Inclusi i derivati, cioè tutti quei prodotti alimentari che si compongono di pesce, anche se in piccole percentuali.
5	Arachidi e derivati	Snack confezionati, creme e condimenti in cui vi sia anche in piccole dosi.
6	Soia e derivati	Latte di soia, tofu, spaghetti, etc.
7	Latte e derivati	Yogurt, biscotti e torte, gelato e creme varie. Ogni prodotto in cui viene usato il latte.
8	Frutta a guscio e derivati	Tutti i prodotti che includono: mandorle, nocciole, noci comuni, noci di acagiù, noci pecan e del Brasile e Queensland, pistacchi.
9	Sedano e derivati	Presente in pezzi ma pure all’interno di preparati per zuppe, salse e concentrati vegetali.
10	Senape e derivati	Si può trovare nelle salse e nei condimenti, specie nella mostarda.
11	Semi di sesamo e derivati	Oltre ai semi interi usati per il pane, possiamo trovare tracce in alcuni tipi di farine.
12	Anidride solforosa e solfiti	In concentrazioni superiori a 10 mg/kg o 10 mg/l espressi come SO2. Usati come conservanti, possiamo trovarli in: conserve di prodotti ittici, in cibi sott’aceto, sott’olio e in salamoia, nelle marmellate, nell’aceto, nei funghi secchi e nelle bibite analcoliche e succhi di frutta.
13	Lupino e derivati	Presente ormai in molti cibi vegan, sotto forma di arrosti, salamini, farine e similari che hanno come base questo legume, ricco di proteine.
14	Molluschi e derivati	Canestrello, cannolicchio, capasanta, cuore, dattero di mare, fasolaro, garagolo, lumachino, cozza, murice, ostrica, patella, tartufo di mare, tellina e vongola etc.
\.


--
-- Data for Name: allergia; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.allergia (utente, allergene, data_aggiunta) FROM stdin;
304635e6-dee2-47f0-b41b-4b71ba3a0ec4	3	2022-01-08 23:18:43.52649
304635e6-dee2-47f0-b41b-4b71ba3a0ec4	7	2022-01-08 23:18:43.52649
304635e6-dee2-47f0-b41b-4b71ba3a0ec4	2	2022-01-08 23:18:43.52649
304635e6-dee2-47f0-b41b-4b71ba3a0ec4	4	2022-01-08 23:18:43.52649
304635e6-dee2-47f0-b41b-4b71ba3a0ec4	8	2022-01-08 23:18:43.52649
5a2e0f66-f568-4b58-a596-9cc10dbfd51d	12	2022-01-08 23:18:43.52649
91c1e2cd-63da-4f8e-893b-c8bcb58a131b	13	2022-01-08 23:18:43.52649
91c1e2cd-63da-4f8e-893b-c8bcb58a131b	9	2022-01-08 23:18:43.52649
80b36196-3292-495c-9f9e-0230f8e0c27c	10	2022-01-08 23:18:43.52649
80b36196-3292-495c-9f9e-0230f8e0c27c	4	2022-01-08 23:18:43.52649
c45a85d6-47bc-480b-9861-4c42642e4c77	1	2022-01-08 23:18:43.52649
7551e169-356d-4e62-a600-48b60861aa82	7	2022-01-08 23:18:43.52649
921e903e-2930-445a-9490-319325b6619d	11	2022-01-08 23:18:43.52649
893401bb-a0bb-4296-aa39-6241b137af1b	14	2022-01-08 23:18:43.52649
893401bb-a0bb-4296-aa39-6241b137af1b	4	2022-01-08 23:18:43.52649
b71e4baf-44f6-4cc7-b82d-ce7691856096	3	2022-01-08 23:18:43.52649
e48f7ffe-cfd4-401d-bd95-825e8bd73437	1	2022-01-08 23:18:43.52649
e48f7ffe-cfd4-401d-bd95-825e8bd73437	7	2022-01-08 23:18:43.52649
4919f131-67e2-4d9a-bf9a-e5ea20e9123e	11	2022-01-08 23:18:43.52649
\.


--
-- Data for Name: gestione; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.gestione (ristorante, ristoratore, data_assegnazione) FROM stdin;
976a3f01-62a7-421d-88f6-ffd7cc79131f	1442d1e5-240f-4088-b744-bf28c1b0d8cf	2022-01-08 23:18:43.52649
b2ed7cf3-a59e-4e90-8572-3ef356bfb106	6ee16a66-8354-4cc9-9b09-9754c66de9b1	2022-01-08 23:18:43.52649
74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	bc4be297-1235-42f5-a2ce-4983141bf853	2022-01-08 23:18:43.52649
\.


--
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.menu (id, ristorante, nome, attivo, data_creazione, ultimo_aggiornamento) FROM stdin;
eba64392-2f4c-4fb4-842b-f22e402eee68	976a3f01-62a7-421d-88f6-ffd7cc79131f	inverno_2022	t	2022-01-08 23:18:43.52649	2022-01-08 23:18:43.52649
face942e-9a0c-4996-ab89-a88b0de0973f	976a3f01-62a7-421d-88f6-ffd7cc79131f	primavera_2022	f	2022-01-08 23:18:43.52649	2022-01-08 23:18:43.52649
967f3c58-ee74-4fbe-bab8-3e35fa43b179	74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	dicembre 2021	f	2022-01-08 23:18:43.52649	2022-01-08 23:18:43.52649
3cbd175f-1829-4526-be6c-8b1e3c6e8006	74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	gennaio 2022	t	2022-01-08 23:18:43.52649	2022-01-08 23:18:43.52649
d17a7b54-d74e-4d29-815c-8ccc5134bab6	b2ed7cf3-a59e-4e90-8572-3ef356bfb106	default	t	2022-01-08 23:18:43.52649	2022-01-08 23:18:43.52649
\.


--
-- Data for Name: piatto; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.piatto (id, ristorante, nome, prezzo, foto, descrizione, vegano, vegetariano, portata, data_aggiunta) FROM stdin;
2f30706f-5e79-47d0-9298-24798eb71336	976a3f01-62a7-421d-88f6-ffd7cc79131f	Jack e lo speck	16.5		Costine dal gusto leggermente affumicato. Ricoperte con salsa tradizionale Trentina, fatta da noi con base di mele e sfumata al Jack Daniel. Poi guarnite con speck croccante, servite con le nostre patate della casa.	f	f	3e81cf7a-4fa1-4e6d-96a8-1c471cc78f8d	2022-01-08 23:18:43.52649
8fcdbaa3-e831-40ce-b69c-28a66fa45ae5	976a3f01-62a7-421d-88f6-ffd7cc79131f	Foresta	15.0		Costine dal gusto di montagna. Ricoperte con funghi e il loro sughetto, guarnite con una spolverata di erba cipollina. Servite con le nostre patate della casa.	f	f	3e81cf7a-4fa1-4e6d-96a8-1c471cc78f8d	2022-01-08 23:18:43.52649
8ddad1ee-96b1-4032-b7d4-909931efd051	976a3f01-62a7-421d-88f6-ffd7cc79131f	Home Style	15.50		Costine dal gusto classico. Semplici, saporite, non piccanti, servite con le nostre patate della casa.	f	f	3e81cf7a-4fa1-4e6d-96a8-1c471cc78f8d	2022-01-08 23:18:43.52649
a8c9f6fb-ad66-4498-b88e-7eca76defa2f	976a3f01-62a7-421d-88f6-ffd7cc79131f	Trentino Ammerigano	16.50		Costine dal gusto piccante. Ricoperte di salsa Barbecue fatta da noi (non è dolciastra in stile americano), servite con le nostre patate della casa.	f	f	3e81cf7a-4fa1-4e6d-96a8-1c471cc78f8d	2022-01-08 23:18:43.52649
834d8c9f-501d-43a5-ba5d-44afa3d6a8dd	976a3f01-62a7-421d-88f6-ffd7cc79131f	Cime nevose	16.50		Costine dal gusto deciso. Ricoperte con fondutina di formaggi dolci fatta da noi. Guarnite con una spolverata di delicato pepe affumicato. Servite con le nostre patate della casa.	f	f	3e81cf7a-4fa1-4e6d-96a8-1c471cc78f8d	2022-01-08 23:18:43.52649
cde7df22-226a-4efd-bc24-0b151eccb96c	976a3f01-62a7-421d-88f6-ffd7cc79131f	Ambiez	11.0		In un panino artigianale, un hamburger 150gr di solo manzo 100% italiano Handmade, formaggio dolce Latte Trento, insalata, pomodoro, salsa burger del Typical, servito con patatine fritte.	f	f	fb570e7b-c61b-430c-853c-a541ea8edf07	2022-01-08 23:18:43.52649
9bf5b8e5-c207-430f-8ca0-d7d96787eb69	976a3f01-62a7-421d-88f6-ffd7cc79131f	Yummy Falkner	11.0		In un panino artigianale, un hamburger 150gr di solo manzo 100% italiano Handmade, stracciatella di burrata, insalata, pomodoro, salsa BBQ, salsa burger del Typical, servito con patatine fritte.	f	f	fb570e7b-c61b-430c-853c-a541ea8edf07	2022-01-08 23:18:43.52649
19678566-5cb3-458c-81fd-4ab9a922d2c1	976a3f01-62a7-421d-88f6-ffd7cc79131f	Double Double	10.80		In un panino artigianale, due burger di manzo (2x100gr), doppio formaggio, insalata, pomodoro, salsa burger del Typical, servito con patatine fritte.	f	f	fb570e7b-c61b-430c-853c-a541ea8edf07	2022-01-08 23:18:43.52649
93f2848a-32e8-413e-b9f3-2d71f712f7b9	976a3f01-62a7-421d-88f6-ffd7cc79131f	Boss delle costine	11.0		In un panino artigianale, le nostre mitiche costine cotte secondo il metodo Rippen, disossate e sfilacciate, delicata salsa Trentina "dolce" dell’Orso, salsa burger del Typical, servito con patatine fritte.	f	f	fb570e7b-c61b-430c-853c-a541ea8edf07	2022-01-08 23:18:43.52649
2b4f11e4-64e9-4c3a-94f7-b1c29c1ab4f3	976a3f01-62a7-421d-88f6-ffd7cc79131f	The pulled pork sandwich	11.0		In un panino artigianale, la nostra spalla di maiale schiacciato cotto a lungo a bassa temperatura, insalata, salsa burger del Typical e a parte la nostra salsa BBQ, servito con patatine fritte.	f	f	fb570e7b-c61b-430c-853c-a541ea8edf07	2022-01-08 23:18:43.52649
fecfee64-3123-4340-9186-bf99c73d2223	976a3f01-62a7-421d-88f6-ffd7cc79131f	The Cheese Lake	14.90		Vi serviamo due burger (2x150gr di solo manzo 100% italiano handmade), ricoperti con la nostra fondutina di formaggi dolci, e listarelle di speck croccante. Serviti con le nostre patate della casa e cavoli cappucci conditi alla Trentina.	f	f	3e81cf7a-4fa1-4e6d-96a8-1c471cc78f8d	2022-01-08 23:18:43.52649
7178bc45-71f4-4bde-b77b-5c2830041552	976a3f01-62a7-421d-88f6-ffd7cc79131f	Guardiaboschi burger	14.90		Vi serviamo un vero burger di black angus irlandese cotto alla griglia (200gr) ricorperto con funghi e il loro sughetto, una spolverata di delicato pepe affumicato. Servito con le nostre patate della casa e cavoli cappucci conditi alla Trentina.	f	f	3e81cf7a-4fa1-4e6d-96a8-1c471cc78f8d	2022-01-08 23:18:43.52649
3b0e8141-c129-42bd-b25c-6d52615fa71a	976a3f01-62a7-421d-88f6-ffd7cc79131f	Quella volta su al maso	15.20		Würstel originale Alro Adige (artigianale fatto a mano a Postal BZ). Avvolto in fette di bacon e poi grigliato, accompagnato da una fetta di pane artigianale ricoperta di fonduta di formaggi dolci e fiocchi di cipolla croccante. Servito con le nostre patate della casa e cavoli cappucci conditi alla Trentina.	f	f	3e81cf7a-4fa1-4e6d-96a8-1c471cc78f8d	2022-01-08 23:18:43.52649
8cf171cb-39ca-42b7-a6ab-e27c1224141a	976a3f01-62a7-421d-88f6-ffd7cc79131f	Braies	14.80		La classica cotoletta di maiale tipica del Südtirol (300gr), servita con le nostre patate della casa e cavoli cappucci conditi alla Trentina.	f	f	3e81cf7a-4fa1-4e6d-96a8-1c471cc78f8d	2022-01-08 23:18:43.52649
9da5633f-0959-4885-9f02-644d1ec4624a	976a3f01-62a7-421d-88f6-ffd7cc79131f	Luserna	16.40		La classica cotoletta di maiale tipica del Südtirol (300gr) ricoperta con pomodorini, zucchine grattugiate, formaggio fresco Philadelphia. Servita con le nostre patate della casa e cavoli cappucci conditi alla Trentina.	f	f	3e81cf7a-4fa1-4e6d-96a8-1c471cc78f8d	2022-01-08 23:18:43.52649
49d379bb-95b0-4d9e-9f7e-90286208f362	976a3f01-62a7-421d-88f6-ffd7cc79131f	Un vegetariano a Trento	15.20		Tortel de patate, formaggio dolce e formaggio stagionato Latte Trento, funghi con il loro sughetto.	f	t	3e81cf7a-4fa1-4e6d-96a8-1c471cc78f8d	2022-01-08 23:18:43.52649
f352224b-715b-4b16-b83b-5e6634d12c2a	976a3f01-62a7-421d-88f6-ffd7cc79131f	No boring food	14.20		Due fette di pane artigianale tostato ricoperte di pomodorini, una burrata fresca, misticanza, ceci, noci.	f	t	3e81cf7a-4fa1-4e6d-96a8-1c471cc78f8d	2022-01-08 23:18:43.52649
f1ab18e8-19af-4f00-8182-8d34b82780d4	976a3f01-62a7-421d-88f6-ffd7cc79131f	Tony Gallo	10.20		Insalata, radicchio, cavoli cappucci conditi, pomodorini, farro, ceci, sesamo, listarelle di pollo, scaglie di parmigiano 24 mesi, noci.	f	f	5411c029-867f-4cba-9ab3-57b8eba93370	2022-01-08 23:18:43.52649
627ad6c5-b7a3-4485-98cf-8ad3d93cd531	976a3f01-62a7-421d-88f6-ffd7cc79131f	Surfing	10.20		Insalata, radicchio, cavoli cappucci conditi, pomodorini, farro, ceci, sesamo, tonno, olive, mozzarella fior di latte.	f	f	5411c029-867f-4cba-9ab3-57b8eba93370	2022-01-08 23:18:43.52649
fc361367-f1aa-4d74-82e2-36159caaada2	976a3f01-62a7-421d-88f6-ffd7cc79131f	Coca cola	2.50			f	f	0250923c-420d-4810-9ff6-a9e62f6be3a9	2022-01-08 23:18:43.52649
4398ca0e-290f-415a-abbc-8925145ef69a	976a3f01-62a7-421d-88f6-ffd7cc79131f	Acqua frizzante/naturale	1.0			f	f	0250923c-420d-4810-9ff6-a9e62f6be3a9	2022-01-08 23:18:43.52649
ddf49cc8-c138-4143-85cb-98e2d4613fd3	976a3f01-62a7-421d-88f6-ffd7cc79131f	Birra Skietta	6.50		Non pastorizzata e spillata con un metodo totalmente naturale. Una sacca isolante la protegge e non la fa mai entrare in contatto con il gas della spillatrice	f	f	0250923c-420d-4810-9ff6-a9e62f6be3a9	2022-01-08 23:18:43.52649
62598898-1124-4196-b2c8-0cf2eb8d8247	74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	Pizza Margherita	10.0		Pizza con passata di pomodoro, mozzarella di bufala e origano.	f	t	4492352b-0484-46e2-935c-471ae36f2100	2022-01-08 23:18:43.52649
82b0f06f-b196-48ac-a9fb-5c1ed7722205	74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	Pizza Diavola	11.0		Pizza con passata di pomodoro, mozzarella di bufala, peperoncino piccante e salame piccante.	f	f	4492352b-0484-46e2-935c-471ae36f2100	2022-01-08 23:18:43.52649
2bd46d71-bf39-42be-9ad8-ea2b112da3fc	74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	Onda calabra	10.50		Mozzarella fiordilatte, salsa di pomodoro BIO, melanzane arrostite, scamorza affumicata e salamino Spianata Calabra (leggermente piccante).	f	f	4492352b-0484-46e2-935c-471ae36f2100	2022-01-08 23:18:43.52649
e2fa88ee-64e8-458c-9105-e57261faf48b	74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	Focaccia al rosmarino	8.0		Focaccia bianca con una spolverata di rosmarino.	t	t	4492352b-0484-46e2-935c-471ae36f2100	2022-01-08 23:18:43.52649
e60ec3b5-4a33-4cb3-afc8-f2f715775aee	74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	Una ragazza capricciosa	12.90		Passata di pomodoro BIO, mozzarella fiordilatte. Dopo cottura: prosciutto cotto tirolese, olive nostra ricetta, carciofi, pomodoro arrostito e basilico.	f	f	4492352b-0484-46e2-935c-471ae36f2100	2022-01-08 23:18:43.52649
83611f6e-c64f-4101-9075-c826d6924b59	74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	Vedi che sei sciupato	10.50		Mozzarella fiordilatte, passata di pomodoro BIO, melanzane arrostite e cipolla caramellata. Dopo cottura: formaggio fresco Bressanone, pomodoro fresco e basilico.	f	t	4492352b-0484-46e2-935c-471ae36f2100	2022-01-08 23:18:43.52649
7d028fbf-5a62-4be9-9301-23922aa42ddb	74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	Gianni e rita	12.80		Passata di pomodoro BIO. Dopo cottura: rucola, mozzarella di bufala e pomodoro fresco e Crudo di Parma.	f	f	4492352b-0484-46e2-935c-471ae36f2100	2022-01-08 23:18:43.52649
72f582fe-702c-4da9-b5b7-85baa39f4d3e	74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	La leggenda di totonno	10.20		Mozzarella fiordilatte, passata di pomodoro BIO e cipolla caramellata. Dopo cottura: pomodoro fresco, tonno e basilico.	f	f	4492352b-0484-46e2-935c-471ae36f2100	2022-01-08 23:18:43.52649
3d1a6bea-8c06-4c4a-b6ec-456438d56b9b	74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	Sora lella	10.20		Mozzarella fiordilatte, salsa di pomodoro BIO, polpettine del Loto e cipolla caramellata. Dopo cottura: Parmigiano a scaglie e basilico.	f	f	4492352b-0484-46e2-935c-471ae36f2100	2022-01-08 23:18:43.52649
f34c759c-739c-4e9f-829e-412418f2666b	74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	Bufala	10.50		Passata di pomodoro BIO, mozzarella di bufala. Dopo cottura: pomodoro "dolce" arrostito e basilico.	f	t	4492352b-0484-46e2-935c-471ae36f2100	2022-01-08 23:18:43.52649
50620722-96a5-457d-98a3-e7155b400974	74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	Focacciamia	12.90		Pasta della pizza cotta in forno. Dopo cottura viene piegata e riempita con rucola, pomodoro fresco e mozzarella di bufala. Poi rimessa un attimo in forno e servita con, a parte, crudo di Parma.	f	f	4492352b-0484-46e2-935c-471ae36f2100	2022-01-08 23:18:43.52649
57a46159-aa9e-4c6f-9a26-550fec7f77e2	74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	Il boia di Carpi	13.70		Mozzarella fiordilatte, passata di pomodoro BIO, funghi e porcini trifolati (homemade), lucanica a fette (prima sgrassata in forno), cipolla caramellata e salamino. Dopo cottura: gorgonzola dolce lavorato a mano.	f	f	4492352b-0484-46e2-935c-471ae36f2100	2022-01-08 23:18:43.52649
b83095fe-5c5b-4f7e-b045-81bacf54f10c	74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	Bondonera	12.8		Mozzarella fiordilatte, passata di pomodoro BIO, funghi e porcini trifolati (homemade). Dopo cottura: speck a fette, gorgonzola dolce.	f	f	4492352b-0484-46e2-935c-471ae36f2100	2022-01-08 23:18:43.52649
eb7e94b0-9075-4e5a-b605-00c1e9c9fb55	74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	Sfrizzoli Anterselva	13.50		Con speck Alto Adige e una burrata.	f	f	3e81cf7a-4fa1-4e6d-96a8-1c471cc78f8d	2022-01-08 23:18:43.52649
21affe0a-03a1-4dc4-9e5a-23c6dd30d346	74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	Sfrizzoli The original	13.50		Prosciutto crudo dolce di Parma e crescenza fresca.	f	t	3e81cf7a-4fa1-4e6d-96a8-1c471cc78f8d	2022-01-08 23:18:43.52649
c1694389-bd5b-4a30-8ca7-16359a43f282	74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	Sfrizzoli Dobbiaco	13.50		Con prosciutto cotto tirolese e una Burrata	f	f	3e81cf7a-4fa1-4e6d-96a8-1c471cc78f8d	2022-01-08 23:18:43.52649
0a08df84-dd0a-481d-88c0-b32d1daf382f	74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	Sfrizzoli La bella coppietta	13.50		Prosciutto crudo dolce di Parma e burrata fresca.	f	f	3e81cf7a-4fa1-4e6d-96a8-1c471cc78f8d	2022-01-08 23:18:43.52649
85b74225-be8f-45b3-8c9c-e83e45ae4512	74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	Sfrizzoli dolci	5.5		La versione originale, la nostra prima ricetta. Accompagnati da una salsina alla cioccolata/nocciola e da una salsa di fragole fatta in casa.	f	t	31bbd71e-bf1b-42a0-b726-445e83076671	2022-01-08 23:18:43.52649
f09ee771-e634-4488-94af-61bd3da17bb9	74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	Coca cola	3.0			f	f	0250923c-420d-4810-9ff6-a9e62f6be3a9	2022-01-08 23:18:43.52649
52e75789-e64b-4db6-9973-1433c4f3d1cf	74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	Vino bianco della casa in calice	6.0			f	f	0250923c-420d-4810-9ff6-a9e62f6be3a9	2022-01-08 23:18:43.52649
2d2b9392-dbea-46cc-b9f6-7c3fb3ff4d57	74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	Vino rosso della casa in calice	6.50			f	f	0250923c-420d-4810-9ff6-a9e62f6be3a9	2022-01-08 23:18:43.52649
d429a3c4-2db0-4d25-b82c-d2140433ab59	74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	Birra alla spina 0.5l	5.5			f	f	0250923c-420d-4810-9ff6-a9e62f6be3a9	2022-01-08 23:18:43.52649
e09452c5-433a-41e7-8a74-2ebd13fe6a3f	b2ed7cf3-a59e-4e90-8572-3ef356bfb106	Un’anguilla risale il fiume Po	80.0			f	f	19cb3e0a-3abd-4465-8ff6-6dad85715ef4	2022-01-08 23:18:43.52649
0f97573c-f316-4198-806a-3171240fa131	b2ed7cf3-a59e-4e90-8572-3ef356bfb106	Cinque stagionature del Parmigiano Reggiano in diverse consistenze e temperature	80.0			f	t	19cb3e0a-3abd-4465-8ff6-6dad85715ef4	2022-01-08 23:18:43.52649
c6acde94-04a4-4dd5-8fa0-c36353b1cc5b	b2ed7cf3-a59e-4e90-8572-3ef356bfb106	Croccantino di foie gras in crosta di mandorle di Noto e nocciole del Piemonte con Aceto Balsamico Tradizionale di Modena Villa Manodori	90.0			f	f	19cb3e0a-3abd-4465-8ff6-6dad85715ef4	2022-01-08 23:18:43.52649
901ae351-a67d-48d0-98f1-f396f72ec861	b2ed7cf3-a59e-4e90-8572-3ef356bfb106	Culatello di Zibello Antiche Razze 42 mesi di stagionatura accompagnato da mostarda di mele Campanine	80.0			f	f	19cb3e0a-3abd-4465-8ff6-6dad85715ef4	2022-01-08 23:18:43.52649
fef2d68f-7372-4dbf-bd14-a3aaba795a0f	b2ed7cf3-a59e-4e90-8572-3ef356bfb106	Ravioli di porri, tartufo nero pregiato e foie gras	90.0			f	f	541e5711-ba4b-4fb3-89ca-1351207f25c2	2022-01-08 23:18:43.52649
e42dfaf6-7c03-4afd-b4e6-409027ad149b	b2ed7cf3-a59e-4e90-8572-3ef356bfb106	Tortellini in crema di Parmigiano Reggiano	80.0			f	f	541e5711-ba4b-4fb3-89ca-1351207f25c2	2022-01-08 23:18:43.52649
08364c83-4295-4638-bd05-732a6dd464dc	b2ed7cf3-a59e-4e90-8572-3ef356bfb106	Tortellini del dito mignolo in brodo di cappone	80.0			f	f	541e5711-ba4b-4fb3-89ca-1351207f25c2	2022-01-08 23:18:43.52649
ef0877b1-c63a-4996-a758-fb315da5942e	b2ed7cf3-a59e-4e90-8572-3ef356bfb106	Tagliatelle al ragù	80.0			f	f	541e5711-ba4b-4fb3-89ca-1351207f25c2	2022-01-08 23:18:43.52649
32645233-9ece-4368-9492-99fc2cf18ccd	b2ed7cf3-a59e-4e90-8572-3ef356bfb106	Astice in doppia salsa spumosa, acida e dolce	110.0			f	f	3e81cf7a-4fa1-4e6d-96a8-1c471cc78f8d	2022-01-08 23:18:43.52649
b3ccd249-1535-49f9-8192-fa4625a7f860	b2ed7cf3-a59e-4e90-8572-3ef356bfb106	Stiamo ancora decidendo che pesce servire!	110.0			f	f	3e81cf7a-4fa1-4e6d-96a8-1c471cc78f8d	2022-01-08 23:18:43.52649
96d51be2-d91b-4cbf-b104-7183b03d7980	b2ed7cf3-a59e-4e90-8572-3ef356bfb106	This little piggy went to the market	110.0			f	f	3e81cf7a-4fa1-4e6d-96a8-1c471cc78f8d	2022-01-08 23:18:43.52649
607a4037-e284-4d9b-8781-c6117dc5cd26	b2ed7cf3-a59e-4e90-8572-3ef356bfb106	Un’interpretazione del filetto alla Rossini con foie gras e caviale	150.0			f	f	3e81cf7a-4fa1-4e6d-96a8-1c471cc78f8d	2022-01-08 23:18:43.52649
2be5c671-fe24-4345-877a-4cf8a1dd22fe	b2ed7cf3-a59e-4e90-8572-3ef356bfb106	Zuppa inglese	60.0			f	f	31bbd71e-bf1b-42a0-b726-445e83076671	2022-01-08 23:18:43.52649
b22ccb15-cfbf-4dd6-81cd-11fe1744a6e0	b2ed7cf3-a59e-4e90-8572-3ef356bfb106	In and Out of Style	60.0			f	f	31bbd71e-bf1b-42a0-b726-445e83076671	2022-01-08 23:18:43.52649
3a214a1d-6c2f-4f34-992b-e2ff297fac17	b2ed7cf3-a59e-4e90-8572-3ef356bfb106	* Non è una Tatin, non è una Sacher e à ghe anche L’amareina *	60.0			f	f	31bbd71e-bf1b-42a0-b726-445e83076671	2022-01-08 23:18:43.52649
b566f4aa-57ae-46ce-a85c-4e20513090cd	b2ed7cf3-a59e-4e90-8572-3ef356bfb106	Oops! I dropped the lemon tart	60.0			f	f	31bbd71e-bf1b-42a0-b726-445e83076671	2022-01-08 23:18:43.52649
\.


--
-- Data for Name: piatto_allergene; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.piatto_allergene (piatto, allergene, disponibile_senza, data_aggiunta) FROM stdin;
834d8c9f-501d-43a5-ba5d-44afa3d6a8dd	7	f	2022-01-08 23:18:43.52649
cde7df22-226a-4efd-bc24-0b151eccb96c	1	f	2022-01-08 23:18:43.52649
cde7df22-226a-4efd-bc24-0b151eccb96c	7	f	2022-01-08 23:18:43.52649
9bf5b8e5-c207-430f-8ca0-d7d96787eb69	1	f	2022-01-08 23:18:43.52649
9bf5b8e5-c207-430f-8ca0-d7d96787eb69	7	f	2022-01-08 23:18:43.52649
19678566-5cb3-458c-81fd-4ab9a922d2c1	1	f	2022-01-08 23:18:43.52649
19678566-5cb3-458c-81fd-4ab9a922d2c1	7	f	2022-01-08 23:18:43.52649
93f2848a-32e8-413e-b9f3-2d71f712f7b9	1	f	2022-01-08 23:18:43.52649
93f2848a-32e8-413e-b9f3-2d71f712f7b9	7	f	2022-01-08 23:18:43.52649
2b4f11e4-64e9-4c3a-94f7-b1c29c1ab4f3	1	f	2022-01-08 23:18:43.52649
2b4f11e4-64e9-4c3a-94f7-b1c29c1ab4f3	7	f	2022-01-08 23:18:43.52649
fecfee64-3123-4340-9186-bf99c73d2223	7	t	2022-01-08 23:18:43.52649
3b0e8141-c129-42bd-b25c-6d52615fa71a	7	t	2022-01-08 23:18:43.52649
8cf171cb-39ca-42b7-a6ab-e27c1224141a	7	f	2022-01-08 23:18:43.52649
8cf171cb-39ca-42b7-a6ab-e27c1224141a	1	f	2022-01-08 23:18:43.52649
8cf171cb-39ca-42b7-a6ab-e27c1224141a	3	f	2022-01-08 23:18:43.52649
9da5633f-0959-4885-9f02-644d1ec4624a	7	f	2022-01-08 23:18:43.52649
9da5633f-0959-4885-9f02-644d1ec4624a	1	f	2022-01-08 23:18:43.52649
49d379bb-95b0-4d9e-9f7e-90286208f362	7	f	2022-01-08 23:18:43.52649
49d379bb-95b0-4d9e-9f7e-90286208f362	1	f	2022-01-08 23:18:43.52649
f352224b-715b-4b16-b83b-5e6634d12c2a	1	f	2022-01-08 23:18:43.52649
f352224b-715b-4b16-b83b-5e6634d12c2a	7	t	2022-01-08 23:18:43.52649
f1ab18e8-19af-4f00-8182-8d34b82780d4	8	f	2022-01-08 23:18:43.52649
f1ab18e8-19af-4f00-8182-8d34b82780d4	11	f	2022-01-08 23:18:43.52649
627ad6c5-b7a3-4485-98cf-8ad3d93cd531	11	f	2022-01-08 23:18:43.52649
627ad6c5-b7a3-4485-98cf-8ad3d93cd531	4	f	2022-01-08 23:18:43.52649
62598898-1124-4196-b2c8-0cf2eb8d8247	7	t	2022-01-08 23:18:43.52649
62598898-1124-4196-b2c8-0cf2eb8d8247	1	f	2022-01-08 23:18:43.52649
82b0f06f-b196-48ac-a9fb-5c1ed7722205	7	t	2022-01-08 23:18:43.52649
82b0f06f-b196-48ac-a9fb-5c1ed7722205	1	f	2022-01-08 23:18:43.52649
2bd46d71-bf39-42be-9ad8-ea2b112da3fc	7	t	2022-01-08 23:18:43.52649
2bd46d71-bf39-42be-9ad8-ea2b112da3fc	1	f	2022-01-08 23:18:43.52649
e2fa88ee-64e8-458c-9105-e57261faf48b	1	f	2022-01-08 23:18:43.52649
e2fa88ee-64e8-458c-9105-e57261faf48b	7	t	2022-01-08 23:18:43.52649
e60ec3b5-4a33-4cb3-afc8-f2f715775aee	1	f	2022-01-08 23:18:43.52649
e60ec3b5-4a33-4cb3-afc8-f2f715775aee	7	t	2022-01-08 23:18:43.52649
83611f6e-c64f-4101-9075-c826d6924b59	1	f	2022-01-08 23:18:43.52649
83611f6e-c64f-4101-9075-c826d6924b59	7	t	2022-01-08 23:18:43.52649
7d028fbf-5a62-4be9-9301-23922aa42ddb	1	f	2022-01-08 23:18:43.52649
7d028fbf-5a62-4be9-9301-23922aa42ddb	7	t	2022-01-08 23:18:43.52649
72f582fe-702c-4da9-b5b7-85baa39f4d3e	1	f	2022-01-08 23:18:43.52649
72f582fe-702c-4da9-b5b7-85baa39f4d3e	7	t	2022-01-08 23:18:43.52649
72f582fe-702c-4da9-b5b7-85baa39f4d3e	4	t	2022-01-08 23:18:43.52649
3d1a6bea-8c06-4c4a-b6ec-456438d56b9b	1	f	2022-01-08 23:18:43.52649
3d1a6bea-8c06-4c4a-b6ec-456438d56b9b	7	t	2022-01-08 23:18:43.52649
f34c759c-739c-4e9f-829e-412418f2666b	1	f	2022-01-08 23:18:43.52649
f34c759c-739c-4e9f-829e-412418f2666b	7	t	2022-01-08 23:18:43.52649
50620722-96a5-457d-98a3-e7155b400974	1	f	2022-01-08 23:18:43.52649
50620722-96a5-457d-98a3-e7155b400974	7	t	2022-01-08 23:18:43.52649
57a46159-aa9e-4c6f-9a26-550fec7f77e2	1	f	2022-01-08 23:18:43.52649
57a46159-aa9e-4c6f-9a26-550fec7f77e2	7	t	2022-01-08 23:18:43.52649
b83095fe-5c5b-4f7e-b045-81bacf54f10c	1	f	2022-01-08 23:18:43.52649
b83095fe-5c5b-4f7e-b045-81bacf54f10c	7	t	2022-01-08 23:18:43.52649
eb7e94b0-9075-4e5a-b605-00c1e9c9fb55	1	f	2022-01-08 23:18:43.52649
eb7e94b0-9075-4e5a-b605-00c1e9c9fb55	7	t	2022-01-08 23:18:43.52649
21affe0a-03a1-4dc4-9e5a-23c6dd30d346	1	f	2022-01-08 23:18:43.52649
21affe0a-03a1-4dc4-9e5a-23c6dd30d346	7	t	2022-01-08 23:18:43.52649
c1694389-bd5b-4a30-8ca7-16359a43f282	1	f	2022-01-08 23:18:43.52649
c1694389-bd5b-4a30-8ca7-16359a43f282	7	t	2022-01-08 23:18:43.52649
0a08df84-dd0a-481d-88c0-b32d1daf382f	1	f	2022-01-08 23:18:43.52649
0a08df84-dd0a-481d-88c0-b32d1daf382f	7	t	2022-01-08 23:18:43.52649
85b74225-be8f-45b3-8c9c-e83e45ae4512	1	f	2022-01-08 23:18:43.52649
85b74225-be8f-45b3-8c9c-e83e45ae4512	7	f	2022-01-08 23:18:43.52649
e09452c5-433a-41e7-8a74-2ebd13fe6a3f	4	f	2022-01-08 23:18:43.52649
0f97573c-f316-4198-806a-3171240fa131	7	f	2022-01-08 23:18:43.52649
c6acde94-04a4-4dd5-8fa0-c36353b1cc5b	1	f	2022-01-08 23:18:43.52649
c6acde94-04a4-4dd5-8fa0-c36353b1cc5b	8	f	2022-01-08 23:18:43.52649
901ae351-a67d-48d0-98f1-f396f72ec861	10	f	2022-01-08 23:18:43.52649
fef2d68f-7372-4dbf-bd14-a3aaba795a0f	1	f	2022-01-08 23:18:43.52649
fef2d68f-7372-4dbf-bd14-a3aaba795a0f	7	f	2022-01-08 23:18:43.52649
e42dfaf6-7c03-4afd-b4e6-409027ad149b	1	f	2022-01-08 23:18:43.52649
e42dfaf6-7c03-4afd-b4e6-409027ad149b	7	f	2022-01-08 23:18:43.52649
08364c83-4295-4638-bd05-732a6dd464dc	1	f	2022-01-08 23:18:43.52649
08364c83-4295-4638-bd05-732a6dd464dc	7	f	2022-01-08 23:18:43.52649
ef0877b1-c63a-4996-a758-fb315da5942e	1	f	2022-01-08 23:18:43.52649
32645233-9ece-4368-9492-99fc2cf18ccd	4	f	2022-01-08 23:18:43.52649
b3ccd249-1535-49f9-8192-fa4625a7f860	4	f	2022-01-08 23:18:43.52649
2be5c671-fe24-4345-877a-4cf8a1dd22fe	1	f	2022-01-08 23:18:43.52649
2be5c671-fe24-4345-877a-4cf8a1dd22fe	7	f	2022-01-08 23:18:43.52649
b22ccb15-cfbf-4dd6-81cd-11fe1744a6e0	1	f	2022-01-08 23:18:43.52649
b22ccb15-cfbf-4dd6-81cd-11fe1744a6e0	7	f	2022-01-08 23:18:43.52649
3a214a1d-6c2f-4f34-992b-e2ff297fac17	1	f	2022-01-08 23:18:43.52649
3a214a1d-6c2f-4f34-992b-e2ff297fac17	7	f	2022-01-08 23:18:43.52649
b566f4aa-57ae-46ce-a85c-4e20513090cd	1	f	2022-01-08 23:18:43.52649
b566f4aa-57ae-46ce-a85c-4e20513090cd	7	f	2022-01-08 23:18:43.52649
\.


--
-- Data for Name: piatto_menu; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.piatto_menu (menu, piatto, posizione, data_aggiunta) FROM stdin;
eba64392-2f4c-4fb4-842b-f22e402eee68	2f30706f-5e79-47d0-9298-24798eb71336	0	2022-01-08 23:18:43.52649
eba64392-2f4c-4fb4-842b-f22e402eee68	8fcdbaa3-e831-40ce-b69c-28a66fa45ae5	1	2022-01-08 23:18:43.52649
eba64392-2f4c-4fb4-842b-f22e402eee68	8ddad1ee-96b1-4032-b7d4-909931efd051	2	2022-01-08 23:18:43.52649
eba64392-2f4c-4fb4-842b-f22e402eee68	a8c9f6fb-ad66-4498-b88e-7eca76defa2f	3	2022-01-08 23:18:43.52649
eba64392-2f4c-4fb4-842b-f22e402eee68	834d8c9f-501d-43a5-ba5d-44afa3d6a8dd	4	2022-01-08 23:18:43.52649
eba64392-2f4c-4fb4-842b-f22e402eee68	cde7df22-226a-4efd-bc24-0b151eccb96c	5	2022-01-08 23:18:43.52649
eba64392-2f4c-4fb4-842b-f22e402eee68	9bf5b8e5-c207-430f-8ca0-d7d96787eb69	6	2022-01-08 23:18:43.52649
eba64392-2f4c-4fb4-842b-f22e402eee68	19678566-5cb3-458c-81fd-4ab9a922d2c1	7	2022-01-08 23:18:43.52649
eba64392-2f4c-4fb4-842b-f22e402eee68	93f2848a-32e8-413e-b9f3-2d71f712f7b9	8	2022-01-08 23:18:43.52649
eba64392-2f4c-4fb4-842b-f22e402eee68	2b4f11e4-64e9-4c3a-94f7-b1c29c1ab4f3	9	2022-01-08 23:18:43.52649
eba64392-2f4c-4fb4-842b-f22e402eee68	fecfee64-3123-4340-9186-bf99c73d2223	10	2022-01-08 23:18:43.52649
eba64392-2f4c-4fb4-842b-f22e402eee68	7178bc45-71f4-4bde-b77b-5c2830041552	11	2022-01-08 23:18:43.52649
eba64392-2f4c-4fb4-842b-f22e402eee68	3b0e8141-c129-42bd-b25c-6d52615fa71a	12	2022-01-08 23:18:43.52649
eba64392-2f4c-4fb4-842b-f22e402eee68	8cf171cb-39ca-42b7-a6ab-e27c1224141a	13	2022-01-08 23:18:43.52649
eba64392-2f4c-4fb4-842b-f22e402eee68	9da5633f-0959-4885-9f02-644d1ec4624a	14	2022-01-08 23:18:43.52649
eba64392-2f4c-4fb4-842b-f22e402eee68	49d379bb-95b0-4d9e-9f7e-90286208f362	15	2022-01-08 23:18:43.52649
eba64392-2f4c-4fb4-842b-f22e402eee68	f352224b-715b-4b16-b83b-5e6634d12c2a	16	2022-01-08 23:18:43.52649
eba64392-2f4c-4fb4-842b-f22e402eee68	f1ab18e8-19af-4f00-8182-8d34b82780d4	17	2022-01-08 23:18:43.52649
eba64392-2f4c-4fb4-842b-f22e402eee68	627ad6c5-b7a3-4485-98cf-8ad3d93cd531	18	2022-01-08 23:18:43.52649
eba64392-2f4c-4fb4-842b-f22e402eee68	fc361367-f1aa-4d74-82e2-36159caaada2	19	2022-01-08 23:18:43.52649
eba64392-2f4c-4fb4-842b-f22e402eee68	4398ca0e-290f-415a-abbc-8925145ef69a	20	2022-01-08 23:18:43.52649
eba64392-2f4c-4fb4-842b-f22e402eee68	ddf49cc8-c138-4143-85cb-98e2d4613fd3	21	2022-01-08 23:18:43.52649
face942e-9a0c-4996-ab89-a88b0de0973f	2f30706f-5e79-47d0-9298-24798eb71336	0	2022-01-08 23:18:43.52649
face942e-9a0c-4996-ab89-a88b0de0973f	8fcdbaa3-e831-40ce-b69c-28a66fa45ae5	1	2022-01-08 23:18:43.52649
face942e-9a0c-4996-ab89-a88b0de0973f	8ddad1ee-96b1-4032-b7d4-909931efd051	2	2022-01-08 23:18:43.52649
face942e-9a0c-4996-ab89-a88b0de0973f	a8c9f6fb-ad66-4498-b88e-7eca76defa2f	3	2022-01-08 23:18:43.52649
face942e-9a0c-4996-ab89-a88b0de0973f	834d8c9f-501d-43a5-ba5d-44afa3d6a8dd	4	2022-01-08 23:18:43.52649
face942e-9a0c-4996-ab89-a88b0de0973f	cde7df22-226a-4efd-bc24-0b151eccb96c	5	2022-01-08 23:18:43.52649
face942e-9a0c-4996-ab89-a88b0de0973f	9bf5b8e5-c207-430f-8ca0-d7d96787eb69	6	2022-01-08 23:18:43.52649
face942e-9a0c-4996-ab89-a88b0de0973f	19678566-5cb3-458c-81fd-4ab9a922d2c1	7	2022-01-08 23:18:43.52649
face942e-9a0c-4996-ab89-a88b0de0973f	93f2848a-32e8-413e-b9f3-2d71f712f7b9	8	2022-01-08 23:18:43.52649
face942e-9a0c-4996-ab89-a88b0de0973f	2b4f11e4-64e9-4c3a-94f7-b1c29c1ab4f3	9	2022-01-08 23:18:43.52649
face942e-9a0c-4996-ab89-a88b0de0973f	fecfee64-3123-4340-9186-bf99c73d2223	10	2022-01-08 23:18:43.52649
face942e-9a0c-4996-ab89-a88b0de0973f	7178bc45-71f4-4bde-b77b-5c2830041552	11	2022-01-08 23:18:43.52649
face942e-9a0c-4996-ab89-a88b0de0973f	3b0e8141-c129-42bd-b25c-6d52615fa71a	12	2022-01-08 23:18:43.52649
face942e-9a0c-4996-ab89-a88b0de0973f	8cf171cb-39ca-42b7-a6ab-e27c1224141a	13	2022-01-08 23:18:43.52649
face942e-9a0c-4996-ab89-a88b0de0973f	9da5633f-0959-4885-9f02-644d1ec4624a	14	2022-01-08 23:18:43.52649
face942e-9a0c-4996-ab89-a88b0de0973f	627ad6c5-b7a3-4485-98cf-8ad3d93cd531	15	2022-01-08 23:18:43.52649
face942e-9a0c-4996-ab89-a88b0de0973f	fc361367-f1aa-4d74-82e2-36159caaada2	16	2022-01-08 23:18:43.52649
face942e-9a0c-4996-ab89-a88b0de0973f	4398ca0e-290f-415a-abbc-8925145ef69a	17	2022-01-08 23:18:43.52649
face942e-9a0c-4996-ab89-a88b0de0973f	ddf49cc8-c138-4143-85cb-98e2d4613fd3	18	2022-01-08 23:18:43.52649
3cbd175f-1829-4526-be6c-8b1e3c6e8006	62598898-1124-4196-b2c8-0cf2eb8d8247	0	2022-01-08 23:18:43.52649
3cbd175f-1829-4526-be6c-8b1e3c6e8006	2bd46d71-bf39-42be-9ad8-ea2b112da3fc	1	2022-01-08 23:18:43.52649
3cbd175f-1829-4526-be6c-8b1e3c6e8006	e2fa88ee-64e8-458c-9105-e57261faf48b	2	2022-01-08 23:18:43.52649
3cbd175f-1829-4526-be6c-8b1e3c6e8006	e60ec3b5-4a33-4cb3-afc8-f2f715775aee	3	2022-01-08 23:18:43.52649
3cbd175f-1829-4526-be6c-8b1e3c6e8006	83611f6e-c64f-4101-9075-c826d6924b59	4	2022-01-08 23:18:43.52649
3cbd175f-1829-4526-be6c-8b1e3c6e8006	7d028fbf-5a62-4be9-9301-23922aa42ddb	5	2022-01-08 23:18:43.52649
3cbd175f-1829-4526-be6c-8b1e3c6e8006	72f582fe-702c-4da9-b5b7-85baa39f4d3e	6	2022-01-08 23:18:43.52649
3cbd175f-1829-4526-be6c-8b1e3c6e8006	3d1a6bea-8c06-4c4a-b6ec-456438d56b9b	7	2022-01-08 23:18:43.52649
3cbd175f-1829-4526-be6c-8b1e3c6e8006	f34c759c-739c-4e9f-829e-412418f2666b	8	2022-01-08 23:18:43.52649
3cbd175f-1829-4526-be6c-8b1e3c6e8006	50620722-96a5-457d-98a3-e7155b400974	9	2022-01-08 23:18:43.52649
3cbd175f-1829-4526-be6c-8b1e3c6e8006	57a46159-aa9e-4c6f-9a26-550fec7f77e2	10	2022-01-08 23:18:43.52649
3cbd175f-1829-4526-be6c-8b1e3c6e8006	b83095fe-5c5b-4f7e-b045-81bacf54f10c	11	2022-01-08 23:18:43.52649
3cbd175f-1829-4526-be6c-8b1e3c6e8006	eb7e94b0-9075-4e5a-b605-00c1e9c9fb55	12	2022-01-08 23:18:43.52649
3cbd175f-1829-4526-be6c-8b1e3c6e8006	21affe0a-03a1-4dc4-9e5a-23c6dd30d346	13	2022-01-08 23:18:43.52649
3cbd175f-1829-4526-be6c-8b1e3c6e8006	c1694389-bd5b-4a30-8ca7-16359a43f282	14	2022-01-08 23:18:43.52649
3cbd175f-1829-4526-be6c-8b1e3c6e8006	0a08df84-dd0a-481d-88c0-b32d1daf382f	15	2022-01-08 23:18:43.52649
3cbd175f-1829-4526-be6c-8b1e3c6e8006	85b74225-be8f-45b3-8c9c-e83e45ae4512	16	2022-01-08 23:18:43.52649
3cbd175f-1829-4526-be6c-8b1e3c6e8006	f09ee771-e634-4488-94af-61bd3da17bb9	17	2022-01-08 23:18:43.52649
3cbd175f-1829-4526-be6c-8b1e3c6e8006	52e75789-e64b-4db6-9973-1433c4f3d1cf	18	2022-01-08 23:18:43.52649
3cbd175f-1829-4526-be6c-8b1e3c6e8006	2d2b9392-dbea-46cc-b9f6-7c3fb3ff4d57	19	2022-01-08 23:18:43.52649
3cbd175f-1829-4526-be6c-8b1e3c6e8006	d429a3c4-2db0-4d25-b82c-d2140433ab59	20	2022-01-08 23:18:43.52649
967f3c58-ee74-4fbe-bab8-3e35fa43b179	82b0f06f-b196-48ac-a9fb-5c1ed7722205	0	2022-01-08 23:18:43.52649
967f3c58-ee74-4fbe-bab8-3e35fa43b179	e2fa88ee-64e8-458c-9105-e57261faf48b	1	2022-01-08 23:18:43.52649
967f3c58-ee74-4fbe-bab8-3e35fa43b179	e60ec3b5-4a33-4cb3-afc8-f2f715775aee	2	2022-01-08 23:18:43.52649
967f3c58-ee74-4fbe-bab8-3e35fa43b179	83611f6e-c64f-4101-9075-c826d6924b59	3	2022-01-08 23:18:43.52649
967f3c58-ee74-4fbe-bab8-3e35fa43b179	7d028fbf-5a62-4be9-9301-23922aa42ddb	4	2022-01-08 23:18:43.52649
967f3c58-ee74-4fbe-bab8-3e35fa43b179	72f582fe-702c-4da9-b5b7-85baa39f4d3e	5	2022-01-08 23:18:43.52649
967f3c58-ee74-4fbe-bab8-3e35fa43b179	3d1a6bea-8c06-4c4a-b6ec-456438d56b9b	6	2022-01-08 23:18:43.52649
967f3c58-ee74-4fbe-bab8-3e35fa43b179	f34c759c-739c-4e9f-829e-412418f2666b	7	2022-01-08 23:18:43.52649
967f3c58-ee74-4fbe-bab8-3e35fa43b179	50620722-96a5-457d-98a3-e7155b400974	8	2022-01-08 23:18:43.52649
967f3c58-ee74-4fbe-bab8-3e35fa43b179	57a46159-aa9e-4c6f-9a26-550fec7f77e2	9	2022-01-08 23:18:43.52649
967f3c58-ee74-4fbe-bab8-3e35fa43b179	b83095fe-5c5b-4f7e-b045-81bacf54f10c	10	2022-01-08 23:18:43.52649
967f3c58-ee74-4fbe-bab8-3e35fa43b179	eb7e94b0-9075-4e5a-b605-00c1e9c9fb55	11	2022-01-08 23:18:43.52649
967f3c58-ee74-4fbe-bab8-3e35fa43b179	21affe0a-03a1-4dc4-9e5a-23c6dd30d346	12	2022-01-08 23:18:43.52649
967f3c58-ee74-4fbe-bab8-3e35fa43b179	c1694389-bd5b-4a30-8ca7-16359a43f282	13	2022-01-08 23:18:43.52649
967f3c58-ee74-4fbe-bab8-3e35fa43b179	0a08df84-dd0a-481d-88c0-b32d1daf382f	14	2022-01-08 23:18:43.52649
967f3c58-ee74-4fbe-bab8-3e35fa43b179	85b74225-be8f-45b3-8c9c-e83e45ae4512	15	2022-01-08 23:18:43.52649
967f3c58-ee74-4fbe-bab8-3e35fa43b179	f09ee771-e634-4488-94af-61bd3da17bb9	16	2022-01-08 23:18:43.52649
967f3c58-ee74-4fbe-bab8-3e35fa43b179	52e75789-e64b-4db6-9973-1433c4f3d1cf	17	2022-01-08 23:18:43.52649
967f3c58-ee74-4fbe-bab8-3e35fa43b179	2d2b9392-dbea-46cc-b9f6-7c3fb3ff4d57	18	2022-01-08 23:18:43.52649
967f3c58-ee74-4fbe-bab8-3e35fa43b179	d429a3c4-2db0-4d25-b82c-d2140433ab59	19	2022-01-08 23:18:43.52649
d17a7b54-d74e-4d29-815c-8ccc5134bab6	e09452c5-433a-41e7-8a74-2ebd13fe6a3f	0	2022-01-08 23:18:43.52649
d17a7b54-d74e-4d29-815c-8ccc5134bab6	0f97573c-f316-4198-806a-3171240fa131	1	2022-01-08 23:18:43.52649
d17a7b54-d74e-4d29-815c-8ccc5134bab6	c6acde94-04a4-4dd5-8fa0-c36353b1cc5b	2	2022-01-08 23:18:43.52649
d17a7b54-d74e-4d29-815c-8ccc5134bab6	901ae351-a67d-48d0-98f1-f396f72ec861	3	2022-01-08 23:18:43.52649
d17a7b54-d74e-4d29-815c-8ccc5134bab6	fef2d68f-7372-4dbf-bd14-a3aaba795a0f	4	2022-01-08 23:18:43.52649
d17a7b54-d74e-4d29-815c-8ccc5134bab6	e42dfaf6-7c03-4afd-b4e6-409027ad149b	5	2022-01-08 23:18:43.52649
d17a7b54-d74e-4d29-815c-8ccc5134bab6	08364c83-4295-4638-bd05-732a6dd464dc	6	2022-01-08 23:18:43.52649
d17a7b54-d74e-4d29-815c-8ccc5134bab6	ef0877b1-c63a-4996-a758-fb315da5942e	7	2022-01-08 23:18:43.52649
d17a7b54-d74e-4d29-815c-8ccc5134bab6	32645233-9ece-4368-9492-99fc2cf18ccd	8	2022-01-08 23:18:43.52649
d17a7b54-d74e-4d29-815c-8ccc5134bab6	b3ccd249-1535-49f9-8192-fa4625a7f860	9	2022-01-08 23:18:43.52649
d17a7b54-d74e-4d29-815c-8ccc5134bab6	96d51be2-d91b-4cbf-b104-7183b03d7980	10	2022-01-08 23:18:43.52649
d17a7b54-d74e-4d29-815c-8ccc5134bab6	607a4037-e284-4d9b-8781-c6117dc5cd26	11	2022-01-08 23:18:43.52649
d17a7b54-d74e-4d29-815c-8ccc5134bab6	2be5c671-fe24-4345-877a-4cf8a1dd22fe	12	2022-01-08 23:18:43.52649
d17a7b54-d74e-4d29-815c-8ccc5134bab6	b22ccb15-cfbf-4dd6-81cd-11fe1744a6e0	13	2022-01-08 23:18:43.52649
d17a7b54-d74e-4d29-815c-8ccc5134bab6	3a214a1d-6c2f-4f34-992b-e2ff297fac17	14	2022-01-08 23:18:43.52649
d17a7b54-d74e-4d29-815c-8ccc5134bab6	b566f4aa-57ae-46ce-a85c-4e20513090cd	15	2022-01-08 23:18:43.52649
\.


--
-- Data for Name: portata; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.portata (id, nome, ordine) FROM stdin;
19cb3e0a-3abd-4465-8ff6-6dad85715ef4	Antipasti	0
f0d37588-804e-4cfd-b823-36cffbe6a02e	Antipasti di carne	1
138562c1-b56b-408d-a502-04e57b5142d0	Antipasti di pesce	2
541e5711-ba4b-4fb3-89ca-1351207f25c2	Primi	3
d105187c-af84-40de-9ee7-01e7a9a0f484	Primi di carne	4
6d167893-ade5-4f8c-b252-676f04ee08b7	Primi di pesce	5
3e81cf7a-4fa1-4e6d-96a8-1c471cc78f8d	Secondi	6
dcad11a7-9153-4209-a6f6-59f2c4fbfc0e	Secondi di carne	7
150fa2c6-7fa9-4308-b558-222af9b5f9c0	Secondi di pesce	8
aaae687e-ce71-443e-8f44-7216f174b625	Contorni	9
4492352b-0484-46e2-935c-471ae36f2100	Pizze	10
fb570e7b-c61b-430c-853c-a541ea8edf07	Hamburger	11
5411c029-867f-4cba-9ab3-57b8eba93370	Insalate	12
31bbd71e-bf1b-42a0-b726-445e83076671	Dolci	13
0250923c-420d-4810-9ff6-a9e62f6be3a9	Bevande	14
07914830-720c-4a87-8e76-93bedb843e55	Caffè e ammazzacaffè	15
\.


--
-- Data for Name: recensione; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.recensione (ristorante, utente, testo, valutazione, data) FROM stdin;
976a3f01-62a7-421d-88f6-ffd7cc79131f	304635e6-dee2-47f0-b41b-4b71ba3a0ec4	abbiamo mangiato molto bene	4.0	2022-01-08 23:18:43.52649
976a3f01-62a7-421d-88f6-ffd7cc79131f	7551e169-356d-4e62-a600-48b60861aa82	Locale molto accogliente, personale super gentile e disponibile, attento a tutte le esigenze soprattutto dei più piccoli. Ottimo cibo e prezzi adeguati. Lo consiglio vivamente!	4.0	2022-01-08 23:18:43.52649
976a3f01-62a7-421d-88f6-ffd7cc79131f	893401bb-a0bb-4296-aa39-6241b137af1b	Menu vario, tutto buono, servizio perfetto, coccolati e sfamati a prezzo giusto. Ci tornerò. Grazie	5.0	2022-01-08 23:18:43.52649
976a3f01-62a7-421d-88f6-ffd7cc79131f	e48f7ffe-cfd4-401d-bd95-825e8bd73437	Buon ristorante-pizzeria con un ottimo servizio al tavolo(complimenti ai ragazzi che se ne occupano), buone le pizze(con costo medio di 12€🤨) dove però sembra si siano dimenticati la "cara e semplice "Margherita"...non tutti amano le pizze farcite!	4.0	2022-01-08 23:18:43.52649
976a3f01-62a7-421d-88f6-ffd7cc79131f	b71e4baf-44f6-4cc7-b82d-ce7691856096	Buon servizio, pulizia, cucina alterna: la pizza mediocre, gli sfrizzoli molto buoni, le carni non eccezionali. Prezzi medio alti, per chi non è abituato a quelli di Trento significa alti.	4.0	2022-01-08 23:18:43.52649
976a3f01-62a7-421d-88f6-ffd7cc79131f	c45a85d6-47bc-480b-9861-4c42642e4c77	Pizza super ottimo servizio.	5.0	2022-01-08 23:18:43.52649
74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	5a2e0f66-f568-4b58-a596-9cc10dbfd51d	Qualità al primo posto. Cortesia e velocità del personale. Ottimo locale per assaggiare piatti tipici e sfiziosi. In continua evoluzione.	5.0	2022-01-08 23:18:43.52649
74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	30e3a798-d16f-4b5f-bb93-750fdcd652bb	Le proposte sono sempre varie e innovative, il personale è abbastanza gentile e il locale presenta un ambiente piacevole. A mio avviso si potrebbe lavorare un po’ sul rapporto qualità prezzo.	4.0	2022-01-08 23:18:43.52649
74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	893401bb-a0bb-4296-aa39-6241b137af1b	Mi è piaciuta la location, in stile americano. Buonissima la tartare di manzo e il dolce, il tris di semifreddi. Prezzo un po’ elevato	3.0	2022-01-08 23:18:43.52649
74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	02f53330-bca8-442a-8047-89636114cb14	L’accoglienza da parte di chi ci ha portato al tavolo è stata abbastanza fredda e un po’ arrogante, arrivati alle 19 e invece di dici guardate signori vi chiedo dato che siete senza prenotazione per le 21 ho bisogno del tavolo libero, invece ci è stato detto entro alle 21 mangiate perché ho bisogno del tavolo. Dove invece al Plan sono molto accoglienti a confortevoli. Preso sfrizzoli molto buoni mio marito la pizza dove lui l’ ha sempre mangiata bene ma questa volta la pizza era  una focaccia… alta senza pomodoro io credo che dovrebbero indicare perché sicuramente avrebbe preso altro. Il tavolo accanto a me di due ragazze quando è arrivata la piazza hanno fatto lo stesso commento di mio marito. Siamo eccellenti noi italiani nella pizza non roviniamola come fanno in America	2.0	2022-01-08 23:18:43.52649
74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	b71e4baf-44f6-4cc7-b82d-ce7691856096	Buon caffe e brioche. Personale gentile e cortese. Inoltre essendo anche ristorante c’è tanto spazio per sedersi. Consigliato	4.0	2022-01-08 23:18:43.52649
74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	921e903e-2930-445a-9490-319325b6619d	Costine superbe e tenerissime (specie quelle con la salsa bbq homemade) e birra non filtrata eccellente e soprattutto spinata come dio comanda. Consiglio vivamente se vi trovate a Trento!	5.0	2022-01-08 23:18:43.52649
b2ed7cf3-a59e-4e90-8572-3ef356bfb106	91c1e2cd-63da-4f8e-893b-c8bcb58a131b	L’esperienza sensoriale migliore della mia vita, servizio attento e discreto, spiegazioni esaurienti. Difficile definirla cucina, è veramente molto di più. L’abbinamento con i vini è irrinunciabile.	5.0	2022-01-08 23:18:43.52649
b2ed7cf3-a59e-4e90-8572-3ef356bfb106	b71e4baf-44f6-4cc7-b82d-ce7691856096	Ho comunicato al ristorante che la mia fidanzata non mangia la pancetta di maiale, ma le hanno dato dei piatti con la pancetta di maiale e mi hanno dato quello senza pancetta di maiale. Prima che me ne andassi, il cameriere alla porta ha aperto la porta e mi ha salutato, il che mi ha reso molto confuso. , sospettavo che stesse pagando online.  Questo mi fa sembrare che voglio sfuggire all’ordine, l’esperienza di servizio non è abbastanza buona.	3.0	2022-01-08 23:18:43.52649
b2ed7cf3-a59e-4e90-8572-3ef356bfb106	e48f7ffe-cfd4-401d-bd95-825e8bd73437	Un viaggio in giro per il mondo, nei piatti del menù degustazione si passa dai sapori tipici italiani sino a quelli tipicamente giapponesi. In ogni singolo piatto, sono raccolti in un mix magico retrogusti conosciuti al palato evocati tutti simultaneamente, ciò si traduce in un esplosione per le papille degustative. Il personale è impeccabile e perfetto in tutto e per tutto.	5.0	2022-01-08 23:18:43.52649
b2ed7cf3-a59e-4e90-8572-3ef356bfb106	921e903e-2930-445a-9490-319325b6619d	Decisamente le 3 stelle rispecchiano la classe del ristorante sia nel menù nella presentazione dei piatti che nel servizio. Location confortevole e ben organizzata nonostante l’aspetto un po’ eccentrico. Chef davvero di alto livello.	5.0	2022-01-08 23:18:43.52649
b2ed7cf3-a59e-4e90-8572-3ef356bfb106	30e3a798-d16f-4b5f-bb93-750fdcd652bb	Che dire? Dal primo passo che si compie all’interno dell’Osteria, fino all’ultimo saluto al personale di sala, si vive in una nuvola di costante attenzione e premura.	5.0	2022-01-08 23:18:43.52649
\.


--
-- Data for Name: ristorante; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ristorante (id, nome, cap, sito_web, telefono, cover, logo, accetta_prenotazioni, accetta_recensioni, citta, indirizzo, data_aggiunta) FROM stdin;
976a3f01-62a7-421d-88f6-ffd7cc79131f	Typical	38122	https://typical.it	04611975804			t	t	Trento	Via Calepina, 28	2022-01-08 23:18:43.52649
74158a2e-ee6c-4cb9-8ea8-d4a4a9bf24c6	Loto	38123	https://loto.it	04611975804			t	t	Trento	Via Bolghera, 23	2022-01-08 23:18:43.52649
3896862d-51b6-495e-8536-98310d93b39d	Auguri	38122	https://www.augurioristorante.it	0461193454			t	t	Trento	Via dietro le mura, B16	2022-01-08 23:18:43.52649
b2ed7cf3-a59e-4e90-8572-3ef356bfb106	Osteria Franzeschina	41121	https://osteriafranzeschina.it	0591975804			t	t	Modena	Via Alghero, 54/A	2022-01-08 23:18:43.52649
\.


--
-- Data for Name: ristoratore; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ristoratore (id, email, nome, password, data_iscrizione, immagine_profilo) FROM stdin;
1442d1e5-240f-4088-b744-bf28c1b0d8cf	ale@typical.it	Alessandro di Giovanni	5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8	2022-01-08 23:18:43.52649	\N
bc4be297-1235-42f5-a2ce-4983141bf853	rodolfo@loto.it	Rodolfo Andreini	a4958053d36c0f96daa380a48335c69751f652bf	2022-01-08 23:18:43.52649	\N
6ee16a66-8354-4cc9-9b09-9754c66de9b1	massimo@osteriafranzeschina.it	Massimo Bottara	f7aa433b92152760080e6bcf14eaf54a505f4b15	2022-01-08 23:18:43.52649	\N
\.


--
-- Data for Name: utente; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.utente (id, email, nome, password, data_iscrizione, immagine_profilo) FROM stdin;
304635e6-dee2-47f0-b41b-4b71ba3a0ec4	text@example.com	Giulio Arnoldi	5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8	2022-01-08 23:18:43.52649	\N
5a2e0f66-f568-4b58-a596-9cc10dbfd51d	alessio@capuzzisrl.it	Alessio Capuzzi	cde2e7655fd33b3ff5e34d351627c7f6143b6f73	2022-01-08 23:18:43.52649	\N
91c1e2cd-63da-4f8e-893b-c8bcb58a131b	gianni@gtrail.it	Gianni Alessandrini	836fa98d6ff36bc487d708a03f865a629053ec98	2022-01-08 23:18:43.52649	\N
80b36196-3292-495c-9f9e-0230f8e0c27c	troy@trin.com	Troy Bakari	02a7e819d96cbb5c43ecf976b573756ca2382f0e	2022-01-08 23:18:43.52649	\N
30e3a798-d16f-4b5f-bb93-750fdcd652bb	rebecca@gmeil.com	Rebecca Mazzi	a4244dfc49a0a4ea9602cfcc1201be91fe44b8a8	2022-01-08 23:18:43.52649	\N
c45a85d6-47bc-480b-9861-4c42642e4c77	gabriella@gmeil.com	Gabriella Fiorentino	7d26fd159a71c72852facac0ea994134650b9f1d	2022-01-08 23:18:43.52649	\N
7551e169-356d-4e62-a600-48b60861aa82	liber0@gmeil.com	Libero Moretti	78fdfe88a13b0249a30de57d1c34e42986c05e3b	2022-01-08 23:18:43.52649	\N
921e903e-2930-445a-9490-319325b6619d	fosca@gmeil.com	Fosca Siciliani	d757590b93d617e8ff6318897878cd90003f137f	2022-01-08 23:18:43.52649	\N
e7edf825-47c5-4bfa-909d-103d2bad33c7	augusta@gmeil.com	Augusta Capon	5f83437018cce9eb7a6b3ed1e9b1678f1e472e9c	2022-01-08 23:18:43.52649	\N
893401bb-a0bb-4296-aa39-6241b137af1b	erica@gmeil.com	Erica Lo Duca	5ac109e09f6cb3803bf189604b86ff0864887232	2022-01-08 23:18:43.52649	\N
b71e4baf-44f6-4cc7-b82d-ce7691856096	divo@gmeil.com	Divo Trentino	a0b4b67e5e7b4dc1cc134d45eff57d750f433bb9	2022-01-08 23:18:43.52649	\N
02f53330-bca8-442a-8047-89636114cb14	ermanno@gmeil.com	Ermanno Bellucci	42bb3112b3012440bdd01da30efab462961d73ac	2022-01-08 23:18:43.52649	\N
e48f7ffe-cfd4-401d-bd95-825e8bd73437	ciro@gmeil.com	Ciro Calabrese	b5b767e83bc7e5cee1d8da9c7175ce2078aaad4f	2022-01-08 23:18:43.52649	\N
4919f131-67e2-4d9a-bf9a-e5ea20e9123e	lionello@gmeil.com	Lionello De Luca	1ee68473c0efaaa65175dd06880e308caf6a707c	2022-01-08 23:18:43.52649	\N
\.


--
-- Name: allergene_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.allergene_id_seq', 1, false);


--
-- Name: allergene allergene_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.allergene
    ADD CONSTRAINT allergene_pkey PRIMARY KEY (id);


--
-- Name: allergia allergia_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.allergia
    ADD CONSTRAINT allergia_pkey PRIMARY KEY (utente, allergene);


--
-- Name: gestione gestione_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gestione
    ADD CONSTRAINT gestione_pkey PRIMARY KEY (ristorante);


--
-- Name: menu menu_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menu
    ADD CONSTRAINT menu_pkey PRIMARY KEY (id);


--
-- Name: menu menu_ristorante_nome; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menu
    ADD CONSTRAINT menu_ristorante_nome UNIQUE (ristorante, nome);


--
-- Name: piatto_allergene piatto_allergene_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.piatto_allergene
    ADD CONSTRAINT piatto_allergene_pkey PRIMARY KEY (piatto, allergene);


--
-- Name: piatto_menu piatto_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.piatto_menu
    ADD CONSTRAINT piatto_menu_pkey PRIMARY KEY (menu, piatto);


--
-- Name: piatto piatto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.piatto
    ADD CONSTRAINT piatto_pkey PRIMARY KEY (id);


--
-- Name: piatto piatto_ristorante_nome; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.piatto
    ADD CONSTRAINT piatto_ristorante_nome UNIQUE (ristorante, nome);


--
-- Name: portata portata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.portata
    ADD CONSTRAINT portata_pkey PRIMARY KEY (id);


--
-- Name: recensione recensione_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recensione
    ADD CONSTRAINT recensione_pkey PRIMARY KEY (ristorante, utente);


--
-- Name: ristorante ristorante_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ristorante
    ADD CONSTRAINT ristorante_pkey PRIMARY KEY (id);


--
-- Name: gestione ristoratore_con; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gestione
    ADD CONSTRAINT ristoratore_con UNIQUE (ristoratore);


--
-- Name: ristoratore ristoratore_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ristoratore
    ADD CONSTRAINT ristoratore_pkey PRIMARY KEY (id);


--
-- Name: ristorante unique_address; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ristorante
    ADD CONSTRAINT unique_address UNIQUE (cap, indirizzo, nome);


--
-- Name: utente utente_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.utente
    ADD CONSTRAINT utente_pkey PRIMARY KEY (id);


--
-- Name: ristoratore_unique_lower_email_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ristoratore_unique_lower_email_index ON public.ristoratore USING btree (lower(email));


--
-- Name: user_unique_lower_email_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX user_unique_lower_email_index ON public.utente USING btree (lower(email));


--
-- Name: menu menu_insert_activity; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER menu_insert_activity BEFORE INSERT ON public.menu FOR EACH ROW WHEN ((new.attivo IS TRUE)) EXECUTE FUNCTION public.create_trigger_for_menu_activity();


--
-- Name: menu menu_update_activity; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER menu_update_activity BEFORE UPDATE ON public.menu FOR EACH ROW EXECUTE FUNCTION public.create_trigger_for_menu_activity();


--
-- Name: piatto_menu plate_menu_insert_activity; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER plate_menu_insert_activity BEFORE INSERT ON public.piatto_menu FOR EACH ROW EXECUTE FUNCTION public.create_trigger_for_plate_menu_activity();


--
-- Name: piatto_menu plate_menu_update_activity; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER plate_menu_update_activity BEFORE UPDATE ON public.piatto_menu FOR EACH ROW WHEN (((old.menu IS DISTINCT FROM new.menu) OR (old.piatto IS DISTINCT FROM new.piatto))) EXECUTE FUNCTION public.create_trigger_for_plate_menu_activity();


--
-- Name: recensione recensione_insert_activity; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER recensione_insert_activity BEFORE INSERT ON public.recensione FOR EACH ROW EXECUTE FUNCTION public.create_trigger_for_review_activity();


--
-- Name: recensione recensione_update_activity; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER recensione_update_activity BEFORE UPDATE ON public.recensione FOR EACH ROW EXECUTE FUNCTION public.create_trigger_for_review_activity();


--
-- Name: allergia allergia_allergene_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.allergia
    ADD CONSTRAINT allergia_allergene_fkey FOREIGN KEY (allergene) REFERENCES public.allergene(id);


--
-- Name: allergia allergia_utente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.allergia
    ADD CONSTRAINT allergia_utente_fkey FOREIGN KEY (utente) REFERENCES public.utente(id) ON DELETE CASCADE;


--
-- Name: gestione gestione_ristorante_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gestione
    ADD CONSTRAINT gestione_ristorante_fkey FOREIGN KEY (ristorante) REFERENCES public.ristorante(id) ON DELETE CASCADE;


--
-- Name: gestione gestione_ristoratore_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gestione
    ADD CONSTRAINT gestione_ristoratore_fkey FOREIGN KEY (ristoratore) REFERENCES public.ristoratore(id) ON DELETE RESTRICT;


--
-- Name: menu menu_ristorante_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menu
    ADD CONSTRAINT menu_ristorante_fkey FOREIGN KEY (ristorante) REFERENCES public.ristorante(id) ON DELETE CASCADE;


--
-- Name: piatto_allergene piatto_allergene_allergene_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.piatto_allergene
    ADD CONSTRAINT piatto_allergene_allergene_fkey FOREIGN KEY (allergene) REFERENCES public.allergene(id);


--
-- Name: piatto_allergene piatto_allergene_piatto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.piatto_allergene
    ADD CONSTRAINT piatto_allergene_piatto_fkey FOREIGN KEY (piatto) REFERENCES public.piatto(id) ON DELETE CASCADE;


--
-- Name: piatto_menu piatto_menu_menu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.piatto_menu
    ADD CONSTRAINT piatto_menu_menu_fkey FOREIGN KEY (menu) REFERENCES public.menu(id) ON DELETE CASCADE;


--
-- Name: piatto_menu piatto_menu_piatto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.piatto_menu
    ADD CONSTRAINT piatto_menu_piatto_fkey FOREIGN KEY (piatto) REFERENCES public.piatto(id) ON DELETE CASCADE;


--
-- Name: piatto piatto_portata_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.piatto
    ADD CONSTRAINT piatto_portata_fkey FOREIGN KEY (portata) REFERENCES public.portata(id) ON DELETE RESTRICT;


--
-- Name: piatto piatto_ristorante_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.piatto
    ADD CONSTRAINT piatto_ristorante_fkey FOREIGN KEY (ristorante) REFERENCES public.ristorante(id) ON DELETE CASCADE;


--
-- Name: recensione recensione_ristorante_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recensione
    ADD CONSTRAINT recensione_ristorante_fkey FOREIGN KEY (ristorante) REFERENCES public.ristorante(id) ON DELETE CASCADE;


--
-- Name: recensione recensione_utente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recensione
    ADD CONSTRAINT recensione_utente_fkey FOREIGN KEY (utente) REFERENCES public.utente(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

