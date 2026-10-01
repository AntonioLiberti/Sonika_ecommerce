<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Utente" %>
<%
    Utente utenteLoggato = (Utente) session.getAttribute("utenteLoggato");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Sonika - Ordine Confermato</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <style>
        .success-container { background-color: #ffffff; max-width: 550px; margin: 80px auto; padding: 50px 40px; border: 1px solid #f3f4f6; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); text-align: center; }
        .success-icon { color: #28a745; font-size: 70px; margin-bottom: 20px; font-weight: bold; line-height: 1; }
        .success-title { color: #1f2937; margin-top: 0; margin-bottom: 15px; font-size: 28px; }
        .success-msg { color: #6b7280; font-size: 16px; margin-bottom: 30px; line-height: 1.6; }
        .order-number { background-color: #f9fafb; padding: 15px; border-radius: 8px; border: 1px dashed #d1d5db; font-size: 18px; color: #1f2937; margin-bottom: 35px; display: inline-block; min-width: 250px; }
        .btn-home { background-color: #0066cc; color: white; padding: 14px 30px; text-decoration: none; border-radius: 8px; font-size: 16px; font-weight: bold; transition: background-color 0.3s, transform 0.1s; display: inline-block; }
        .btn-home:hover { background-color: #005bb5; transform: translateY(-2px); }
    </style>
</head>
<body style="background-color: #f9fafb; margin: 0; font-family: sans-serif;">
    
    <header style="background-color: #ffffff; padding: 15px 40px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 10px rgba(0,0,0,0.05);">
        <h1 style="color: #CC0000; margin: 0; font-size: 30px; letter-spacing: -1px;">
            Sonika
        </h1>
        <div>
            <% if (utenteLoggato != null) { %>
                <span style="color: #333333; font-weight: bold; margin-right: 20px;">Ciao, <%= utenteLoggato.getNome() %></span>
            <% } %>
            <a href="${pageContext.request.contextPath}/Home" style="color: #4b5563; font-weight: 600; text-decoration: none; transition: color 0.2s;">Torna alla Vetrina</a>
        </div>
    </header>
    
    <div class="success-container">
        <div class="success-icon">✓</div>
        <h2 class="success-title">Pagamento andato a buon fine!</h2>
        <div class="success-msg">
            Grazie per il tuo acquisto.<br>
            Il tuo ordine è stato registrato ed è attualmente in fase di elaborazione.
        </div>
        
        <div class="order-number">
            Numero d'ordine: <strong>${idOrdine}</strong>
        </div>
        
        <div>
            <a href="${pageContext.request.contextPath}/Home" class="btn-home">Torna agli acquisti</a>
        </div>
    </div>
</body>
</html>