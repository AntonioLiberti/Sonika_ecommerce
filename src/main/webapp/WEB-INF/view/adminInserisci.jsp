<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Utente" %>
<%
    Utente utenteLoggato = (Utente) session.getAttribute("utenteLoggato");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Sonika - Nuovo Prodotto</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <style>
        .form-container { background-color: #ffffff; max-width: 500px; margin: 40px auto; padding: 30px; border: 1px solid #f3f4f6; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.03); }
        .form-group { margin-bottom: 15px; text-align: left; }
        .form-group label { display: block; font-weight: bold; margin-bottom: 5px; color: #1f2937; }
        .form-group input { width: 100%; padding: 10px; box-sizing: border-box; border: 1px solid #d1d5db; border-radius: 6px; outline: none; transition: border-color 0.3s; }
        .form-group input:focus { border-color: #CC0000; }
        .btn-submit { background-color: #28a745; color: white; padding: 12px 15px; border: none; cursor: pointer; border-radius: 6px; width: 100%; font-size: 16px; font-weight: bold; transition: background-color 0.3s; }
        .btn-submit:hover { background-color: #218838; }
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
            <a href="${pageContext.request.contextPath}/Admin" style="color: #4b5563; font-weight: 600; text-decoration: none; margin-right: 20px; transition: color 0.2s;">&larr; Torna al Catalogo</a>
            <a href="${pageContext.request.contextPath}/login?action=logout" style="color: #CC0000; font-weight: bold; text-decoration: none;">Logout</a>
        </div>
    </header>
    
    <div class="form-container">
        <h2 style="text-align: center; margin-bottom: 25px; color: #1f2937;">Aggiungi Nuovo Prodotto</h2>
        <form action="${pageContext.request.contextPath}/AdminInserisci" method="post" enctype="multipart/form-data">
    
    <div class="form-group">
        <label>Nome Prodotto:</label>
        <input type="text" name="nome" required>
    </div>
   
    <div class="form-group">
        <label>Immagine Prodotto:</label>
        <input type="file" name="immagine" accept="image/*" required style="padding: 5px;">
    </div>
    
    <div class="form-group">
        <label>Marca:</label>
        <input type="text" name="marca" required>
    </div>
    
    <div class="form-group">
        <label>Prezzo Attuale (€):</label>
        <input type="number" step="0.01" name="prezzo" required>
    </div>
    
    <div class="form-group">
        <label>Categoria:</label>
        <input type="text" name="categoria" required>
    </div>
    
    <div class="form-group">
        <label>Giacenza (Quantità in magazzino):</label>
        <input type="number" name="giacenza" required>
    </div>
    
    <button type="submit" class="btn-submit">+ Inserisci nel Catalogo</button>
    <div style="text-align: center; margin-top: 15px;">
        <a href="${pageContext.request.contextPath}/Admin" style="color: #CC0000; text-decoration: none; font-weight: bold; transition: color 0.2s;">Annulla</a>
    </div>
</form>
    </div>
</body>
</html>