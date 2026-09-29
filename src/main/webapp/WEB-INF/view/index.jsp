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
                
                <a href="${pageContext.request.contextPath}/StoricoOrdini" style="color: #4b5563; font-weight: 600; margin-right: 15px; text-decoration: none;">I Miei Ordini</a>
                <a href="${pageContext.request.contextPath}/login?action=logout" style="color: #CC0000; font-weight: bold; margin-right: 15px; text-decoration: none;">Logout</a>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/login" style="color: #4b5563; font-weight: 600; margin-right: 15px; text-decoration: none;">Login / Registrati</a>
            <% } %>
            <a href="${pageContext.request.contextPath}/CarrelloServlet" style="color: #4b5563; font-weight: 600; text-decoration: none;">Carrello</a>
        </div>
    </header>

    <div class="container">
        <aside>
            <div class="sidebar-box">
                <h3>Categorie</h3>
                <ul style="list-style-type: none; padding-left: 0; line-height: 2;">
                    <li><a href="${pageContext.request.contextPath}/Home" style="color: #333333; text-decoration: none; font-weight: bold;">Tutti i Prodotti</a></li>
                    <li><a href="${pageContext.request.contextPath}/Home?categoria=Chitarre" style="color: #333333; text-decoration: none;">Chitarre</a></li>
                    <li><a href="${pageContext.request.contextPath}/Home?categoria=Tastiere" style="color: #333333; text-decoration: none;">Tastiere</a></li>
                    <li><a href="${pageContext.request.contextPath}/Home?categoria=Bassi" style="color: #333333; text-decoration: none;">Bassi</a></li>
                    <li><a href="${pageContext.request.contextPath}/Home?categoria=Ukulele" style="color: #333333; text-decoration: none;">Ukulele</a></li>
                </ul>
            </div>
            
            <div class="sidebar-box">
                <h3>Range Prezzo (€)</h3>
                <form action="${pageContext.request.contextPath}/Home" method="GET" style="display: flex; align-items: center; gap: 5px;">
                    <input type="hidden" name="search" value="${param.search != null ? param.search : ''}">
                    <input type="hidden" name="categoria" value="${param.categoria != null ? param.categoria : ''}">
                    
                    <input type="number" name="minPrezzo" value="${param.minPrezzo}" style="width: 55px; padding: 3px;" placeholder="Min" min="0">
                    - 
                    <input type="number" name="maxPrezzo" value="${param.maxPrezzo}" style="width: 55px; padding: 3px;" placeholder="Max" min="0">
                    <button type="submit" style="background-color: #333; color: white; border: none; padding: 4px 8px; cursor: pointer; border-radius: 3px; margin-left: 5px;">Vai</button>
                </form>
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