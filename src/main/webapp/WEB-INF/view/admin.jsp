<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Prodotto" %>

<jsp:include page="header.jsp" />

<div class="container header-centered" style="max-width: 1200px;">
    <h2 class="text-center mt-20">Pannello di Controllo Admin - Catalogo</h2>
    
    <div class="text-center mt-20">
        <a href="${pageContext.request.contextPath}/AdminInserisciServlet" class="btn-aggiungi" style="width:auto; text-decoration:none;">Aggiungi Nuovo Prodotto</a>
        <a href="${pageContext.request.contextPath}/AdminOrdiniServlet" class="btn-dettagli">Gestione Ordini Clienti</a>
    </div>

    <table class="admin-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Immagine</th>
                <th>Nome</th>
                <th>Marca</th>
                <th>Categoria</th>
                <th>Prezzo</th>
                <th>Giacenza</th>
                <th>Stato</th>
                <th>Azioni</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
                if (prodotti != null && !prodotti.isEmpty()) {
                    for (Prodotto p : prodotti) {
            %>
            <tr>
                <td><%= p.getIdProdotto() %></td>
                <td><img src="${pageContext.request.contextPath}/images/<%= p.getImmagine() != null && !p.getImmagine().isEmpty() ? p.getImmagine() : "default.png" %>" alt="img"></td>
                <td><%= p.getNome().replace("<", "&lt;") %></td>
                <td><%= p.getMarca() %></td>
                <td><%= p.getCategoria() %></td>
                <td>€ <%= String.format("%.2f", p.getPrezzoAttuale()) %></td>
                <td><%= p.getGiacenza() %></td>
                <td><%= p.isEliminato() ? "<span style='color:red;'>Nascosto</span>" : "<span style='color:green;'>Attivo</span>" %></td>
                <td>
                    <a href="${pageContext.request.contextPath}/AdminModificaServlet?id=<%= p.getIdProdotto() %>" class="btn-azione btn-modifica">Modifica</a>
                    <% if (!p.isEliminato()) { %>
                        <form action="${pageContext.request.contextPath}/AdminNascondiServlet" method="POST" class="form-inline">
                            <input type="hidden" name="id" value="<%= p.getIdProdotto() %>">
                            <button type="submit" class="btn-azione btn-nascondi">Nascondi</button>
                        </form>
                    <% } else { %>
                        <form action="${pageContext.request.contextPath}/AdminRipristinaServlet" method="POST" class="form-inline">
                            <input type="hidden" name="id" value="<%= p.getIdProdotto() %>">
                            <button type="submit" class="btn-azione btn-ripristina">Ripristina</button>
                        </form>
                    <% } %>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr><td colspan="9" class="text-center">Nessun prodotto nel catalogo.</td></tr>
            <% } %>
        </tbody>
    </table>
</div>

<jsp:include page="footer.jsp" />