$(window).load(function () {
    HideLoadingImage();
});
function HideLoadingImage() {
    if (document.getElementById('divImgLoading') != null)
        document.getElementById('divImgLoading').style.visibility = 'hidden';
}