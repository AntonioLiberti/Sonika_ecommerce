	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Ordine" %>

<jsp:include page="header.jsp" />

<div class="container header-centered">
    <h2 class="text-center mt-20">I Miei Ordini</h2>
    
    <div class="checkout-container checkout-wrapper" style="background: white; border: 1px solid #ddd;">
        <%
            List<Ordine> ordini = (List<Ordine>) request.getAttribute("ordini");
            if (ordini != null && !ordini.isEmpty()) {
        %>
            <table class="table-ordini">
                <thead>
                    <tr>
                        <th>Numero Ordine</th>
                        <th>Data</th>
                        <th>Stato</th>
                        <th>Indirizzo di Spedizione</th>
                        <th>Azione</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Ordine o : ordini) { %>
                        <tr>
                            <td>#<%= o.getIdOrdine() %></td>
                            <td><%= o.getDataOrdine() %></td>
                            <td><%= o.getStato() %></td>
                            <td><%= o.getIndirizzoSpedizione() != null ? o.getIndirizzoSpedizione().replace("<", "&lt;").replace(">", "&gt;") : "Non specificato" %></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/DettaglioOrdine?id=<%= o.getIdOrdine() %>" class="btn-dettagli" style="margin-bottom:0;">Visualizza Dettagli</a>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } else { %>
            <p class="text-center">Non hai ancora effettuato ordini.</p>
        <% } %>
    </div>
</div>

<jsp:include page="footer.jsp" />l>