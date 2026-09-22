	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Ordine" %>
<%
    List<Ordine> ordini = (List<Ordine>) request.getAttribute("ordini");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Sonika - Storico Ordini</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <header>
        <h1>Sonika - I Miei Ordini</h1>
        <nav><a href="${pageContext.request.contextPath}/Home" style="color: white; text-decoration: none;">Torna alla Vetrina</a></nav>
    </header>
    
    <div class="container" style="margin-top: 30px;">
        <h2 style="color: #333333;">Storico Acquisti</h2>
        
        <%
            if (ordini == null || ordini.isEmpty()) {
        %>
            <p style="color: #666; font-size: 1.2em;">Non hai ancora effettuato ordini su Sonika.</p>
        <%
            } else {
        %>
            <table style="width: 100%; border-collapse: collapse; margin-top: 20px;">
                <tr style="background-color: #333333; color: white; text-align: left;">
                    <th style="padding: 10px;">Numero Ordine</th>
                    <th style="padding: 10px;">Data Acquisto</th>
                    <th style="padding: 10px;">Stato</th>
                </tr>
                <% 
                    for (Ordine o : ordini) { 
                %>
                    <tr style="border-bottom: 1px solid #ccc;">
                        <td style="padding: 10px; font-weight: bold;">#<%= o.getIdOrdine() %></td>
                        <td style="padding: 10px;"><%= o.getDataOrdine() %></td>
                        <td style="padding: 10px; color: #28a745; font-weight: bold;"><%= o.getStato() %></td>
                    </tr>
                <% 
                    } 
                %>
            </table>
        <%
            }
        %>
    </div>
</body>
</html>