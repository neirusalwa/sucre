# sucre
yet another gif tool (this one is better tho)  

a fork of vanille that is a lot more lightweight and modular than vanille itself  

sucre is a fully standalone script that will convert any input video you drag and drop on the script file into a gif with pretty good quality 
however unlike vanille sucre is entirely self contained thus every feature vanille had (seek, profiles, optimization, ytdl) is now optional  
to get those features u just need to follow this folder structure  

sucre.bat  
runes    
-script.bat  
-script.bat  
-script.bat  
-etc...  

### requirements
ffmpeg  
ffprobe  
gifski  

### optional
youtube-dl

### faq
> why does it remove the video after the gif is done?

the goal of this script is to make gifs not to be a youtube dl downloader, if u want smth like that feel free to take a look at heyam on my github which does exactly that  

> why are scripts called "runes"?

if u know u know  

> why batch?

no

### available runes
seek : adds a function to set a start point and an end point to the clip you want to gif instead of converting the entire video  
ytdl : lets you use an online video just double click the script instead of the usual drag and drop and you will be prompted to input a url  

### wip runes
optimization : simple gifsicle loop until the gif reaches a desired target size
profiles : enable the ability to select a specific framerate or size for the gif as well as adding custom settings "easily" (by editing the profiles script) 
