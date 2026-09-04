<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Prodotto" %>
<%
    List<Prodotto> catalogo = (List<Prodotto>) request.getAttribute("prodotti");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Sonika - Strumenti Musicali</title>
    <!-- Collegamento al file CSS esterno -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>

    <header>
        <h1>Sonika</h1>
        <div class="search-bar">
            <input type="text" placeholder="Cerca chitarra, pianoforte..." style="padding: 5px; width: 250px;">
        </div>
        <div class="header-actions">
            <a href="${pageContext.request.contextPath}/login.jsp">Login/Area Personale</a>
            <a href="#">Carrello (0)</a>
        </div>
    </header>

    <nav>
        <a href="${pageContext.request.contextPath}/Home">Home</a> | 
        <a href="#">Chitarre</a> | 
        <a href="#">Ukulele</a> | 
        <a href="#">Pianoforti</a> | 
        <a href="#">Contatti</a>
    </nav>

    <div class="container">
        <aside>
            <div class="sidebar-box">
                <h3>Categorie</h3>
                <ul style="list-style-type: none; padding-left: 0;">
                    <li><a href="#" style="color: #333333; text-decoration: none;">Acustiche</a></li>
                    <li><a href="#" style="color: #333333; text-decoration: none;">Elettriche</a></li>
                    <li><a href="#" style="color: #333333; text-decoration: none;">Bassi</a></li>
                </ul>
            </div>
            
            <div class="sidebar-box">
                <h3>Ukulele</h3>
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
                                <!-- Placeholder grigio in attesa delle immagini reali -->
                                <div class="product-placeholder">Immagine Prodotto</div>
                                
                                <div>
                                    <div class="product-name"><%= p.getNome() %></div>
                                    <div class="product-brand"><%= p.getMarca() %></div>
                                </div>
                                
                                <div>
                                    <div class="product-price">€ <%= String.format("%.2f", p.getPrezzoAttuale()) %></div>
                                    <button class="btn-cart">Aggiungi al Carrello</button>
                                </div>
                            </div>
                <%
                        }
                    } else {
                %>
                        <p style="color: #CC0000;">Nessun prodotto disponibile in catalogo.</p>
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