drop database faculdadevey;


Create database FACULDADEvey;
Use FACULDADEvey;

drop table tbl_alunos;
alter table tbl_alunos;

create table if not exists tbl_alunos( 
RA Int auto_increment primary key,
Nome varchar(30),
Sobrenome varchar(30),
CPF bigint,
Idade tinyint,
Sexo enum('M','F'),
Email varchar(80),
Telefone int,
Cidade varchar (80),
Logradouro varchar(30),
Rua varchar(80),
CEP int,
CTurma int, 
CCurso int);

alter table tbl_alunos add constraint fk_cturma foreign key (CTurma) references tbl_turma(cturma);
alter table tbl_alunos add constraint fk_ccurso foreign key (CCurso) references tbl_cursos(ccurso);

drop table tbl_cursos;

Create table if not exists tbl_Cursos(
NoCurso varchar(50),
CCurso int auto_increment primary key,
CDepartamento int);

alter table tbl_cursos add constraint fk_cdepartamento_cursos foreign key (CDepartamento) references tbl_departamento(cdepartamento);

drop table tbl_departamento;

Create table if not exists tbl_Departamento(
CDepartamento int auto_increment primary key,
NoDepartamento varchar(80));

drop table tbl_disciplina;

create table if not exists tbl_Disciplina(
CDisciplina int auto_increment primary key,
CDepartamento int,
NuAlunos int,
CargaHoraria varchar(80),
NoDisciplina varchar(50));

alter table tbl_disciplina add constraint fk_departamento_disc foreign key (CDepartamento) references tbl_departamento(cdepartamento);

drop table tbl_historico;

create table if not exists tbl_Historico(
CHistorico int,
CDisciplina int, 	
CTurma int,
CProfessor int,
Ano year,
Frequência int,
Nota int,
RA int,
primary key (CHistorico,RA,CDisciplina,CTurma,CProfessor,ANO));

alter table tbl_Historico add constraint fk_HistH foreign key (RA) references tbl_Alunos(RA);
alter table tbl_Historico add constraint fk_DiscH foreign key (CDisciplina) references tbl_Turma(CDisciplina);
alter table tbl_Historico add constraint fk_TurmaH foreign key (CTurma) references tbl_Turma(CTurma);
alter table tbl_Historico add constraint fk_ProfH foreign key (CProfessor) references tbl_Turma(CProfessor);



drop table tbl_professor;

create table if not exists tbl_Professor(
CProfessor int auto_increment primary key,
NomeP varchar(80),
SobrenomeP varchar(80),
Idade int,
CPF bigint,
Sexo enum('M','F'),
Email varchar (80),
Telefone int,
Cidade varchar(80),
Logradouro varchar(30),
Rua varchar (80),
CEP int,
CDepartamento int);

alter table tbl_professor add constraint fk_departamento foreign key (CDepartamento) references tbl_departamento(CDepartamento);

drop table tbl_turma;

create table if not exists tbl_Turma(
InicioDCurso varchar(30),
FimDCurso varchar (30),
NmAlunos int,
Período enum('Matutino','Vespertino','Noturno'),
Ano year,
CDisciplina int,
CProfessor int,
CTurma int,
CCurso int,
primary key (CDisciplina, CProfessor, CTurma, CCurso, Ano));

alter table tbl_turma add constraint fk_ccurso_turma foreign key (CCurso) references tbl_cursos(ccurso);
alter table tbl_turma add constraint fk_cprofessorT foreign key (CProfessor) references tbl_professor(CProfessor);
alter table tbl_turma add constraint fk_cdisciT foreign key (CDisciplina) references Tbl_disciplina(CDisciplina);
Alter table tbl_turma add constraint fk_anoT foreign key (Ano) references tbl_historico(Ano);

insert into tbl_alunos(RA, Nome, Sobrenome,CPF, Idade, Sexo, Email, Telefone, Cidade, Logradouro, Rua, CEP, CTurma, CCurso) values
(99900301, 'Anna','Delmondes',37524417281, 18, 'F', 'Anninhazica@outlook.com', 949640983, 'Osasco','Avenida','Tenente Marques', '05450011', 66600301,77700301),
(99900302, 'Bianca','Farias',37518676833, 23, 'F', 'BiaFarinhas@outlook.com', 993141242, 'São Paulo','Rua','Eugenio filho', '07210011', 66600302,77700302),
(99900303, 'Bruno','Miranda',11341287641, 28, 'M', 'BMiranda@outlook.com', 978942183, 'Osasco','Avenida','Bubarim', '05452134', 06600303,77700303),
(99900304, 'Igor','Gomes',38812176631, 18, 'M', 'Omaisbrabodetodos@outlook.com', 945535343, 'Pinheiros','Rua','Winston lindo', '050012011', 66600304,77700304),
(99900305, 'João','Oliveira',7524418876, 18, 'M', 'Anninhazica@outlook.com', 949640987, 'Osasco','Rua','Doutor Jose', '016701234', 66600305,77700305);

select * from tbl_alunos;

insert into tbl_cursos(NoCurso, CCurso, CDepartamento) values
('BD',77700301,88800301),
('WEB', 77700302, 88800302),
('PHP', 77700303, 88800303),
('BD2', 77700304, 88800304),
('Python', 77700305, 88800305);

select * from tbl_cursos;

insert into tbl_departamento(CDepartamento, Nodepartamento) values
(88800301, 'DEBD'),
(88800302, 'DEWEB'),
(88800303, 'DEPHP'),
(88800304, 'DEBD2'),
(88800305, 'DEPython');

select * from tbl_departamento;

insert into tbl_disciplina(CDisciplina, CDepartamento, NuAlunos, CargaHoraria, NoDisciplina) values
(33300301, 88800301, 30, '100Horas', 'Banco de dados'),
(33300302, 88800302, 30, '80Horas', 'WEB'),
(33300303, 88800303, 30, '80Horas', 'PHP'),
(33300304, 88800304, 30, '100Horas', 'Banco de dados2'),
(33300305, 88800305, 30, '80Horas', 'Python');

select * from tbl_disciplina;

insert into tbl_historico(CHistorico, CDisciplina, CTurma, CProfessor, Ano, Frequência, Nota, RA) values
(55500301, 33300301, 66600301,44400301, 2002, 60, 6, 99900301),
(55500302, 33300302, 6600302,44400302, 2002, 100, 10, 99900302),
(55500303, 33300303, 66600303,44400303, 2002, 70, 7, 99900303),
(55500304, 33300304, 66600304,44400304, 2002, 80, 8, 99900304),
(55500305, 33300305, 66600305,44400305, 2002, 100, 10, 99900305);

select * from tbl_historico;

insert into tbl_professor(CProfessor, NomeP, SobrenomeP, Idade, CPF, Sexo, Email, Telefone, Cidade, Logradouro, Rua, CEP, CDepartamento) values
(44400301, 'NICKERSON','FERREIRA',48,17787623491, 'M',  'NickersonFEE@outlook.com', 992130983, 'Osasco','Avenida','Tenente Marques', '02242145',66600301),
(44400302, 'Gerson','Freitas',38, 37517765421,'M',  'GeFreitas@outlook.com', 991234483, 'Osasco','Rua','Adoniran Barbosa', '09872435',66600302),
(44400303, 'Anna','Montalvão',26,  34112356781,'F','AnnaMONTA@outlook.com', 976573242, 'Barueri','Avenida','Carapicuiba', '06524411',66600303),
(44400304, 'Rosana','Lima',56, 17734421151,'F',  'RosanaLima@hotmail.com', 997654231, 'Osasco','Avenida','Tenente Marques', '02242145',66600304),
(44400305, 'Gabriel','Alvaro',32,37524417645, 'M',  'GaAlvaro@outlook.com', 994523451, 'Osasco','Rua','Nelson Mandela', '07633145',66600305);

select * from tbl_professor;

insert into tbl_turma(InicioDCurso, FimDCurso, NmAlunos, Período, CTurma, CCurso, CDisciplina, CProfessor, Ano) values
('10-09-2002', '30-10-2002', 30, 'Matutino', 66600301, 77700301,33300301,44400301,2002),
('10-09-2002', '10-10-2002', 30, 'Noturno', 66600302, 77700302,33300302,44400302,2002),
('10-09-2002', '10-10-2002', 30, 'Matutino', 66600303, 77700303,33300303,44400303,2002),
('10-09-2002', '30-10-2002', 30, 'Noturno', 66600304, 77700304,33300304,44400304,2002),
('10-09-2002', '10-10-2002', 30, 'Noturno', 66600305, 77700305,33300305,44400305,2002);

select * from tbl_turma;

select RA, nota from tbl_historico where ano='2002' and CDisciplina = '33300301';
Select RA, avg(NOTA) from tbl_historico where CDisciplina='333003026' and ano='2002';
Select Nome, Logradouro, Cidade from tbl_Alunos where Cidade = 'Osasco'; 
select RA, nota from tbl_historico;

select NomeP, SobrenomeP from tbl_professor where Idade>=27;