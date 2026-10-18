<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Prodotto" %>
<%@ page import="model.Utente" %>
<%
    List<Prodotto> catalogo = (List<Prodotto>) request.getAttribute("prodotti");
    Utente utenteLoggato = (Utente) session.getAttribute("utenteLoggato");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sonika - Strumenti Musicali</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/index.css">
</head>
<body class="page-bg">

    <header class="light-header">
        <a href="${pageContext.request.contextPath}/Home" class="logo-link">
             <h1 class="brand-logo">
                <svg width="28" height="28" viewBox="0 0 24 24" fill="#CC0000" xmlns="http://www.w3.org/2000/svg" class="logo-svg">
                    <rect x="3" y="8" width="4" height="8" rx="2" />
                    <rect x="10" y="3" width="4" height="18" rx="2" />
                    <rect x="17" y="8" width="4" height="8" rx="2" />
                </svg>
                Sonika
            </h1>
        </a>

        <div class="search-bar">
            <form action="${pageContext.request.contextPath}/Home" method="GET">
                <input type="text" name="search" placeholder="Cerca strumenti..." value="${param.search != null ? param.search : ''}">
                <button type="submit">Cerca</button>
            </form>
        </div>

        <div class="header-nav">
            <% if (utenteLoggato != null) { %>
                <span class="user-greeting">Ciao, <%= utenteLoggato.getNome() %></span>
                <% if ("admin".equalsIgnoreCase(utenteLoggato.getRuolo())) { %>
                    <a href="${pageContext.request.contextPath}/Admin" class="nav-link admin-link">Pannello Admin</a>
                <% } %>
                <a href="${pageContext.request.contextPath}/StoricoOrdini" class="nav-link">I Miei Ordini</a>
                <a href="${pageContext.request.contextPath}/login?action=logout" class="nav-link logout-link">Logout</a>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/login" class="nav-link">Login / Registrati</a>
            <% } %>
            <a href="${pageContext.request.contextPath}/CarrelloServlet" class="nav-link cart-link">Carrello</a>
        </div>
    </header>

    <div class="store-layout">
        <aside class="sidebar">
            <div class="sidebar-box">
                <h3>Categorie</h3>
                <ul class="category-list">
                    <li><a href="${pageContext.request.contextPath}/Home" class="active-cat">Tutti i Prodotti</a></li>
                    <li><a href="${pageContext.request.contextPath}/Home?categoria=Chitarre">Chitarre</a></li>
                    <li><a href="${pageContext.request.contextPath}/Home?categoria=Tastiere">Tastiere</a></li>
                    <li><a href="${pageContext.request.contextPath}/Home?categoria=Bassi">Bassi</a></li>
                    <li><a href="${pageContext.request.contextPath}/Home?categoria=Ukulele">Ukulele</a></li>
                </ul>
            </div>

            <div class="sidebar-box">
                <h3>Range Prezzo (€)</h3>
                <form action="${pageContext.request.contextPath}/Home" method="GET" class="price-form">
                    <input type="hidden" name="search" value="${param.search != null ? param.search : ''}">
                    <input type="hidden" name="categoria" value="${param.categoria != null ? param.categoria : ''}">

                    <input type="number" name="minPrezzo" value="${param.minPrezzo}" class="price-input" placeholder="Min" min="0">
                    <span class="price-separator">-</span>
                    <input type="number" name="maxPrezzo" value="${param.maxPrezzo}" class="price-input" placeholder="Max" min="0">
                    <button type="submit" class="btn-price">Vai</button>
                </form>
            </div>
        </aside>

        <main class="main-content">
            <div class="product-grid">
                <%
                    if (catalogo != null && !catalogo.isEmpty()) {
                        for (Prodotto p : catalogo) {
                %>
                            <div class="product-card">
                                <img src="${pageContext.request.contextPath}/images/<%= p.getImmagine() != null && !p.getImmagine().isEmpty() ? p.getImmagine() : "default.png" %>"
                                     alt="<%= p.getNome() %>" class="product-img">

                                <div>
                                    <div class="product-name"><%= p.getNome() %></div>
                                    <div class="product-brand"><%= p.getMarca() %></div>
                                </div>

                                <div>
                                    <div class="product-price">€ <%= String.format("%.2f", p.getPrezzoAttuale()) %></div>
                                    <form action="<%= request.getContextPath() %>/CarrelloServlet" method="get">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="id" value="<%= p.getIdProdotto() %>">
                                        <button type="submit" class="btn-cart">Aggiungi</button>
                                    </form>
                                </div>
                            </div>
                <%
                        }
                    } else {
                %>
                        <div class="empty-products">
                            <p>Nessun prodotto trovato per questa ricerca.</p>
                        </div>
                <%
                    }
                %>
            </div>
        </main>
    </div>

    <footer class="site-footer">
        Sonika © 2026 | Vendita Strumenti Musicali <br>
        <a href="#">Privacy Policy</a> |
        <a href="#">Termini e Condizioni</a>
    </footer>

</body>
</html>