DELIMITER //

CREATE PROCEDURE actualizar_rfc()
BEGIN
	DECLARE contador INT DEFAULT 0;
	
	UPDATE personas SET clave_rfc = generar_rfc(nombre, apellido_pat, apellido_mat, fecha_nac)
	WHERE clave_rfc IS NULL;
	SET contador = ROW_COUNT();	
	
	SELECT CONCAT('Se actualizaron ', contador, ' registros') AS mensaje;
END //

DELIMITER ;


/*DELIMITER //

CREATE PROCEDURE actualizar_rfc()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE clave INT;
    DECLARE nombre VARCHAR(50);
    DECLARE apellido_pat VARCHAR(50);
    DECLARE apellido_mat VARCHAR(50);
    DECLARE fecha_nac DATE;
    DECLARE rfc VARCHAR(15);
    DECLARE cur CURSOR FOR SELECT id, nombre, apellido_pat, apellido_mat, fecha_nac FROM personas WHERE clave_rfc IS NULL;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO clave, nombre, apellido_pat, apellido_mat, fecha_nac;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SET rfc = generar_rfc(nombre, apellido_pat, apellido_mat, fecha_nac);
        UPDATE personas SET clave_rfc = rfc WHERE id = clave;
    END LOOP;

    CLOSE cur;
END //

DELIMITER ;*/


/*DELIMITER //

CREATE PROCEDURE actualizar_rfc()
BEGIN
    DECLARE terminar INT DEFAULT FALSE;
    DECLARE clave INT;
    DECLARE nombre VARCHAR(50);
    DECLARE apellidoPat VARCHAR(50);
    DECLARE apellidoMat VARCHAR(50);
    DECLARE fechaNac DATE;
    DECLARE rfc VARCHAR(15);
    
    DECLARE listaClientes CURSOR FOR
        SELECT id, nombre, apellido_pat, apellido_mat, fecha_nac
        FROM personas;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET terminar = TRUE;
    
    OPEN listaClientes;
    
    datos: LOOP
        FETCH listaClientes INTO clave, nombre, apellidoPat, apellidoMat, fechaNac;
        IF terminar THEN
            LEAVE datos;
        END IF;
        
        SET rfc = generar_rfc(nombre, apellidoPat, apellidoMat, fechaNac);
        
        UPDATE personas
        SET clave_rfc = rfc
        WHERE id = clave;
    END LOOP datos;
    
    CLOSE listaClientes;
END //

DELIMITER ;*/



/*DELIMITER //
create procedure llenarRFC()
begin
    declare clave int;
    declare nombre varchar(50);
    declare apellidoPat varchar(50);
    declare apellidoMat varchar(50);
    declare fecha_nac date;
    declare nuevo_rfc varchar(50);
    declare terminar int default false;
    declare lista_clientes cursor for    
        select id, nombre, apellido_pat, apellido_mat, fecha_nac from personas;
    declare continue handler for NOT FOUND set terminar = true;
    
    open lista_clientes;
    datos: loop
        fetch lista_clientes into clave, nombre, apellidoPat, apellidoMat, fecha_nac;
        select generar_rfc(clave, nombre, apellidoPat, apellidoMat, fecha_nac) into nuevo_rfc;
        update personas
        set clave_rfc = nuevo_rfc
        where id = clave;
        if terminar = true then
            leave datos;
        end if;
    end loop datos;
    close lista_clientes;    
END //
DELIMITER ;*/
