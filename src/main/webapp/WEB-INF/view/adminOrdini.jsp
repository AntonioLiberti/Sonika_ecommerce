<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Ordine" %>

<jsp:include page="header.jsp" />

<div class="container header-centered" style="max-width: 1000px;">
    <h2 class="text-center mt-20">Gestione Ordini Globali</h2>
    
    <div class="text-center mt-20" style="margin-bottom: 20px;">
        <a href="${pageContext.request.contextPath}/AdminServlet" class="btn-dettagli">Torna al Catalogo</a>
    </div>

    <form action="${pageContext.request.contextPath}/AdminOrdiniServlet" method="GET" class="admin-filters">
        <label>Da Data: <input type="date" name="dataDa" value="<%= request.getParameter("dataDa") != null ? request.getParameter("dataDa") : "" %>"></label>
        <label>A Data: <input type="date" name="dataA" value="<%= request.getParameter("dataA") != null ? request.getParameter("dataA") : "" %>"></label>
        <label>ID Cliente: <input type="number" name="idCliente" value="<%= request.getParameter("idCliente") != null ? request.getParameter("idCliente") : "" %>" placeholder="Es. 2"></label>
        <button type="submit" class="btn-aggiungi" style="width: auto;">Filtra</button>
        <a href="${pageContext.request.contextPath}/AdminOrdiniServlet" class="btn-dettagli" style="margin-bottom: 0;">Reset</a>
    </form>

    <table class="admin-table">
        <thead>
            <tr>
                <th>ID Ordine</th>
                <th>Data</th>
                <th>Stato</th>
                <th>ID Cliente</th>
                <th>Indirizzo</th>
                <th>Dettagli</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Ordine> ordini = (List<Ordine>) request.getAttribute("ordini");
                if (ordini != null && !ordini.isEmpty()) {
                    for (Ordine o : ordini) {
            %>
            <tr>
                <td>#<%= o.getIdOrdine() %></td>
                <td><%= o.getDataOrdine() %></td>
                <td><%= o.getStato() %></td>
                <td><%= o.getIdUtente() %></td>
                <td><%= o.getIndirizzoSpedizione() != null ? o.getIndirizzoSpedizione().replace("<", "&lt;") : "ND" %></td>
                <td>
                    <a href="${pageContext.request.contextPath}/DettaglioOrdine?id=<%= o.getIdOrdine() %>" class="btn-azione btn-modifica">Visualizza</a>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr><td colspan="6" class="text-center">Nessun ordine trovato.</td></tr>
            <% } %>
        </tbody>
    </table>
</div>

<jsp:include page="footer.jsp" />>