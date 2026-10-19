	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Ordine" %>
<%@ page import="model.Utente" %>
<%
    List<Ordine> ordini = (List<Ordine>) request.getAttribute("ordini");
    Utente utenteLoggato = (Utente) session.getAttribute("utenteLoggato");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sonika - Storico Ordini</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/storicoOrdini.css">
</head>
<body class="page-bg">
    
    <header class="light-header">
        <a href="${pageContext.request.contextPath}/Home" class="logo-link">
            <h1 class="brand-logo">
                <svg width="28" height="28" viewBox="0 0 24 24" fill="#CC0000" xmlns="http://www.w3.org/2000/svg" class="logo-svg">
                    <rect x="3" y="8" width="4" height="8" rx="2" />
                    <rect x="10" y="3" width="4" height="18" rx="2" />
                    <rect x="17" y="8" width="4" height="8" rx="2" />
                </svg>
                Sonika
            </h1>
        </a>
        
        <div class="search-bar">
            <form action="${pageContext.request.contextPath}/Home" method="GET">
                <input type="text" name="search" placeholder="Cerca chitarra, pianoforte..." value="${param.search != null ? param.search : ''}">
                <button type="submit">Cerca</button>
            </form>
        </div>
        
        <div class="header-nav">
            <% if (utenteLoggato != null) { %>
                <span class="user-greeting">Ciao, <%= utenteLoggato.getNome() %></span>
                
                <% if ("admin".equalsIgnoreCase(utenteLoggato.getRuolo())) { %>
                    <a href="${pageContext.request.contextPath}/Admin" class="nav-link">Pannello Admin</a>
                <% } %>
                
                <a href="${pageContext.request.contextPath}/StoricoOrdini" class="nav-link nav-active">I Miei Ordini</a>
                <a href="${pageContext.request.contextPath}/login?action=logout" class="nav-link logout-link">Logout</a>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/login" class="nav-link">Login / Registrati</a>
            <% } %>
            <a href="${pageContext.request.contextPath}/CarrelloServlet" class="nav-link">Carrello</a>
        </div>
    </header>
    
    <div class="history-container">
        <h2 class="history-header-title">Storico Acquisti</h2>
        
        <%
            if (ordini == null || ordini.isEmpty()) {
        %>
            <div class="empty-history-msg">
                <p>Non hai ancora effettuato ordini su Sonika.</p>
                <a href="${pageContext.request.contextPath}/Home" class="btn-shop">Inizia lo shopping</a>
            </div>
        <%
            } else {
        %>
            <div class="table-wrapper">
                <table class="history-table">
                    <thead>
                        <tr>
                            <th>Numero Ordine</th>
                            <th>Data Acquisto</th>
                            <th>Stato</th>
                            <th>Azioni</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            for (Ordine o : ordini) { 
                        %>
                            <tr>
                                <td class="order-id-col">#<%= o.getIdOrdine() %></td>
                                <td><%= o.getDataOrdine() %></td>
                                <td><span class="status-badge"><%= o.getStato() %></span></td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/DettaglioOrdine?id=<%= o.getIdOrdine() %>" class="btn-detail">Vedi Dettaglio</a>
                                </td>
                            </tr>
                        <% 
                            } 
                        %>
                    </tbody>
                </table>
            </div>
        <%
            }
        %>
    </div>
</body>
</html> 