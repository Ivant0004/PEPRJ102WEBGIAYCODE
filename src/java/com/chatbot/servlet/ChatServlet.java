package com.chatbot.servlet;

import dao.DAO;
import entity.Product;
import entity.Category;
import com.chatbot.model.ChatMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ChatServlet", urlPatterns = {"/chat"})
public class ChatServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/chat.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userMessage = request.getParameter("message");

        if (userMessage != null && !userMessage.trim().isEmpty()) {
            HttpSession session = request.getSession();
            List<ChatMessage> chatHistory = (List<ChatMessage>) session.getAttribute("chatHistory");
            if (chatHistory == null) {
                chatHistory = new ArrayList<>();
                session.setAttribute("chatHistory", chatHistory);
            }

            chatHistory.add(new ChatMessage(userMessage, "user"));

            String aiResponse = generateAIResponse(userMessage);
            chatHistory.add(new ChatMessage(aiResponse, "ai"));

            if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                response.setContentType("application/json");
                response.getWriter().write("{\"message\": \"" + 
                    aiResponse.replace("\"", "\\\"").replace("\n", "\\n") + "\"}");
                return;
            }
        }

        request.getRequestDispatcher("/WEB-INF/chat.jsp").forward(request, response);
    }

private String generateAIResponse(String userMessage) {
    if (userMessage == null || userMessage.trim().isEmpty()) {
        return "Xin chào! Bạn có thể hỏi tôi về các loại giày, giá cả hoặc sản phẩm bán chạy.";
    }

    String lowerCaseMessage = userMessage.trim().toLowerCase();
    DAO productDAO = new DAO();

    // Xử lý các câu hỏi về cửa hàng
    if (lowerCaseMessage.contains("mua giày ở đâu") || 
        lowerCaseMessage.contains("mua ở đâu") || 
        lowerCaseMessage.contains("nơi nào tốt nhất")) {
        return "Chào mừng bạn đến với Shoes Family - thế giới của những đôi giày hoàn hảo! " +
               "Hãy để chúng tôi giúp bạn tìm được đôi giày ưng ý nhất hôm nay! Bạn đang quan tâm đến kiểu giày nào?";
    }

    // Xử lý tìm kiếm sản phẩm
    if (lowerCaseMessage.contains("tìm") || lowerCaseMessage.contains("search")) {
    try {
        return searchProducts(userMessage, productDAO);
    } catch (SQLException e) {
        e.printStackTrace();
        return "Xin lỗi, tôi gặp lỗi khi tìm kiếm sản phẩm. Vui lòng thử lại!";
    }
}


    // Xử lý các thương hiệu giày
    try {
        switch (lowerCaseMessage) {
            case "nike":
            case "chạy bộ":
                return suggestProducts(productDAO.getProductByCID("2"), "giày Nike");
            case "adidas":
            case "running":
                return suggestProducts(productDAO.getProductByCID("1"), "giày Adidas");
            case "bitis":
            case "thời trang":
                return suggestProducts(productDAO.getProductByCID("3"), "giày Bitis");
            case "converse":
            case "cổ điển":
                return suggestProducts(productDAO.getProductByCID("4"), "giày Converse");
        }

        // Sản phẩm bán chạy
        if (lowerCaseMessage.contains("bán chạy") || lowerCaseMessage.contains("best seller")) {
            return suggestBestSellers(productDAO);
        }

        // Sản phẩm mới
        if (lowerCaseMessage.contains("mới") || lowerCaseMessage.contains("new")) {
            return suggestProducts(productDAO.get8Last(), "giày mới nhất 2025");
        }

        // Sản phẩm theo giá
        if (lowerCaseMessage.contains("giá") || lowerCaseMessage.contains("price")) {
            return suggestProductsByPrice(lowerCaseMessage, productDAO);
        }

        // Danh mục sản phẩm
        if (lowerCaseMessage.contains("danh mục") || lowerCaseMessage.contains("category")) {
            return listCategories(productDAO);
        }

    } catch (SQLException e) {
        e.printStackTrace();
        return "Xin lỗi, tôi gặp lỗi khi truy vấn dữ liệu. Vui lòng thử lại!";
    }

    // Câu trả lời mặc định nếu không nhận diện được yêu cầu
    return "Xin chào! Tôi có thể giúp bạn tìm giày Nike, Adidas, Bitis hoặc Converse. " +
           "Bạn muốn mua hãng giày nào hôm nay? (Gõ 'danh mục' để xem tất cả các hãng giày)";
}

    private String suggestProducts(List<Product> products, String category) {
        if (products == null || products.isEmpty()) {
            return "Hiện tại không có sản phẩm nào trong danh mục " + category + ".";
        }

        StringBuilder response = new StringBuilder("Dưới đây là một số " + category + " nổi bật:\n");
        int count = Math.min(3, products.size());
        for (int i = 0; i < count; i++) {
            Product product = products.get(i);
            response.append("- ").append(product.getName())
                    .append(": Giá ").append(product.getPrice()).append(" $")
                    .append(" (Màu: ").append(product.getColor())
                    .append(", Model: ").append(product.getModel())
                    .append(", ").append(product.getDescription()).append(")\n");
        }
        response.append("Bạn muốn biết thêm về đôi giày nào?");
        return response.toString();
    }

    private String suggestBestSellers(DAO productDAO) throws SQLException {
        List<entity.SoLuongDaBan> bestSellers = productDAO.getTop10SanPhamBanChay();
        if (bestSellers == null || bestSellers.isEmpty()) {
            return "Hiện tại không có sản phẩm bán chạy nào.";
        }

        List<Product> products = new ArrayList<>();
        for (int i = 0; i < Math.min(3, bestSellers.size()); i++) {
            Product product = productDAO.getProductByID(String.valueOf(bestSellers.get(i).getProductID()));
            if (product != null) {
                products.add(product);
            }
        }

        if (products.isEmpty()) {
            return "Không tìm thấy thông tin chi tiết về các sản phẩm bán chạy.";
        }

        StringBuilder response = new StringBuilder("Dưới đây là một số giày bán chạy nhất:\n");
        for (Product product : products) {
            response.append("- ").append(product.getName())
                    .append(": Giá ").append(product.getPrice()).append(" VNĐ")
                    .append(" (Màu: ").append(product.getColor()).append(")\n");
        }
        response.append("Bạn muốn biết thêm về đôi giày nào?");
        return response.toString();
    }

    private String suggestProductsByPrice(String message, DAO productDAO) throws SQLException {
        double priceFrom = extractPrice(message, "từ", "from");
        double priceTo = extractPrice(message, "đến", "to");

        List<Product> filteredProducts;
        if (priceFrom > 0 && priceTo > 0) {
            filteredProducts = productDAO.searchByPriceMinToMax(String.valueOf(priceFrom), String.valueOf(priceTo));
        } else if (priceFrom > 0) {
            filteredProducts = productDAO.getAllProduct().stream()
                    .filter(p -> p.getPrice() >= priceFrom)
                    .collect(java.util.stream.Collectors.toList());
        } else if (priceTo > 0) {
            filteredProducts = productDAO.getAllProduct().stream()
                    .filter(p -> p.getPrice() <= priceTo)
                    .collect(java.util.stream.Collectors.toList());
        } else {
            return "Vui lòng cung cấp khoảng giá cụ thể (ví dụ: 'giá từ 500 đến 1000')!";
        }

        if (filteredProducts.isEmpty()) {
            return "Không tìm thấy đôi giày nào trong khoảng giá bạn yêu cầu.";
        }

        StringBuilder response = new StringBuilder("Dưới đây là các đôi giày trong khoảng giá:\n");
        int count = Math.min(3, filteredProducts.size());
        for (int i = 0; i < count; i++) {
            Product product = filteredProducts.get(i);
            response.append("- ").append(product.getName())
                    .append(": Giá ").append(product.getPrice()).append(" VNĐ")
                    .append(" (Màu: ").append(product.getColor()).append(")\n");
        }
        response.append("Bạn muốn biết thêm về đôi giày nào?");
        return response.toString();
    }

    private String searchProducts(String message, DAO productDAO) throws SQLException {
        String[] words = message.split("\\s+");
        String searchTerm = "";
        for (String word : words) {
            if (!word.equalsIgnoreCase("tìm") && !word.equalsIgnoreCase("search")) {
                searchTerm += word + " ";
            }
        }
        searchTerm = searchTerm.trim();

        if (searchTerm.isEmpty()) {
            return "Vui lòng cung cấp từ khóa để tìm kiếm giày!";
        }

        List<Product> matchedProducts = productDAO.searchByName(searchTerm);
        if (matchedProducts.isEmpty()) {
            return "Không tìm thấy đôi giày nào với từ khóa '" + searchTerm + "'.";
        }

        StringBuilder response = new StringBuilder("Kết quả tìm kiếm cho '" + searchTerm + "':\n");
        int count = Math.min(3, matchedProducts.size());
        for (int i = 0; i < count; i++) {
            Product product = matchedProducts.get(i);
            response.append("- ").append(product.getName())
                    .append(": Giá ").append(product.getPrice()).append(" VNĐ")
                    .append(" (Màu: ").append(product.getColor()).append(")\n");
        }
        response.append("Bạn muốn biết thêm về đôi giày nào?");
        return response.toString();
    }

    private String listCategories(DAO productDAO) throws SQLException {
        List<Category> categories = productDAO.getAllCategory();
        if (categories == null || categories.isEmpty()) {
            return "Hiện tại không có danh mục giày nào.";
        }

        StringBuilder response = new StringBuilder("Danh sách các danh mục giày tại Shoes Family:\n");
        for (Category category : categories) {
            response.append("- ").append(category.getCname()).append(" (ID: ").append(category.getCid()).append(")\n");
        }
        response.append("Bạn muốn xem giày trong danh mục nào? Hãy cung cấp tên hoặc ID danh mục!");
        return response.toString();
    }

    private double extractPrice(String message, String fromKeyword, String alternativeKeyword) {
        String[] words = message.split("\\s+");
        for (int i = 0; i < words.length - 1; i++) {
            if (words[i].equalsIgnoreCase(fromKeyword) || words[i].equalsIgnoreCase(alternativeKeyword)) {
                try {
                    return Double.parseDouble(words[i + 1]);
                } catch (NumberFormatException e) {
                    return 0;
                }
            }
        }
        return 0;
    }
}