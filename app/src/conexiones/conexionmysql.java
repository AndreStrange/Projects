
package conexiones;

import com.mysql.jdbc.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Andrés
 */
public class conexionmysql {
    
    private static Connection conn;
    private static final String DRIVER = "com.mysql.jdbc.Driver";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    private static final String URL = "jdbc:mysql://localhost:3306/app_cine";
        
    public conexionmysql() {
    conn=null;
    try{
        Class.forName(DRIVER);
        
        conn =  (Connection) DriverManager.getConnection(URL, USER, PASSWORD);
        if(conn!=null){
            System.out.println("Conexión Establecida");
        }
    }   catch (ClassNotFoundException | SQLException e){
        
            System.out.println("Error al conectar" + e);
        
        }

}
    //Retornar Conexión
    public Connection getConnection(){
        return conn;        
    }
    
    
    //Dc DB
    public void desconectar(){
        
        conn = null;
        if(conn == null){
            System.out.println("Conexión Terminada");
        }
        
    }
    
}
