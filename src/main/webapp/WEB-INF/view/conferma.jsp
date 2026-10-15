<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="header.jsp" />

<div class="container header-centered">
    <div class="checkout-container checkout-wrapper text-center">
        <h2 style="color: #28a745;">Ordine Confermato!</h2>
        <p>Grazie per il tuo acquisto.</p>
        
        <% if (request.getAttribute("idOrdine") != null) { %>
            <p>Il numero del tuo ordine è: <strong>#<%= request.getAttribute("idOrdine") %></strong></p>
        <% } %>
        
        <p>Puoi controllare lo stato della spedizione nella sezione "I Miei Ordini".</p>
        
        <div class="mt-20">
            <a href="${pageContext.request.contextPath}/Home" class="btn-aggiungi" style="width: auto; display: inline-block; text-decoration: none;">Torna al Catalogo</a>
            <a href="${pageContext.request.contextPath}/StoricoOrdini" class="btn-dettagli">Visualizza Storico</a>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />