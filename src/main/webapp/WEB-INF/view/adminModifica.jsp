<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Prodotto" %>

<jsp:include page="header.jsp" />

<div class="container header-centered">
    <div class="checkout-container checkout-wrapper text-center">
        <h2 class="mt-20">Modifica Prodotto</h2>
        
        <% 
            Prodotto p = (Prodotto) request.getAttribute("prodotto"); 
            if (p != null) { 
        %>
        <form action="${pageContext.request.contextPath}/AdminModificaServlet" method="POST" class="admin-form">
            <input type="hidden" name="idProdotto" value="<%= p.getIdProdotto() %>">
            
            <label>Nome: <input type="text" name="nome" value="<%= p.getNome().replace("\"", "&quot;") %>" required></label>
            <label>Marca: <input type="text" name="marca" value="<%= p.getMarca().replace("\"", "&quot;") %>" required></label>
            <label>Prezzo (€): <input type="number" name="prezzo" step="0.01" min="0.01" value="<%= p.getPrezzoAttuale() %>" required></label>
            <label>Categoria: <input type="text" name="categoria" value="<%= p.getCategoria().replace("\"", "&quot;") %>" required></label>
            <label>Giacenza: <input type="number" name="giacenza" min="0" value="<%= p.getGiacenza() %>" required></label>
            
            <button type="submit" class="btn-aggiungi mt-20">Aggiorna Prodotto</button>
            <a href="${pageContext.request.contextPath}/AdminServlet" class="btn-dettagli mt-20">Annulla</a>
        </form>
        <% } else { %>
            <p class="text-center" style="color: red;">Prodotto non trovato.</p>
            <a href="${pageContext.request.contextPath}/AdminServlet" class="btn-dettagli mt-20">Torna al Catalogo</a>
        <% } %>
    </div>
</div>

<jsp:include page="footer.jsp" />