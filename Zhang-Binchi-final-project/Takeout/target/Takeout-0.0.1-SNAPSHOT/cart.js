document.addEventListener("DOMContentLoaded",load);
function load(){
    var num = 0;
    var amount = 0;
    var item = 0;
    for(num=0;num<localStorage.length;num++) {
        var product;
        var key = localStorage.key(num);
        product= localStorage.getItem(key);
        var row = document.getElementsByClassName("w-100")[0];
        var newRow = document.createElement("div");
        newRow.classList.add("row");
        var namecol = document.createElement("div");
        namecol.classList.add("col-3");
        namecol.classList.add("col-sm-3");
        var pricecol = document.createElement("div");
        pricecol.classList.add("col-3");
        pricecol.classList.add("col-sm-3");
        var countcol = document.createElement("div");
        countcol.classList.add("col-3");
        countcol.classList.add("col-sm-3");
        var delcol = document.createElement("div");
        delcol.classList.add("col-3");
        delcol.classList.add("col-sm-3");
        var btndel = document.createElement("a");
        btndel.href="#";
        btndel.innerHTML = "delete";
        btndel.classList.add("btn-del");
        btndel.foodname = key;


        namecol.innerHTML = key;
        pricecol.innerHTML = JSON.parse(product).price;
        countcol.innerHTML = JSON.parse(product).count;
        delcol.appendChild(btndel);

        newRow.appendChild(namecol);
        newRow.appendChild(pricecol);
        newRow.appendChild(countcol);
        newRow.appendChild(delcol);

        row.appendChild(newRow);

        amount = JSON.parse(product).price * JSON.parse(product).count + amount;

        item = JSON.parse(product).count + item;

        btndel.addEventListener("click",deleteProduct);

    }

    items.innerHTML = "Products In Cart: " + item;
    am.innerHTML = "Product Amount: $"+ amount;
    minicart.innerHTML = item;

}

function deleteProduct(evt){

    localStorage.removeItem(evt.currentTarget.foodname);
    location.reload();

}






