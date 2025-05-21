package context;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBContext {

    // Thông tin kết nối đến cơ sở dữ liệu
    private final String serverName = "localhost";      // Tên server
    private final String dbName = "QuanLyBanGiay";      // Tên database
    private final String portNumber = "1433";           // Cổng kết nối mặc định của SQL Server
    private final String sqlInstance = "";              // Nếu là Single Instance, để trống
    private final String userID = "sa";                 // Tài khoản đăng nhập SQL Server
    private final String password = "123";              // Mật khẩu đăng nhập SQL Server

    /**
     * Phương thức kết nối đến cơ sở dữ liệu.
     * 
     * @return Connection đối tượng kết nối đến cơ sở dữ liệu.
     * @throws Exception nếu không kết nối được (sai thông tin hoặc SQL Server không chạy).
     */
    public Connection getConnection() throws Exception {
        // Tạo URL kết nối dựa trên các biến
        String url = "jdbc:sqlserver://" + serverName + ":" + portNumber;
        
        // Nếu có instance, thêm vào URL
        if (sqlInstance != null && !sqlInstance.trim().isEmpty()) {
            url += "\\" + sqlInstance;
        }
        
        // Thêm databaseName vào URL
        url += ";databaseName=" + dbName;

        // Nạp Driver của SQL Server
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

        // Kết nối và trả về đối tượng Connection
        return DriverManager.getConnection(url, userID, password);
    }
}