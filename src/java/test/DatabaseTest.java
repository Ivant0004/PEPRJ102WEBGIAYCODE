package test;

import context.DBContext;
import java.sql.Connection;

public class DatabaseTest {
    public static void main(String[] args) {
        DBContext dbContext = new DBContext();
        Connection conn = null;
        
        try {
            // Thử kết nối
            conn = dbContext.getConnection();
            System.out.println("Kết nối đến cơ sở dữ liệu QuanLyBanGiay thành công!");
            
            // Kiểm tra thông tin cơ sở dữ liệu (tùy chọn)
            System.out.println("Tên cơ sở dữ liệu: " + conn.getCatalog());
            
        } catch (Exception e) {
            System.err.println("Không thể kết nối đến cơ sở dữ liệu!");
            e.printStackTrace();
        } finally {
            // Đóng kết nối nếu có
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                    System.out.println("Đã đóng kết nối.");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}