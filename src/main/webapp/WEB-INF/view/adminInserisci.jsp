<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Sonika - Nuovo Prodotto</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <style>
        .form-container { max-width: 500px; margin: 40px auto; padding: 20px; border: 1px solid #ccc; border-radius: 8px; }
        .form-group { margin-bottom: 15px; text-align: left; }
        .form-group label { display: block; font-weight: bold; margin-bottom: 5px; }
        .form-group input { width: 100%; padding: 8px; box-sizing: border-box; }
        .btn-submit { background-color: #28a745; color: white; padding: 10px 15px; border: none; cursor: pointer; border-radius: 4px; width: 100%; font-size: 16px; font-weight: bold; }
    </style>
</head>
<body>
    <header style="background-color: #333333; padding: 15px; text-align: center;">
        <h1 style="color: white; margin: 0;">Aggiungi Nuovo Prodotto</h1>
    </header>
    
    <div class="form-container">
        <form action="${pageContext.request.contextPath}/AdminInserisci" method="post">
            
            <div class="form-group">
                <label>Nome Prodotto:</label>
                <input type="text" name="nome" required>
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
                <a href="${pageContext.request.contextPath}/Admin" style="color: #CC0000; text-decoration: none; font-weight: bold;">Annulla e torna al catalogo</a>
            </div>
        </form>
    </div>
</body>
</html>