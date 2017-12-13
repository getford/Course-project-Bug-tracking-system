function div_show_prEdit() {
    document.getElementById('projectEdit').style.display = "block";
    document.getElementsByTagName("body").style.opacity = .75;
}

//Function to Hide Popup
function div_hide_prEdit() {
    document.getElementById('projectEdit').style.display = "none";
    document.getElementsByTagName("body").style.opacity = 1;
}