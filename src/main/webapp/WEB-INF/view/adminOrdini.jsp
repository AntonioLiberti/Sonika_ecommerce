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
        .filter-bar { background-color: #f4f4f4; padding: 15px; margin-top: 20px; border-radius: 5px; border: 1px solid #ddd; }
        .filter-bar input[type="date"], .filter-bar input[type="number"] { padding: 8px; margin-right: 10px; border: 1px solid #ccc; border-radius: 4px; }
        .btn-filter { background-color: #0066cc; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; }
        .btn-reset { background-color: #666; color: white; padding: 10px 15px; text-decoration: none; border-radius: 4px; font-weight: bold; margin-left: 5px; }
    </style>
</head>
<body>
    <header style="background-color: #333333; padding: 15px;">
        <h1 style="color: white; margin: 0; display: inline-block;">Visualizzazione Ordini</h1>
        <a href="${pageContext.request.contextPath}/Admin" style="color: #28a745; float: right; margin-top: 5px; text-decoration: none; font-weight: bold;">Torna al Catalogo</a>
    </header>
    
    <div class="container" style="margin-top: 20px; display: block;">
        <h2>Storico Complessivo Ordini</h2>
        
        <!-- BARRA DEI FILTRI -->
        <div class="filter-bar">
            <form action="${pageContext.request.contextPath}/AdminOrdini" method="GET" style="display: flex; align-items: center;">
                <label style="margin-right: 5px;">Da data:</label>
                <input type="date" name="dataDa" value="${param.dataDa}">
                
                <label style="margin-right: 5px;">A data:</label>
                <input type="date" name="dataA" value="${param.dataA}">
                
                <label style="margin-right: 5px;">ID Cliente:</label>
                <input type="number" name="idCliente" placeholder="Es. 1" value="${param.idCliente}">
                
                <button type="submit" class="btn-filter">Filtra Ordini</button>
                <a href="${pageContext.request.contextPath}/AdminOrdini" class="btn-reset">Azzera</a>
            </form>
        </div>
        
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
                    <td colspan="4" style="text-align: center;">Nessun ordine trovato con i filtri selezionati.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>