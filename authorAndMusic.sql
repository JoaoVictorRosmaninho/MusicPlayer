create database Music;

use Music;

create table User (
	id int not null auto_increment,
	login varchar(45),
	senha varchar(45),

	constraint pk_user primary key(id)
);


create table Musica (
	id int not null auto_increment,
    nome varchar(45),
    author varchar(45), 
    imagePath varchar(100),
    musicPath varchar(100),
    
    constraint pk_musica primary key (id)
);

