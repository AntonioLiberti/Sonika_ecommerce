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
    <title>Sonika - Gestione Catalogo</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <style>
        .admin-container { max-width: 1200px; margin: 40px auto; padding: 0 20px; }
        .admin-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }
        .admin-header h2 { color: #1f2937; margin: 0; font-size: 24px; }
        .btn-action-top { padding: 10px 18px; border-radius: 6px; font-weight: 600; text-decoration: none; color: white; transition: background-color 0.3s, transform 0.1s; display: inline-block; border: none; cursor: pointer; }
        .btn-new { background-color: #28a745; }
        .btn-new:hover { background-color: #218838; transform: translateY(-2px); }
        .btn-orders { background-color: #0066cc; margin-left: 10px; }
        .btn-orders:hover { background-color: #005bb5; transform: translateY(-2px); }
        .table-wrapper { background: #ffffff; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.03); border: 1px solid #f3f4f6; overflow: hidden; }
        .admin-table { width: 100%; border-collapse: collapse; }
        .admin-table th, .admin-table td { padding: 15px 20px; text-align: left; border-bottom: 1px solid #f3f4f6; }
        .admin-table th { background-color: #f9fafb; color: #4b5563; font-weight: 600; text-transform: uppercase; font-size: 13px; letter-spacing: 0.5px; }
        .admin-table tr:hover { background-color: #f9fafb; }
        .admin-table td { color: #1f2937; vertical-align: middle; font-size: 15px; }
        .btn-action { padding: 8px 14px; border-radius: 6px; font-weight: 600; text-decoration: none; color: white; border: none; cursor: pointer; transition: background-color 0.3s; font-size: 13px; }
        .btn-edit { background-color: #0066cc; margin-right: 5px; }
        .btn-edit:hover { background-color: #005bb5; }
        .btn-hide { background-color: #CC0000; }
        .btn-hide:hover { background-color: #a30000; }
        .btn-restore { background-color: #28a745; margin-left: 5px; }
        .btn-restore:hover { background-color: #218838; }
    </style>
</head>
<body>
    
    <header style="background-color: #ffffff; padding: 15px 40px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 10px rgba(0,0,0,0.05);">
        <h1 style="color: #CC0000; margin: 0; font-size: 30px; letter-spacing: -1px;">
            Sonika <span style="font-size: 16px; color: #6b7280; font-weight: normal; margin-left: 10px;">| Area Admin</span>
        </h1>
        <div>
            <% if (utenteLoggato != null) { %>
                <span style="color: #333333; font-weight: bold; margin-right: 20px;">Ciao, <%= utenteLoggato.getNome() %></span>
            <% } %>
            <a href="${pageContext.request.contextPath}/Home" style="color: #4b5563; font-weight: 600; text-decoration: none; margin-right: 20px; transition: color 0.2s;">Torna alla Home</a>
            <a href="${pageContext.request.contextPath}/login?action=logout" style="color: #CC0000; font-weight: bold; text-decoration: none;">Logout</a>
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
                        <td style="font-weight: 500;"><%= p.getNome() %></td>
                        <td style="font-weight: bold; color: #CC0000;">€ <%= String.format("%.2f", p.getPrezzoAttuale()) %></td>
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
                        <td colspan="4" style="text-align: center; padding: 30px; color: #6b7280;">Nessun prodotto presente nel database.</td>
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