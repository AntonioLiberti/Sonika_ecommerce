<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Utente" %>
<%
    Utente utenteLoggato = (Utente) session.getAttribute("utenteLoggato");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Sonika - Checkout</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <style>
        .checkout-container { background-color: #ffffff; max-width: 500px; margin: 60px auto; padding: 40px; border: 1px solid #f3f4f6; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .checkout-header-title { text-align: center; color: #1f2937; margin-top: 0; margin-bottom: 30px; font-size: 24px; }
        .form-group { margin-bottom: 20px; text-align: left; }
        .form-group label { display: block; font-weight: 600; margin-bottom: 8px; color: #4b5563; font-size: 14px; }
        .form-group input { width: 100%; padding: 12px; box-sizing: border-box; border: 1px solid #d1d5db; border-radius: 8px; outline: none; transition: border-color 0.3s; font-size: 15px; }
        .form-group input:focus { border-color: #28a745; box-shadow: 0 0 0 3px rgba(40,167,69,0.1); }
        .btn-pay { background-color: #28a745; color: white; padding: 15px; border: none; cursor: pointer; border-radius: 8px; width: 100%; font-size: 18px; font-weight: bold; transition: background-color 0.3s, transform 0.1s; margin-top: 10px; }
        .btn-pay:hover { background-color: #218838; transform: translateY(-2px); }
        .error-text { color: #dc3545; font-size: 13px; margin-top: 5px; display: block; min-height: 15px; font-weight: 500; }
    </style>
</head>
<body style="background-color: #f9fafb; margin: 0; font-family: sans-serif;">
    
    <header style="background-color: #ffffff; padding: 15px 40px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 10px rgba(0,0,0,0.05);">
        <h1 style="color: #CC0000; margin: 0; font-size: 34px; letter-spacing: -1px; display: flex; align-items: center; transition: transform 0.2s;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">
    <svg width="28" height="28" viewBox="0 0 24 24" fill="#CC0000" xmlns="http://www.w3.org/2000/svg" style="margin-right: 10px;">
        <rect x="3" y="8" width="4" height="8" rx="2" />
        <rect x="10" y="3" width="4" height="18" rx="2" />
        <rect x="17" y="8" width="4" height="8" rx="2" />
    </svg>
    Sonika
<span style="font-size: 16px; color: #6b7280; font-weight: normal; margin-left: 10px;">| Checkout </span>
        </h1>
        <div>
            <% if (utenteLoggato != null) { %>
                <span style="color: #333333; font-weight: bold; margin-right: 20px;">Ciao, <%= utenteLoggato.getNome() %></span>
            <% } %>
            <a href="${pageContext.request.contextPath}/CarrelloServlet" style="color: #4b5563; font-weight: 600; text-decoration: none; transition: color 0.2s;">&larr; Torna al Carrello</a>
        </div>
    </header>
    
    <div class="checkout-container">
        <h2 class="checkout-header-title">Dati di Spedizione e Pagamento</h2>
        
        <form id="formCheckout" action="${pageContext.request.contextPath}/Checkout" method="post">
            
            <div class="form-group">
                <label>Indirizzo di Spedizione:</label>
                <input type="text" id="chkIndirizzo" name="indirizzo" placeholder="Es. Via Roma 1, Milano">
                <span id="errIndirizzo" class="error-text"></span>
            </div>
            
            <div class="form-group">
                <label>Numero Carta di Credito:</label>
                <input type="text" id="chkCarta" name="carta" placeholder="1234567812345678" maxlength="16">
                <span id="errCarta" class="error-text"></span>
            </div>
            
            <button type="submit" class="btn-pay">Conferma Ordine e Paga</button>
        </form>
    </div>

    <script>
        const formCheckout = document.getElementById('formCheckout');
        const indirizzoInput = document.getElementById('chkIndirizzo');
        const errIndirizzo = document.getElementById('errIndirizzo');
        const cartaInput = document.getElementById('chkCarta');
        const errCarta = document.getElementById('errCarta');

        const indirizzoRegex = /^[a-zA-Z0-9\s,.'-]{5,}$/;
        const cartaRegex = /^\d{16}$/;

        indirizzoInput.addEventListener('change', function() {
            if (!indirizzoRegex.test(indirizzoInput.value)) {
                errIndirizzo.innerText = "Inserisci un indirizzo valido (minimo 5 caratteri).";
            } else {
                errIndirizzo.innerText = "";
            }
        });

        cartaInput.addEventListener('change', function() {
            if (!cartaRegex.test(cartaInput.value)) {
                errCarta.innerText = "Inserisci un numero di carta valido (esattamente 16 cifre).";
            } else {
                errCarta.innerText = "";
            }
        });

        formCheckout.addEventListener('submit', function(event) {
            let formValido = true;

            if (!indirizzoRegex.test(indirizzoInput.value)) {
                errIndirizzo.innerText = "Inserisci un indirizzo valido (minimo 5 caratteri).";
                formValido = false;
            }

            if (!cartaRegex.test(cartaInput.value)) {
                errCarta.innerText = "Inserisci un numero di carta valido (esattamente 16 cifre).";
                formValido = false;
            }

            if (!formValido) {
                event.preventDefault(); 
            }
        });
    </script>
</body>
</html>