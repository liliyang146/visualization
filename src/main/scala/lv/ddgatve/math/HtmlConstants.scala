package lv.ddgatve.math

object HtmlConstants {

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
      }
      table.index {
      }
      table.index td {
        border-bottom: 1px solid #cccccc;
        border-left: 1px solid #cccccc;
        border-right: 1px solid #cccccc;
      }
      table.index th {
        font-size: 120%;
        padding-top: 10px;
        text-align: left;
        border-bottom: 1px solid #cccccc;
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

}