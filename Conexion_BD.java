/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package taller_bases_de_datos;

import java.util.logging.Level;
import java.util.logging.Logger;
//Para la conexión
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
//Para ejecutar instrucciones
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
//Llamada a función
import java.sql.CallableStatement;
import java.sql.Types;
import java.time.LocalDate;



/**
 *
 * @author moral
 */
public class Conexion_BD {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        //SOLO NOS CONECTAMOS UNA VEZ AL SERVIDOR
        //Esto debería estar en una clase conexión pero lo vamos a poner todo 
        //aquí por comodidad y para la explicación
        Connection connection;
        try{
            //CARGAMOS LA LIBRERIA JDBC
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            //CONEXION
            String url = "jdbc:mysql://localhost:3306/eva3";
            connection = DriverManager.getConnection(url,"root", "root");
            
            /* ---------------------1er Practica--------------------------------------
            //CONSULTA SQL
            Statement statement = connection.createStatement();{
            //OBTENER UN RESULTSET (un listado de filas)
            ResultSet resultSet;
            resultSet = statement.executeQuery(
                    "select * from actor limit 50;"
            );
            --------------------------------------------------------------------------*/
            
            //Comodín (?) son para sustituirlos al final de instrucción
            /*? soin comodines, se numeran en la secuencia que aparecen en el query.
            A traves de statement.setType(posicion, valor) se cambia el comodín 
            en la posición indicada por el valor*/
            String query = "select * from actor where actor_id = ?;";
            //En los parentesis va el query SQL
            PreparedStatement pStatement = connection.prepareStatement(query); 
            //Aquí sustituimos el primer comodín por 152
            //No es como en los arreglos el primer comodín es el número 1
            pStatement.setInt(1, 152);            
            
            ResultSet resultSet;
            resultSet = pStatement.executeQuery();
            
            //Ejecutar un insert
            String qInsert = "insert into actor(first_name, last_name)" + "values(?,?)";
            PreparedStatement psInsert = connection.prepareStatement(qInsert);
            psInsert.setString(1,"Mario");
            psInsert.setString(2,"Moreno");
            psInsert.execute();
                        
            int actor_id;
            String f_name;
            String l_name;
            
            while(resultSet.next()){//true mientras haya datos
                actor_id = resultSet.getInt("actor_id");
                f_name = resultSet.getString("first_name");
                l_name = resultSet.getString("last_name");
                System.out.println("ID: " + actor_id + "\n" +
                "First name: " + f_name + "\n" + 
                "Last name: " + l_name + "\n");
            }
            
            //LLAMAR A FUNCIÓN / PROCEDIMIENTO
            CallableStatement callStat = connection.prepareCall(
            "? = call generar_rfc(?,?,?,?)"
            );
            //PARAMETRO DE SALIDA
            callStat.registerOutParameter(1, Types.VARCHAR);
            //PARAMETROS DE ENTRADA
            callStat.setString(2, "Juan");
            callStat.setString(3, "Perez");
            callStat.setString(4, "Jolote");
            callStat.setObject(5, LocalDate.of(2004,11,20));
            callStat.execute();
            System.out.println("RFC: " + callStat.getString(1));
            
            
        }catch(ClassNotFoundException ex){
            ex.printStackTrace();
        } catch (SQLException ex) {
            Logger.getLogger(Conexion_BD.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("SQLEception: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("Error: " + ex.getErrorCode());
        }
    }
    
}
