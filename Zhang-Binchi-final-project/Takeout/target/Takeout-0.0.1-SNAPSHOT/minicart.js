document.addEventListener("DOMContentLoaded",mini);
function mini() {

    var num = 0;
    var item = 0;
    for (num = 0; num < localStorage.length; num++) {
        var product;
        var key = localStorage.key(num);
        product = localStorage.getItem(key);

        item = JSON.parse(product).count + item;
    }
    minicart.innerHTML=item;
}
