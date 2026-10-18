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
    <title>Sonika - Ordine Confermato</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/conferma.css">
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
                Sonika
            </h1>
        </a>
        <div class="header-nav">
            <% if (utenteLoggato != null) { %>
                <span class="user-greeting">Ciao, <%= utenteLoggato.getNome() %></span>
            <% } %>
            <a href="${pageContext.request.contextPath}/Home" class="nav-link">Torna alla Vetrina</a>
        </div>
    </header>

    <div class="success-container">
        <div class="success-icon">✓</div>
        <h2 class="success-title">Pagamento andato a buon fine!</h2>
        <div class="success-msg">
            Grazie per il tuo acquisto.<br>
            Il tuo ordine è stato registrato ed è attualmente in fase di elaborazione.
        </div>

        <div class="order-number">
            Numero d'ordine: <strong>${idOrdine}</strong>
        </div>

        <div>
            <a href="${pageContext.request.contextPath}/Home" class="btn-home">Torna agli acquisti</a>
        </div>
    </div>
</body>
</html>