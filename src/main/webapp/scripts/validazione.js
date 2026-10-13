let emailDuplicata = false;

const formReg = document.getElementById('formRegistrazione');
const emailInput = document.getElementById('regEmail');
const errEmail = document.getElementById('errRegEmail');
const passInput = document.getElementById('regPassword');
const errPass = document.getElementById('errRegPassword');
const nomeInput = document.getElementById('regNome');
const errNome = document.getElementById('errRegNome');
const cognomeInput = document.getElementById('regCognome');
const errCognome = document.getElementById('errRegCognome');

const formLogin = document.getElementById('formLogin');
const logEmailInput = document.getElementById('logEmail');
const errLogEmail = document.getElementById('errLogEmail');
const logPassInput = document.getElementById('logPassword');
const errLogPass = document.getElementById('errLogPassword');

const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
const passRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
const nomeRegex = /^[a-zA-ZÀ-ÿ\s']{2,50}$/;

if (formReg) {
    nomeInput.addEventListener('change', function() {
        if (!nomeRegex.test(nomeInput.value.trim())) {
            errNome.innerText = "Inserisci un nome valido (min. 2 lettere).";
        } else {
            errNome.innerText = "";
        }
    });

    cognomeInput.addEventListener('change', function() {
        if (!nomeRegex.test(cognomeInput.value.trim())) {
            errCognome.innerText = "Inserisci un cognome valido (min. 2 lettere).";
        } else {
            errCognome.innerText = "";
        }
    });

    passInput.addEventListener('change', function() {
        if (!passRegex.test(passInput.value)) {
            errPass.innerText = "Minimo 8 caratteri, inclusi una lettera e un numero.";
        } else {
            errPass.innerText = "";
        }
    });

    emailInput.addEventListener('change', function() {
        if (!emailRegex.test(emailInput.value.trim())) {
            errEmail.innerText = "Formato email non valido.";
            return;
        }
        let xhr = new XMLHttpRequest();
        xhr.open("GET", "CheckEmail?email=" + encodeURIComponent(emailInput.value.trim()), true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                if (xhr.responseText.trim() === "esiste") {
                    errEmail.innerText = "Questa email è già registrata.";
                    emailDuplicata = true;
                } else {
                    errEmail.innerText = "";
                    emailDuplicata = false;
                }
            }
        };
        xhr.send();
    });

    formReg.addEventListener('submit', function(event) {
        let formValido = true;

        if (!emailRegex.test(emailInput.value.trim()) || emailDuplicata) {
            errEmail.innerText = emailDuplicata ? "Questa email è già registrata." : "Formato email non valido.";
            formValido = false;
        }
        if (!passRegex.test(passInput.value)) {
            errPass.innerText = "Minimo 8 caratteri, inclusi una lettera e un numero.";
            formValido = false;
        }
        if (!nomeRegex.test(nomeInput.value.trim())) {
            errNome.innerText = "Inserisci un nome valido (min. 2 lettere).";
            formValido = false;
        }
        if (!nomeRegex.test(cognomeInput.value.trim())) {
            errCognome.innerText = "Inserisci un cognome valido (min. 2 lettere).";
            formValido = false;
        }

        if (!formValido) {
            event.preventDefault();
        }
    });
}

if (formLogin) {
    logEmailInput.addEventListener('change', function() {
        if (!emailRegex.test(logEmailInput.value.trim())) {
            errLogEmail.innerText = "Formato email non valido.";
        } else {
            errLogEmail.innerText = "";
        }
    });

    logPassInput.addEventListener('change', function() {
        if (logPassInput.value.trim() === "") {
            errLogPass.innerText = "Inserisci la password.";
        } else {
            errLogPass.innerText = "";
        }
    });

    formLogin.addEventListener('submit', function(event) {
        let loginValido = true;

        if (!emailRegex.test(logEmailInput.value.trim())) {
            errLogEmail.innerText = "Formato email non valido.";
            loginValido = false;
        }
        if (logPassInput.value.trim() === "") {
            errLogPass.innerText = "Inserisci la password.";
            loginValido = false;
        }

        if (!loginValido) {
            event.preventDefault();
        }
    });
}