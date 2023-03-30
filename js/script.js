const fd1 = document.querySelector("#fd1");
const fd2 = document.querySelector("#fd2");
const slct = document.querySelector("select");

function displays() {
    let value = slct.value;

    if (value=="Średnia ocen") {
        fd1.removeAttribute("class");
        fd1.setAttribute("class", "d-none");

        fd2.removeAttribute("class");
    } else {
        fd2.removeAttribute("class");
        fd2.setAttribute("class", "d-none");

        fd1.removeAttribute("class");
    }
}