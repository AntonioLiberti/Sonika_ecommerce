document.addEventListener("DOMContentLoaded", function() {
    const regEmail = document.getElementById("regEmail");
    const errRegEmail = document.getElementById("errRegEmail");
    const regPassword = document.getElementById("regPassword");
    const errRegPassword = document.getElementById("errRegPassword");
    const formRegistrazione = document.getElementById("formRegistrazione");
    
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    // Password: minimo 8 caratteri, almeno una lettera e un numero
    const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
    

    if (regEmail) {
        regEmail.addEventListener("change", function() {
            const email = regEmail.value;
            errRegEmail.innerText = "";
            
            if (!emailRegex.test(email)) {
                errRegEmail.innerText = "Formato email non valido (es: nome@email.com).";
                return;
            }
            

            const xhr = new XMLHttpRequest();
            xhr.open("GET", "CheckEmail?email=" + encodeURIComponent(email), true);
            xhr.onload = function() {
                if (xhr.status === 200) {
                    if (xhr.responseText.trim() === "esiste") {
                        errRegEmail.innerText = "Questa email è già registrata. Scegline un'altra.";
                    }
                }
            };
            xhr.send();
        });
    }
    
    if (formRegistrazione) {
        formRegistrazione.addEventListener("submit", function(event) {
            let valido = true;
            errRegEmail.innerText = "";
            errRegPassword.innerText = "";
            
            if (!emailRegex.test(regEmail.value)) {
                errRegEmail.innerText = "Formato email non valido.";
                valido = false;
            }
            
            if (!passwordRegex.test(regPassword.value)) {
                errRegPassword.innerText = "La password deve contenere almeno 8 caratteri, una lettera e un numero.";
                valido = false;
            }
            
            if (!valido || errRegEmail.innerText === "Questa email è già registrata. Scegline un'altra.") {
                event.preventDefault(); 
            }
        });
    }
});