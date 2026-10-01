<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Carrello" %>
<%@ page import="model.ItemCarrello" %>
<%@ page import="model.Utente" %>
<%
    Carrello carrello = (Carrello) session.getAttribute("carrello");
    Utente utenteLoggato = (Utente) session.getAttribute("utenteLoggato");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Sonika - Il tuo Carrello</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <style>
        .cart-container { max-width: 1000px; margin: 40px auto; padding: 0 20px; }
        .cart-header { margin-bottom: 25px; border-bottom: 2px solid #f3f4f6; padding-bottom: 15px; }
        .cart-header h2 { color: #1f2937; margin: 0; font-size: 28px; }
        .empty-cart-msg { text-align: center; padding: 60px 20px; background: #ffffff; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.03); border: 1px solid #f3f4f6; }
        .empty-cart-msg p { color: #6b7280; font-size: 18px; margin-bottom: 20px; }
        .btn-continue-shopping { background-color: #28a745; color: white; padding: 12px 24px; text-decoration: none; border-radius: 6px; font-weight: bold; display: inline-block; transition: background-color 0.3s; }
        .btn-continue-shopping:hover { background-color: #218838; }
        .cart-table-wrapper { background: #ffffff; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.03); border: 1px solid #f3f4f6; overflow: hidden; margin-bottom: 30px; }
        .cart-table { width: 100%; border-collapse: collapse; }
        .cart-table th, .cart-table td { padding: 18px 20px; text-align: left; border-bottom: 1px solid #f3f4f6; }
        .cart-table th { background-color: #f9fafb; color: #4b5563; font-weight: 600; text-transform: uppercase; font-size: 13px; letter-spacing: 0.5px; }
        .cart-table td { color: #1f2937; vertical-align: middle; font-size: 15px; }
        .product-info strong { font-size: 16px; display: block; margin-bottom: 4px; }
        .product-info span { font-size: 13px; color: #6b7280; }
        .qty-form { display: flex; align-items: center; gap: 8px; }
        .qty-input { width: 60px; padding: 8px; border: 1px solid #d1d5db; border-radius: 6px; text-align: center; font-size: 15px; outline: none; }
        .qty-input:focus { border-color: #4b5563; }
        .btn-update { background-color: #f3f4f6; color: #4b5563; border: 1px solid #d1d5db; padding: 8px 12px; border-radius: 6px; cursor: pointer; font-weight: 600; transition: all 0.2s; font-size: 13px; }
        .btn-update:hover { background-color: #e5e7eb; color: #1f2937; }
        .btn-remove { background-color: #fee2e2; color: #CC0000; border: none; padding: 8px 12px; border-radius: 6px; cursor: pointer; font-weight: 600; transition: background-color 0.2s; font-size: 13px; }
        .btn-remove:hover { background-color: #fca5a5; }
        .cart-footer { display: flex; justify-content: space-between; align-items: flex-start; padding: 25px; background: #f9fafb; border-radius: 12px; border: 1px solid #f3f4f6; }
        .btn-clear { background-color: transparent; color: #6b7280; border: 1px solid #d1d5db; padding: 10px 20px; border-radius: 6px; cursor: pointer; font-weight: 600; transition: all 0.2s; }
        .btn-clear:hover { background-color: #f3f4f6; color: #1f2937; }
        .checkout-section { text-align: right; }
        .total-price { font-size: 24px; color: #CC0000; margin: 0 0 15px 0; }
        .btn-checkout { background-color: #0066cc; color: white; padding: 14px 30px; border: none; border-radius: 6px; cursor: pointer; font-size: 18px; font-weight: bold; transition: background-color 0.3s; display: inline-block; text-decoration: none; }
        .btn-checkout:hover { background-color: #005bb5; }
    </style>
</head>
<body>
    
    <header style="background-color: #ffffff; padding: 15px 40px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 10px rgba(0,0,0,0.05);">
        <h1 style="color: #CC0000; margin: 0; font-size: 30px; letter-spacing: -1px;">
            Sonika <span style="font-size: 16px; color: #6b7280; font-weight: normal; margin-left: 10px;">| Carrello</span>
        </h1>
        <div>
            <% if (utenteLoggato != null) { %>
                <span style="color: #333333; font-weight: bold; margin-right: 20px;">Ciao, <%= utenteLoggato.getNome() %></span>
            <% } %>
            <a href="${pageContext.request.contextPath}/Home" style="color: #4b5563; font-weight: 600; text-decoration: none; margin-right: 20px; transition: color 0.2s;">Torna alla Home</a>
            <% if (utenteLoggato != null) { %>
                <a href="${pageContext.request.contextPath}/login?action=logout" style="color: #CC0000; font-weight: bold; text-decoration: none;">Logout</a>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/login" style="color: #4b5563; font-weight: 600; text-decoration: none;">Login / Registrati</a>
            <% } %>
        </div>
    </header>

    <div class="cart-container">
        <div class="cart-header">
            <h2>Il tuo Carrello</h2>
        </div>
        
        <%
            if (carrello == null || carrello.getItems().isEmpty()) {
        %>
            <div class="empty-cart-msg">
                <p>Il tuo carrello è attualmente vuoto.</p>
                <a href="${pageContext.request.contextPath}/Home" class="btn-continue-shopping">Torna alla Vetrina</a>
            </div>
        <%
            } else {
        %>
            <div class="cart-table-wrapper">
                <table class="cart-table">
                    <thead>
                        <tr>
                            <th>Prodotto</th>
                            <th>Prezzo Unitario</th>
                            <th>Quantità</th>
                            <th>Totale</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            for (ItemCarrello item : carrello.getItems()) { 
                        %>
                            <tr>
                                <td class="product-info">
                                    <strong><%= item.getProdotto().getNome() %></strong>
                                    <span><%= item.getProdotto().getMarca() %></span>
                                </td>
                                <td>€ <%= String.format("%.2f", item.getProdotto().getPrezzoAttuale()) %></td>
                                <td>
                                    <form action="<%= request.getContextPath() %>/CarrelloServlet" method="get" class="qty-form">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="id" value="<%= item.getProdotto().getIdProdotto() %>">
                                        <input type="number" name="quantita" value="<%= item.getQuantita() %>" min="1" class="qty-input">
                                        <button type="submit" class="btn-update">Aggiorna</button>
                                    </form>
                                </td>
                                <td style="font-weight: bold; color: #1f2937;">€ <%= String.format("%.2f", item.getPrezzoTotale()) %></td>
                                <td style="text-align: right;">
                                    <form action="<%= request.getContextPath() %>/CarrelloServlet" method="get">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="id" value="<%= item.getProdotto().getIdProdotto() %>">
                                        <button type="submit" class="btn-remove">X Rimuovi</button>
                                    </form>
                                </td>
                            </tr>
                        <% 
                            } 
                        %>
                    </tbody>
                </table>
            </div>
            
            <div class="cart-footer">
                <form action="<%= request.getContextPath() %>/CarrelloServlet" method="get">
                    <input type="hidden" name="action" value="clear">
                    <button type="submit" class="btn-clear">Svuota Carrello</button>
                </form>
                
                <div class="checkout-section">
                    <h3 class="total-price">
                        Totale: € <%= String.format("%.2f", carrello.getPrezzoTotaleCarrello()) %>
                    </h3>
                    <form action="<%= request.getContextPath() %>/Checkout" method="get">
                        <button type="submit" class="btn-checkout">Procedi al Pagamento &rarr;</button>
                    </form>
                </div>
            </div>
        <%
            }
        %>
    </div>
</body>
</html>