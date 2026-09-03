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
    <style>
        /* Applicazione Tema e Palette Colori da specifiche */
        body {
            font-family: sans-serif;
            background-color: #FFFFFF;
            color: #333333;
            margin: 0;
            padding: 0;
        }
        
        /* Header e Navbar */
        header {
            background-color: #F4F4F4;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #CCCCCC;
        }
        
        header h1 {
            margin: 0;
            font-size: 24px;
        }
        
        .header-actions a {
            color: #333333;
            text-decoration: none;
            margin-left: 20px;
            font-weight: bold;
        }
        
        nav {
            background-color: #333333;
            padding: 10px 30px;
        }
        
        nav a {
            color: #FFFFFF;
            text-decoration: none;
            margin-right: 15px;
            font-size: 14px;
        }
        
        /* Layout Principale */
        .container {
            display: flex;
            padding: 20px 30px;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        /* Sidebar Sinistra */
        aside {
            width: 200px;
            margin-right: 30px;
        }
        
        .sidebar-box {
            border: 1px solid #CCCCCC;
            padding: 15px;
            margin-bottom: 20px;
            background-color: #F4F4F4;
        }
        
        .sidebar-box h3 {
            margin-top: 0;
            font-size: 16px;
        }
        
        /* Griglia Prodotti */
        main {
            flex-grow: 1;
        }
        
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 20px;
        }
        
        /* Card Prodotto */
        .product-card {
            border: 1px solid #CCCCCC;
            background-color: #F4F4F4;
            padding: 15px;
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        
        .product-placeholder {
            width: 100%;
            height: 150px;
            background-color: #CCCCCC;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #333333;
            font-size: 12px;
        }
        
        .product-name {
            font-weight: bold;
            margin-bottom: 5px;
        }
        
        .product-brand {
            font-size: 12px;
            color: #666;
            margin-bottom: 10px;
        }
        
        .product-price {
            color: #CC0000;
            font-weight: bold;
            font-size: 18px;
            margin-bottom: 15px;
        }
        
        .btn-cart {
            background-color: #CC0000;
            color: #FFFFFF;
            border: none;
            padding: 10px;
            cursor: pointer;
            font-weight: bold;
            width: 100%;
            text-transform: uppercase;
        }
        
        .btn-cart:hover {
            background-color: #a00000;
        }
        
        /* Footer */
        footer {
            background-color: #CCCCCC;
            text-align: center;
            padding: 20px;
            margin-top: 40px;
            font-size: 12px;
        }
    </style>
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