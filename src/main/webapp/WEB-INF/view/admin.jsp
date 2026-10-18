<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Prodotto" %>
<%@ page import="model.Utente" %>
<%
    List<Prodotto> catalogo = (List<Prodotto>) request.getAttribute("catalogoAdmin");
    Utente utenteLoggato = (Utente) session.getAttribute("utenteLoggato");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sonika - Gestione Catalogo</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/admin.css">
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
                <span class="header-subtitle">| Area Admin</span>
            </h1>
        </a>
        <div class="header-nav">
            <% if (utenteLoggato != null) { %>
                <span class="user-greeting">Ciao, <%= utenteLoggato.getNome() %></span>
            <% } %>
            <a href="${pageContext.request.contextPath}/Home" class="nav-link">Torna alla Home</a>
            <a href="${pageContext.request.contextPath}/login?action=logout" class="nav-link logout-link">Logout</a>
        </div>
    </header>

    <div class="admin-container">
        <div class="admin-header">
            <h2>Gestione Catalogo</h2>
            <div>
                <a href="${pageContext.request.contextPath}/AdminInserisci" class="btn-action-top btn-new">+ Nuovo Prodotto</a>
                <a href="${pageContext.request.contextPath}/AdminOrdini" class="btn-action-top btn-orders">Visualizza Ordini</a>
            </div>
        </div>

        <div class="table-wrapper">
            <table class="admin-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nome</th>
                        <th>Prezzo</th>
                        <th>Azioni</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (catalogo != null && !catalogo.isEmpty()) {
                            for (Prodotto p : catalogo) {
                    %>
                    <tr>
                        <td><%= p.getIdProdotto() %></td>
                        <td class="td-nome"><%= p.getNome() %></td>
                        <td class="td-prezzo">€ <%= String.format("%.2f", p.getPrezzoAttuale()) %></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/AdminModifica?id=<%= p.getIdProdotto() %>" class="btn-action btn-edit">Modifica</a>
                            <% if (!p.isEliminato()) { %>
                                <form action="${pageContext.request.contextPath}/AdminNascondi" method="post" class="form-inline">
                                    <input type="hidden" name="idProdotto" value="<%= p.getIdProdotto() %>">
                                    <button type="submit" class="btn-action btn-hide">Nascondi</button>
                                </form>
                            <% } else { %>
                                <form action="${pageContext.request.contextPath}/AdminRipristina" method="post" class="form-inline">
                                    <input type="hidden" name="idProdotto" value="<%= p.getIdProdotto() %>">
                                    <button type="submit" class="btn-action btn-restore">Ripristina</button>
                                </form>
                            <% } %>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="4" class="td-empty">Nessun prodotto presente nel database.</td>
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