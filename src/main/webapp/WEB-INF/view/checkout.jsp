<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Sonika - Checkout</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <header>
        <h1>Sonika - Checkout</h1>
        <nav><a href="${pageContext.request.contextPath}/CarrelloServlet" style="color: white; text-decoration: none;">Torna al Carrello</a></nav>
    </header>
    
    <div class="container" style="margin-top: 30px;">
        <h2>Dati di Spedizione e Pagamento</h2>
        <form action="${pageContext.request.contextPath}/Checkout" method="post" style="max-width: 500px; margin: 0 auto; display: flex; flex-direction: column; gap: 15px;">
            
            <label>Indirizzo di Spedizione:</label>
            <input type="text" name="indirizzo" required style="padding: 8px;">
            
            <label>Numero Carta di Credito:</label>
            <input type="text" name="carta" required pattern="\d{16}" title="Inserisci 16 cifre" style="padding: 8px;">
            
            <button type="submit" style="background-color: #CC0000; color: white; padding: 10px; border: none; cursor: pointer; font-size: 1.1em; margin-top: 20px;">Conferma Ordine e Paga</button>
        </form>
    </div>
</body>
</html>