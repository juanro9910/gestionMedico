
package rojas.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;


public class ConexionDB {
//    private String host = "localhost";
    private String host = "basedatos-1.clmsosfswjgz.us-east-1.rds.amazonaws.com"; //pdescomentar para AWS
    private int port = 3306;
    private String db = "gestionmedico";
    private String user = "root";
    private String passwd = "8S1sH6Ua5PH";
    private String url = "jdbc:mysql://" + host + ":" + port + "/" + db+"?verifyServerCertificate=false&useSSL=false&serverTimezone=UTC";

    private Connection conexion;

    private static ConexionDB dbInstance;

    public ConexionDB() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.conexion = DriverManager.getConnection(url, user, passwd);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(ConexionDB.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println(ex.getMessage());
        }
    }

    public static ConexionDB getInstance() {
        if (dbInstance == null) {
            dbInstance = new ConexionDB();
        }
        return dbInstance;
    }

    public Connection getConexion() {
        return conexion;
    }

    public void closed() {
        if (conexion != null) {
            try {
                conexion.close();
            } catch (SQLException ex) {
                Logger.getLogger(ConexionDB.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
    
}
