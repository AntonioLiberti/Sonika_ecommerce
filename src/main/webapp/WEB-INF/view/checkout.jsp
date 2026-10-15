<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="header.jsp" />
    
<div class="checkout-container checkout-wrapper mt-20">
    <h2 class="checkout-header-title">Dati di Spedizione e Pagamento</h2>
    
    <% if(request.getAttribute("errore") != null) { %>
        <div class="sys-msg-error"><%= request.getAttribute("errore") %></div>
    <% } %>
    
    <form id="formCheckout" action="${pageContext.request.contextPath}/Checkout" method="post" novalidate>
        <div class="form-group">
            <label for="chkIndirizzo">Indirizzo di Spedizione:</label>
            <input type="text" id="chkIndirizzo" name="indirizzo" placeholder="Es. Via Roma 1, Milano" required>
            <span id="errIndirizzo" class="error-text"></span>
        </div>
        
        <div class="form-group">
            <label for="chkCarta">Numero Carta di Credito:</label>
            <input type="text" id="chkCarta" name="carta" placeholder="1234567812345678" maxlength="16" required>
            <span id="errCarta" class="error-text"></span>
        </div>
        
        <button type="submit" class="btn-pay mt-20">Conferma Ordine e Paga</button>
    </form>
</div>

<!-- Inclusione dello script di validazione per il checkout -->
<script src="${pageContext.request.contextPath}/scripts/checkout.js"></script>

<jsp:include page="footer.jsp" />