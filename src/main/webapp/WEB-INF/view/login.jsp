<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Sonika</title>
</head>
<body>
    <h2>Accesso Area Riservata</h2>
    <p style="color:red;">${errore}</p>
    <form action="${pageContext.request.contextPath}/login" method="post">
        <label>Email:</label>
        <input type="email" name="email" required><br><br>
        
        <label>Password:</label>
        <input type="password" name="password" required><br><br>
        
        <button type="submit">Entra</button>
    </form>
</body>
</html>