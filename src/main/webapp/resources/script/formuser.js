function div_show_us() {
    document.getElementById('user').style.display = "block";
    document.getElementsByTagName("body").style.opacity = .75;
}

//Function to Hide Popup
function div_hide_us() {
    document.getElementById('user').style.display = "none";
    document.getElementsByTagName("body").style.opacity = 1;
}