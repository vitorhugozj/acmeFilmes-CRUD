create database db_acme_filmes_turma_aa;
use db_acme_filmes_turma_aa;

create table tbl_filme(
	id int not null auto_increment primary key,
    nome varchar(100) not null,
    sinopse text not null,
    duracao time not null,
    data_lancamento date not null,
    data_relacamento date not null,
    foto_capa varchar(200) not null,
    valor_unitario float not null,
    id_classificacao int not null,
	index fk_tbl_filme_tbl_classificacao (id_classificacao asc),
    constraint fk_tbl_filme_tbl_classificacao
    foreign key (id_classificacao)
    references tbl_classificacao(id)
);

create table tbl_classificacao(
	id int not null auto_increment,
    caracteristicas varchar(150) not null,
	faixa_etaria varchar(2) not null,
    classificacao varchar(45) not null,
    primary key (id)
);

create table tbl_genero (
	id int not null auto_increment,
    nome varchar(45) not null,
    primary key(id)
);

create table tbl_nacionalidade(
	id int not null auto_increment,
    nome varchar(50) not null,
	primary key(id)
);

create table tbl_sexo (
	id int not null auto_increment,
    sigla varchar(2) not null,
    nome varchar(45) not null,
    primary key (id)
);

create table tbl_diretor (
	id int not null auto_increment,
    nome varchar(200) not null,
    biografia text null,
    data_nascimento date not null,
	tbl_sexo_id int not null,
    primary key(id),
    index fk_tbl_diretor_tbl_sexo1_sexo1_idx(tbl_sexo_id asc),
    constraint fk_tbl_diretor_tbl_sexo1
    foreign key(tbl_sexo_id)
    references tbl_sexo(id)
);

create table tbl_ator(
	id int not null auto_increment,
    nome varchar(100) not null,
    foto varchar(150) not null,
    biografia text null,
	data_nascimento date not null,
    tbl_sexo_id int not null,
    primary key(id),
    index fk_tbl_ator_sexo1_idx(tbl_sexo_id asc),
    constraint fk_tbl_ator_tbl_sexo1
    foreign key(tbl_sexo_id)
    references tbl_sexo(id)
);


create table tbl_filme_ator (
	id int not null auto_increment,
    tbl_filme_id int not null,
    tbl_ator_id int not null,
	primary key(id),
    index fk_tbl_tbl_ator_tbl_filme1_idx(tbl_filme_id asc),
    index fk_tbl_filme_ator_tbl_ator1_idx(tbl_ator_id asc),
    constraint fk_tbl_filme_ator_tbl_filme
    foreign key(tbl_filme_id)
    references tbl_filme(id),
    constraint fk_tbl_filme_ator_tbl_ator
    foreign key(tbl_ator_id)
    references tbl_ator (id)
);

create table tbl_ator_nacionalidade (
	id int not null auto_increment,
    tbl_nacionalidade int not null,
    tbl_ator_id int not null,
    primary key(id),
    index fk_tbl_ator_nacionalidade_tbl_nacionalidade1_idx(tbl_nacionalidade asc),
    index fk_tbl_ator_nacionalidade_tbl_ator1_idx(tbl_ator_id asc),
    constraint fk_tbl_ator_nacionalidade_tbl_nacionalidade1
    foreign key(tbl_nacionalidade)
    references tbl_nacionalidade(id),
    constraint fk_tbl_ator_nacionalidade_tbl_ator1
    foreign key(tbl_ator_id)
    references tbl_ator(id)
);

create table tbl_diretor_nacionalidade(
    id int not null auto_increment,
    tbl_nacionalidade_id int not null,
    tbl_diretor_id int not null,
    primary key(id),
    index fk_tbl_diretor_nacionalidade_tbl_nacionalidade1_idx(tbl_nacionalidade_id asc),
    index fk_tbl_diretor_nacionalidade_tbl_diretor1_idx(tbl_diretor_id asc),
    constraint fk_tbl_diretor_nacionalidade_tbl_nacionalidade1
    foreign key(tbl_nacionalidade_id)
    references tbl_nacionalidade(id),
    constraint fk_tbl_diretor_nacionalidade_tbl_diretor1
    foreign key (tbl_diretor_id)
    references tbl_diretor(id)
);

insert into tbl_classificacao(caracteristicas, faixa_etaria, classificacao) values
("Recomendado para todas as idades", "0", "Livre para todos os públicos");
select * from tbl_classificacao;

insert into tbl_filme(nome, sinopse, duracao, data_lancamento, foto_capa, valor_unitario, tbl_classificacao_id)values
(
	'flash',
    'Pictures, ele é o décimo terceiro filme do Universo Estendido DC.',
    '02:24:00',
    '2022-03-12',
    null,
    'https://www.google.com/url?sa=i&url=https%3A%2F%2Flegadodadc.com.br%2Fthe-flash-com-liga-da-justica-veja-o-poster-oficial-do-filme%2F&psig=AOvVaw1Oj4H47H_m1vfU9F1C5qAu&ust=1714536400851000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCJCWjuaH6YUDFQAAAAAdAAAAABAE'
	'10',
    1
);

insert into tbl_sexo(sigla, nome) values (
	"F"
    "Feminino"
), 
(
	"M"
    "Masculino");

insert into tbl_ator(nome, data_nascimento, biografia, foto, tbl_sexo_id)values
(	'Ezra Miller',
	'1992-09-30',
	'Ezra Matthew Miller é um ator estadunidense que trabalha como intérprete de artes cênicas, cancionista, musicista e modelo.',
    'https://pt.wikipedia.org/wiki/Ficheiro:Ezra_Miller_by_Gage_Skidmore_2.jpg',
    2
);

insert into nacionalidade(nome)values
(
"Brasileiro"
),
(
"Estadunidense"
),
(	
"Espanhol"
);


