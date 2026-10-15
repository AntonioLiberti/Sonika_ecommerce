<<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="header.jsp" />

<div class="auth-wrapper">
    
    <div class="auth-box box-reg">
        <h2>Nuovo Cliente?</h2>
        
        <% if(request.getAttribute("messaggio") != null) { %>
            <div class="sys-msg-success"><%= request.getAttribute("messaggio") %></div>
        <% } %>
        <% if(request.getAttribute("errore") != null) { %>
            <div class="sys-msg-error"><%= request.getAttribute("errore") %></div>
        <% } %>

        <form id="formRegistrazione" action="${pageContext.request.contextPath}/Registrazione" method="post" novalidate>
            <div class="form-group">
                <label for="regNome">Nome</label>
                <input type="text" id="regNome" name="nome" required>
                <span id="errRegNome" class="error-msg"></span>
            </div>
            <div class="form-group">
                <label for="regCognome">Cognome</label>
                <input type="text" id="regCognome" name="cognome" required>
                <span id="errRegCognome" class="error-msg"></span>
            </div>
            <div class="form-group">
                <label for="regEmail">Email</label>
                <input type="email" id="regEmail" name="email" required>
                <span id="errRegEmail" class="error-msg"></span>
            </div>
            <div class="form-group">
                <label for="regPassword">Password</label>
                <input type="password" id="regPassword" name="password" required>
                <span id="errRegPassword" class="error-msg"></span>
            </div>
            <button type="submit" class="btn-auth btn-reg">Crea Account</button>
        </form>
    </div>

    <div class="auth-box box-log">
        <h2>Hai già un account?</h2>
        
        <form id="formLogin" action="${pageContext.request.contextPath}/login" method="post" novalidate>
            <div class="form-group">
                <label for="logEmail">Email</label>
                <input type="email" id="logEmail" name="email" required>
                <span id="errLogEmail" class="error-msg"></span>
            </div>
            <div class="form-group">
                <label for="logPassword">Password</label>
                <input type="password" id="logPassword" name="password" required>
                <span id="errLogPassword" class="error-msg"></span>
            </div>
            <button type="submit" class="btn-auth btn-log">Accedi</button>
        </form>
    </div>

</div>

<!-- Inclusione dello script di validazione per i form in pagina -->
<script src="${pageContext.request.contextPath}/scripts/validazione.js"></script>

<jsp:include page="footer.jsp" />