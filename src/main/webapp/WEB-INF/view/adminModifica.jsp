<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Prodotto" %>
<%@ page import="model.Utente" %>
<%
    Prodotto prodotto = (Prodotto) request.getAttribute("prodotto");
    Utente utenteLoggato = (Utente) session.getAttribute("utenteLoggato");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sonika - Modifica Prodotto</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/adminModifica.css">
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
        <h2 class="form-title">Modifica Prodotto #<%= prodotto != null ? prodotto.getIdProdotto() : "" %></h2>

        <% if (prodotto != null) { %>
        <form action="${pageContext.request.contextPath}/AdminModifica" method="post" enctype="multipart/form-data">
            <input type="hidden" name="idProdotto" value="<%= prodotto.getIdProdotto() %>">

            <div class="form-group">
                <label>Stato nel Catalogo:</label>
                <% if (prodotto.isEliminato()) { %>
                    <span class="status-badge status-hidden">NASCOSTO</span>
                <% } else { %>
                    <span class="status-badge status-active">ATTIVO</span>
                <% } %>
            </div>

            <div class="form-group">
                <label>Nome Prodotto:</label>
                <input type="text" name="nome" value="<%= prodotto.getNome() %>" required>
            </div>

            <div class="form-group">
                <label>Immagine Attuale:</label>
                <div class="current-img-container">
                    <% if (prodotto.getImmagine() != null && !prodotto.getImmagine().isEmpty()) { %>
                        <img src="${pageContext.request.contextPath}/images/<%= prodotto.getImmagine() %>" alt="Immagine attuale" class="img-preview">
                    <% } else { %>
                        <span class="current-img-text">Nessuna immagine presente</span>
                    <% } %>
                </div>
                <label>Carica Nuova Immagine (lascia vuoto per mantenere l'attuale):</label>
                <input type="file" name="immagine" accept="image/*" class="file-input">
            </div>

            <div class="form-group">
                <label>Marca:</label>
                <input type="text" name="marca" value="<%= prodotto.getMarca() %>" required>
            </div>

            <div class="form-group">
                <label>Prezzo Attuale (€):</label>
                <input type="number" step="0.01" name="prezzo" value="<%= prodotto.getPrezzoAttuale() %>" required>
            </div>

            <div class="form-group">
                <label>Categoria:</label>
                <input type="text" name="categoria" value="<%= prodotto.getCategoria() %>" required>
            </div>

            <div class="form-group">
                <label>Giacenza (Quantità in magazzino):</label>
                <input type="number" name="giacenza" value="<%= prodotto.getGiacenza() %>" required>
            </div>

            <button type="submit" class="btn-submit">Salva Modifiche</button>
            <div class="cancel-container">
                <a href="${pageContext.request.contextPath}/Admin" class="btn-cancel">Annulla</a>
            </div>
        </form>
        <% } else { %>
            <div class="msg-errore">
                Errore: Prodotto non trovato o ID non valido.
            </div>
            <div class="cancel-container">
                <a href="${pageContext.request.contextPath}/Admin" class="btn-cancel">&larr; Torna al Catalogo</a>
            </div>
        <% } %>
    </div>
</body>
</html>