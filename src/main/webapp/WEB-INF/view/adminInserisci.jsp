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
    <title>Sonika - Nuovo Prodotto</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/adminInserisci.css">
    <script src="${pageContext.request.contextPath}/scripts/adminValidazione.js" defer></script>
</head>
<body class="page-bg">
    
    <header class="light-header">
        <a href="${pageContext.request.contextPath}/Admin" class="logo-link">
             <h1 class="brand-logo">
                <svg width="28" height="28" viewBox="0 0 24 24" fill="#CC0000" xmlns="http://www.w3.org/2000/svg" class="logo-svg">
                    <rect x="3" y="8" width="4" height="8" rx="2" />
                    <rect x="10" y="3" width="4" height="18" rx="2" />
                    <rect x="17" y="8" width="4" height="8" rx="2" />
                </svg>
                Sonika
                <span class="header-subtitle">| Area Admin</span>
            </h1>
        </a>
        <div class="header-nav">
            <% if (utenteLoggato != null) { %>
                <span class="user-greeting">Ciao, <%= utenteLoggato.getNome() %></span>
            <% } %>
            <a href="${pageContext.request.contextPath}/Admin" class="nav-link">&larr; Torna al Catalogo</a>
            <a href="${pageContext.request.contextPath}/login?action=logout" class="nav-link logout-link">Logout</a>
        </div>
    </header>
    
    <div class="form-container">
        <h2 class="form-title">Aggiungi Nuovo Prodotto</h2>
        <form action="${pageContext.request.contextPath}/AdminInserisci" method="post" enctype="multipart/form-data" id="formProdotto" novalidate>
    
            <div class="form-group">
                <label>Nome Prodotto:</label>
                <input type="text" id="prodNome" name="nome" required>
                <span id="errNome" class="error-text"></span>
            </div>
           
            <div class="form-group">
                <label>Immagine Prodotto:</label>
                <input type="file" id="prodImmagine" name="immagine" accept="image/*" required class="file-input">
                <span id="errImmagine" class="error-text"></span>
            </div>
            
            <div class="form-group">
                <label>Marca:</label>
                <input type="text" id="prodMarca" name="marca" required>
                <span id="errMarca" class="error-text"></span>
            </div>
            
            <div class="form-group">
                <label>Prezzo Attuale (€):</label>
                <input type="number" step="0.01" id="prodPrezzo" name="prezzo" required>
                <span id="errPrezzo" class="error-text"></span>
            </div>
            
            <div class="form-group">
                <label>Categoria:</label>
                <input type="text" id="prodCategoria" name="categoria" required>
                <span id="errCategoria" class="error-text"></span>
            </div>
            
            <div class="form-group">
                <label>Giacenza (Quantità in magazzino):</label>
                <input type="number" id="prodGiacenza" name="giacenza" required>
                <span id="errGiacenza" class="error-text"></span>
            </div>
            
            <button type="submit" class="btn-submit">+ Inserisci nel Catalogo</button>
            <div class="cancel-container">
                <a href="${pageContext.request.contextPath}/Admin" class="btn-cancel">Annulla</a>
            </div>
        </form>
    </div>
</body>
</html>