DELIMITER //

CREATE FUNCTION generar_rfc(nombre VARCHAR(50), apellido_pat VARCHAR(50), apellido_mat VARCHAR(50), fecha_nac DATE)
RETURNS VARCHAR(15) deterministic
BEGIN
	DECLARE letraNombre VARCHAR(1);
	DECLARE letrasPat VARCHAR(2);
	DECLARE letraMat VARCHAR(1);
	DECLARE año VARCHAR(4);
	DECLARE mes VARCHAR(2);
	DECLARE dia VARCHAR(2);
	DECLARE rfc VARCHAR(15);
	
	SET letraNombre = LEFT(nombre, 1);
	SET letrasPat = LEFT(apellido_pat, 2);
	
	IF apellido_mat IS NULL THEN
		SET letraMat = 'X';
	ELSE
		SET letraMat = LEFT(apellido_mat, 1);
	END IF;
	
	SET año = YEAR(fecha_nac);
	SET mes = MONTH(fecha_nac);
	SET dia = DAY(fecha_nac);
	
	SET rfc = CONCAT(letrasPat, letraMat, letraNombre, año, mes, dia);
	
	RETURN rfc;
END //

DELIMITER ;


/*DELIMITER //

CREATE FUNCTION generar_rfc(id INT) RETURNS VARCHAR(15) DETERMINISTIC
BEGIN
    DECLARE letraNombre VARCHAR(1);
    DECLARE letrasPat VARCHAR(2);
    DECLARE letraMat VARCHAR(1);
    DECLARE año VARCHAR(4);
    DECLARE mes VARCHAR(2);
    DECLARE día VARCHAR(2);
    DECLARE rfc VARCHAR(15);
    
    SELECT SUBSTRING(nombre,1,1) INTO letraNombre FROM personas WHERE id = id;
    SELECT SUBSTRING(apellido_pat,1,2) INTO letrasPat FROM personas WHERE id = id;
    IF apellido_mat IS NULL THEN
		SET letraMat = 'x';
	ELSE
		SELECT SUBSTRING(apellido_mat,1,1) INTO letraMat FROM personas WHERE id = id;
    END IF;
    SELECT YEAR(fecha_nac) INTO año FROM personas WHERE id = id;
    SELECT MONTH(fecha_nac) INTO mes FROM personas WHERE id = id;
    SELECT DAY(fecha_nac) INTO día FROM personas WHERE id = id;
    
    SET rfc = CONCAT(letrasPat, letraMat, letraNombre, año, mes, día);
    
    RETURN rfc;
END //
DELIMITER ;*/


/*
insert into personas(nombre, apellido_pat, apellido_mat, fecha_nac) values('Gabriel','Morales','Ochoa','2002-11-27');
insert into personas(nombre, apellido_pat, fecha_nac) values('Gabriel','Morales','2002-11-27');
*/


