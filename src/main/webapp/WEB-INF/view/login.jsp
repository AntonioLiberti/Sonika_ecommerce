<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Sonika - Login e Registrazione</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <style>
        .auth-wrapper { display: flex; justify-content: center; gap: 40px; max-width: 1000px; margin: 60px auto; padding: 0 20px; flex-wrap: wrap; }
        .auth-box { background-color: #ffffff; width: 100%; max-width: 420px; padding: 40px; border: 1px solid #f3f4f6; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .auth-box h2 { color: #1f2937; margin-top: 0; font-size: 24px; padding-bottom: 15px; margin-bottom: 25px; }
        .box-reg h2 { border-bottom: 3px solid #CC0000; }
        .box-log h2 { border-bottom: 3px solid #0066cc; }
        
        .form-group { margin-bottom: 20px; text-align: left; }
        .form-group label { display: block; font-weight: 600; margin-bottom: 8px; color: #4b5563; font-size: 14px; }
        .form-group input { width: 100%; padding: 12px; box-sizing: border-box; border: 1px solid #d1d5db; border-radius: 8px; outline: none; transition: border-color 0.3s; font-size: 15px; }
        .form-group input:focus { border-color: #4b5563; box-shadow: 0 0 0 3px rgba(75,85,99,0.1); }
        
        .btn-auth { color: white; padding: 14px; border: none; cursor: pointer; border-radius: 8px; width: 100%; font-size: 16px; font-weight: bold; transition: background-color 0.3s, transform 0.1s; margin-top: 10px; }
        .btn-reg { background-color: #CC0000; }
        .btn-reg:hover { background-color: #a30000; transform: translateY(-2px); }
        .btn-log { background-color: #0066cc; }
        .btn-log:hover { background-color: #005bb5; transform: translateY(-2px); }
        
        .error-msg { color: #CC0000; font-size: 12px; display: block; margin-top: 5px; font-weight: bold; }
        .sys-msg-success { color: #28a745; font-weight: bold; background: #e6f4ea; padding: 10px; border-radius: 6px; margin-bottom: 20px; font-size: 14px; text-align: center;}
        .sys-msg-error { color: #CC0000; font-weight: bold; background: #fde8e8; padding: 10px; border-radius: 6px; margin-bottom: 20px; font-size: 14px; text-align: center;}
    </style>
    <script src="${pageContext.request.contextPath}/scripts/validazione.js" defer></script>
</head>
<body style="background-color: #f9fafb; margin: 0; font-family: sans-serif;">
    
 <header style="background-color: #ffffff; padding: 15px 40px; display: flex; justify-content: center; align-items: center; box-shadow: 0 2px 10px rgba(0,0,0,0.05);">
        <a href="${pageContext.request.contextPath}/Home" style="text-decoration: none;">
           <h1 style="color: #CC0000; margin: 0; font-size: 34px; letter-spacing: -1px; display: flex; align-items: center; transition: transform 0.2s;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">
    <svg width="28" height="28" viewBox="0 0 24 24" fill="#CC0000" xmlns="http://www.w3.org/2000/svg" style="margin-right: 10px;">
        <rect x="3" y="8" width="4" height="8" rx="2" />
        <rect x="10" y="3" width="4" height="18" rx="2" />
        <rect x="17" y="8" width="4" height="8" rx="2" />
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

            <form id="formRegistrazione" action="${pageContext.request.contextPath}/Registrazione" method="post">
                <div class="form-group">
                    <label>Nome</label>
                    <input type="text" id="regNome" name="nome" required>
                    <span id="errRegNome" class="error-msg"></span>
                </div>
                <div class="form-group">
                    <label>Cognome</label>
                    <input type="text" id="regCognome" name="cognome" required>
                    <span id="errRegCognome" class="error-msg"></span>
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" id="regEmail" name="email" required>
                    <span id="errRegEmail" class="error-msg"></span>
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" id="regPassword" name="password" required>
                    <span id="errRegPassword" class="error-msg"></span>
                </div>
                <button type="submit" class="btn-auth btn-reg">Crea Account</button>
            </form>
        </div>

        <div class="auth-box box-log">
            <h2>Hai già un account?</h2>
            
            <form id="formLogin" action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" id="logEmail" name="email" required>
                    <span id="errLogEmail" class="error-msg"></span>
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" id="logPassword" name="password" required>
                    <span id="errLogPassword" class="error-msg"></span>
                </div>
                <button type="submit" class="btn-auth btn-log">Accedi</button>
            </form>
        </div>

    </div>
</body>
</html>