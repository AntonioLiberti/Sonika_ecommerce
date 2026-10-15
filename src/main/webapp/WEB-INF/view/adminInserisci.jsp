<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="header.jsp" />

<div class="container header-centered">
    <div class="checkout-container checkout-wrapper text-center">
        <h2 class="mt-20">Inserisci Nuovo Prodotto</h2>
        
        <form action="${pageContext.request.contextPath}/AdminInserisciServlet" method="POST" enctype="multipart/form-data" class="admin-form">
            <label>Nome: <input type="text" name="nome" required></label>
            <label>Marca: <input type="text" name="marca" required></label>
            <label>Prezzo (€): <input type="number" name="prezzo" step="0.01" min="0.01" required></label>
            <label>Categoria: <input type="text" name="categoria" required></label>
            <label>Giacenza: <input type="number" name="giacenza" min="0" required></label>
            
            <!-- Limitiamo l'upload lato client ai soli formati sicuri (il lato server lo faremo dopo) -->
            <label>Immagine: <input type="file" name="immagine" accept="image/png, image/jpeg, image/jpg"></label>
            
            <button type="submit" class="btn-aggiungi mt-20">Salva Prodotto</button>
            <a href="${pageContext.request.contextPath}/AdminServlet" class="btn-dettagli mt-20">Annulla</a>
        </form>
    </div>
</div>

<jsp:include page="footer.jsp" />