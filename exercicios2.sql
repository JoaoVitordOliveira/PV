create database if not exists LojaJuao;	
use LojaJuao;	
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
create table if not exists tbl_vendas(
ID_NF tinyint not null,
ID_ITEM tinyint not null,
COD_PROD tinyint not null,
VALOR float not null,
QUANTIDADE tinyint not null,
DESCONTO tinyint,
primary key (ID_NF, ID_ITEM)
);
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
insert into tbl_vendas(id_nf,id_item ,cod_prod,valor,quantidade,desconto) values 
(1,1,1,25.00,10,5), 
(1,2,2,13.50,3,null), 
(1,3,3,15.00,2,null), 
(1,4,4,10.00,1,null), 
(1,5,5,30.00,1,null), 
(2,1,3,15.00,4,null), 
(2,3,5,30.00,7,null), 
(3,2,4,10.00,4,null), 
(3,4,2,13.50,7,null), 
(4,1,5,30.00,10,15), 
(4,2,4,10.00,12,5), 
(4,3,1,25.00,13,5), 
(4,4,2,13.50,15,5), 
(5,2,5,30.00,6,null), 
(6,2,3,15.00,25,20), 
(7,1,1,25.00,10,3), 
(7,2,2,13.50,10,4), 
(7,4,5,30.00,10,1);
select * from tbl_vendas;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- A.
select id_nf, id_item,cod_prod, valor from tbl_vendas where desconto=0;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- B.
select id_nf, id_item, cod_prod, valor, 
(valor-valor*desconto/100) as 'Valor vendido'
from tbl_vendas
where desconto is not null order by valor;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- C.
update tbl_vendas set desconto=0 where desconto is null;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- D.
select ID_NF, ID_ITEM, COD_PROD, VALOR, valor*quantidade as valor_total, DESCONTO,
VALOR -(VALOR*(DESCONTO/100)) as Valor_Vendido
from tbl_vendas;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- E.
select id_nf, sum(QUANTIDADE * VALOR) as Valor_Total 
from tbl_vendas
group by id_nf order by valor_total desc;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- F.
 select ID_NF,sum(valor-(valor*desconto/100)) as valor_vendido from tbl_vendas
 group by id_nf order by valor_vendido desc;
 -- ----------------------------------------------------------------------------------------------------------------------------------------------------
 -- G.
 select COD_PROD, QUANTIDADE from tbl_vendas
 group by cod_prod;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- H.
select  ID_NF, COD_PROD, QUANTIDADE from tbl_vendas
where quantidade>10 group by cod_prod;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- I.
select  ID_NF, valor*quantidade as valor_total from tbl_vendas
group by id_nf having valor_total>500;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- J.
select COD_PROD, avg(desconto) from tbl_vendas
group by cod_prod;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- K.
select cod_prod, min(desconto) as menor, max(desconto) as maior, sum(desconto) as soma, avg(desconto) as media, count(desconto) as itens from tbl_vendas
group by cod_prod;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- L.
select id_nf, count(quantidade) as itens from tbl_vendas group by id_nf
having itens>3;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------

 # Acabo :))))

-- 2.--------------------------------------------------------------------------------------------------------------------------------------------------
create database if not exists FaculdadeEXE;
use faculdadeEXE;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
create table if not exists Alunos(
MAT int primary key not null,	
Nome varchar(80) not null,
Endereço varchar(80) not null,
Cidade varchar(80) not null);
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
create table if not exists Disciplinas(
COD_Disc varchar(20) primary key not null,
Nome_Disc varchar (80) not null,
Carga_H tinyint not null);
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
create table if not exists Professores(
COD_PROF int primary key not null,
Nome varchar(80) not null,
Endereço varchar(80) not null,
Cidade varchar(80) not null);
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
create table if not exists Turma(
COD_DISC varchar(20) not null,
COD_TURMA int not null,
COD_PROF int not null,
ANO varchar(4) not null,
Horário varchar(7) not null,
primary key (cod_disc,cod_turma,cod_prof,ano));
alter table Turma add constraint fk_Disc foreign key (Cod_disc) references Disciplinas(Cod_Disc);
alter table Turma add constraint fk_Prof foreign key (Cod_Prof) references Professores(Cod_Prof);
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
create table if not exists Historico(
MAT int not null,
COD_DISC varchar(20) not null,
COD_TURMA int not null,
COD_PROF int not null,
ANO varchar(4) not null,
Frequência enum('Alta','Média','Baixa'), #FREQUÊNCIA - ALTA=100-70%, MÉDIA 70%-40%, BAIXA 40%-0%
Nota float,
primary key (MAT,COD_DISC,COD_TURMA,COD_PROF,ANO));
alter table Historico add constraint fk_HistH foreign key (MAT) references Alunos(MAT);
alter table Historico add constraint fk_DiscH2 foreign key (cod_disc,cod_turma,cod_prof,ano) references Turma(cod_disc,cod_turma,cod_prof,ano);
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
insert into Alunos (MAT,Nome,Endereço,Cidade) values

(2015010101, 'JOSE DE ALENCAR', 'RUA DAS ALMAS', 'NATAL'),
(2015010102, 'JOÃO JOSÉ', 'AVENIDA RUY CARNEIRO', 'JOÃO PESSOA'),
(2015010103, 'MARIA JOAQUINA', 'RUA CARROSSEL', 'RECIFE'),
(2015010104, 'MARIA DAS DORES', 'RUA DAS LADEIRAS', 'FORTALEZA'),
(2015010105, 'JOSUÉ CLAUDINO DOS SANTOS', 'CENTRO', 'NATAL'),
(2015010106, 'JOSUÉLISSON CLAUDINO DOS SANTOS', 'CENTRO', 'NATAL');

select * from alunos;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
insert into disciplinas(COD_DISC, Nome_Disc, Carga_H) values

('BD', 'BANCO DE DADOS', 100),
('POO', 'PROGRAMAÇÃO COM ACESSO A BANCO DE DADOS', 100),
('WEB', 'AUTORIA WEB', 50),
('ENG', 'ENGENHARIA DE SOFTWARE', 80);

select * from disciplinas;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
insert into Professores (COD_PROF, nome, endereço, Cidade) values

(212131, 'NICKERSON FERREIRA', 'RUA MANAÍRA', 'JOÃO PESSOA'),
(122135, 'ADORILSON BEZERRA', 'AVENIDA SALGADO FILHO', 'NATAL'),
(192011, 'DIEGO OLIVEIRA', 'AVENIDA ROBERTO FREIRE', 'NATAL');

select * from professores;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
insert into turma(COD_DISC,COD_TURMA,COD_PROF,ANO,HORáRIO) values

('BD', 1, 212131, 2015, '11H-12H'),
('BD', 2, 212131, 2015, '13H-14H'),
('POO', 1, 192011, 2015, '08H-09H'),
('WEB', 1, 192011, 2015, '07H-08H'),
('ENG', 1, 122135, 2015, '10H-11H');

select * from turma;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
insert into historico (MAT, COD_DISC, COD_TURMA, COD_PROF, ANO, Frequência, Nota) values

(2015010101, 'BD',1, 212131,'2015','Média', 7),
(2015010101, 'ENG',1, 122135,'2015','Média', 5),
(2015010101, 'WEB',1, 192011,'2015','Média', 6),
(2015010101, 'POO',1, 192011,'2015','Média', 7),

(2015010102, 'BD', 1, 212131, '2015', 'Alta', 10),
(2015010102, 'ENG', 1, 122135, '2015', 'Alta', 7.25),
(2015010102, 'WEB', 1, 192011, '2015', 'Alta', 7),
(2015010102, 'POO', 1, 192011, '2015', 'Alta', 8.5),

(2015010103,'BD', 2, 212131,'2015', 'Baixa', 4),
(2015010103,'ENG', 1, 122135,'2015', 'Baixa', 2),
(2015010103,'WEB', 1, 192011,'2015', 'Baixa', 3.5),
(2015010103,'POO', 1, 192011,'2015', 'Baixa', 4.5),

(2015010104, 'BD', 1, 212131, '2015', 'Alta', 8.5),
(2015010104, 'ENG', 1, 122135, '2015', 'Alta', 8),
(2015010104, 'WEB', 1, 192011, '2015', 'Alta', 10),
(2015010104, 'POO', 1, 192011, '2015', 'Alta', 9.5),

(2015010105, 'BD', 1, 212131, '2015', 'Baixa', 4),
(2015010105, 'ENG', 1, 122135, '2015', 'Baixa', 3),
(2015010105, 'WEB', 1, 192011, '2015', 'Baixa', 3.5),
(2015010105, 'POO', 1, 192011, '2015', 'Baixa', 4.5),

(2015010106, 'BD', 1, 212131, '2015', 'Média', 6.5),
(2015010106, 'ENG', 1, 122135, '2015', 'Média', 6), 
(2015010106, 'WEB', 1, 192011, '2015', 'Média', 5), 
(2015010106, 'POO', 1, 192011, '2015', 'Média', 7);

select * from historico;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- A.
Select mat, nota from historico where ano='2015' and cod_disc='BD' and nota<5;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- B.
Select Mat, avg(NOTA) from historico where Cod_disc='POO' and ano='2015';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- C.
Select Mat, avg(NOTA) from historico where Cod_disc='POO' and ano='2015' and Nota>6;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- D.
Select Nome, Endereço, Cidade from Alunos where not Cidade = 'Natal'; 
-- ----------------------------------------------------------------------------------------------------------------------------------------------------

