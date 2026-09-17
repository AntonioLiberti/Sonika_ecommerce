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
                Context initCtx = new InitialContext();
                Context envCtx = (Context) initCtx.lookup("java:comp/env");
                // Cerca esattamente il nome definito nel tuo context.xml
                datasource = (DataSource) envCtx.lookup("jdbc/sonika");
            } catch (NamingException e) {
                System.out.println("Errore JNDI: Controlla il file context.xml in META-INF");
                e.printStackTrace();
                throw new SQLException("Impossibile trovare il DataSource: " + e.getMessage());
            }
        }
        return datasource.getConnection();
    }
}