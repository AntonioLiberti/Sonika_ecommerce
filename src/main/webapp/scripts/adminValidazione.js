const formProdotto = document.getElementById('formProdotto');

if (formProdotto) {
    const nomeInput = document.getElementById('prodNome');
    const marcaInput = document.getElementById('prodMarca');
    const prezzoInput = document.getElementById('prodPrezzo');
    const categoriaInput = document.getElementById('prodCategoria');
    const giacenzaInput = document.getElementById('prodGiacenza');
   
    const errNome = document.getElementById('errNome');
    const errMarca = document.getElementById('errMarca');
    const errPrezzo = document.getElementById('errPrezzo');
    const errCategoria = document.getElementById('errCategoria');
    const errGiacenza = document.getElementById('errGiacenza');
   

    const nomeRegex = /^[A-Za-z0-9À-ÿ\s.,'&()\/+-]{2,100}$/;
    const marcaRegex = /^[A-Za-z0-9À-ÿ\s.'&-]{2,50}$/;
    const prezzoRegex = /^\d{1,8}(\.\d{1,2})?$/;
    const giacenzaRegex = /^\d{1,9}$/;
    const categoriaRegex = /^[A-Za-zÀ-ÿ\s]{2,50}$/;
  

    function validaTesto(input, errSpan, regex, messaggio) {
        if (!regex.test(input.value.trim())) {
            errSpan.textContent = messaggio;
            return false;
        }
        errSpan.textContent = '';
        return true;
    }

    function validaNome() {
        return validaTesto(nomeInput, errNome, nomeRegex,
            'Inserisci un nome valido ');
    }

    function validaMarca() {
        return validaTesto(marcaInput, errMarca, marcaRegex,
            'Inserisci una marca valida ');
    }

    function validaPrezzo() {
        return validaTesto(prezzoInput, errPrezzo, prezzoRegex,
            'Il prezzo deve essere un numero maggiore o uguale a 0');
    }

    function validaCategoria() {
        return validaTesto(categoriaInput, errCategoria, categoriaRegex,
            'La categoria deve contenere solo lettere ');
    }

    function validaGiacenza() {
        return validaTesto(giacenzaInput, errGiacenza, giacenzaRegex,
            'La giacenza deve essere un numero intero maggiore o uguale a 0.');
    }


    nomeInput.addEventListener('change', validaNome);
    marcaInput.addEventListener('change', validaMarca);
    prezzoInput.addEventListener('change', validaPrezzo);
    categoriaInput.addEventListener('change', validaCategoria);
    giacenzaInput.addEventListener('change', validaGiacenza);
    

    formProdotto.addEventListener('submit', function (event) {
        const risultati = [
            validaNome(),
            validaMarca(),
            validaPrezzo(),
            validaCategoria(),
            validaGiacenza(),
			];
			
        if (risultati.includes(false)) {
            event.preventDefault();
        }
    });
}