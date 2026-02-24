--
-- PostgreSQL database dump
--

\restrict MifR4AeNLOdmZxhb5CcEKQgit8KCKbZq2HQfZC885I5BJ6zMu0qMFQ5yE8kfXCj

-- Dumped from database version 18.2
-- Dumped by pg_dump version 18.2

-- Started on 2026-02-25 02:52:08

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS django_demo_3_meshkov;
--
-- TOC entry 5101 (class 1262 OID 25200)
-- Name: django_demo_3_meshkov; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE django_demo_3_meshkov WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';


ALTER DATABASE django_demo_3_meshkov OWNER TO postgres;

\unrestrict MifR4AeNLOdmZxhb5CcEKQgit8KCKbZq2HQfZC885I5BJ6zMu0qMFQ5yE8kfXCj
\connect django_demo_3_meshkov
\restrict MifR4AeNLOdmZxhb5CcEKQgit8KCKbZq2HQfZC885I5BJ6zMu0qMFQ5yE8kfXCj

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 240 (class 1259 OID 25997)
-- Name: order_statuses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_statuses (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.order_statuses OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 25996)
-- Name: order_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.order_statuses ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.order_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 236 (class 1259 OID 25974)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    date_creation date NOT NULL,
    date_delivery date NOT NULL,
    pick_up_point_id integer NOT NULL,
    user_id integer NOT NULL,
    receipt_code integer NOT NULL,
    status_id integer NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 25973)
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.orders ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 25878)
-- Name: pick_up_points; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pick_up_points (
    id integer NOT NULL,
    post_code integer NOT NULL,
    city character varying NOT NULL,
    street character varying NOT NULL,
    building integer
);


ALTER TABLE public.pick_up_points OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 25877)
-- Name: pick_up_points_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.pick_up_points ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.pick_up_points_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 232 (class 1259 OID 25945)
-- Name: product_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_categories (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.product_categories OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 25944)
-- Name: product_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.product_categories ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 238 (class 1259 OID 25987)
-- Name: product_in_order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_in_order (
    id integer NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    amount integer NOT NULL
);


ALTER TABLE public.product_in_order OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 25986)
-- Name: product_in_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.product_in_order ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_in_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 230 (class 1259 OID 25935)
-- Name: product_producers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_producers (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.product_producers OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 25934)
-- Name: product_producers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.product_producers ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_producers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 25925)
-- Name: product_providers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_providers (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.product_providers OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 25924)
-- Name: product_providers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.product_providers ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_providers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 226 (class 1259 OID 25915)
-- Name: product_units; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_units (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.product_units OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 25914)
-- Name: product_units_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.product_units ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_units_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 234 (class 1259 OID 25955)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    article character varying NOT NULL,
    name character varying NOT NULL,
    unit_id integer NOT NULL,
    price integer NOT NULL,
    provider_id integer NOT NULL,
    producer_id integer NOT NULL,
    category_id integer NOT NULL,
    discount integer NOT NULL,
    amount_in_stock integer NOT NULL,
    description character varying NOT NULL,
    photo character varying
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 25954)
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.products ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 25905)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 25904)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.roles ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 25890)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    surname character varying NOT NULL,
    name character varying NOT NULL,
    patronymic character varying NOT NULL,
    login character varying NOT NULL,
    password character varying NOT NULL,
    user_role integer NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 25889)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.users ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 5095 (class 0 OID 25997)
-- Dependencies: 240
-- Data for Name: order_statuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.order_statuses OVERRIDING SYSTEM VALUE VALUES (1, 'Завершен') ON CONFLICT DO NOTHING;
INSERT INTO public.order_statuses OVERRIDING SYSTEM VALUE VALUES (2, 'Новый') ON CONFLICT DO NOTHING;


--
-- TOC entry 5091 (class 0 OID 25974)
-- Dependencies: 236
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.orders OVERRIDING SYSTEM VALUE VALUES (1, '2025-04-10', '2025-04-15', 3, 6, 551, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.orders OVERRIDING SYSTEM VALUE VALUES (2, '2025-04-11', '2025-04-16', 7, 7, 552, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.orders OVERRIDING SYSTEM VALUE VALUES (3, '2025-04-12', '2025-04-17', 12, 8, 553, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.orders OVERRIDING SYSTEM VALUE VALUES (4, '2025-04-13', '2025-04-18', 5, 9, 554, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.orders OVERRIDING SYSTEM VALUE VALUES (5, '2025-04-14', '2025-04-19', 9, 10, 555, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.orders OVERRIDING SYSTEM VALUE VALUES (6, '2025-04-15', '2025-04-20', 15, 6, 556, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.orders OVERRIDING SYSTEM VALUE VALUES (7, '2025-04-16', '2025-04-21', 2, 7, 557, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.orders OVERRIDING SYSTEM VALUE VALUES (8, '2025-04-17', '2025-04-22', 18, 8, 558, 2) ON CONFLICT DO NOTHING;
INSERT INTO public.orders OVERRIDING SYSTEM VALUE VALUES (9, '2025-04-18', '2025-04-23', 4, 9, 559, 2) ON CONFLICT DO NOTHING;
INSERT INTO public.orders OVERRIDING SYSTEM VALUE VALUES (10, '2025-04-19', '2025-04-24', 11, 10, 560, 2) ON CONFLICT DO NOTHING;


--
-- TOC entry 5075 (class 0 OID 25878)
-- Dependencies: 220
-- Data for Name: pick_up_points; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pick_up_points OVERRIDING SYSTEM VALUE VALUES (1, 101000, 'Бумажск', 'Канцелярская', 12) ON CONFLICT DO NOTHING;
INSERT INTO public.pick_up_points OVERRIDING SYSTEM VALUE VALUES (2, 101001, 'Бумажск', 'Офисная', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.pick_up_points OVERRIDING SYSTEM VALUE VALUES (3, 101002, 'Бумажск', 'Бумажная', 34) ON CONFLICT DO NOTHING;
INSERT INTO public.pick_up_points OVERRIDING SYSTEM VALUE VALUES (4, 101003, 'Бумажск', 'Папковая', 17) ON CONFLICT DO NOTHING;
INSERT INTO public.pick_up_points OVERRIDING SYSTEM VALUE VALUES (5, 101004, 'Бумажск', 'Линейная', 9) ON CONFLICT DO NOTHING;
INSERT INTO public.pick_up_points OVERRIDING SYSTEM VALUE VALUES (6, 101005, 'Бумажск', 'Ручкина', 21) ON CONFLICT DO NOTHING;
INSERT INTO public.pick_up_points OVERRIDING SYSTEM VALUE VALUES (7, 101006, 'Бумажск', 'Тетрадная', 8) ON CONFLICT DO NOTHING;
INSERT INTO public.pick_up_points OVERRIDING SYSTEM VALUE VALUES (8, 101007, 'Бумажск', 'Скрепочная', 13) ON CONFLICT DO NOTHING;
INSERT INTO public.pick_up_points OVERRIDING SYSTEM VALUE VALUES (9, 101008, 'Бумажск', 'Клеевая', 3) ON CONFLICT DO NOTHING;
INSERT INTO public.pick_up_points OVERRIDING SYSTEM VALUE VALUES (10, 101009, 'Бумажск', 'Маркерная', 26) ON CONFLICT DO NOTHING;
INSERT INTO public.pick_up_points OVERRIDING SYSTEM VALUE VALUES (11, 101010, 'Бумажск', 'Степлерная', 7) ON CONFLICT DO NOTHING;
INSERT INTO public.pick_up_points OVERRIDING SYSTEM VALUE VALUES (12, 101011, 'Бумажск', 'Ластикова', 15) ON CONFLICT DO NOTHING;
INSERT INTO public.pick_up_points OVERRIDING SYSTEM VALUE VALUES (13, 101012, 'Бумажск', 'Конвертная', 11) ON CONFLICT DO NOTHING;
INSERT INTO public.pick_up_points OVERRIDING SYSTEM VALUE VALUES (14, 101013, 'Бумажск', 'Ножничная', 19) ON CONFLICT DO NOTHING;
INSERT INTO public.pick_up_points OVERRIDING SYSTEM VALUE VALUES (15, 101014, 'Бумажск', 'Блокнотная', 22) ON CONFLICT DO NOTHING;
INSERT INTO public.pick_up_points OVERRIDING SYSTEM VALUE VALUES (16, 101015, 'Бумажск', 'Карандашная', 6) ON CONFLICT DO NOTHING;
INSERT INTO public.pick_up_points OVERRIDING SYSTEM VALUE VALUES (17, 101016, 'Бумажск', 'Файловая', 30) ON CONFLICT DO NOTHING;
INSERT INTO public.pick_up_points OVERRIDING SYSTEM VALUE VALUES (18, 101017, 'Бумажск', 'Стикерная', 4) ON CONFLICT DO NOTHING;
INSERT INTO public.pick_up_points OVERRIDING SYSTEM VALUE VALUES (19, 101018, 'Бумажск', 'Точильная', 18) ON CONFLICT DO NOTHING;
INSERT INTO public.pick_up_points OVERRIDING SYSTEM VALUE VALUES (20, 101019, 'Бумажск', 'Корректорная', 1) ON CONFLICT DO NOTHING;


--
-- TOC entry 5087 (class 0 OID 25945)
-- Dependencies: 232
-- Data for Name: product_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.product_categories OVERRIDING SYSTEM VALUE VALUES (1, 'Письменные принадлежности') ON CONFLICT DO NOTHING;
INSERT INTO public.product_categories OVERRIDING SYSTEM VALUE VALUES (2, 'Бумажная продукция') ON CONFLICT DO NOTHING;
INSERT INTO public.product_categories OVERRIDING SYSTEM VALUE VALUES (3, 'Папки и архивация') ON CONFLICT DO NOTHING;
INSERT INTO public.product_categories OVERRIDING SYSTEM VALUE VALUES (4, 'Офисная техника') ON CONFLICT DO NOTHING;
INSERT INTO public.product_categories OVERRIDING SYSTEM VALUE VALUES (5, 'Канцелярские инструменты') ON CONFLICT DO NOTHING;
INSERT INTO public.product_categories OVERRIDING SYSTEM VALUE VALUES (6, 'Творчество') ON CONFLICT DO NOTHING;
INSERT INTO public.product_categories OVERRIDING SYSTEM VALUE VALUES (7, 'Крепеж') ON CONFLICT DO NOTHING;
INSERT INTO public.product_categories OVERRIDING SYSTEM VALUE VALUES (8, 'Клеящие материалы') ON CONFLICT DO NOTHING;


--
-- TOC entry 5093 (class 0 OID 25987)
-- Dependencies: 238
-- Data for Name: product_in_order; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.product_in_order OVERRIDING SYSTEM VALUE VALUES (1, 1, 1, 5) ON CONFLICT DO NOTHING;
INSERT INTO public.product_in_order OVERRIDING SYSTEM VALUE VALUES (2, 2, 2, 10) ON CONFLICT DO NOTHING;
INSERT INTO public.product_in_order OVERRIDING SYSTEM VALUE VALUES (3, 3, 3, 2) ON CONFLICT DO NOTHING;
INSERT INTO public.product_in_order OVERRIDING SYSTEM VALUE VALUES (4, 4, 4, 8) ON CONFLICT DO NOTHING;
INSERT INTO public.product_in_order OVERRIDING SYSTEM VALUE VALUES (5, 5, 5, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.product_in_order OVERRIDING SYSTEM VALUE VALUES (6, 6, 7, 2) ON CONFLICT DO NOTHING;
INSERT INTO public.product_in_order OVERRIDING SYSTEM VALUE VALUES (7, 7, 8, 6) ON CONFLICT DO NOTHING;
INSERT INTO public.product_in_order OVERRIDING SYSTEM VALUE VALUES (8, 8, 9, 4) ON CONFLICT DO NOTHING;
INSERT INTO public.product_in_order OVERRIDING SYSTEM VALUE VALUES (9, 9, 13, 5) ON CONFLICT DO NOTHING;
INSERT INTO public.product_in_order OVERRIDING SYSTEM VALUE VALUES (10, 10, 14, 25) ON CONFLICT DO NOTHING;
INSERT INTO public.product_in_order OVERRIDING SYSTEM VALUE VALUES (11, 1, 6, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.product_in_order OVERRIDING SYSTEM VALUE VALUES (12, 2, 10, 5) ON CONFLICT DO NOTHING;
INSERT INTO public.product_in_order OVERRIDING SYSTEM VALUE VALUES (13, 3, 11, 3) ON CONFLICT DO NOTHING;
INSERT INTO public.product_in_order OVERRIDING SYSTEM VALUE VALUES (14, 4, 18, 20) ON CONFLICT DO NOTHING;
INSERT INTO public.product_in_order OVERRIDING SYSTEM VALUE VALUES (15, 5, 12, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.product_in_order OVERRIDING SYSTEM VALUE VALUES (16, 6, 19, 3) ON CONFLICT DO NOTHING;
INSERT INTO public.product_in_order OVERRIDING SYSTEM VALUE VALUES (17, 7, 16, 2) ON CONFLICT DO NOTHING;
INSERT INTO public.product_in_order OVERRIDING SYSTEM VALUE VALUES (18, 8, 15, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.product_in_order OVERRIDING SYSTEM VALUE VALUES (19, 9, 17, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.product_in_order OVERRIDING SYSTEM VALUE VALUES (20, 10, 20, 2) ON CONFLICT DO NOTHING;


--
-- TOC entry 5085 (class 0 OID 25935)
-- Dependencies: 230
-- Data for Name: product_producers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.product_producers OVERRIDING SYSTEM VALUE VALUES (1, 'ErichKrause') ON CONFLICT DO NOTHING;
INSERT INTO public.product_producers OVERRIDING SYSTEM VALUE VALUES (2, 'Koh-i-Noor') ON CONFLICT DO NOTHING;
INSERT INTO public.product_producers OVERRIDING SYSTEM VALUE VALUES (3, 'Moleskine') ON CONFLICT DO NOTHING;
INSERT INTO public.product_producers OVERRIDING SYSTEM VALUE VALUES (4, 'Brauberg') ON CONFLICT DO NOTHING;
INSERT INTO public.product_producers OVERRIDING SYSTEM VALUE VALUES (5, 'Deli') ON CONFLICT DO NOTHING;
INSERT INTO public.product_producers OVERRIDING SYSTEM VALUE VALUES (6, 'Centrum') ON CONFLICT DO NOTHING;
INSERT INTO public.product_producers OVERRIDING SYSTEM VALUE VALUES (7, 'SvetoCopy') ON CONFLICT DO NOTHING;
INSERT INTO public.product_producers OVERRIDING SYSTEM VALUE VALUES (8, 'Edding') ON CONFLICT DO NOTHING;
INSERT INTO public.product_producers OVERRIDING SYSTEM VALUE VALUES (9, 'Attache') ON CONFLICT DO NOTHING;
INSERT INTO public.product_producers OVERRIDING SYSTEM VALUE VALUES (10, 'Гознак') ON CONFLICT DO NOTHING;
INSERT INTO public.product_producers OVERRIDING SYSTEM VALUE VALUES (11, 'Faber-Castell') ON CONFLICT DO NOTHING;
INSERT INTO public.product_producers OVERRIDING SYSTEM VALUE VALUES (12, 'GBC') ON CONFLICT DO NOTHING;
INSERT INTO public.product_producers OVERRIDING SYSTEM VALUE VALUES (13, 'Post-it') ON CONFLICT DO NOTHING;


--
-- TOC entry 5083 (class 0 OID 25925)
-- Dependencies: 228
-- Data for Name: product_providers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.product_providers OVERRIDING SYSTEM VALUE VALUES (1, 'ОфисМир') ON CONFLICT DO NOTHING;
INSERT INTO public.product_providers OVERRIDING SYSTEM VALUE VALUES (2, 'КанцТорг') ON CONFLICT DO NOTHING;
INSERT INTO public.product_providers OVERRIDING SYSTEM VALUE VALUES (3, 'БумагаPro') ON CONFLICT DO NOTHING;


--
-- TOC entry 5081 (class 0 OID 25915)
-- Dependencies: 226
-- Data for Name: product_units; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.product_units OVERRIDING SYSTEM VALUE VALUES (1, 'шт.') ON CONFLICT DO NOTHING;
INSERT INTO public.product_units OVERRIDING SYSTEM VALUE VALUES (2, 'пачка') ON CONFLICT DO NOTHING;
INSERT INTO public.product_units OVERRIDING SYSTEM VALUE VALUES (3, 'набор') ON CONFLICT DO NOTHING;
INSERT INTO public.product_units OVERRIDING SYSTEM VALUE VALUES (4, 'коробка') ON CONFLICT DO NOTHING;
INSERT INTO public.product_units OVERRIDING SYSTEM VALUE VALUES (5, 'блок') ON CONFLICT DO NOTHING;


--
-- TOC entry 5089 (class 0 OID 25955)
-- Dependencies: 234
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.products OVERRIDING SYSTEM VALUE VALUES (1, 'K1001', 'Ручка шариковая синяя', 1, 25, 1, 1, 1, 0, 150, 'Ручка шариковая, синие чернила, пластиковый корпус', 'images/pen1.jpg') ON CONFLICT DO NOTHING;
INSERT INTO public.products OVERRIDING SYSTEM VALUE VALUES (2, 'K1002', 'Карандаш чернографитный', 1, 15, 2, 2, 1, 5, 200, 'Карандаш HB, деревянный корпус, с ластиком', 'images/pencil1.jpg') ON CONFLICT DO NOTHING;
INSERT INTO public.products OVERRIDING SYSTEM VALUE VALUES (3, 'K1003', 'Блокнот А5, 80 листов', 1, 120, 3, 3, 2, 10, 80, 'Блокнот в твердой обложке, клетка, 80 листов', 'images/notebook1.jpg') ON CONFLICT DO NOTHING;
INSERT INTO public.products OVERRIDING SYSTEM VALUE VALUES (4, 'K1004', 'Папка-скоросшиватель А4', 1, 45, 1, 4, 3, 0, 120, 'Папка-скоросшиватель пластиковая, синяя', 'images/folder1.jpg') ON CONFLICT DO NOTHING;
INSERT INTO public.products OVERRIDING SYSTEM VALUE VALUES (5, 'K1005', 'Степлер мини', 1, 280, 2, 5, 4, 15, 40, 'Степлер компактный, вмещает до 20 листов', 'images/stapler1.jpg') ON CONFLICT DO NOTHING;
INSERT INTO public.products OVERRIDING SYSTEM VALUE VALUES (6, 'K1006', 'Ножницы канцелярские', 1, 180, 1, 6, 5, 0, 65, 'Ножницы с пластмассовыми ручками, длина лезвия 15 см', 'images/scissors1.jpg') ON CONFLICT DO NOTHING;
INSERT INTO public.products OVERRIDING SYSTEM VALUE VALUES (7, 'K1007', 'Бумага А4, 500 л.', 2, 350, 3, 7, 2, 8, 30, 'Бумага для офисной техники, плотность 80 г/м²', 'images/paper1.jpg') ON CONFLICT DO NOTHING;
INSERT INTO public.products OVERRIDING SYSTEM VALUE VALUES (8, 'K1008', 'Маркер перманентный', 1, 60, 2, 8, 1, 0, 90, 'Маркер перманентный, черный, тонкий наконечник', 'images/marker1.jpg') ON CONFLICT DO NOTHING;
INSERT INTO public.products OVERRIDING SYSTEM VALUE VALUES (9, 'K1009', 'Линейка пластиковая 30см', 1, 40, 1, 9, 5, 0, 110, 'Линейка гибкая, прозрачная, с метрической и дюймовой шкалой', 'images/ruler1.jpg') ON CONFLICT DO NOTHING;
INSERT INTO public.products OVERRIDING SYSTEM VALUE VALUES (10, 'K1010', 'Ластик белый', 1, 20, 2, 2, 1, 0, 200, 'Ластик мягкий, для карандаша и чернил', 'images/eraser1.jpg') ON CONFLICT DO NOTHING;
INSERT INTO public.products OVERRIDING SYSTEM VALUE VALUES (11, 'K1011', 'Тетрадь 48л., клетка', 1, 65, 3, 10, 2, 5, 180, 'Тетрадь в мягкой обложке, 48 листов, клетка', 'images/copybook1.jpg') ON CONFLICT DO NOTHING;
INSERT INTO public.products OVERRIDING SYSTEM VALUE VALUES (12, 'K1012', 'Дырокол на 2 отверстия', 1, 320, 1, 4, 4, 12, 25, 'Дырокол пластиковый, регулируемое расстояние между отверстиями', 'images/holepunch1.jpg') ON CONFLICT DO NOTHING;
INSERT INTO public.products OVERRIDING SYSTEM VALUE VALUES (13, 'K1013', 'Корректирующая лента', 1, 110, 2, 1, 1, 0, 70, 'Корректирующая лента, ширина 5 мм, длина 6 м', 'images/corrector1.jpg') ON CONFLICT DO NOTHING;
INSERT INTO public.products OVERRIDING SYSTEM VALUE VALUES (14, 'K1014', 'Конверт С5, без марки', 1, 8, 3, 10, 2, 0, 300, 'Конверт почтовый, формат С5, белый', 'images/envelope1.jpg') ON CONFLICT DO NOTHING;
INSERT INTO public.products OVERRIDING SYSTEM VALUE VALUES (15, 'K1015', 'Набор цветных карандашей', 3, 450, 1, 11, 6, 20, 35, 'Набор из 24 цветных карандашей, деревянный корпус', 'images/pencils_set1.jpg') ON CONFLICT DO NOTHING;
INSERT INTO public.products OVERRIDING SYSTEM VALUE VALUES (16, 'K1016', 'Точилка для карандашей', 1, 35, 2, 5, 1, 0, 85, 'Точилка пластиковая с контейнером для стружки', 'images/sharpener1.jpg') ON CONFLICT DO NOTHING;
INSERT INTO public.products OVERRIDING SYSTEM VALUE VALUES (17, 'K1017', 'Скрепки металлические', 4, 55, 1, 4, 7, 0, 60, 'Скрепки оцинкованные, размер 28 мм, 100 шт. в коробке', 'images/clips1.jpg') ON CONFLICT DO NOTHING;
INSERT INTO public.products OVERRIDING SYSTEM VALUE VALUES (18, 'K1018', 'Файл А4, прозрачный', 1, 5, 3, 12, 3, 0, 500, 'Файл для документов, полипропилен, матовая поверхность', 'images/file1.jpg') ON CONFLICT DO NOTHING;
INSERT INTO public.products OVERRIDING SYSTEM VALUE VALUES (19, 'K1019', 'Клей-карандаш', 1, 75, 2, 1, 8, 0, 120, 'Клей-карандаш, 21 г, нетоксичный, с колпачком', 'images/glue1.jpg') ON CONFLICT DO NOTHING;
INSERT INTO public.products OVERRIDING SYSTEM VALUE VALUES (20, 'K1020', 'Блок стикеров 76x76 мм', 5, 90, 1, 13, 2, 10, 45, 'Блок липких заметок, 100 листов, желтый', 'images/stickers1.jpg') ON CONFLICT DO NOTHING;


--
-- TOC entry 5079 (class 0 OID 25905)
-- Dependencies: 224
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.roles OVERRIDING SYSTEM VALUE VALUES (1, 'Администратор') ON CONFLICT DO NOTHING;
INSERT INTO public.roles OVERRIDING SYSTEM VALUE VALUES (2, 'Менеджер') ON CONFLICT DO NOTHING;
INSERT INTO public.roles OVERRIDING SYSTEM VALUE VALUES (3, 'Авторизированный клиент') ON CONFLICT DO NOTHING;


--
-- TOC entry 5077 (class 0 OID 25890)
-- Dependencies: 222
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users OVERRIDING SYSTEM VALUE VALUES (1, 'Волкова', 'Анна', 'Сергеевна', 'volkova@kancmail.com', 'aB3#9fG', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.users OVERRIDING SYSTEM VALUE VALUES (2, 'Котов', 'Илья', 'Дмитриевич', 'kotov@kancmail.com', 'xY7@2pL', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.users OVERRIDING SYSTEM VALUE VALUES (3, 'Смирнова', 'Ольга', 'Петровна', 'smirnova@kancmail.com', 'mN5!1qW', 2) ON CONFLICT DO NOTHING;
INSERT INTO public.users OVERRIDING SYSTEM VALUE VALUES (4, 'Новиков', 'Денис', 'Игоревич', 'novikov@kancmail.com', 'rT8*4zV', 2) ON CONFLICT DO NOTHING;
INSERT INTO public.users OVERRIDING SYSTEM VALUE VALUES (5, 'Захарова', 'Елена', 'Викторовна', 'zaharova@kancmail.com', 'kP2&6sD', 2) ON CONFLICT DO NOTHING;
INSERT INTO public.users OVERRIDING SYSTEM VALUE VALUES (6, 'Белов', 'Артем', 'Александрович', 'belov@clientmail.ru', 'hJ9@3gF', 3) ON CONFLICT DO NOTHING;
INSERT INTO public.users OVERRIDING SYSTEM VALUE VALUES (7, 'Григорьева', 'Мария', 'Павловна', 'grigorieva@clientmail.ru', 'cV4#7nK', 3) ON CONFLICT DO NOTHING;
INSERT INTO public.users OVERRIDING SYSTEM VALUE VALUES (8, 'Тимофеев', 'Сергей', 'Олегович', 'timofeev@clientmail.ru', 'fR1*8tM', 3) ON CONFLICT DO NOTHING;
INSERT INTO public.users OVERRIDING SYSTEM VALUE VALUES (9, 'Кузнецова', 'Анастасия', 'Ильинична', 'kuznetsova@clientmail.ru', 'qW5!2bX', 3) ON CONFLICT DO NOTHING;
INSERT INTO public.users OVERRIDING SYSTEM VALUE VALUES (10, 'Федоров', 'Павел', 'Максимович', 'fedorov@clientmail.ru', 'zL6@9yH', 3) ON CONFLICT DO NOTHING;


--
-- TOC entry 5102 (class 0 OID 0)
-- Dependencies: 239
-- Name: order_statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_statuses_id_seq', 1, false);


--
-- TOC entry 5103 (class 0 OID 0)
-- Dependencies: 235
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, false);


--
-- TOC entry 5104 (class 0 OID 0)
-- Dependencies: 219
-- Name: pick_up_points_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pick_up_points_id_seq', 1, false);


--
-- TOC entry 5105 (class 0 OID 0)
-- Dependencies: 231
-- Name: product_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_categories_id_seq', 1, false);


--
-- TOC entry 5106 (class 0 OID 0)
-- Dependencies: 237
-- Name: product_in_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_in_order_id_seq', 1, false);


--
-- TOC entry 5107 (class 0 OID 0)
-- Dependencies: 229
-- Name: product_producers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_producers_id_seq', 1, false);


--
-- TOC entry 5108 (class 0 OID 0)
-- Dependencies: 227
-- Name: product_providers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_providers_id_seq', 1, false);


--
-- TOC entry 5109 (class 0 OID 0)
-- Dependencies: 225
-- Name: product_units_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_units_id_seq', 1, false);


--
-- TOC entry 5110 (class 0 OID 0)
-- Dependencies: 233
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 1, false);


--
-- TOC entry 5111 (class 0 OID 0)
-- Dependencies: 223
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 1, false);


--
-- TOC entry 5112 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- TOC entry 4910 (class 2606 OID 25972)
-- Name: products id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT id_unique PRIMARY KEY (id);


--
-- TOC entry 4916 (class 2606 OID 26005)
-- Name: order_statuses order_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_statuses
    ADD CONSTRAINT order_statuses_pkey PRIMARY KEY (id);


--
-- TOC entry 4912 (class 2606 OID 25985)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- TOC entry 4896 (class 2606 OID 25888)
-- Name: pick_up_points pick_up_points_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pick_up_points
    ADD CONSTRAINT pick_up_points_pkey PRIMARY KEY (id);


--
-- TOC entry 4908 (class 2606 OID 25953)
-- Name: product_categories product_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT product_categories_pkey PRIMARY KEY (id);


--
-- TOC entry 4914 (class 2606 OID 25995)
-- Name: product_in_order product_in_order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_in_order
    ADD CONSTRAINT product_in_order_pkey PRIMARY KEY (id);


--
-- TOC entry 4906 (class 2606 OID 25943)
-- Name: product_producers product_producers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_producers
    ADD CONSTRAINT product_producers_pkey PRIMARY KEY (id);


--
-- TOC entry 4904 (class 2606 OID 25933)
-- Name: product_providers product_providers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_providers
    ADD CONSTRAINT product_providers_pkey PRIMARY KEY (id);


--
-- TOC entry 4902 (class 2606 OID 25923)
-- Name: product_units product_units_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_units
    ADD CONSTRAINT product_units_pkey PRIMARY KEY (id);


--
-- TOC entry 4900 (class 2606 OID 25913)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4898 (class 2606 OID 25903)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4922 (class 2606 OID 26036)
-- Name: orders orders_pick_up_point_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pick_up_point_id_fkey FOREIGN KEY (pick_up_point_id) REFERENCES public.pick_up_points(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 4923 (class 2606 OID 26041)
-- Name: orders orders_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.order_statuses(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 4924 (class 2606 OID 26031)
-- Name: orders orders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 4925 (class 2606 OID 26051)
-- Name: product_in_order product_in_order_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_in_order
    ADD CONSTRAINT product_in_order_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 4926 (class 2606 OID 26046)
-- Name: product_in_order product_in_order_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_in_order
    ADD CONSTRAINT product_in_order_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 4918 (class 2606 OID 26021)
-- Name: products products_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.product_categories(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 4919 (class 2606 OID 26016)
-- Name: products products_producer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_producer_id_fkey FOREIGN KEY (producer_id) REFERENCES public.product_producers(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 4920 (class 2606 OID 26011)
-- Name: products products_provider_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_provider_id_fkey FOREIGN KEY (provider_id) REFERENCES public.product_providers(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 4921 (class 2606 OID 26026)
-- Name: products products_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES public.product_units(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 4917 (class 2606 OID 26006)
-- Name: users users_user_role_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_user_role_fkey FOREIGN KEY (user_role) REFERENCES public.roles(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


-- Completed on 2026-02-25 02:52:08

--
-- PostgreSQL database dump complete
--

\unrestrict MifR4AeNLOdmZxhb5CcEKQgit8KCKbZq2HQfZC885I5BJ6zMu0qMFQ5yE8kfXCj

