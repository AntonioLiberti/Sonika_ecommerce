<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sonika - Login e Registrazione</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/login.css">
    <script src="${pageContext.request.contextPath}/scripts/validazione.js" defer></script>
</head>
<body class="page-bg">
    
    <header class="light-header header-centered">
        <a href="${pageContext.request.contextPath}/Home" class="logo-link">
            <h1 class="brand-logo">
                <svg width="28" height="28" viewBox="0 0 24 24" fill="#CC0000" xmlns="http://www.w3.org/2000/svg" class="logo-svg">
                    <rect x="3" y="8" width="4" height="8" rx="2"/>
                    <rect x="10" y="3" width="4" height="18" rx="2"/>
                    <rect x="17" y="8" width="4" height="8" rx="2"/>
                </svg>
                Sonika
            </h1>
        </a>
    </header>

    <div class="auth-wrapper">
        
        <div class="auth-box box-reg">
            <h2>Nuovo Cliente?</h2>
            
            <% if(request.getAttribute("messaggio") != null) { %>
                <div class="sys-msg-success">${messaggio}</div>
            <% } %>
            <% if(request.getAttribute("errore") != null) { %>
                <div class="sys-msg-error">${errore}</div>
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
</body>
</html>