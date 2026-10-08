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
    <title>Sonika - Ordini Complessivi</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <style>
        .admin-container { max-width: 1200px; margin: 40px auto; padding: 0 20px; }
        .admin-header { margin-bottom: 25px; }
        .admin-header h2 { color: #1f2937; margin: 0 0 20px 0; font-size: 24px; }
        .filter-bar { background-color: #ffffff; padding: 20px; border-radius: 12px; box-shadow: 0 2px 5px rgba(0,0,0,0.02); border: 1px solid #f3f4f6; margin-bottom: 25px; display: flex; align-items: center; gap: 15px; }
        .filter-group { display: flex; align-items: center; gap: 8px; }
        .filter-group label { font-weight: 600; color: #4b5563; font-size: 14px; }
        .filter-bar input[type="date"], .filter-bar input[type="number"] { padding: 8px 12px; border: 1px solid #d1d5db; border-radius: 6px; outline: none; transition: border-color 0.3s; }
        .filter-bar input:focus { border-color: #4b5563; }
        .btn-filter { background-color: #6b7280; color: white; padding: 9px 18px; border: none; border-radius: 6px; cursor: pointer; font-weight: bold; transition: background-color 0.3s; font-size: 14px; }
        .btn-filter:hover { background-color: #4b5563; }
        .btn-reset { background-color: #CC0000; color: white; padding: 9px 18px; text-decoration: none; border-radius: 6px; font-weight: bold; transition: background-color 0.3s; font-size: 14px; }
        .btn-reset:hover { background-color: #a30000; }
        .table-wrapper { background: #ffffff; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.03); border: 1px solid #f3f4f6; overflow: hidden; }
        .admin-table { width: 100%; border-collapse: collapse; }
        .admin-table th, .admin-table td { padding: 15px 20px; text-align: left; border-bottom: 1px solid #f3f4f6; }
        .admin-table th { background-color: #f9fafb; color: #4b5563; font-weight: 600; text-transform: uppercase; font-size: 13px; letter-spacing: 0.5px; }
        .admin-table tr:hover { background-color: #f9fafb; }
        .admin-table td { color: #1f2937; vertical-align: middle; font-size: 15px; }
        .btn-action { background-color: #0066cc; color: white; padding: 8px 14px; text-decoration: none; border-radius: 6px; font-size: 13px; font-weight: 600; transition: background-color 0.3s; display: inline-block; }
        .btn-action:hover { background-color: #005bb5; }
    </style>
</head>
<body>
    <header style="background-color: #ffffff; padding: 15px 40px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 10px rgba(0,0,0,0.05);">
       <h1 style="color: #CC0000; margin: 0; font-size: 34px; letter-spacing: -1px; display: flex; align-items: center; transition: transform 0.2s;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">
    <svg width="28" height="28" viewBox="0 0 24 24" fill="#CC0000" xmlns="http://www.w3.org/2000/svg" style="margin-right: 10px;">
        <rect x="3" y="8" width="4" height="8" rx="2" />
        <rect x="10" y="3" width="4" height="18" rx="2" />
        <rect x="17" y="8" width="4" height="8" rx="2" />
    </svg>
    Sonika
<span style="font-size: 16px; color: #6b7280; font-weight: normal; margin-left: 10px;">| Area Admin</span>
        </h1>
        <div>
            <% if (utenteLoggato != null) { %>
                <span style="color: #333333; font-weight: bold; margin-right: 20px;">Ciao, <%= utenteLoggato.getNome() %></span>
            <% } %>
            <a href="${pageContext.request.contextPath}/Admin" style="color: #4b5563; font-weight: 600; text-decoration: none; margin-right: 20px; transition: color 0.2s;">&larr; Torna al Catalogo</a>
            <a href="${pageContext.request.contextPath}/login?action=logout" style="color: #CC0000; font-weight: bold; text-decoration: none;">Logout</a>
        </div>
    </header>
    
    <div class="admin-container">
        <div class="admin-header">
            <h2>Storico Complessivo Ordini</h2>
            
            <div class="filter-bar">
                <form action="${pageContext.request.contextPath}/AdminOrdini" method="GET" style="display: flex; align-items: center; gap: 15px; width: 100%; flex-wrap: wrap;">
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
                        <input type="number" name="idCliente" placeholder="Es. 1" value="${param.idCliente}" style="width: 80px;">
                    </div>
                    <div style="margin-left: auto; display: flex; gap: 10px;">
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
                                String textColor = "Pagato".equalsIgnoreCase(o.getStato()) ? "#28a745" : "#1f2937";
                    %>
                    <tr>
                        <td style="font-weight: 600;"><%= o.getIdOrdine() %></td>
                        <td><%= o.getDataOrdine() %></td>
                        <td><span style="font-weight: bold; color: <%= textColor %>;"><%= o.getStato() %></span></td>
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
                        <td colspan="5" style="text-align: center; padding: 30px; color: #6b7280;">Nessun ordine trovato con i filtri selezionati.</td>
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