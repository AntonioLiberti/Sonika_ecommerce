<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Sonika - Login e Registrazione</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <header>
        <h1>Sonika</h1>
        <nav><a href="${pageContext.request.contextPath}/Home" style="color: white; text-decoration: none;">Torna alla Vetrina</a></nav>
    </header>

    <div class="container" style="display: flex; justify-content: space-around; margin-top: 50px;">
        
       
        <div class="form-box" style="border: 1px solid #ccc; padding: 20px; width: 40%; background-color: #f9f9f9;">
            <h2 style="border-bottom: 2px solid #CC0000; padding-bottom: 10px;">Nuovo Cliente?</h2>
            
            <p style="color: green; font-weight: bold;">${messaggio}</p>
            <p style="color: red; font-weight: bold;">${errore}</p>

            <form action="${pageContext.request.contextPath}/Registrazione" method="post">
                <p>Nome:<br> <input type="text" name="nome" required style="width: 90%; padding: 5px;"></p>
                <p>Cognome:<br> <input type="text" name="cognome" required style="width: 90%; padding: 5px;"></p>
                <p>Email:<br> <input type="email" name="email" required style="width: 90%; padding: 5px;"></p>
                <p>Password:<br> <input type="password" name="password" required style="width: 90%; padding: 5px;"></p>
                <button type="submit" style="background-color: #CC0000; color: white; padding: 10px 20px; border: none; cursor: pointer; margin-top: 10px;">Registrati</button>
            </form>
        </div>


        <div class="form-box" style="border: 1px solid #ccc; padding: 20px; width: 40%; background-color: #f9f9f9;">
            <h2 style="border-bottom: 2px solid #333; padding-bottom: 10px;">Hai già un account?</h2>
            <form action="${pageContext.request.contextPath}/login" method="post">
                <p>Email:<br> <input type="email" name="email" required style="width: 90%; padding: 5px;"></p>
                <p>Password:<br> <input type="password" name="password" required style="width: 90%; padding: 5px;"></p>
                <button type="submit" style="background-color: #333; color: white; padding: 10px 20px; border: none; cursor: pointer; margin-top: 10px;">Accedi</button>
            </form>
        </div>

    </div>
</body>
</html>