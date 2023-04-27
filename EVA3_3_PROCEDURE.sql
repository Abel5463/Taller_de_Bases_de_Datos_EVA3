/*Los procedimientos nos permiten ejecutar casi cualquier cosa al contrario que las funciones
Las funciones regresan valor pero los procedimientos no*/
delimiter //
create procedure consultar_actores()
begin
	select * from actor;
end//
delimiter ;

/*Ahora consultamos solo un actor*/
/*el "in" antes de actorid significa que es un dato de entrada, se deben de indicar si los argumentos
son de entrada (in) salida (out) o ambos*/
delimiter //
create procedure consultar_actor(in actorid int)
begin
	select * from actor
    where actor_id = actorid;
end//
delimiter ;

/*Consultamos la cantidad de actores*/
/*Usando la consola ponemos: 
call cantidad_actores(@cant);
select @cant;
Así creamos una variable temporal cant que podemos hacerle un select para ver su valor*/
delimiter //
create procedure cantidad_actores(out cant int)
begin
	select count(*) into cant from actor;
end//
delimiter ;

/*Agregar actor*/
delimiter //
create procedure agregar_actor(in actorid int, in fname varchar(50), in lname varchar(50))
begin
	insert into actor(actor_id, first_name, last_name)
    values(actorid, fname, lname);
end//
delimiter ;

/*FUNCION ultimo id de actor*/
delimiter //
create function ultimo_actorid()
returns int deterministic reads sql data
begin
	declare actorid int;
    select max(actor_id) into actorid from actor;
    return actorid;
end//
delimiter ;

/*Nuevo actor pero sin solicitar id*/
delimiter //
create procedure agregar_actor2(in fname varchar(50), in lname varchar(50))
begin
	declare actorid int;
    select ultimo_actorid() into actorid;
    set actorid = actorid + 1;
    
	insert into actor(actor_id, first_name, last_name)
    values(actorid, fname, lname);
end//
delimiter ;

/*Borrar y actualizar actores*/
delimiter //
create procedure borrar_actor(in actorid int)
begin
	delete from actor 
    where actor_id = actorid;
end;

create procedure actualizar_actor(in actorid int, in fname varchar(50), in lname varchar(50))
begin
	update actor 
    set first_name = fname,
    last_name = lname
    where actor_id = actorid;
end//
delimiter ;