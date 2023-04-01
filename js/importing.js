const r1 = document.querySelector("#studenci");
const r2 = document.querySelector("#projekty");
const r3 = document.querySelector("#zainteresowania");
const r4 = document.querySelector("#kierunki");
const desc = document.querySelector("#instruction");

function description() {

    if (r1.checked) {
        desc.innerHTML = "Wybrany plik .csv nie powinien zawierać nagłówków ani tytułów/ID wierszy. Powinien posiadać następujące kolumny w dokładnie odwzorowanej kolejnośći:<br><table class='table mt-3'><tr><th>Imię</th><th>Nazwisko</th><th>Numer albumu</th><th>Numer kierunku studiów<br><a href='study.php'>Lista kierunków</a></th><th>Średnią ocen</th></tr></table>"
    }

    if (r2.checked) {
        desc.innerHTML = "Wybrany plik .csv nie powinien zawierać nagłówków ani tytułów/ID wierszy. Zostaną one automatycznie dopisane do studentów, którzy nie będą mieli jeszcze wprowadzonego projektu. Plik powinien posiadać następujące kolumny w dokładnie odwzorowanej kolejnośći:<br><table class='table mt-3'><tr><th>Tytuł pracy</th><th>Ocena</th></tr></table>"
    }

    if (r3.checked) {
        desc.innerHTML = "Wybrany plik .csv nie powinien zawierać nagłówków ani tytułów/ID wierszy. Zostaną one automatycznie dopisane do studentów, którzy nie będą mieli jeszcze wprowadzonego zainteresowania. Powinien posiadać następujące kolumny w dokładnie odwzorowanej kolejnośći:<br><table class='table mt-3'><tr><th>Nazwa zainteresowania</th></tr></table>"
    }

    if (r4.checked) {
        desc.innerHTML = "Wybrany plik .csv nie powinien zawierać nagłówków ani tytułów/ID wierszy. Powinien posiadać następujące kolumny w dokładnie odwzorowanej kolejnośći:<br><table class='table mt-3'><tr><th>Nazwę kierunku</th></tr></table>"
    }

}