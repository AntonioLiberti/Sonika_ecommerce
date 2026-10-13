const formCheckout = document.getElementById('formCheckout');
const indirizzoInput = document.getElementById('chkIndirizzo');
const errIndirizzo = document.getElementById('errIndirizzo');
const cartaInput = document.getElementById('chkCarta');
const errCarta = document.getElementById('errCarta');

const indirizzoRegex = /^[a-zA-Z0-9À-ÿ\s,.'/-]{5,}$/;
const cartaRegex = /^\d{16}$/;

if (formCheckout) {
    indirizzoInput.addEventListener('change', function() {
        if (!indirizzoRegex.test(indirizzoInput.value.trim())) {
            errIndirizzo.innerText = "Inserisci un indirizzo valido (minimo 5 caratteri).";
        } else {
            errIndirizzo.innerText = "";
        }
    });

    cartaInput.addEventListener('change', function() {
        if (!cartaRegex.test(cartaInput.value.trim())) {
            errCarta.innerText = "Inserisci un numero di carta valido (esattamente 16 cifre).";
        } else {
            errCarta.innerText = "";
        }
    });

    formCheckout.addEventListener('submit', function(event) {
        let formValido = true;

        if (!indirizzoRegex.test(indirizzoInput.value.trim())) {
            errIndirizzo.innerText = "Inserisci un indirizzo valido (minimo 5 caratteri).";
            formValido = false;
        }

        if (!cartaRegex.test(cartaInput.value.trim())) {
            errCarta.innerText = "Inserisci un numero di carta valido (esattamente 16 cifre).";
            formValido = false;
        }

        if (!formValido) {
            event.preventDefault();
        }
    });
}