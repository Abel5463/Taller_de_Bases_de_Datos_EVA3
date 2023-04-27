/*Cursor para contar uno por uno los actores (Muy tonto pero es para ver como funcionana)*/
delimiter //
create procedure contar_actores2(out cant int)
begin
	/*Las variables booleanas son de tipo númerico en sql*/
	declare terminar int default FALSE;
    declare actorid int;
    declare cont_act int;
	declare cant_actores cursor for select actor_id from actor;
    /*No son necesarias las mayúsculas así lo copié del manual de referencia*/
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET terminar = TRUE;
    
    open cant_actores;
    set cont_act = 0;
    
    contar_a: loop
		fetch cant_actores into actorid;
        set cont_act = cont_act + 1;
        if terminar then
			leave contar_a;
        end if;
    end loop;
end//
delimiter ;