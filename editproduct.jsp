<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.ProductDao" %>
<%@ page import="bean.Product" %>
<%@ page import="bean.Brands" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.*, java.sql.*" %>
<%
    // Check if user is logged in
    HttpSession httpSession = request.getSession();
    if (httpSession == null || httpSession.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Retrieve product ID from request parameter
    int productId = Integer.parseInt(request.getParameter("id"));
    
    // Retrieve product details using ProductDao
    ProductDao productDao = new ProductDao();
    Product product = productDao.getProductById(productId);
    
    // Redirect to products.jsp if product not found
    if (product == null) {
        response.sendRedirect("products.jsp");
        return;
    }
    
    // Retrieve all brands
    List<Brands> brands = productDao.getAllBrands();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Product - <%= product.getName() %></title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4">Edit Product - <%= product.getName() %></h2>
        <form action="updateProduct.jsp" method="post">
            <input type="hidden" name="id" value="<%= product.getId() %>">
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" class="form-control" id="name" name="name" value="<%= product.getName() %>" required>
            </div>
            <div class="form-group">
                <label for="brand">Brand:</label>
                <select class="form-control" id="brand" name="brand" required>
                    <% for (Brands brand : brands) { %>
                        <option value="<%= brand.getId() %>" <%= brand.getId() == product.getBrand_id() ? "selected" : "" %>>
                            <%= brand.getBrand_name() %>
                        </option>
                    <% } %>
                </select>
            </div>
            <div class="form-group">
                <label for="price">Price:</label>
                <input type="number" step="0.01" class="form-control" id="price" name="price" value="<%= product.getPrice() %>" required>
            </div>
            <div class="form-group">
                <label for="color">Color:</label>
                <input type="text" class="form-control" id="color" name="color" value="<%= product.getColor() %>" required>
            </div>
            <div class="form-group">
                <label for="specification">Specification:</label>
                <textarea class="form-control" id="specification" name="specification" required><%= product.getSpecification() %></textarea>
            </div>
            <div class="form-group">
                <label for="image_url">Image URL:</label>
                <input type="text" class="form-control" id="image_url" name="image_url" value="<%= product.getImage() %>" required>
            </div>
            <button type="submit" class="btn btn-primary">Update</button>
        </form>
    </div>

    <!-- Bootstrap JS (optional) -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
