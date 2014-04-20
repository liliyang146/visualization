package lv.ddgatve.math

import org.fusesource.scalate.TemplateEngine
import java.io.File
import org.fusesource.scalate.support.FileTemplateSource
import java.nio.file.{ Path, Paths, Files }
import java.io.PrintWriter
import org.apache.commons.io.FileUtils

object MakeLandingPages {

  def writeToFile(text: String, file: File): Unit = {
    val writer = new PrintWriter(file, "UTF-8")
    writer.write(text)
    writer.close()
  }

  def main(args: Array[String]): Unit = {
    // create destination directory, if it does not exist
    val folderPath: Path = Paths.get("target/site/math/")
    var tmpDir: Path = Files.createTempDirectory(folderPath, null)
    FileUtils.copyFile(new File("src/main/webapp/math/amo40-list.html"),
      new File("target/site/math/amo40-list.html"))
    FileUtils.copyFile(new File("src/main/webapp/math/ifd.js"),
      new File("target/site/math/idf.js"))

    val style1 = """      body {
        font-size: 100%; 
        margin: 2em 4em 2em 4em; 
        font-family: Trebuchet MS, Helvetica, Arial, sans serif;
      }
      h1 {
        margin-top: 2px;
        font-weight: normal;
      }
      h4 {
        margin: 4px
        padding: 4px
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
        swfobject.embedSWF("//www.youtube.com/e/XXXXXXXXXXX?enablejsapi=1&playerapiid=ytplayer &version=3",
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
      
      
    val googleAnalyticsScript = """(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-50196303-1', 'demografija.lv');
  ga('send', 'pageview');"""

    val result = OutlineParser.parseXmlOutline("src/main/resources/video-outlines.xml")

    val engine = new TemplateEngine
    engine.workingDirectory = new File("src/main/resources")
    var fts: FileTemplateSource = new FileTemplateSource(
      new File("src/main/resources/youtube-topics.scaml"),
      "http://85.254.250.28/downloads1/youtube-topics.scaml")

    for (pv <- result) {
      val m = Map("script1" -> script1,
        "script2" -> script2.replaceFirst("XXXXXXXXXXX", pv.YouTubeId),
        "style1" -> style1,
        "googleAnalyticsScript" -> googleAnalyticsScript,
        "pv" -> pv)

      writeToFile(engine.layout(fts, m),
        new File("target/site/math/" + pv.id + ".html"))
    }
  }
}
