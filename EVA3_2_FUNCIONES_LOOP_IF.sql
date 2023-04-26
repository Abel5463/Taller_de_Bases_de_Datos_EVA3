/*Cuestiones relativas a los datos de la base de datos es mejor hacerlas con procedimientos
almacenados en vez de con funciones pero este ejemplo es para seguir con funciones
Estas cuestiones serían agregar, actualizar, eliminar, etc.*/

/*Todas las funciones regresan un valor por lo que no podemos omitir el return*/
delimiter //
create function agregar_actor(first_name varchar(45), last_name varchar(45))
returns int deterministic modifies sql data
begin
	declare num int;
    declare num2 int;
    declare resu int;
    declare id int;
    
    select max(actor_id) into id from actor;
    set id = id + 1;
    select count(*) into num from actor;
	insert into actor(actor_id, first_name, last_name)
    values(id, first_name, last_name);
    select count(*) into num2 from actor;
    /*Para realizar una operación aritmetica usamos el "set"*/
    set resu = num2 - num;
    return resu;
end//
delimiter ;

/*En la terminal drop function nombre_de_la_función 
Esto para eliminar funciones*/

/*LOOP (Cíclos)*/
/*Función para devolver un factorial*/

delimiter //
create function factorial(num int)
returns int deterministic
begin
	declare resu int;
    set resu = 1;    
	facto: loop
		set resu = resu * num;
        set num = num - 1;
        if num = 1 then 
			leave facto;
        end if;
    end loop facto;
    return resu;
end//
delimiter ;
