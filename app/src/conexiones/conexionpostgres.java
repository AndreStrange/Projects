package conexiones;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
//import javax.swing.JOptionPane;


public class conexionpostgres {
    
    
    
    public static Connection getConnection(){
    
    String conexion = "jdbc:postgresql://localhost:5432/app_cine";
    String pass="123";
    String user="postgres";
    
        try{
            Connection con = DriverManager.getConnection(conexion, user, pass);
            //JOptionPane.showMessageDialog(null, "CONECTADO");
            return con;
        }catch(SQLException ex){
            
          System.out.println(ex.toString());
            return null;
        }
    }
}
