/**
 * 
 */
function login() {
 
    var username = document.getElementById("UserName");
    var pass = document.getElementById("Password");
 
    if (username.value == "") {
 
        alert("Please enter the user name");
 
    } else if (pass.value  == "") {
 
        alert("Please enter the password");
 
    } else {
 
        alert("Please enter the correct user name and password！")
 
    }
}