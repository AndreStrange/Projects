toc.dat                                                                                             0000600 0004000 0002000 00000061443 14014122272 0014442 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP           9                 y            app_cine    13.1    13.1 M    4           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false         5           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false         6           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false         7           1262    49285    app_cine    DATABASE     g   CREATE DATABASE app_cine WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Spanish_Colombia.1252';
    DROP DATABASE app_cine;
                postgres    false         ?            1255    49444 $   funcionespelicula(character varying)    FUNCTION     D  CREATE FUNCTION public.funcionespelicula(titulo character varying) RETURNS integer
    LANGUAGE sql
    AS $$SELECT count(f.id_funcion) as Cantidad_Funciones FROM PELICULAS p, FUNCIONES f, SALAS s, CINES c WHERE p.id_pelicula=f.id_pelicula AND f.id_sala=s.id_sala AND s.nombre_cine=c.nombre AND p.titulo_original=titulo;$$;
 B   DROP FUNCTION public.funcionespelicula(titulo character varying);
       public          postgres    false         ?            1255    49443 %   funcionespeliculas(character varying)    FUNCTION     E  CREATE FUNCTION public.funcionespeliculas(titulo character varying) RETURNS integer
    LANGUAGE sql
    AS $$SELECT count(f.id_funcion) as Cantidad_Funciones FROM PELICULAS p, FUNCIONES f, SALAS s, CINES c WHERE p.id_pelicula=f.id_pelicula AND f.id_sala=s.id_sala AND s.nombre_cine=c.nombre AND p.titulo_original=titulo;$$;
 C   DROP FUNCTION public.funcionespeliculas(titulo character varying);
       public          postgres    false         ?            1255    49469    pelis_fuera_de_cartelera()    FUNCTION     ?  CREATE FUNCTION public.pelis_fuera_de_cartelera() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
insert into "peliculas_fuera_de_cartelera" values (old.id_pelicula, old.titulo_distribucion, old.titulo_original, old.genero, old.idioma_original, old.subtitulos, old.pais_origen, old.anio_produccion, old.url, old.duracion, old.clasificacion, old.fecha_estreno_santiago, old.resumen);
return old;
end
$$;
 1   DROP FUNCTION public.pelis_fuera_de_cartelera();
       public          postgres    false         ?            1259    49344    cines    TABLE     ?   CREATE TABLE public.cines (
    nombre character varying(50) NOT NULL,
    direccion character varying(50) NOT NULL,
    telefono bigint NOT NULL
);
    DROP TABLE public.cines;
       public         heap    postgres    false         ?            1259    49294 
   secuencia5    SEQUENCE     s   CREATE SEQUENCE public.secuencia5
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 !   DROP SEQUENCE public.secuencia5;
       public          postgres    false         ?            1259    49338    salas    TABLE     ?   CREATE TABLE public.salas (
    id_sala bigint DEFAULT nextval('public.secuencia5'::regclass) NOT NULL,
    nombre character varying(50),
    butacas bigint NOT NULL,
    numero_sala bigint NOT NULL,
    nombre_cine character varying(50)
);
    DROP TABLE public.salas;
       public         heap    postgres    false    204         ?            1259    49438    cineinfo    VIEW     ?   CREATE VIEW public.cineinfo AS
 SELECT c.nombre AS cine,
    c.direccion,
    s.numero_sala,
    s.butacas
   FROM public.cines c,
    public.salas s
  WHERE ((s.nombre_cine)::text = (c.nombre)::text);
    DROP VIEW public.cineinfo;
       public          postgres    false    214    214    214    215    215         ?            1259    49292 
   secuencia4    SEQUENCE     s   CREATE SEQUENCE public.secuencia4
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 !   DROP SEQUENCE public.secuencia4;
       public          postgres    false         ?            1259    49332 	   funciones    TABLE     /  CREATE TABLE public.funciones (
    id_funcion bigint DEFAULT nextval('public.secuencia4'::regclass) NOT NULL,
    duracion time without time zone NOT NULL,
    hora_inicio time without time zone NOT NULL,
    id_sala bigint NOT NULL,
    numero_sala bigint NOT NULL,
    id_pelicula bigint NOT NULL
);
    DROP TABLE public.funciones;
       public         heap    postgres    false    203         ?            1259    49286 
   secuencia1    SEQUENCE     s   CREATE SEQUENCE public.secuencia1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 !   DROP SEQUENCE public.secuencia1;
       public          postgres    false         ?            1259    49304 	   peliculas    TABLE     }  CREATE TABLE public.peliculas (
    id_pelicula bigint DEFAULT nextval('public.secuencia1'::regclass) NOT NULL,
    titulo_distribucion character varying(50),
    titulo_original character varying(50) NOT NULL,
    genero character varying(250) NOT NULL,
    idioma_original character varying(20) NOT NULL,
    subtitulos character varying(10) NOT NULL,
    pais_origen character varying(50),
    anio_produccion bigint,
    url character varying(50),
    duracion time without time zone NOT NULL,
    clasificacion character varying(15) NOT NULL,
    fecha_estreno_santiago date NOT NULL,
    resumen character varying(250) NOT NULL
);
    DROP TABLE public.peliculas;
       public         heap    postgres    false    200         ?            1259    49434    masfunciones    VIEW     5  CREATE VIEW public.masfunciones AS
 SELECT p.titulo_distribucion,
    p.titulo_original,
    count(f.id_pelicula) AS cantidad
   FROM public.peliculas p,
    public.funciones f
  WHERE (p.id_pelicula = f.id_pelicula)
  GROUP BY p.titulo_distribucion, p.titulo_original
  ORDER BY (count(f.id_pelicula)) DESC;
    DROP VIEW public.masfunciones;
       public          postgres    false    209    213    209    209         ?            1259    49290 
   secuencia3    SEQUENCE     s   CREATE SEQUENCE public.secuencia3
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 !   DROP SEQUENCE public.secuencia3;
       public          postgres    false         ?            1259    49326 	   opiniones    TABLE     Z  CREATE TABLE public.opiniones (
    id_opinion bigint DEFAULT nextval('public.secuencia3'::regclass) NOT NULL,
    nombre_persona character varying(50) NOT NULL,
    edad integer,
    fecha_registro date NOT NULL,
    calificacion character varying(20) NOT NULL,
    comentario character varying(250) NOT NULL,
    id_pelicula bigint NOT NULL
);
    DROP TABLE public.opiniones;
       public         heap    postgres    false    202         ?            1259    49448    peliculas_fuera_de_cartelera    TABLE     a  CREATE TABLE public.peliculas_fuera_de_cartelera (
    id_pelicula bigint NOT NULL,
    titulo_distribucion character varying(50),
    titulo_original character varying(50) NOT NULL,
    genero character varying(250) NOT NULL,
    idioma_original character varying(20) NOT NULL,
    subtitulos character varying(10) NOT NULL,
    pais_origen character varying(50),
    anio_produccion bigint,
    url character varying(50),
    duracion time without time zone NOT NULL,
    clasificacion character varying(15) NOT NULL,
    fecha_estreno_santiago date NOT NULL,
    resumen character varying(250) NOT NULL
);
 0   DROP TABLE public.peliculas_fuera_de_cartelera;
       public         heap    postgres    false         ?            1259    49288 
   secuencia2    SEQUENCE     s   CREATE SEQUENCE public.secuencia2
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 !   DROP SEQUENCE public.secuencia2;
       public          postgres    false         ?            1259    49320    peliculas_personas    TABLE     ?   CREATE TABLE public.peliculas_personas (
    pk_peliculas_personas bigint DEFAULT nextval('public.secuencia2'::regclass) NOT NULL,
    id_pelicula bigint NOT NULL,
    nombre_persona character varying(50) NOT NULL
);
 &   DROP TABLE public.peliculas_personas;
       public         heap    postgres    false    201         ?            1259    49315    personas    TABLE     ?   CREATE TABLE public.personas (
    nombre character varying(50) NOT NULL,
    nacionalidad character varying(20) NOT NULL,
    cantidad_de_peliculas bigint
);
    DROP TABLE public.personas;
       public         heap    postgres    false         ?            1259    49296 
   secuencia6    SEQUENCE     s   CREATE SEQUENCE public.secuencia6
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 !   DROP SEQUENCE public.secuencia6;
       public          postgres    false         ?            1259    49353    promociones    TABLE     ?   CREATE TABLE public.promociones (
    id_promocion bigint DEFAULT nextval('public.secuencia6'::regclass) NOT NULL,
    descripcion character varying(250) NOT NULL,
    descuento numeric NOT NULL,
    id_funcion bigint NOT NULL
);
    DROP TABLE public.promociones;
       public         heap    postgres    false    205         ?            1259    49298 
   secuencia7    SEQUENCE     s   CREATE SEQUENCE public.secuencia7
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 !   DROP SEQUENCE public.secuencia7;
       public          postgres    false         ?            1259    49362    roles    TABLE     ?   CREATE TABLE public.roles (
    id_rol bigint DEFAULT nextval('public.secuencia7'::regclass) NOT NULL,
    nombre_rol character varying(25) NOT NULL
);
    DROP TABLE public.roles;
       public         heap    postgres    false    206         ?            1259    49300 
   secuencia8    SEQUENCE     s   CREATE SEQUENCE public.secuencia8
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 !   DROP SEQUENCE public.secuencia8;
       public          postgres    false         ?            1259    49368    roles_personas    TABLE     ?   CREATE TABLE public.roles_personas (
    pk_roles_personas bigint DEFAULT nextval('public.secuencia8'::regclass) NOT NULL,
    id_rol bigint NOT NULL,
    nombre_persona character varying(50) NOT NULL
);
 "   DROP TABLE public.roles_personas;
       public         heap    postgres    false    207         ?            1259    49302 
   secuencia9    SEQUENCE     s   CREATE SEQUENCE public.secuencia9
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 !   DROP SEQUENCE public.secuencia9;
       public          postgres    false         -          0    49344    cines 
   TABLE DATA           <   COPY public.cines (nombre, direccion, telefono) FROM stdin;
    public          postgres    false    215       3117.dat +          0    49332 	   funciones 
   TABLE DATA           i   COPY public.funciones (id_funcion, duracion, hora_inicio, id_sala, numero_sala, id_pelicula) FROM stdin;
    public          postgres    false    213       3115.dat *          0    49326 	   opiniones 
   TABLE DATA           |   COPY public.opiniones (id_opinion, nombre_persona, edad, fecha_registro, calificacion, comentario, id_pelicula) FROM stdin;
    public          postgres    false    212       3114.dat '          0    49304 	   peliculas 
   TABLE DATA           ?   COPY public.peliculas (id_pelicula, titulo_distribucion, titulo_original, genero, idioma_original, subtitulos, pais_origen, anio_produccion, url, duracion, clasificacion, fecha_estreno_santiago, resumen) FROM stdin;
    public          postgres    false    209       3111.dat 1          0    49448    peliculas_fuera_de_cartelera 
   TABLE DATA           ?   COPY public.peliculas_fuera_de_cartelera (id_pelicula, titulo_distribucion, titulo_original, genero, idioma_original, subtitulos, pais_origen, anio_produccion, url, duracion, clasificacion, fecha_estreno_santiago, resumen) FROM stdin;
    public          postgres    false    221       3121.dat )          0    49320    peliculas_personas 
   TABLE DATA           `   COPY public.peliculas_personas (pk_peliculas_personas, id_pelicula, nombre_persona) FROM stdin;
    public          postgres    false    211       3113.dat (          0    49315    personas 
   TABLE DATA           O   COPY public.personas (nombre, nacionalidad, cantidad_de_peliculas) FROM stdin;
    public          postgres    false    210       3112.dat .          0    49353    promociones 
   TABLE DATA           W   COPY public.promociones (id_promocion, descripcion, descuento, id_funcion) FROM stdin;
    public          postgres    false    216       3118.dat /          0    49362    roles 
   TABLE DATA           3   COPY public.roles (id_rol, nombre_rol) FROM stdin;
    public          postgres    false    217       3119.dat 0          0    49368    roles_personas 
   TABLE DATA           S   COPY public.roles_personas (pk_roles_personas, id_rol, nombre_persona) FROM stdin;
    public          postgres    false    218       3120.dat ,          0    49338    salas 
   TABLE DATA           S   COPY public.salas (id_sala, nombre, butacas, numero_sala, nombre_cine) FROM stdin;
    public          postgres    false    214       3116.dat 8           0    0 
   secuencia1    SEQUENCE SET     8   SELECT pg_catalog.setval('public.secuencia1', 6, true);
          public          postgres    false    200         9           0    0 
   secuencia2    SEQUENCE SET     9   SELECT pg_catalog.setval('public.secuencia2', 25, true);
          public          postgres    false    201         :           0    0 
   secuencia3    SEQUENCE SET     9   SELECT pg_catalog.setval('public.secuencia3', 20, true);
          public          postgres    false    202         ;           0    0 
   secuencia4    SEQUENCE SET     9   SELECT pg_catalog.setval('public.secuencia4', 50, true);
          public          postgres    false    203         <           0    0 
   secuencia5    SEQUENCE SET     9   SELECT pg_catalog.setval('public.secuencia5', 25, true);
          public          postgres    false    204         =           0    0 
   secuencia6    SEQUENCE SET     9   SELECT pg_catalog.setval('public.secuencia6', 50, true);
          public          postgres    false    205         >           0    0 
   secuencia7    SEQUENCE SET     8   SELECT pg_catalog.setval('public.secuencia7', 2, true);
          public          postgres    false    206         ?           0    0 
   secuencia8    SEQUENCE SET     9   SELECT pg_catalog.setval('public.secuencia8', 56, true);
          public          postgres    false    207         @           0    0 
   secuencia9    SEQUENCE SET     9   SELECT pg_catalog.setval('public.secuencia9', 1, false);
          public          postgres    false    208         ?           2606    49350    cines cines_direccion_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.cines
    ADD CONSTRAINT cines_direccion_key UNIQUE (direccion);
 C   ALTER TABLE ONLY public.cines DROP CONSTRAINT cines_direccion_key;
       public            postgres    false    215         ?           2606    49348    cines cines_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.cines
    ADD CONSTRAINT cines_pkey PRIMARY KEY (nombre);
 :   ALTER TABLE ONLY public.cines DROP CONSTRAINT cines_pkey;
       public            postgres    false    215         ?           2606    49352    cines cines_telefono_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.cines
    ADD CONSTRAINT cines_telefono_key UNIQUE (telefono);
 B   ALTER TABLE ONLY public.cines DROP CONSTRAINT cines_telefono_key;
       public            postgres    false    215                    2606    49337    funciones funciones_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.funciones
    ADD CONSTRAINT funciones_pkey PRIMARY KEY (id_funcion);
 B   ALTER TABLE ONLY public.funciones DROP CONSTRAINT funciones_pkey;
       public            postgres    false    213         |           2606    49331    opiniones opiniones_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.opiniones
    ADD CONSTRAINT opiniones_pkey PRIMARY KEY (id_opinion);
 B   ALTER TABLE ONLY public.opiniones DROP CONSTRAINT opiniones_pkey;
       public            postgres    false    212         ?           2606    49455 M   peliculas_fuera_de_cartelera peliculas_fuera_de_cartelera_titulo_original_key 
   CONSTRAINT     ?   ALTER TABLE ONLY public.peliculas_fuera_de_cartelera
    ADD CONSTRAINT peliculas_fuera_de_cartelera_titulo_original_key UNIQUE (titulo_original);
 w   ALTER TABLE ONLY public.peliculas_fuera_de_cartelera DROP CONSTRAINT peliculas_fuera_de_cartelera_titulo_original_key;
       public            postgres    false    221         y           2606    49325 *   peliculas_personas peliculas_personas_pkey 
   CONSTRAINT     {   ALTER TABLE ONLY public.peliculas_personas
    ADD CONSTRAINT peliculas_personas_pkey PRIMARY KEY (pk_peliculas_personas);
 T   ALTER TABLE ONLY public.peliculas_personas DROP CONSTRAINT peliculas_personas_pkey;
       public            postgres    false    211         q           2606    49312    peliculas peliculas_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.peliculas
    ADD CONSTRAINT peliculas_pkey PRIMARY KEY (id_pelicula);
 B   ALTER TABLE ONLY public.peliculas DROP CONSTRAINT peliculas_pkey;
       public            postgres    false    209         s           2606    49314 '   peliculas peliculas_titulo_original_key 
   CONSTRAINT     m   ALTER TABLE ONLY public.peliculas
    ADD CONSTRAINT peliculas_titulo_original_key UNIQUE (titulo_original);
 Q   ALTER TABLE ONLY public.peliculas DROP CONSTRAINT peliculas_titulo_original_key;
       public            postgres    false    209         w           2606    49319    personas personas_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.personas
    ADD CONSTRAINT personas_pkey PRIMARY KEY (nombre);
 @   ALTER TABLE ONLY public.personas DROP CONSTRAINT personas_pkey;
       public            postgres    false    210         ?           2606    49361    promociones promociones_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.promociones
    ADD CONSTRAINT promociones_pkey PRIMARY KEY (id_promocion);
 F   ALTER TABLE ONLY public.promociones DROP CONSTRAINT promociones_pkey;
       public            postgres    false    216         ?           2606    49373 "   roles_personas roles_personas_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.roles_personas
    ADD CONSTRAINT roles_personas_pkey PRIMARY KEY (pk_roles_personas);
 L   ALTER TABLE ONLY public.roles_personas DROP CONSTRAINT roles_personas_pkey;
       public            postgres    false    218         ?           2606    49367    roles roles_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id_rol);
 :   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_pkey;
       public            postgres    false    217         ?           2606    49343    salas salas_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.salas
    ADD CONSTRAINT salas_pkey PRIMARY KEY (id_sala);
 :   ALTER TABLE ONLY public.salas DROP CONSTRAINT salas_pkey;
       public            postgres    false    214         }           1259    49388    duracion_idx    INDEX     F   CREATE INDEX duracion_idx ON public.funciones USING btree (duracion);
     DROP INDEX public.duracion_idx;
       public            postgres    false    213         u           1259    49386 
   nombre_idx    INDEX     A   CREATE INDEX nombre_idx ON public.personas USING btree (nombre);
    DROP INDEX public.nombre_idx;
       public            postgres    false    210         z           1259    49387    opinion_idx    INDEX     I   CREATE INDEX opinion_idx ON public.opiniones USING btree (calificacion);
    DROP INDEX public.opinion_idx;
       public            postgres    false    212         t           1259    49385 
   titulo_idx    INDEX     K   CREATE INDEX titulo_idx ON public.peliculas USING btree (titulo_original);
    DROP INDEX public.titulo_idx;
       public            postgres    false    209         ?           2620    49470    peliculas peliculas_fuera    TRIGGER     ?   CREATE TRIGGER peliculas_fuera BEFORE DELETE ON public.peliculas FOR EACH ROW EXECUTE FUNCTION public.pelis_fuera_de_cartelera();
 2   DROP TRIGGER peliculas_fuera ON public.peliculas;
       public          postgres    false    209    224         ?           2606    49409     funciones fk_funciones_peliculas    FK CONSTRAINT     ?   ALTER TABLE ONLY public.funciones
    ADD CONSTRAINT fk_funciones_peliculas FOREIGN KEY (id_pelicula) REFERENCES public.peliculas(id_pelicula) ON UPDATE CASCADE ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.funciones DROP CONSTRAINT fk_funciones_peliculas;
       public          postgres    false    213    209    2929         ?           2606    49404    funciones fk_funciones_salas    FK CONSTRAINT     ?   ALTER TABLE ONLY public.funciones
    ADD CONSTRAINT fk_funciones_salas FOREIGN KEY (id_sala) REFERENCES public.salas(id_sala) ON UPDATE CASCADE ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.funciones DROP CONSTRAINT fk_funciones_salas;
       public          postgres    false    2945    214    213         ?           2606    49389     opiniones fk_opiniones_peliculas    FK CONSTRAINT     ?   ALTER TABLE ONLY public.opiniones
    ADD CONSTRAINT fk_opiniones_peliculas FOREIGN KEY (id_pelicula) REFERENCES public.peliculas(id_pelicula) ON UPDATE CASCADE ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.opiniones DROP CONSTRAINT fk_opiniones_peliculas;
       public          postgres    false    2929    209    212         ?           2606    49394 (   peliculas_personas fk_peliculas_personas    FK CONSTRAINT     ?   ALTER TABLE ONLY public.peliculas_personas
    ADD CONSTRAINT fk_peliculas_personas FOREIGN KEY (id_pelicula) REFERENCES public.peliculas(id_pelicula) ON UPDATE CASCADE ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.peliculas_personas DROP CONSTRAINT fk_peliculas_personas;
       public          postgres    false    209    2929    211         ?           2606    49399 (   peliculas_personas fk_personas_peliculas    FK CONSTRAINT     ?   ALTER TABLE ONLY public.peliculas_personas
    ADD CONSTRAINT fk_personas_peliculas FOREIGN KEY (nombre_persona) REFERENCES public.personas(nombre) ON UPDATE CASCADE ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.peliculas_personas DROP CONSTRAINT fk_personas_peliculas;
       public          postgres    false    2935    211    210         ?           2606    49419 $   promociones fk_promociones_funciones    FK CONSTRAINT     ?   ALTER TABLE ONLY public.promociones
    ADD CONSTRAINT fk_promociones_funciones FOREIGN KEY (id_funcion) REFERENCES public.funciones(id_funcion) ON UPDATE CASCADE ON DELETE CASCADE;
 N   ALTER TABLE ONLY public.promociones DROP CONSTRAINT fk_promociones_funciones;
       public          postgres    false    2943    216    213         ?           2606    49424     roles_personas fk_roles_personas    FK CONSTRAINT     ?   ALTER TABLE ONLY public.roles_personas
    ADD CONSTRAINT fk_roles_personas FOREIGN KEY (id_rol) REFERENCES public.roles(id_rol) ON UPDATE CASCADE ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.roles_personas DROP CONSTRAINT fk_roles_personas;
       public          postgres    false    217    2955    218         ?           2606    49429 !   roles_personas fk_roles_personass    FK CONSTRAINT     ?   ALTER TABLE ONLY public.roles_personas
    ADD CONSTRAINT fk_roles_personass FOREIGN KEY (nombre_persona) REFERENCES public.personas(nombre);
 K   ALTER TABLE ONLY public.roles_personas DROP CONSTRAINT fk_roles_personass;
       public          postgres    false    2935    218    210         ?           2606    49414    salas fk_salas_cines    FK CONSTRAINT     ?   ALTER TABLE ONLY public.salas
    ADD CONSTRAINT fk_salas_cines FOREIGN KEY (nombre_cine) REFERENCES public.cines(nombre) ON UPDATE CASCADE ON DELETE CASCADE;
 >   ALTER TABLE ONLY public.salas DROP CONSTRAINT fk_salas_cines;
       public          postgres    false    214    2949    215                                                                                                                                                                                                                                     3117.dat                                                                                            0000600 0004000 0002000 00000000320 14014122272 0014233 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        dworcester0	25 Onsgard Parkway	1695730379
mwestwater1	305 Golf View Road	5736924495
oduggon2	663 Clarendon Hill	9452438877
iwaything3	7 Susan Center	2312902253
mmacterlagh4	75046 7th Crossing	8244609364
\.


                                                                                                                                                                                                                                                                                                                3115.dat                                                                                            0000600 0004000 0002000 00000002544 14014122272 0014243 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	03:10:25	10:06:00	21	2	5
2	02:35:13	18:42:00	15	2	3
3	03:12:34	17:03:00	24	2	2
4	02:35:13	23:04:00	18	2	3
5	02:35:13	16:01:00	6	2	3
6	02:52:02	23:01:00	5	2	4
7	03:01:19	16:13:00	17	2	1
8	02:52:02	20:48:00	2	2	4
9	02:52:02	17:10:00	13	2	4
10	03:01:19	19:05:00	15	2	1
11	03:10:25	10:25:00	22	2	5
12	03:12:34	16:20:00	16	2	2
13	03:01:19	23:10:00	1	2	1
14	03:12:34	14:45:00	3	2	2
15	03:01:19	17:15:00	21	2	1
16	02:35:13	13:01:00	3	2	3
17	02:35:13	19:56:00	6	2	3
18	03:01:19	20:28:00	12	2	1
19	03:10:25	18:45:00	11	2	5
20	02:35:13	21:30:00	16	2	3
21	03:10:25	11:28:00	15	2	5
22	03:10:25	11:03:00	18	2	5
23	03:12:34	13:13:00	4	2	2
24	03:01:19	12:18:00	20	2	1
25	03:10:25	23:40:00	20	2	5
26	02:52:02	13:59:00	4	2	4
27	02:35:13	13:36:00	18	2	3
28	03:12:34	22:57:00	7	2	2
29	03:12:34	15:19:00	12	2	2
30	02:35:13	11:28:00	22	2	3
31	03:10:25	11:45:00	10	2	5
32	02:52:02	10:43:00	7	2	4
33	03:12:34	15:11:00	14	2	2
34	03:10:25	22:29:00	18	2	5
35	02:35:13	11:15:00	16	2	3
36	03:10:25	19:38:00	17	2	5
37	03:01:19	22:19:00	21	2	1
38	03:10:25	17:26:00	18	2	5
39	02:52:02	22:05:00	5	2	4
40	02:52:02	17:45:00	9	2	4
41	03:01:19	19:37:00	16	2	1
42	03:12:34	10:25:00	24	2	2
43	03:12:34	11:23:00	7	2	2
44	03:01:19	20:34:00	25	2	1
45	03:10:25	14:00:00	10	2	5
46	02:35:13	23:36:00	5	2	3
47	03:10:25	23:39:00	22	2	5
48	03:10:25	16:39:00	25	2	5
49	03:12:34	20:22:00	11	2	2
50	03:10:25	20:32:00	5	2	5
\.


                                                                                                                                                            3114.dat                                                                                            0000600 0004000 0002000 00000005120 14014122272 0014233 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Elvira O'Hannigan	20	2021-01-21	2.6	ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris	4
2	Aleece Rooper	34	2021-02-13	3.4	nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id	4
3	Candie Withinshaw	59	2020-05-11	1.2	sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus	5
4	Moore Swanborrow	52	2020-07-05	3.4	suscipit a feugiat et eros vestibulum ac est lacinia nisi	5
5	Sibylle Axon	49	2020-12-22	3.6	curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero	2
6	Matthieu Pulhoster	31	2020-08-23	3.4	tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis	1
7	Patten Dutch	23	2021-01-04	2.8	ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam	4
8	Orelle Gosford	43	2020-10-10	3.4	mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris	3
9	Moises Josefsohn	28	2020-11-21	2.8	nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit	3
10	Briant Petch	30	2020-07-05	4.7	dolor vel est donec odio justo sollicitudin ut suscipit a	5
11	Kathlin Elverstone	54	2020-10-06	4.7	nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat	5
12	Alethea Tuffey	24	2020-04-06	4.9	in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet	3
13	Uta Hammerton	49	2020-03-07	4.5	quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus	4
14	Katrinka Wye	32	2020-06-05	2.5	porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non	3
15	Nari De Ruggero	55	2020-10-05	4.2	libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla	4
16	Glen Pirnie	21	2020-10-26	1.5	nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra	3
17	Melli Gergher	32	2020-06-19	3.0	augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in hac	1
18	Maximilien Geerdts	57	2020-07-24	2.5	sed justo pellentesque viverra pede ac diam cras pellentesque volutpat	2
19	Lottie Tatem	33	2021-02-01	3.7	venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien	1
20	Towney Gawthrop	28	2020-08-15	2.5	vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget	4
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                3111.dat                                                                                            0000600 0004000 0002000 00000002027 14014122272 0014233 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Everything Must Go	Camila	Comedy|Drama	Oriya	YES	Indonesia	2002	https://intel.com	03:01:19	16	2010-09-19	arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula
2	Sharkwater	Sully	Documentary	Azeri	YES	Poland	2006	https://cdbaby.com	03:12:34	1	2009-12-03	nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula
3	Invictus	Aurlie	Drama	Tsonga	YES	Kyrgyzstan	1995	https://tinyurl.com	02:35:13	10	2014-01-22	quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit
4	World, the Flesh and the Devil, The	Avivah	Drama|Romance|Sci-Fi	Swahili	YES	Indonesia	2008	http://google.com.hk	02:52:02	7	2012-10-26	velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel
5	Big Man Japan (Dai-Nihonjin)	Shadow	Comedy|Sci-Fi	Yiddish	YES	Greece	2007	http://ebay.co.uk	03:10:25	5	2011-01-16	quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         3121.dat                                                                                            0000600 0004000 0002000 00000000375 14014122272 0014240 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        6	Everything Must Go	RAPIDOSYFURIOSOS	Comedy|Drama	Oriya	YES	Indonesia	2002	https://intel.com	03:01:19	16	2010-09-19	arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula
\.


                                                                                                                                                                                                                                                                   3113.dat                                                                                            0000600 0004000 0002000 00000000747 14014122272 0014244 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	5	Stevie Perree
2	1	Elayne Pullman
3	3	Mella Dinwoodie
4	1	Panchito Blaber
5	3	Brear Gowdy
6	2	Lemmie Amys
7	5	Nealson Niave
8	4	Dore Yushmanov
9	1	Andie Monini
10	1	Sandor MacKay
11	2	Nicolea Napleton
12	2	Silvanus Belt
13	4	Rivkah Botwood
14	2	Addi McWhin
15	2	Renard Beaver
16	2	Merrili Phillippo
17	1	Mendie Stearndale
18	2	Gladi Goreway
19	4	Lothaire Bird
20	2	Ennis McIlvaney
21	5	Eulalie Shurey
22	4	Corinna Rubenov
23	1	Joy Rasher
24	2	Benedetto Fermin
25	1	Ilene Huertas
\.


                         3112.dat                                                                                            0000600 0004000 0002000 00000001177 14014122272 0014241 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        Stevie Perree	Peru	3
Elayne Pullman	China	1
Mella Dinwoodie	Vietnam	3
Panchito Blaber	Canada	3
Brear Gowdy	Philippines	1
Lemmie Amys	Turkmenistan	1
Nealson Niave	Poland	2
Dore Yushmanov	Ukraine	1
Andie Monini	Thailand	3
Sandor MacKay	Indonesia	2
Nicolea Napleton	Ireland	3
Silvanus Belt	Indonesia	2
Rivkah Botwood	Poland	1
Addi McWhin	Czech Republic	1
Renard Beaver	Peru	2
Merrili Phillippo	Russia	2
Mendie Stearndale	Philippines	1
Gladi Goreway	Serbia	2
Lothaire Bird	Indonesia	2
Ennis McIlvaney	Indonesia	2
Eulalie Shurey	Russia	1
Corinna Rubenov	Indonesia	2
Joy Rasher	Belarus	1
Benedetto Fermin	Netherlands	2
Ilene Huertas	Peru	3
\.


                                                                                                                                                                                                                                                                                                                                                                                                 3118.dat                                                                                            0000600 0004000 0002000 00000012335 14014122272 0014245 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus	68	42
2	nulla neque libero convallis eget eleifend luctus ultricies eu nibh	25	20
3	nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus	33	43
4	risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero	82	43
5	non pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa	50	48
6	vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere	81	49
7	vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum	46	20
8	felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam	50	23
9	amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales	26	8
10	id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam	27	26
11	vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien	15	46
12	quam pharetra magna ac consequat metus sapien ut nunc vestibulum	82	33
13	cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue	32	16
14	pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique est et tempus semper est quam	83	39
15	aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero	85	2
16	a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet	35	38
17	fusce congue diam id ornare imperdiet sapien urna pretium nisl ut	33	31
18	libero convallis eget eleifend luctus ultricies eu nibh quisque id justo	86	32
19	habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien	49	31
20	odio consequat varius integer ac leo pellentesque ultrices mattis odio donec	59	6
21	amet consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante	83	28
22	blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent	80	34
23	ipsum praesent blandit lacinia erat vestibulum sed magna at nunc	82	14
24	velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget	61	28
25	curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac	68	14
26	vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque	71	10
27	tempus semper est quam pharetra magna ac consequat metus sapien	37	11
28	nibh ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam	33	47
29	etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst	10	8
30	volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna	32	34
31	magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque	39	32
32	nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla sed vel	67	30
33	nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra	13	40
34	nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo	87	17
35	mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede	39	48
36	aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam	80	46
37	parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque	10	26
38	varius integer ac leo pellentesque ultrices mattis odio donec vitae nisi	21	15
39	gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi	13	6
40	dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim	35	9
41	tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien	60	35
42	maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus	55	33
43	in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec	89	26
44	in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec	27	10
45	donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci	69	9
46	mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at	14	15
47	ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae	87	33
48	consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante	29	26
49	eget nunc donec quis orci eget orci vehicula condimentum curabitur in	38	26
50	quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate	18	29
\.


                                                                                                                                                                                                                                                                                                   3119.dat                                                                                            0000600 0004000 0002000 00000000030 14014122272 0014233 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Actor
2	Director
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        3120.dat                                                                                            0000600 0004000 0002000 00000001047 14014122272 0014234 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        29	1	Stevie Perree
30	1	Elayne Pullman
31	1	Mella Dinwoodie
32	1	Panchito Blaber
33	1	Brear Gowdy
34	1	Lemmie Amys
35	1	Nealson Niave
36	1	Dore Yushmanov
37	1	Andie Monini
38	1	Sandor MacKay
39	1	Nicolea Napleton
40	1	Silvanus Belt
41	1	Rivkah Botwood
42	2	Addi McWhin
43	1	Addi McWhin
44	2	Renard Beaver
45	1	Renard Beaver
46	1	Merrili Phillippo
47	1	Mendie Stearndale
48	2	Gladi Goreway
49	2	Lothaire Bird
50	1	Gladi Goreway
51	1	Ennis McIlvaney
52	1	Eulalie Shurey
53	2	Corinna Rubenov
54	1	Joy Rasher
55	1	Benedetto Fermin
56	1	Ilene Huertas
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         3116.dat                                                                                            0000600 0004000 0002000 00000001335 14014122272 0014241 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	btutill0	39	1	dworcester0
2	tdurrans1	39	3	mwestwater1
3	aatterbury2	24	4	oduggon2
4	mtriggs3	23	1	iwaything3
5	sjakaway4	38	3	mmacterlagh4
6	slondsdale5	33	2	oduggon2
7	gbarsham6	26	5	iwaything3
8	horry7	23	5	mmacterlagh4
9	rsetterthwait8	27	4	oduggon2
10	jtaunton9	28	3	iwaything3
11	tanthonsena	22	5	mmacterlagh4
12	htrimb	30	4	dworcester0
13	lmcmeekingc	33	3	mmacterlagh4
14	sabadamd	35	2	oduggon2
15	glafranconie	27	4	mwestwater1
16	mbournerf	27	5	dworcester0
17	ncullong	22	3	mwestwater1
18	ghulburth	23	3	oduggon2
19	fbraysoni	24	1	iwaything3
20	evynollj	22	2	mmacterlagh4
21	bbrimsonk	26	2	dworcester0
22	hthireaul	26	4	mwestwater1
23	aamphlettm	34	5	oduggon2
24	oroskeillyn	39	2	iwaything3
25	dhoyo	20	5	mmacterlagh4
\.


                                                                                                                                                                                                                                                                                                   restore.sql                                                                                         0000600 0004000 0002000 00000051703 14014122272 0015365 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.1

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

DROP DATABASE app_cine;
--
-- Name: app_cine; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE app_cine WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Spanish_Colombia.1252';


ALTER DATABASE app_cine OWNER TO postgres;

\connect app_cine

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
-- Name: funcionespelicula(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.funcionespelicula(titulo character varying) RETURNS integer
    LANGUAGE sql
    AS $$SELECT count(f.id_funcion) as Cantidad_Funciones FROM PELICULAS p, FUNCIONES f, SALAS s, CINES c WHERE p.id_pelicula=f.id_pelicula AND f.id_sala=s.id_sala AND s.nombre_cine=c.nombre AND p.titulo_original=titulo;$$;


ALTER FUNCTION public.funcionespelicula(titulo character varying) OWNER TO postgres;

--
-- Name: funcionespeliculas(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.funcionespeliculas(titulo character varying) RETURNS integer
    LANGUAGE sql
    AS $$SELECT count(f.id_funcion) as Cantidad_Funciones FROM PELICULAS p, FUNCIONES f, SALAS s, CINES c WHERE p.id_pelicula=f.id_pelicula AND f.id_sala=s.id_sala AND s.nombre_cine=c.nombre AND p.titulo_original=titulo;$$;


ALTER FUNCTION public.funcionespeliculas(titulo character varying) OWNER TO postgres;

--
-- Name: pelis_fuera_de_cartelera(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.pelis_fuera_de_cartelera() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
insert into "peliculas_fuera_de_cartelera" values (old.id_pelicula, old.titulo_distribucion, old.titulo_original, old.genero, old.idioma_original, old.subtitulos, old.pais_origen, old.anio_produccion, old.url, old.duracion, old.clasificacion, old.fecha_estreno_santiago, old.resumen);
return old;
end
$$;


ALTER FUNCTION public.pelis_fuera_de_cartelera() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: cines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cines (
    nombre character varying(50) NOT NULL,
    direccion character varying(50) NOT NULL,
    telefono bigint NOT NULL
);


ALTER TABLE public.cines OWNER TO postgres;

--
-- Name: secuencia5; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.secuencia5
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.secuencia5 OWNER TO postgres;

--
-- Name: salas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.salas (
    id_sala bigint DEFAULT nextval('public.secuencia5'::regclass) NOT NULL,
    nombre character varying(50),
    butacas bigint NOT NULL,
    numero_sala bigint NOT NULL,
    nombre_cine character varying(50)
);


ALTER TABLE public.salas OWNER TO postgres;

--
-- Name: cineinfo; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.cineinfo AS
 SELECT c.nombre AS cine,
    c.direccion,
    s.numero_sala,
    s.butacas
   FROM public.cines c,
    public.salas s
  WHERE ((s.nombre_cine)::text = (c.nombre)::text);


ALTER TABLE public.cineinfo OWNER TO postgres;

--
-- Name: secuencia4; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.secuencia4
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.secuencia4 OWNER TO postgres;

--
-- Name: funciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.funciones (
    id_funcion bigint DEFAULT nextval('public.secuencia4'::regclass) NOT NULL,
    duracion time without time zone NOT NULL,
    hora_inicio time without time zone NOT NULL,
    id_sala bigint NOT NULL,
    numero_sala bigint NOT NULL,
    id_pelicula bigint NOT NULL
);


ALTER TABLE public.funciones OWNER TO postgres;

--
-- Name: secuencia1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.secuencia1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.secuencia1 OWNER TO postgres;

--
-- Name: peliculas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.peliculas (
    id_pelicula bigint DEFAULT nextval('public.secuencia1'::regclass) NOT NULL,
    titulo_distribucion character varying(50),
    titulo_original character varying(50) NOT NULL,
    genero character varying(250) NOT NULL,
    idioma_original character varying(20) NOT NULL,
    subtitulos character varying(10) NOT NULL,
    pais_origen character varying(50),
    anio_produccion bigint,
    url character varying(50),
    duracion time without time zone NOT NULL,
    clasificacion character varying(15) NOT NULL,
    fecha_estreno_santiago date NOT NULL,
    resumen character varying(250) NOT NULL
);


ALTER TABLE public.peliculas OWNER TO postgres;

--
-- Name: masfunciones; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.masfunciones AS
 SELECT p.titulo_distribucion,
    p.titulo_original,
    count(f.id_pelicula) AS cantidad
   FROM public.peliculas p,
    public.funciones f
  WHERE (p.id_pelicula = f.id_pelicula)
  GROUP BY p.titulo_distribucion, p.titulo_original
  ORDER BY (count(f.id_pelicula)) DESC;


ALTER TABLE public.masfunciones OWNER TO postgres;

--
-- Name: secuencia3; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.secuencia3
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.secuencia3 OWNER TO postgres;

--
-- Name: opiniones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.opiniones (
    id_opinion bigint DEFAULT nextval('public.secuencia3'::regclass) NOT NULL,
    nombre_persona character varying(50) NOT NULL,
    edad integer,
    fecha_registro date NOT NULL,
    calificacion character varying(20) NOT NULL,
    comentario character varying(250) NOT NULL,
    id_pelicula bigint NOT NULL
);


ALTER TABLE public.opiniones OWNER TO postgres;

--
-- Name: peliculas_fuera_de_cartelera; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.peliculas_fuera_de_cartelera (
    id_pelicula bigint NOT NULL,
    titulo_distribucion character varying(50),
    titulo_original character varying(50) NOT NULL,
    genero character varying(250) NOT NULL,
    idioma_original character varying(20) NOT NULL,
    subtitulos character varying(10) NOT NULL,
    pais_origen character varying(50),
    anio_produccion bigint,
    url character varying(50),
    duracion time without time zone NOT NULL,
    clasificacion character varying(15) NOT NULL,
    fecha_estreno_santiago date NOT NULL,
    resumen character varying(250) NOT NULL
);


ALTER TABLE public.peliculas_fuera_de_cartelera OWNER TO postgres;

--
-- Name: secuencia2; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.secuencia2
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.secuencia2 OWNER TO postgres;

--
-- Name: peliculas_personas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.peliculas_personas (
    pk_peliculas_personas bigint DEFAULT nextval('public.secuencia2'::regclass) NOT NULL,
    id_pelicula bigint NOT NULL,
    nombre_persona character varying(50) NOT NULL
);


ALTER TABLE public.peliculas_personas OWNER TO postgres;

--
-- Name: personas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personas (
    nombre character varying(50) NOT NULL,
    nacionalidad character varying(20) NOT NULL,
    cantidad_de_peliculas bigint
);


ALTER TABLE public.personas OWNER TO postgres;

--
-- Name: secuencia6; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.secuencia6
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.secuencia6 OWNER TO postgres;

--
-- Name: promociones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.promociones (
    id_promocion bigint DEFAULT nextval('public.secuencia6'::regclass) NOT NULL,
    descripcion character varying(250) NOT NULL,
    descuento numeric NOT NULL,
    id_funcion bigint NOT NULL
);


ALTER TABLE public.promociones OWNER TO postgres;

--
-- Name: secuencia7; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.secuencia7
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.secuencia7 OWNER TO postgres;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id_rol bigint DEFAULT nextval('public.secuencia7'::regclass) NOT NULL,
    nombre_rol character varying(25) NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: secuencia8; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.secuencia8
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.secuencia8 OWNER TO postgres;

--
-- Name: roles_personas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles_personas (
    pk_roles_personas bigint DEFAULT nextval('public.secuencia8'::regclass) NOT NULL,
    id_rol bigint NOT NULL,
    nombre_persona character varying(50) NOT NULL
);


ALTER TABLE public.roles_personas OWNER TO postgres;

--
-- Name: secuencia9; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.secuencia9
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.secuencia9 OWNER TO postgres;

--
-- Data for Name: cines; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cines (nombre, direccion, telefono) FROM stdin;
\.
COPY public.cines (nombre, direccion, telefono) FROM '$$PATH$$/3117.dat';

--
-- Data for Name: funciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.funciones (id_funcion, duracion, hora_inicio, id_sala, numero_sala, id_pelicula) FROM stdin;
\.
COPY public.funciones (id_funcion, duracion, hora_inicio, id_sala, numero_sala, id_pelicula) FROM '$$PATH$$/3115.dat';

--
-- Data for Name: opiniones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.opiniones (id_opinion, nombre_persona, edad, fecha_registro, calificacion, comentario, id_pelicula) FROM stdin;
\.
COPY public.opiniones (id_opinion, nombre_persona, edad, fecha_registro, calificacion, comentario, id_pelicula) FROM '$$PATH$$/3114.dat';

--
-- Data for Name: peliculas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.peliculas (id_pelicula, titulo_distribucion, titulo_original, genero, idioma_original, subtitulos, pais_origen, anio_produccion, url, duracion, clasificacion, fecha_estreno_santiago, resumen) FROM stdin;
\.
COPY public.peliculas (id_pelicula, titulo_distribucion, titulo_original, genero, idioma_original, subtitulos, pais_origen, anio_produccion, url, duracion, clasificacion, fecha_estreno_santiago, resumen) FROM '$$PATH$$/3111.dat';

--
-- Data for Name: peliculas_fuera_de_cartelera; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.peliculas_fuera_de_cartelera (id_pelicula, titulo_distribucion, titulo_original, genero, idioma_original, subtitulos, pais_origen, anio_produccion, url, duracion, clasificacion, fecha_estreno_santiago, resumen) FROM stdin;
\.
COPY public.peliculas_fuera_de_cartelera (id_pelicula, titulo_distribucion, titulo_original, genero, idioma_original, subtitulos, pais_origen, anio_produccion, url, duracion, clasificacion, fecha_estreno_santiago, resumen) FROM '$$PATH$$/3121.dat';

--
-- Data for Name: peliculas_personas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.peliculas_personas (pk_peliculas_personas, id_pelicula, nombre_persona) FROM stdin;
\.
COPY public.peliculas_personas (pk_peliculas_personas, id_pelicula, nombre_persona) FROM '$$PATH$$/3113.dat';

--
-- Data for Name: personas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personas (nombre, nacionalidad, cantidad_de_peliculas) FROM stdin;
\.
COPY public.personas (nombre, nacionalidad, cantidad_de_peliculas) FROM '$$PATH$$/3112.dat';

--
-- Data for Name: promociones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.promociones (id_promocion, descripcion, descuento, id_funcion) FROM stdin;
\.
COPY public.promociones (id_promocion, descripcion, descuento, id_funcion) FROM '$$PATH$$/3118.dat';

--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id_rol, nombre_rol) FROM stdin;
\.
COPY public.roles (id_rol, nombre_rol) FROM '$$PATH$$/3119.dat';

--
-- Data for Name: roles_personas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles_personas (pk_roles_personas, id_rol, nombre_persona) FROM stdin;
\.
COPY public.roles_personas (pk_roles_personas, id_rol, nombre_persona) FROM '$$PATH$$/3120.dat';

--
-- Data for Name: salas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.salas (id_sala, nombre, butacas, numero_sala, nombre_cine) FROM stdin;
\.
COPY public.salas (id_sala, nombre, butacas, numero_sala, nombre_cine) FROM '$$PATH$$/3116.dat';

--
-- Name: secuencia1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.secuencia1', 6, true);


--
-- Name: secuencia2; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.secuencia2', 25, true);


--
-- Name: secuencia3; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.secuencia3', 20, true);


--
-- Name: secuencia4; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.secuencia4', 50, true);


--
-- Name: secuencia5; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.secuencia5', 25, true);


--
-- Name: secuencia6; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.secuencia6', 50, true);


--
-- Name: secuencia7; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.secuencia7', 2, true);


--
-- Name: secuencia8; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.secuencia8', 56, true);


--
-- Name: secuencia9; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.secuencia9', 1, false);


--
-- Name: cines cines_direccion_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cines
    ADD CONSTRAINT cines_direccion_key UNIQUE (direccion);


--
-- Name: cines cines_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cines
    ADD CONSTRAINT cines_pkey PRIMARY KEY (nombre);


--
-- Name: cines cines_telefono_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cines
    ADD CONSTRAINT cines_telefono_key UNIQUE (telefono);


--
-- Name: funciones funciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funciones
    ADD CONSTRAINT funciones_pkey PRIMARY KEY (id_funcion);


--
-- Name: opiniones opiniones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.opiniones
    ADD CONSTRAINT opiniones_pkey PRIMARY KEY (id_opinion);


--
-- Name: peliculas_fuera_de_cartelera peliculas_fuera_de_cartelera_titulo_original_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peliculas_fuera_de_cartelera
    ADD CONSTRAINT peliculas_fuera_de_cartelera_titulo_original_key UNIQUE (titulo_original);


--
-- Name: peliculas_personas peliculas_personas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peliculas_personas
    ADD CONSTRAINT peliculas_personas_pkey PRIMARY KEY (pk_peliculas_personas);


--
-- Name: peliculas peliculas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peliculas
    ADD CONSTRAINT peliculas_pkey PRIMARY KEY (id_pelicula);


--
-- Name: peliculas peliculas_titulo_original_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peliculas
    ADD CONSTRAINT peliculas_titulo_original_key UNIQUE (titulo_original);


--
-- Name: personas personas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personas
    ADD CONSTRAINT personas_pkey PRIMARY KEY (nombre);


--
-- Name: promociones promociones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promociones
    ADD CONSTRAINT promociones_pkey PRIMARY KEY (id_promocion);


--
-- Name: roles_personas roles_personas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_personas
    ADD CONSTRAINT roles_personas_pkey PRIMARY KEY (pk_roles_personas);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id_rol);


--
-- Name: salas salas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salas
    ADD CONSTRAINT salas_pkey PRIMARY KEY (id_sala);


--
-- Name: duracion_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX duracion_idx ON public.funciones USING btree (duracion);


--
-- Name: nombre_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX nombre_idx ON public.personas USING btree (nombre);


--
-- Name: opinion_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX opinion_idx ON public.opiniones USING btree (calificacion);


--
-- Name: titulo_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX titulo_idx ON public.peliculas USING btree (titulo_original);


--
-- Name: peliculas peliculas_fuera; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER peliculas_fuera BEFORE DELETE ON public.peliculas FOR EACH ROW EXECUTE FUNCTION public.pelis_fuera_de_cartelera();


--
-- Name: funciones fk_funciones_peliculas; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funciones
    ADD CONSTRAINT fk_funciones_peliculas FOREIGN KEY (id_pelicula) REFERENCES public.peliculas(id_pelicula) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: funciones fk_funciones_salas; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funciones
    ADD CONSTRAINT fk_funciones_salas FOREIGN KEY (id_sala) REFERENCES public.salas(id_sala) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: opiniones fk_opiniones_peliculas; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.opiniones
    ADD CONSTRAINT fk_opiniones_peliculas FOREIGN KEY (id_pelicula) REFERENCES public.peliculas(id_pelicula) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: peliculas_personas fk_peliculas_personas; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peliculas_personas
    ADD CONSTRAINT fk_peliculas_personas FOREIGN KEY (id_pelicula) REFERENCES public.peliculas(id_pelicula) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: peliculas_personas fk_personas_peliculas; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peliculas_personas
    ADD CONSTRAINT fk_personas_peliculas FOREIGN KEY (nombre_persona) REFERENCES public.personas(nombre) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: promociones fk_promociones_funciones; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promociones
    ADD CONSTRAINT fk_promociones_funciones FOREIGN KEY (id_funcion) REFERENCES public.funciones(id_funcion) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: roles_personas fk_roles_personas; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_personas
    ADD CONSTRAINT fk_roles_personas FOREIGN KEY (id_rol) REFERENCES public.roles(id_rol) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: roles_personas fk_roles_personass; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_personas
    ADD CONSTRAINT fk_roles_personass FOREIGN KEY (nombre_persona) REFERENCES public.personas(nombre);


--
-- Name: salas fk_salas_cines; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salas
    ADD CONSTRAINT fk_salas_cines FOREIGN KEY (nombre_cine) REFERENCES public.cines(nombre) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             