<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Ordine" %>
<%@ page import="model.Utente" %>
<%
    List<Ordine> ordini = (List<Ordine>) request.getAttribute("listaOrdini");
    Utente utenteLoggato = (Utente) session.getAttribute("utenteLoggato");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sonika - Ordini Complessivi</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/adminOrdini.css">
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
    
    <div class="admin-container">
        <div class="admin-header">
            <h2>Storico Complessivo Ordini</h2>
            
            <div class="filter-bar">
                <form action="${pageContext.request.contextPath}/AdminOrdini" method="GET" class="filter-form">
                    <div class="filter-group">
                        <label>Da data:</label>
                        <input type="date" name="dataDa" value="${param.dataDa}">
                    </div>
                    <div class="filter-group">
                        <label>A data:</label>
                        <input type="date" name="dataA" value="${param.dataA}">
                    </div>
                    <div class="filter-group">
                        <label>ID Cliente:</label>
                        <input type="number" name="idCliente" placeholder="Es. 1" value="${param.idCliente}" class="input-id-cliente">
                    </div>
                    <div class="filter-actions">
                        <button type="submit" class="btn-filter">Filtra Ordini</button>
                        <a href="${pageContext.request.contextPath}/AdminOrdini" class="btn-reset">Azzera</a>
                    </div>
                </form>
            </div>
        </div>
        
        <div class="table-wrapper">
            <table class="admin-table">
                <thead>
                    <tr>
                        <th>ID Ordine</th>
                        <th>Data</th>
                        <th>Stato</th>
                        <th>ID Utente</th>
                        <th>Azioni</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (ordini != null && !ordini.isEmpty()) {
                            for (Ordine o : ordini) {
                                String statusClass = "Pagato".equalsIgnoreCase(o.getStato()) ? "status-pagato" : "status-default";
                    %>
                    <tr>
                        <td class="td-id"><%= o.getIdOrdine() %></td>
                        <td><%= o.getDataOrdine() %></td>
                        <td><span class="<%= statusClass %>"><%= o.getStato() %></span></td>
                        <td><%= o.getIdUtente() %></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/DettaglioOrdine?id=<%= o.getIdOrdine() %>" class="btn-action">Vedi Dettaglio</a>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="5" class="td-empty">Nessun ordine trovato con i filtri selezionati.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>