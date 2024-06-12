-- Noms des clients qui ont un age > 20

select * from clients where age > 20;

-- Noms de clients ayant commandé le jeu de société ayant pour id 2

-- Join

select * from clients join buy using(client_id) where gameboard_id = 2;

select * from clients natural join buy where gameboard_id = 2;

select * from clients where client_id in (select client_id from buy where gameboard_id = 2);

select client_id from clients
intersect
select client_id from buy where gameboard_id = 2;

-- Noms de clients ayant commandé un jeu de société pour 2 joueurs

select distinct clients.name, clients.email, clients.age from clients natural join buy join gameboards using(gameboard_id) where gameboards.max_nb_players = 2;

select name, email, age from clients where client_id in (
	select client_id from buy where gameboard_id in (
		select gameboard_id from gameboards where max_nb_players = 2
	)
);



-- Types de jeu commandés par Jenny

select type from gameboards join buy using(gameboard_id) join clients using(client_id) where clients.name = 'Jenny';

-- Noms des clients ayant commandé au moins un jeu

select distinct clients.name, clients.email from clients natural join buy;

-- Noms des clients n'ayant jamais commandé de jeu

-- Algèbre relationnel

select clients.name, clients.email from clients
EXCEPT
select distinct clients.name, clients.email from clients natural join buy;

-- Jointure Externe

select distinct clients.name, clients.email from clients left join buy using(client_id) where date_achat is null;

-- Noms des clients ayant commandé un jeu de rôle ou un puzzle

select distinct clients.name from clients natural join buy join gameboards using(gameboard_id) where type in ('RPG', 'PUZZLE');

-- Clients n'ayant pas commandé 3 jeux de société (donc 2, 1 ou 0)
select clients.name, clients.email from clients
EXCEPT
select clients.name, clients.email from clients natural join (select client_id, sum(quantite) from clients natural join buy group by client_id having sum(quantite) >= 3) as c;

select clients.name, clients.email from clients natural join (select client_id, coalesce(sum(quantite),0) from clients left join buy using(client_id) group by client_id having coalesce(sum(quantite),0) < 3) as c;


-- Clients ayant commandé au moins 2 jeux de société

select client_id, sum(quantite) from clients natural join buy group by client_id having sum(quantite) >= 3


-- Clients qui ont un âge > 50 et qui n’ont pas commmandé un jeu de société pour 2 joueurs



-- Clients qui ont commandé tous les jeux de société

select client_id, count(distinct gameboard_id) from clients join buy using(client_id) group by client_id

select 
	client_id,
	count(distinct gameboard_id) as nb_distinct_games_bought,
	(
	select
		count(*)
	from
		gameboards) - count(distinct gameboard_id) nb_remaining_games_to_buy
from
	clients
join buy
		using(client_id)
group by
	client_id
having
	(
	select
		count(*)
	from
		gameboards) - count(distinct gameboard_id) = 0
order by
	client_id;

-- add some buy

insert into buy (
	client_id,
	store_id,
	gameboard_id,
	date_achat,
	quantite) values
	((select client_id from clients where name = 'Bruce'),
	(select store_id from stores where website = 'https://espritgame.com' ),
	(select gameboard_id from gameboards where title = 'Living Forest'),
	'2010-01-10', 4),
	((select client_id from clients where name = 'Bruce'),
	(select store_id from stores where website = 'https://espritgame.com' ),
	(select gameboard_id from gameboards where title = 'Unlock'),
	'2010-01-10', 4),
	((select client_id from clients where name = 'Bruce'),
	(select store_id from stores where website = 'https://espritgame.com' ),
	(select gameboard_id from gameboards where title = 'Detective'),
	'2010-01-10', 4);

select count(*) from gameboards;

-- Division de buy par gameboard pour trouver tous les clients ayant commandé tous les jeux

-- calculer toutes les solutions possibles
-- CROSS JOIN
-- retirer les cas qui se sont réalisés
-- EXCEPT

select client_id from clients except
select client_id from (
	select client_id, gameboard_id from clients cross join gameboards
	except
	select client_id, gameboard_id from buy
);
-- le résultat contient les clients qui n'ont pas tout acheté


-- refaire une différence pour obtenir les clients qui ont tout acheté
-- EXCEPT


-- Noms de client qui ont commandé tous les jeux de société de “deck building”