create database db_acme_filmes_turma_aa;
use db_acme_filmes_turma_aa;

create table tbl_filme(
	id int not null auto_increment primary key,
    nome varchar(100) not null,
    sinopse text not null,
    duracao time not null,
    data_lancamento date not null,
    data_relancamento date,
    foto_capa varchar(400) not null,
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

create table tbl_filme_diretor(
	id int not null auto_increment primary key,
	id_filme int not null,
    id_diretor int not null,
    
    constraint FK_DIRETOR_FILMEDIRETOR
    foreign key(id_diretor)
    references tbl_diretor(id),
    
    constraint FK_FILME_FILMEDIRETOR
    foreign key(id_filme)
    references tbl_filme(id)
);

create table tbl_filme_genero(
	id int not null auto_increment primary key,
	id_filme int not null,
    id_genero int not null,
    
    constraint FK_GENERO_FILMEGENERO
    foreign key(id_genero)
    references tbl_genero(id),
    
    constraint FK_FILME_FILMEGENERO
    foreign key(id_filme)
    references tbl_filme(id)
);

desc tbl_classificacao;

insert into tbl_classificacao(
	caracteristicas,
	faixa_etaria,
    classificacao
)values(
	"Não expõe crianças a conteúdo potencalmente prejudiciais.",
	"L",
    "Livre"
),(
	"Conteúdo violento ou linguagem inapropriada para crianças, ainda que em menor itensidade.",
	"10",
    "Não recomendado para menores de 10 anos"
),(
	"As cenas podem conter agressão física, consumo de drogas e insinuação sexual.",
	"12",
    "Não recomendado para menores de 12 anos"
),(
	"Conteúdos mais violentos e/ou de linguagem sexual mais acentuada.",
	"14",
    "Não recomendado para menores de 14 anos"
),(
	"Conteúdos mais violentos ou com conteúdo sexual mais intenso, com cenas de tortura, suicídio, estupro ou nudez total.",
	"16",
    "Não recomendado para menores de 16 anos"
),(
	"Conteúdos violentos e sexuais extremos. Cenas de sexo, incesto, ou atos repetidos de tortura, mutilação ou abuso sexual.",
	"18",
    "Não recomendado para menores de 18 anos"
);

desc tbl_filme;
insert into tbl_filme(nome, sinopse, duracao, data_lancamento, data_relancamento, foto_capa, valor_unitario, id_classificacao)values
(
	"flash",
    "Pictures, ele é o décimo terceiro filme do Universo Estendido DC.",
    "02:24:00",
    "2022-03-12",
    null,
    "https://www.google.com/url?sa=i&url=https%3A%2F%2Flegadodadc.com.br%2Fthe-flash-com-liga-da-justica-veja-o-poster-oficial-do-filme%2F&psig=AOvVaw1Oj4H47H_m1vfU9F1C5qAu&ust=1714536400851000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCJCWjuaH6YUDFQAAAAAdAAAAABAE",
	"10",
    1
);

desc tbl_sexo;
insert into tbl_sexo(sigla, nome) values (
	"F",
    "Feminino"
), 
(
	"M",
    "Masculino");

insert into tbl_ator(nome, data_nascimento, biografia, foto, tbl_sexo_id)values
(	'Ezra Miller',
	'1992-09-30',
	'Ezra Matthew Miller é um ator estadunidense que trabalha como intérprete de artes cênicas, cancionista, musicista e modelo.',
    'https://pt.wikipedia.org/wiki/Ficheiro:Ezra_Miller_by_Gage_Skidmore_2.jpg',
    2
);

insert into tbl_nacionalidade(nome)values
(
"Brasileiro"
),
(
"Estadunidense"
),
(	
"Espanhol"
),
(
"Argentino"
);

select * from tbl_diretor;
insert into tbl_diretor(
	nome,
    biografia,
    data_nascimento,
    tbl_sexo_id
)values(
	"Andy Muschietti",
    "Andy Muschietti, é um cineasta argentino que alcançou amplo reconhecimento com o filme Mama que ele fez com Neil Cross e sua irmã, produtora e roteirista Barbara Muschietti, baseada em seu curta de três minutos de mesmo nome",
    "1973-08-26",
    2
);

insert into tbl_genero(
	nome
)values(
	'Terror'
),(
	'Suspense'
),(
	'Comédia'
),(
	'Romance'
),(
	'Ação'
),(
	'Ficcção Científica'
),(
	'Documentário'
),(
	'Musical'
),(
	'Aventura'
),(
	'Guerra'
),(
	'Thriller'
),(
	'Animação'
),(
	'Mistério'
),(
	'Drama'
),(
	'Filme Policial'
);

insert into tbl_ator_nacionalidade(
	tbl_nacionalidade,
    tbl_ator_id
)values(
	2,
    1
);

insert into tbl_diretor_nacionalidade(
	tbl_nacionalidade_id,
    tbl_diretor_id
)values(
	4,
    1
);

insert into tbl_filme_diretor(
	id_filme,
    id_diretor
)values(
	1,
    1
);

insert into tbl_filme_ator(
	tbl_filme_id,
    tbl_ator_id
)values(
	1,
    1
);

insert into tbl_filme_genero(
	id_filme,
    id_genero
)values(
	1,
    5
);
