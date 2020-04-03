// default style preload emails
function defaultPreloadImage(path)
{
    //list of image that will be preloaded\    
    var preImageLinks = new Array("CloseDown.gif","CloseOut.gif","MaximizeDown.gif","MaximizeOut.gif","RestoreDownDown.gif","RestoreDownOut.gif");
    
    //preload action
    for(var i=0;i<preImageLinks.length;i++)
    {
        var img = new Image();
        img.src = path+"/"+preImageLinks[i];
        img.style.display = "none";
        document.body.insertBefore(img,document.body.firstChild);
    }
}
