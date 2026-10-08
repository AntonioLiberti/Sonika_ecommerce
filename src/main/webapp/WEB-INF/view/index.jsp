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
    <style>
        .store-layout { display: flex; gap: 30px; max-width: 1200px; margin: 40px auto; padding: 0 20px; align-items: flex-start; }
        .sidebar { flex: 0 0 250px; }
        .main-content { flex: 1; }

        .sidebar-box { background: #ffffff; padding: 25px; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.03); border: 1px solid #f3f4f6; margin-bottom: 25px; }
        .sidebar-box h3 { color: #1f2937; margin-top: 0; margin-bottom: 15px; font-size: 18px; border-bottom: 2px solid #f3f4f6; padding-bottom: 10px; }
        .category-list { list-style-type: none; padding-left: 0; margin: 0; }
        .category-list li { margin-bottom: 12px; }
        .category-list a { color: #4b5563; text-decoration: none; font-size: 15px; transition: color 0.2s; }
        .category-list a:hover { color: #CC0000; font-weight: bold; }
        
        .product-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); gap: 25px; }
        .product-card { background: #ffffff; padding: 20px; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.03); border: 1px solid #f3f4f6; display: flex; flex-direction: column; justify-content: space-between; text-align: center; transition: transform 0.2s; }
        .product-card:hover { transform: translateY(-5px); box-shadow: 0 8px 15px rgba(0,0,0,0.08); }
        .product-placeholder { background-color: #f9fafb; height: 180px; border-radius: 8px; border: 1px dashed #d1d5db; display: flex; align-items: center; justify-content: center; color: #9ca3af; margin-bottom: 15px; }
        .product-name { font-weight: bold; color: #1f2937; font-size: 18px; margin-bottom: 5px; }
        .product-brand { color: #6b7280; font-size: 14px; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 15px; }
        .product-price { color: #CC0000; font-size: 22px; font-weight: bold; margin-bottom: 15px; }
        .btn-cart { background-color: #CC0000; color: white; padding: 12px; border: none; border-radius: 6px; cursor: pointer; font-weight: bold; width: 100%; transition: background-color 0.2s; }
        .btn-cart:hover { background-color: #a30000; }

        .main-header { background-color: #ffffff; padding: 15px 40px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 10px rgba(0,0,0,0.05); flex-wrap: wrap; gap: 15px; }
        .header-search { display: flex; flex: 1; justify-content: center; min-width: 200px; }
        .header-actions { display: flex; align-items: center; gap: 20px; flex-wrap: wrap; }
    </style>
</head>
<body style="background-color: #f9fafb; margin: 0; font-family: sans-serif;">

    <header class="main-header">
        <h1 style="color: #CC0000; margin: 0; font-size: 34px; letter-spacing: -1px; display: flex; align-items: center; transition: transform 0.2s;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">
    <svg width="28" height="28" viewBox="0 0 24 24" fill="#CC0000" xmlns="http://www.w3.org/2000/svg" style="margin-right: 10px;">
        <rect x="3" y="8" width="4" height="8" rx="2" />
        <rect x="10" y="3" width="4" height="18" rx="2" />
        <rect x="17" y="8" width="4" height="8" rx="2" />
    </svg>
    Sonika
</h1>
        
        <div class="header-search">
            <form action="${pageContext.request.contextPath}/Home" method="GET" style="margin: 0; display: flex; width: 100%; max-width: 400px;">
                <input type="text" name="search" placeholder="Cerca strumenti..." value="${param.search != null ? param.search : ''}" style="flex: 1; padding: 10px 15px; border: 1px solid #d1d5db; border-radius: 6px 0 0 6px; outline: none;">
                <button type="submit" style="background-color: #333; color: white; border: none; padding: 10px 20px; cursor: pointer; border-radius: 0 6px 6px 0; font-weight: bold;">Cerca</button>
            </form>
        </div>
        
        <div class="header-actions">
            <% if (utenteLoggato != null) { %>
                <span style="color: #1f2937; font-weight: bold;">Ciao, <%= utenteLoggato.getNome() %></span>
                <% if ("admin".equalsIgnoreCase(utenteLoggato.getRuolo())) { %>
                    <a href="${pageContext.request.contextPath}/Admin" style="color: #28a745; font-weight: bold; text-decoration: none;">Pannello Admin</a>
                <% } %>
                <a href="${pageContext.request.contextPath}/StoricoOrdini" style="color: #4b5563; font-weight: 600; text-decoration: none;">I Miei Ordini</a>
                <a href="${pageContext.request.contextPath}/login?action=logout" style="color: #CC0000; font-weight: bold; text-decoration: none;">Logout</a>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/login" style="color: #4b5563; font-weight: 600; text-decoration: none;">Login / Registrati</a>
            <% } %>
            <a href="${pageContext.request.contextPath}/CarrelloServlet" style="color: #CC0000; font-weight: 800; text-decoration: none;">Carrello</a>
        </div>
    </header>

    <div class="store-layout">
        <aside class="sidebar">
            <div class="sidebar-box">
                <h3>Categorie</h3>
                <ul class="category-list">
                    <li><a href="${pageContext.request.contextPath}/Home" style="font-weight: bold; color: #1f2937;">Tutti i Prodotti</a></li>
                    <li><a href="${pageContext.request.contextPath}/Home?categoria=Chitarre">Chitarre</a></li>
                    <li><a href="${pageContext.request.contextPath}/Home?categoria=Tastiere">Tastiere</a></li>
                    <li><a href="${pageContext.request.contextPath}/Home?categoria=Bassi">Bassi</a></li>
                    <li><a href="${pageContext.request.contextPath}/Home?categoria=Ukulele">Ukulele</a></li>
                </ul>
            </div>
            
            <div class="sidebar-box">
                <h3>Range Prezzo (€)</h3>
                <form action="${pageContext.request.contextPath}/Home" method="GET" style="display: flex; align-items: center; gap: 8px;">
                    <input type="hidden" name="search" value="${param.search != null ? param.search : ''}">
                    <input type="hidden" name="categoria" value="${param.categoria != null ? param.categoria : ''}">
                    
                    <input type="number" name="minPrezzo" value="${param.minPrezzo}" style="width: 100%; padding: 8px; border: 1px solid #d1d5db; border-radius: 4px;" placeholder="Min" min="0">
                    <span style="color: #6b7280;">-</span>
                    <input type="number" name="maxPrezzo" value="${param.maxPrezzo}" style="width: 100%; padding: 8px; border: 1px solid #d1d5db; border-radius: 4px;" placeholder="Max" min="0">
                    <button type="submit" style="background-color: #333; color: white; border: none; padding: 8px 12px; cursor: pointer; border-radius: 4px; font-weight: bold;">Vai</button>
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
<img 
    src="${pageContext.request.contextPath}/images/<%= p.getImmagine() != null && !p.getImmagine().isEmpty() ? p.getImmagine() : "default.png" %>" 
    alt="<%= p.getNome() %>" 
    style="width: 100%; height: 200px; object-fit: contain; margin-bottom: 15px; border-radius: 8px;"
>
                                
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
                        <div style="grid-column: 1 / -1; text-align: center; padding: 40px; background: white; border-radius: 12px; border: 1px solid #f3f4f6;">
                            <p style="color: #6b7280; font-size: 18px; margin: 0;">Nessun prodotto trovato per questa ricerca.</p>
                        </div>
                <%
                    }
                %>
            </div>
        </main>
    </div>

    <footer style="text-align: center; padding: 30px; color: #6b7280; font-size: 14px; border-top: 1px solid #e5e7eb; margin-top: 40px;">
        Sonika © 2026 | Vendita Strumenti Musicali <br>
        <a href="#" style="color: #4b5563; text-decoration: none; margin: 0 10px;">Privacy Policy</a> | 
        <a href="#" style="color: #4b5563; text-decoration: none; margin: 0 10px;">Termini e Condizioni</a>
    </footer>

</body>
</html>