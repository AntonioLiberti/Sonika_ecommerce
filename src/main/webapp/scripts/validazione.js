
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

const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
const passRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/; 
const nomeRegex = /^[a-zA-Z\s]{2,50}$/; 


emailInput.addEventListener('change', function() {
    if (!emailRegex.test(emailInput.value)) {
        errEmail.innerText = "Formato email non valido.";
        return;
    }
    let xhr = new XMLHttpRequest();
    xhr.open("GET", "CheckEmail?email=" + encodeURIComponent(emailInput.value), true);
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

passInput.addEventListener('change', function() {
    if (!passRegex.test(passInput.value)) {
        errPass.innerText = "Minimo 8 caratteri, inclusi una lettera e un numero.";
    } else {
        errPass.innerText = "";
    }
});

nomeInput.addEventListener('change', function() {
     if (!nomeRegex.test(nomeInput.value)) {
         errNome.innerText = "Inserisci un nome valido (solo lettere).";
     } else {
         errNome.innerText = "";
     }
});

cognomeInput.addEventListener('change', function() {
     if (!nomeRegex.test(cognomeInput.value)) {
         errCognome.innerText = "Inserisci un cognome valido (solo lettere).";
     } else {
         errCognome.innerText = "";
     }
});

formReg.addEventListener('submit', function(event) {
    let formValido = true;
    if (!emailRegex.test(emailInput.value) || emailDuplicata) {
        errEmail.innerText = emailDuplicata ? "Questa email è già registrata." : "Formato email non valido.";
        formValido = false;
    }
   
    if (!passRegex.test(passInput.value)) {
        errPass.innerText = "Minimo 8 caratteri, inclusi una lettera e un numero.";
        formValido = false;
    }
    if (!nomeRegex.test(nomeInput.value)) {
        errNome.innerText = "Inserisci un nome valido.";
        formValido = false;
    }
    if (!nomeRegex.test(cognomeInput.value)) {
        errCognome.innerText = "Inserisci un cognome valido.";
        formValido = false;
    }
    if (!formValido) {
        event.preventDefault(); 
    }
});