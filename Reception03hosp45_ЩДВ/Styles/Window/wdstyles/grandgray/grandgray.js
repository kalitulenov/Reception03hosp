// blue style preload emails
function grandgrayPreloadImage(path)
{
    //list of image that will be preloaded\    
    var preImageLinks = new Array("CloseOut.gif","MaximizeOut.gif");
    
    //preload action
    for(var i=0;i<preImageLinks.length;i++)
    {
        var img = new Image();
        img.src = path+"/"+preImageLinks[i];
        img.style.display = "none";
        document.body.insertBefore(img,document.body.firstChild);
    }
}
