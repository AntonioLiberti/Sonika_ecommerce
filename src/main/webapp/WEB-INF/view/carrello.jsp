<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Carrello" %>
<%@ page import="model.ItemCarrello" %>

<jsp:include page="header.jsp" />

<div class="container header-centered">
    <h2 class="text-center mt-20">Il Tuo Carrello</h2>
    
    <div class="checkout-container checkout-wrapper" style="background: white; border: 1px solid #ddd;">
        <%
            Carrello carrello = (Carrello) session.getAttribute("carrello");
            if (carrello != null && !carrello.getItems().isEmpty()) {
        %>
            <table class="table-ordini">
                <thead>
                    <tr>
                        <th>Prodotto</th>
                        <th>Prezzo</th>
                        <th>Quantità</th>
                        <th>Totale</th>
                        <th>Azioni</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (ItemCarrello item : carrello.getItems()) { %>
                        <tr>
                            <td><%= item.getProdotto().getNome().replace("<", "&lt;").replace(">", "&gt;") %></td>
                            <td>€ <%= String.format("%.2f", item.getProdotto().getPrezzoAttuale()) %></td>
                            <td>
                                <!-- Form per aggiornare la quantità -->
                                <form action="${pageContext.request.contextPath}/CarrelloServlet" method="POST" class="form-inline">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="idProdotto" value="<%= item.getProdotto().getIdProdotto() %>">
                                    <input type="number" name="quantita" value="<%= item.getQuantita() %>" min="1" max="<%= item.getProdotto().getGiacenza() %>" style="width: 60px; padding: 5px;">
                                    <button type="submit" class="btn-dettagli" style="margin-bottom:0; margin-left: 10px;">Aggiorna</button>
                                </form>
                            </td>
                            <td>€ <%= String.format("%.2f", item.getPrezzoTotale()) %></td>
                            <td>
                                <!-- Form per rimuovere il prodotto -->
                                <form action="${pageContext.request.contextPath}/CarrelloServlet" method="POST" class="form-inline">
                                    <input type="hidden" name="action" value="remove">
                                    <input type="hidden" name="idProdotto" value="<%= item.getProdotto().getIdProdotto() %>">
                                    <button type="submit" class="btn-dettagli" style="color: white; background-color: #CC0000;">Rimuovi</button>
                                </form>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
            
            <h3 class="totale-ordine">Totale Carrello: € <%= String.format("%.2f", carrello.getPrezzoTotaleCarrello()) %></h3>
            
            <div style="text-align: right; margin-top: 20px;">
                <form action="${pageContext.request.contextPath}/CarrelloServlet" method="POST" class="form-inline">
                    <input type="hidden" name="action" value="clear">
                    <button type="submit" class="btn-dettagli">Svuota Carrello</button>
                </form>
                <a href="${pageContext.request.contextPath}/Checkout" class="btn-aggiungi" style="display:inline-block; width:auto; text-decoration:none; margin-left: 15px;">Procedi al Checkout</a>
            </div>
            
        <% } else { %>
            <p class="text-center">Il tuo carrello è vuoto.</p>
            <div class="text-center mt-20">
                <a href="${pageContext.request.contextPath}/Home" class="btn-aggiungi" style="display:inline-block; width:auto; text-decoration:none;">Torna agli acquisti</a>
            </div>
        <% } %>
    </div>
</div>

<jsp:include page="footer.jsp" />