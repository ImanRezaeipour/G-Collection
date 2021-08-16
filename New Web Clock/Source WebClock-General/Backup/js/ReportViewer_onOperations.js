/// <reference path="jquery-1.7.1.js" />


$(window).load(function () {
    HideLoadingImage();
});
function HideLoadingImage() {
if(document.getElementById('divImgLoading')!=null)
    document.getElementById('divImgLoading').style.visibility = 'hidden';
}
        


