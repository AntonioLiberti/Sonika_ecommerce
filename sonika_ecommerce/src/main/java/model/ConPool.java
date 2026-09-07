package model;

import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ConPool {
    private static DataSource datasource;

    public static Connection getConnection() throws SQLException {
        if (datasource == null) {
            try {
                // Va a cercare il DataSource configurato in Tomcat (context.xml)
                Context initCtx = new InitialContext();
                Context envCtx = (Context) initCtx.lookup("java:comp/env");
                datasource = (DataSource) envCtx.lookup("jdbc/sonika");
            } catch (NamingException e) {
                e.printStackTrace();
                throw new SQLException("Errore JNDI: impossibile trovare il DataSource configurato in Tomcat.");
            }
        }
        return datasource.getConnection();
    }
}