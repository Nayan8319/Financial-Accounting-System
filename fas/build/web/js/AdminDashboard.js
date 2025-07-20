/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/javascript.js to edit this template
 */


let navs = document.getElementsByClassName("nav-link");

for (let i = 0; i < navs.length; i++) {
    navs[i].addEventListener("click", function () {
        // Remove "active" class from all items
        for (let j = 0; j < navs.length; j++) {
            navs[j].classList.remove("active");
        }
        // Add "active" class to the clicked item
        navs[i].classList.add("active");
    });
}

document.addEventListener("DOMContentLoaded", () => {
    navs[0].click();
});

function setPage(pageName) {
    document.getElementById("pageTitle").innerText = pageName;
}