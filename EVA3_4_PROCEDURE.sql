/*CURSORES 
Los cursores en SQL Server pueden definirse como un elemento que representará 
a un conjunto de datos determinado por una consulta T-SQL. Los cursores permiten recorrer 
fila a fila, leer y eventualmente modificar dicho conjunto de resultados.
*/
/*inout permite recibir y mandar datos con el procedimiento*/
DELIMITER //
create procedure listaCorreos(inout correos varchar(5000))
begin
	/*Los declare deben ser lo primero del programa*/
	/*Los handler y cursores se ponen al final de la declración de variables */
	declare correo varchar(50);
	declare terminar int default false;
	/*cursor es un tipo de datos*/
	declare lista_clientes cursor for
		select email from customer limit 100;
        /*Cuando se genere la excepcion not found cambiamos la variable terminar
        a verdadero para terminar el ciclo*/
	declare continue handler for NOT FOUND set terminar = true;
    
    
    open lista_clientes;
    obten_correos: loop
		fetch lista_clientes into correo;
        if terminar then
			leave obten_correos;
		end if;
        set correos = concat(correo, "; " ,correos);
    end loop obten_correos;
end//
DELIMITER ;