package lv.ddgatve.math

import org.fusesource.scalate.TemplateEngine
import java.io.File
import org.fusesource.scalate.support.FileTemplateSource

object MakeLandingPages {

  def main(args:Array[String]): Unit = {
    
    val style1 = """      body {
        font-size: 100%; 
        margin: 2em 4em 2em 4em; 
        font-family: Trebuchet MS, Helvetica, Arial, sans serif;
      }
      h1 {
        font-weight: normal;
      }
      div.line {
        margin: 0em;
        padding: 0em;
      } 
      div.indentedLine {
        margin: 0em 0em 0em 2em;
        padding: 0em;
      }
      div.problem {
        border: 1px solid black;
        width: 560px;
        background-color: #ffffcc;
        padding: 5px;
      }"""
      
    val script1 = """//this function gets called when the player is ready    
      function onYouTubePlayerReady (playerId) {
        ytplayer = document.getElementById("myytplayer");
        console.log(ytplayer);
      }
      //generic seekTo function taking a player element and seconds as parameters    
      function playerSeekTo(player, seconds) {
        player.seekTo(seconds);
      }"""
      
      val script2 = """      var ytplayer;  
      $(document).ready(function() {
        swfobject.embedSWF("//www.youtube.com/e/UNyM7DyFDug?enablejsapi=1&playerapiid=ytplayer &version=3",
        "ytapiplayer", // where the embedded player ends up
        "560", // width    
        "315", // height    
        "8", // swf version    
        null,
        null, {
            allowScriptAccess: "always"
        }, {
            id: "myytplayer"
        });   
      });"""
    
    val m = Map("script1" -> script1, "script2" -> script2, "style1" -> style1)
    
    val engine = new TemplateEngine
    engine.workingDirectory = new File("src/main/resources")
    var fts:FileTemplateSource = new FileTemplateSource(new File("src/main/resources/youtube-topics.scaml"),"http://85.254.250.28/downloads1/youtube-topics.scaml")
    print(engine.layout(fts, m))
  }
}
