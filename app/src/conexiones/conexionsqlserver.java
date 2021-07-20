
package conexiones;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class conexionsqlserver {
    
    public static Connection getConnection(){
        
        String conexionUrl = "jdbc:sqlserver://localhost:1433;"
                + "database=app_cine;"
                + "user=sa;"
                + "password=123;"
                + "loginTimeout=30;";
        
        try{
            
            Connection con = DriverManager.getConnection(conexionUrl);
            return con;            
        }catch(SQLException ex){
            
            System.out.println(ex.toString());
            return null;
        }
        
    }

}
