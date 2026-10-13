<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Utente" %>
<%
    Utente utenteLoggato = (Utente) session.getAttribute("utenteLoggato");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sonika - Checkout</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <script src="${pageContext.request.contextPath}/scripts/checkout.js" defer></script>
</head>
<body class="page-bg">
    
    <header class="light-header">
        <a href="${pageContext.request.contextPath}/Home" class="logo-link">
            <h1 class="brand-logo">
                <svg width="28" height="28" viewBox="0 0 24 24" fill="#CC0000" xmlns="http://www.w3.org/2000/svg" class="logo-svg">
                    <rect x="3" y="8" width="4" height="8" rx="2"/>
                    <rect x="10" y="3" width="4" height="18" rx="2"/>
                    <rect x="17" y="8" width="4" height="8" rx="2"/>
                </svg>
                Sonika <span class="header-subtitle">| Checkout</span>
            </h1>
        </a>
        <div class="header-nav">
            <% if (utenteLoggato != null) { %>
                <span class="user-greeting">Ciao, <%= utenteLoggato.getNome() %></span>
            <% } %>
            <a href="${pageContext.request.contextPath}/CarrelloServlet" class="nav-link">&larr; Torna al Carrello</a>
        </div>
    </header>
    
    <div class="checkout-container">
        <h2 class="checkout-header-title">Dati di Spedizione e Pagamento</h2>
        
        <form id="formCheckout" action="${pageContext.request.contextPath}/Checkout" method="post" novalidate>
            <div class="form-group">
                <label for="chkIndirizzo">Indirizzo di Spedizione:</label>
                <input type="text" id="chkIndirizzo" name="indirizzo" placeholder="Es. Via Roma 1, Milano" required>
                <span id="errIndirizzo" class="error-text"></span>
            </div>
            
            <div class="form-group">
                <label for="chkCarta">Numero Carta di Credito:</label>
                <input type="text" id="chkCarta" name="carta" placeholder="1234567812345678" maxlength="16" required>
                <span id="errCarta" class="error-text"></span>
            </div>
            
            <button type="submit" class="btn-pay">Conferma Ordine e Paga</button>
        </form>
    </div>

</body>
</html>