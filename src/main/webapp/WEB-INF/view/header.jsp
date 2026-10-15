<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Utente" %>
<% Utente utenteLoggato = (Utente) session.getAttribute("utenteLoggato"); %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sonika E-Commerce</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body class="page-bg">
    <header>
        <a href="${pageContext.request.contextPath}/Home" class="logo-link">
            <h1><span class="logo-svg">🎸</span> Sonika</h1>
        </a>
        <div class="search-bar">
            <form action="${pageContext.request.contextPath}/Home" method="GET">
                <input type="text" name="search" placeholder="Cerca uno strumento...">
                <button type="submit">Cerca</button>
            </form>
        </div>
        <div class="header-actions">
            <% if (utenteLoggato != null) { %>
                <span class="user-greeting">Ciao, <%= utenteLoggato.getNome() %></span>
                <% if (utenteLoggato.getRuolo().equals("admin")) { %>
                    <a href="${pageContext.request.contextPath}/AdminOrdiniServlet">Pannello Admin</a>
                <% } else { %>
                    <a href="${pageContext.request.contextPath}/StoricoOrdini">I Miei Ordini</a>
                <% } %>
                <a href="${pageContext.request.contextPath}/CarrelloServlet">Carrello</a>
                <a href="${pageContext.request.contextPath}/LoginServlet?action=logout">Logout</a>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/CarrelloServlet">Carrello</a>
                <a href="${pageContext.request.contextPath}/login">Accedi / Registrati</a>
            <% } %>
        </div>
    </header>