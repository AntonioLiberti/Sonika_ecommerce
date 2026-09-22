<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Sonika - Ordine Confermato</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <header>
        <h1>Sonika - Conferma</h1>
        <nav><a href="${pageContext.request.contextPath}/Home" style="color: white; text-decoration: none;">Torna alla Vetrina</a></nav>
    </header>
    
    <div class="container" style="margin-top: 50px; text-align: center;">
        <h2 style="color: #333333;">Pagamento andato a buon fine!</h2>
        <p>Grazie per il tuo acquisto.</p>
        <p>Il tuo numero d'ordine è: <strong>${idOrdine}</strong></p>
        
        <a href="${pageContext.request.contextPath}/Home" style="display: inline-block; margin-top: 20px; padding: 10px 20px; background-color: #CC0000; color: white; text-decoration: none; border-radius: 3px;">Torna agli acquisti</a>
    </div>
</body>
</html>