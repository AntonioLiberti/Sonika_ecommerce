<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Prodotto" %>

<jsp:include page="header.jsp" />

<div class="container header-centered">
    <h2 class="text-center mt-20">Il nostro Catalogo</h2>
    
    <div class="product-grid">
        <%
            List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
            if (prodotti != null && !prodotti.isEmpty()) {
                for (Prodotto p : prodotti) {
        %>
        <div class="product-card">
            <a href="${pageContext.request.contextPath}/ProdottoServlet?id=<%= p.getIdProdotto() %>">
                <img src="${pageContext.request.contextPath}/images/<%= p.getImmagine() != null && !p.getImmagine().isEmpty() ? p.getImmagine() : "default.png" %>" 
                     alt="<%= p.getNome().replace("\"", "&quot;") %>" 
                     class="product-image">
            </a>
            
            <div class="product-title"><%= p.getNome().replace("<", "&lt;").replace(">", "&gt;") %></div>
            <div class="product-price">€ <%= String.format("%.2f", p.getPrezzoAttuale()) %></div>
            
            <a href="${pageContext.request.contextPath}/ProdottoServlet?id=<%= p.getIdProdotto() %>" class="btn-dettagli">Dettagli</a>
            
            <form action="${pageContext.request.contextPath}/CarrelloServlet" method="POST" class="form-inline">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="idProdotto" value="<%= p.getIdProdotto() %>">
                <input type="hidden" name="quantita" value="1">
                <button type="submit" class="btn-aggiungi">Aggiungi al Carrello</button>
            </form>
        </div>
        <%
                }
            } else {
        %>
            <p class="text-center">Nessun prodotto disponibile al momento.</p>
        <%
            }
        %>
    </div>
</div>

<jsp:include page="footer.jsp" />