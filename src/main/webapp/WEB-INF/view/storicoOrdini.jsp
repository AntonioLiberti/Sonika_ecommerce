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
    <title>Sonika - Storico Ordini</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <style>
        .history-container { max-width: 1000px; margin: 40px auto; padding: 0 20px; }
        .history-header-title { color: #1f2937; margin: 0 0 25px 0; font-size: 28px; }
        .empty-history-msg { text-align: center; padding: 60px 20px; background: #ffffff; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.03); border: 1px solid #f3f4f6; }
        .empty-history-msg p { color: #6b7280; font-size: 18px; margin-bottom: 20px; }
        .btn-shop { background-color: #28a745; color: white; padding: 12px 24px; text-decoration: none; border-radius: 6px; font-weight: bold; display: inline-block; transition: background-color 0.3s; }
        .btn-shop:hover { background-color: #218838; }
        .table-wrapper { background: #ffffff; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.03); border: 1px solid #f3f4f6; overflow: hidden; margin-bottom: 30px; }
        .history-table { width: 100%; border-collapse: collapse; }
        .history-table th, .history-table td { padding: 18px 20px; text-align: left; border-bottom: 1px solid #f3f4f6; }
        .history-table th { background-color: #f9fafb; color: #4b5563; font-weight: 600; text-transform: uppercase; font-size: 13px; letter-spacing: 0.5px; }
        .history-table td { color: #1f2937; vertical-align: middle; font-size: 15px; }
        .status-badge { font-weight: bold; color: #28a745; }
        .btn-detail { background-color: #0066cc; color: white; padding: 8px 14px; text-decoration: none; border-radius: 6px; font-size: 13px; font-weight: 600; transition: background-color 0.3s; display: inline-block; }
        .btn-detail:hover { background-color: #005bb5; }
    </style>
</head>
<body style="background-color: #f9fafb; margin: 0; font-family: sans-serif;">
    
    <header>
        <h1 style="color: #CC0000; margin: 0; font-size: 34px; letter-spacing: -1px; display: flex; align-items: center; transition: transform 0.2s;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">
    <svg width="28" height="28" viewBox="0 0 24 24" fill="#CC0000" xmlns="http://www.w3.org/2000/svg" style="margin-right: 10px;">
        <rect x="3" y="8" width="4" height="8" rx="2" />
        <rect x="10" y="3" width="4" height="18" rx="2" />
        <rect x="17" y="8" width="4" height="8" rx="2" />
    </svg>
    Sonika
</h1>
        
        <div class="search-bar">
            <form action="${pageContext.request.contextPath}/Home" method="GET" style="margin: 0; display: flex;">
                <input type="text" name="search" placeholder="Cerca chitarra, pianoforte..." value="${param.search != null ? param.search : ''}" style="padding: 5px; width: 250px;">
                <button type="submit" style="background-color: #333; color: white; border: none; padding: 5px 10px; cursor: pointer;">Cerca</button>
            </form>
        </div>
        
        <div class="header-actions">
            <% if (utenteLoggato != null) { %>
                <span style="color: #333333; font-weight: bold; margin-right: 15px;">Ciao, <%= utenteLoggato.getNome() %></span>
                
                <% if ("admin".equalsIgnoreCase(utenteLoggato.getRuolo())) { %>
                    <a href="${pageContext.request.contextPath}/Admin" style="color: #28a745; font-weight: bold; margin-right: 15px;">Pannello Admin</a>
                <% } %>
                
                <a href="${pageContext.request.contextPath}/StoricoOrdini" style="color: #CC0000; font-weight: 800; margin-right: 15px; text-decoration: none; border-bottom: 2px solid #CC0000; padding-bottom: 2px;">I Miei Ordini</a>
                <a href="${pageContext.request.contextPath}/login?action=logout" style="color: #CC0000; font-weight: bold; margin-right: 15px; text-decoration: none;">Logout</a>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/login" style="color: #4b5563; font-weight: 600; margin-right: 15px; text-decoration: none;">Login / Registrati</a>
            <% } %>
            <a href="${pageContext.request.contextPath}/CarrelloServlet" style="color: #4b5563; font-weight: 600; text-decoration: none;">Carrello</a>
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
                                <td style="font-weight: 600;">#<%= o.getIdOrdine() %></td>
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