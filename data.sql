insert into clients (name, email, age) values
	('John', 'john@gmail.com', 23),
	('Jenny', 'jenny@gmail.com', 23),
	('Yvan', null, 62),
	('Yvonne', null, 67),
	('Jordy', null, 18)
;

insert into clients (name, email, age) values
	('Bruce', 'bruce@tout.fr', null);

insert into publishers (publisher_name, location) values
('Tac Toc', null),
('Asmodii', null);

-- 'RPG', 'PUZZLE', 'DECK BUILDING'


insert into gameboards (type, age, title, max_nb_players, publisher_id) values
	('DECK BUILDING', null, 'Living Forest', null, (select publisher_id from publishers where publisher_name = 'Tac Toc')),
	('PUZZLE', null, 'Unlock', null, (select publisher_id from publishers where publisher_name = 'Asmodii')),
	('PUZZLE', null, 'Detective', null, (select publisher_id from publishers where publisher_name = 'Asmodii'))
	;

insert into stores (website) values ('https://espritgame.com');

insert into buy (
	client_id,
	store_id,
	gameboard_id,
	date_achat,
	quantite) values
	((select client_id from clients where name = 'John'),
	(select store_id from stores where website = 'https://espritgame.com' ),
	(select gameboard_id from gameboards where title = 'Living Forest'),
	'2010-01-10', 1),
	((select client_id from clients where name = 'John'),
	(select store_id from stores where website = 'https://espritgame.com' ),
	(select gameboard_id from gameboards where title = 'Unlock'),
	'2020-01-20', 3),	
	((select client_id from clients where name = 'Jenny'),
	(select store_id from stores where website = 'https://espritgame.com' ),
	(select gameboard_id from gameboards where title = 'Detective'),
	'2020-01-21', 2),
	((select client_id from clients where name = 'John'),
	(select store_id from stores where website = 'https://espritgame.com' ),
	(select gameboard_id from gameboards where title = 'Living Forest'),
	'2010-01-12', 1)
	;

