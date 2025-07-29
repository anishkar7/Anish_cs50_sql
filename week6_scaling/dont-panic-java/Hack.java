import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class Hack {

    public static void main(String[] args) throws Exception {
        Connection sqliteConnection = null;
        try {
            sqliteConnection = DriverManager.getConnection("jdbc:sqlite:dont-panic.db");

            Statement sqliteStatement = sqliteConnection.createStatement();

            String sqlQuery = """
                UPDATE "users"
                SET "password" = 'CS50'
                WHERE "username" = 'admin';
            """;
            int rowsAffected = sqliteStatement.executeUpdate(sqlQuery);

            if (rowsAffected > 0) {
                System.out.println("Success! The administrator's password has been altered.");
            } else {
                System.out.println("Operation failed. Administrator user not found.");
            }
            sqliteStatement.close();

        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        } finally {
            if (sqliteConnection != null) {
                sqliteConnection.close();
            }
        }
    }
}
