-- Adminer 4.8.1 PostgreSQL 16.3 (Debian 16.3-1.pgdg120+1) dump

CREATE SEQUENCE pessoa_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1;

CREATE TABLE "public"."pessoa" (
    "id" bigint DEFAULT nextval('pessoa_id_seq') NOT NULL,
    "email" character varying(255),
    "nome" character varying(255),
    CONSTRAINT "pessoa_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

INSERT INTO "pessoa" ("email", "nome") VALUES 
('edineinissola@gmail.com', 'Edinei Nissola'),
('eduardosantos@gmail.com',	'Eduardo Ormond dos Santos'),
('francisco4vidal@gmail.com',	'Francisco Jose Prata Vidal'),
('jegoreis@gmail.com',	'Jefferson Gonçalves de Oliveira Reis');


-- 2024-06-22 19:59:10.149186+00