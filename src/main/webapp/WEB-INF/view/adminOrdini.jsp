<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Ordine" %>
<%
    List<Ordine> ordini = (List<Ordine>) request.getAttribute("listaOrdini");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Sonika - Ordini Complessivi</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <style>
        .admin-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .admin-table th, .admin-table td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        .admin-table th { background-color: #333333; color: white; }
    </style>
</head>
<body>
    <header style="background-color: #333333; padding: 15px;">
        <h1 style="color: white; margin: 0; display: inline-block;">Visualizzazione Ordini</h1>
        <a href="${pageContext.request.contextPath}/Admin" style="color: #28a745; float: right; margin-top: 5px; text-decoration: none; font-weight: bold;">Torna al Catalogo</a>
    </header>
    
    <div class="container" style="margin-top: 40px; display: block;">
        <h2>Storico Complessivo Ordini</h2>
        
        <table class="admin-table">
            <thead>
                <tr>
                    <th>ID Ordine</th>
                    <th>Data</th>
                    <th>Stato</th>
                    <th>ID Utente</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (ordini != null && !ordini.isEmpty()) {
                        for (Ordine o : ordini) {
                %>
                <tr>
                    <td><%= o.getIdOrdine() %></td>
                    <td><%= o.getDataOrdine() %></td>
                    <td><span style="font-weight: bold; color: #0066cc;"><%= o.getStato() %></span></td>
                    <td><%= o.getIdUtente() %></td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="4" style="text-align: center;">Nessun ordine presente nel sistema.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>