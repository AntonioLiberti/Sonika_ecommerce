package model;

import com.mysql.cj.jdbc.MysqlDataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class ConPool {
    private static MysqlDataSource dataSource;

    public static Connection getConnection() throws SQLException {
        if (dataSource == null) {
            dataSource = new MysqlDataSource();
            dataSource.setServerName("localhost");
            dataSource.setPortNumber(3306);
            dataSource.setDatabaseName("sonika_ecommerce");
            dataSource.setUser("root");
            dataSource.setPassword(""); // XAMPP di base non ha password
            
            // Risolve eventuali problemi di fuso orario del server
            dataSource.setServerTimezone("Europe/Rome");
        }
        return dataSource.getConnection();
    }
}
