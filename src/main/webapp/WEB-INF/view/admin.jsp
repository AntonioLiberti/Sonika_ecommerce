<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Prodotto" %>
<%
    List<Prodotto> catalogo = (List<Prodotto>) request.getAttribute("catalogoAdmin");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Sonika - Gestione Catalogo</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <style>
        .admin-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .admin-table th, .admin-table td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        .admin-table th { background-color: #333333; color: white; }
        .btn-action { padding: 6px 12px; text-decoration: none; border-radius: 4px; color: white; border: none; cursor: pointer; }
        .btn-edit { background-color: #0066cc; }
        .btn-hide { background-color: #CC0000; }
    </style>
</head>
<body>
    <header style="background-color: #333333; padding: 15px;">
        <h1 style="color: white; margin: 0; display: inline-block;">Pannello Amministratore</h1>
        <a href="${pageContext.request.contextPath}/Home" style="color: #CC0000; float: right; margin-top: 5px; text-decoration: none; font-weight: bold;">Torna al Sito</a>
    </header>
    
  <div class="container" style="margin-top: 40px; display: block;">
        <h2>Gestione Catalogo</h2>
        
        <!-- Pulsanti di azione Admin -->
        <div style="margin-bottom: 15px;">
            <a href="${pageContext.request.contextPath}/AdminInserisci" style="display: inline-block; background-color: #28a745; color: white; padding: 10px 15px; text-decoration: none; border-radius: 4px; font-weight: bold;">+ Nuovo Prodotto</a>
            <a href="${pageContext.request.contextPath}/AdminOrdini" style="display: inline-block; margin-left: 10px; background-color: #0066cc; color: white; padding: 10px 15px; text-decoration: none; border-radius: 4px; font-weight: bold;">Visualizza Ordini</a>
        </div>
        
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
                    <td><%= p.getNome() %></td>
                    <td>€ <%= String.format("%.2f", p.getPrezzoAttuale()) %></td>
                    <td>
                        
                        <a href="${pageContext.request.contextPath}/AdminModifica?id=<%= p.getIdProdotto() %>" class="btn-action btn-edit">Modifica</a>
                        
                        <% if (!p.isEliminato()) { %>
                            <form action="${pageContext.request.contextPath}/AdminNascondi" method="post" style="display:inline;">
                                <input type="hidden" name="idProdotto" value="<%= p.getIdProdotto() %>">
                                <button type="submit" class="btn-action btn-hide">Nascondi</button>
                            </form>
                        <% } else { %>
                            <form action="${pageContext.request.contextPath}/AdminRipristina" method="post" style="display:inline;">
                                <input type="hidden" name="idProdotto" value="<%= p.getIdProdotto() %>">
                                <button type="submit" class="btn-action" style="background-color: #28a745; margin-left: 5px;">Ripristina</button>
                            </form>
                        <% } %>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="4" style="text-align: center;">Nessun prodotto presente nel database.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>