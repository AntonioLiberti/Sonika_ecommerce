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
    <title>Sonika - Strumenti Musicali</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>

    <header>
        <h1>Sonika</h1>
        
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
                
                <a href="${pageContext.request.contextPath}/StoricoOrdini" style="margin-right: 15px;">I Miei Ordini</a>
                <a href="${pageContext.request.contextPath}/login?action=logout" style="color: #CC0000;">Logout</a>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/login">Login / Registrati</a>
            <% } %>
            <a href="${pageContext.request.contextPath}/CarrelloServlet">Carrello</a>
        </div>
    </header>

    <!-- LINK ALLINEATI ESATTAMENTE AL DATABASE -->
    <nav>
        <a href="${pageContext.request.contextPath}/Home">Tutti i Prodotti</a> | 
        <a href="${pageContext.request.contextPath}/Home?categoria=Chitarre">Chitarre</a> | 
        <a href="${pageContext.request.contextPath}/Home?categoria=Tastiere">Tastiere</a> | 
        <a href="${pageContext.request.contextPath}/Home?categoria=Bassi">Bassi</a> |
        <a href="${pageContext.request.contextPath}/Home?categoria=Ukulele">Ukulele</a>
    </nav>

    <div class="container">
        <aside>
            <div class="sidebar-box">
                <h3>Categorie</h3>
                <ul style="list-style-type: none; padding-left: 0; line-height: 2;">
                    <li><a href="${pageContext.request.contextPath}/Home?categoria=Chitarre" style="color: #333333; text-decoration: none;">Chitarre</a></li>
                    <li><a href="${pageContext.request.contextPath}/Home?categoria=Tastiere" style="color: #333333; text-decoration: none;">Tastiere</a></li>
                    <li><a href="${pageContext.request.contextPath}/Home?categoria=Bassi" style="color: #333333; text-decoration: none;">Bassi</a></li>
                    <li><a href="${pageContext.request.contextPath}/Home?categoria=Ukulele" style="color: #333333; text-decoration: none;">Ukulele</a></li>
                </ul>
            </div>
            
            <div class="sidebar-box">
                <h3>Ricerca per Nome</h3>
                <p style="font-size: 0.9em; color: #666;">Usa la barra in alto per cercare modelli specifici (es. Stratocaster).</p>
            </div>
            
            <div class="sidebar-box">
                <h3>Range Prezzo (€)</h3>
                <input type="text" style="width: 40px;"> - <input type="text" style="width: 40px;">
            </div>
        </aside>

        <main>
            <div class="product-grid">
                <%
                    if (catalogo != null && !catalogo.isEmpty()) {
                        for (Prodotto p : catalogo) {
                %>
                            <div class="product-card">
                                <div class="product-placeholder">Immagine Prodotto</div>
                                
                                <div>
                                    <div class="product-name"><%= p.getNome() %></div>
                                    <div class="product-brand"><%= p.getMarca() %></div>
                                </div>
                                
                                <div>
                                    <div class="product-price">€ <%= String.format("%.2f", p.getPrezzoAttuale()) %></div>
                                    <form action="<%= request.getContextPath() %>/CarrelloServlet" method="get">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="id" value="<%= p.getIdProdotto() %>">
                                        <button type="submit" class="btn-cart">Aggiungi al Carrello</button>
                                    </form>
                                </div>
                            </div>
                <%
                        }
                    } else {
                %>
                        <p style="color: #CC0000; font-weight: bold;">Nessun prodotto trovato per questa ricerca.</p>
                <%
                    }
                %>
            </div>
        </main>
    </div>

    <footer>
        Link Legali / Privacy | Contatti Assistenza
    </footer>

</body>
</html>