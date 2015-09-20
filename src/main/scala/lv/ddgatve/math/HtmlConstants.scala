package lv.ddgatve.math

object HtmlConstants {

  val style1 = ""
//  val style1 = """      body {
//        font-size: 100%; 
//        margin: 1em 4em 2em 4em; 
//        font-family: Trebuchet MS, Helvetica, Arial, sans serif;
//      }
//      h1 {
//        margin-top: 2px;
//        font-weight: normal;
//      }
//      h4 {
//        margin: 4px
//        padding: 4px
//      }
//      div.line {
//        margin: 0em;
//        padding: 0em;
//      } 
//      div.indentedLine {
//        margin: 0em 0em 0em 2em;
//        padding: 0em;
//      }
//      div.problem {
//        border: 1px solid black;
//        width: 560px;
//        background-color: #ffffcc;
//        padding: 5px;
//      }
//      table.index {
//	    border: 0px solid red;
//      }
//      table.index td {
//        border-bottom: 1px solid #cccccc;
//        border-left: 1px solid #cccccc;
//        border-right: 1px solid #cccccc;
//      }
//      table.index th {
//        font-size: 120%;
//        padding-top: 10px;
//        text-align: left;
//        border-bottom: 1px solid #cccccc;
//      }
//	  
//	  table.rightmenu {
//	    border: 0px solid red;
//      }  
//	  table.rightmenu th {
//        font-size: 120%;
//        padding-top: 10px;
//        text-align: center;
//        border-bottom: 1px solid #cccccc;
//      }
//	  
//	  table.rightmenu th.noborder {
//        font-size: 120%;
//        padding-top: 10px;
//        text-align: center;
//        border-bottom: 0px solid #cccccc;
//      }
//	  
//	  table.rightmenu td {
//        border-bottom: 1px solid #cccccc;
//        border-left: 1px solid #cccccc;
//        border-right: 1px solid #cccccc;
//		text-align: center;
//      }
//	  
//	  table.rightmenu td.noborder {
//        border-bottom: 0px solid #cccccc;
//        border-left: 0px solid #cccccc;
//        border-right: 1px solid #cccccc;
//		text-align: center;
//      }
//    
//      nav {
//        background-color: #fff;
//        border: 1px solid #dedede;
//        border-radius: 4px;
//        box-shadow: 0 2px 2px -1px rgba(0, 0, 0, 0.055);
//        color: #888;
//        display: block;
//        margin: 0px 0px 0px 0px;
//        overflow: hidden;
//        width: 100%; 
//      }
//
//      nav ul {
//        margin: 0;
//        padding: 0;
//      }
//
//      nav ul li {
//        display: inline-block;
//        list-style-type: none;      
//        -webkit-transition: all 0.2s;
//        -moz-transition: all 0.2s;
//        -ms-transition: all 0.2s;
//        -o-transition: all 0.2s;
//        transition: all 0.2s; 
//      }
//      
//      nav > ul > li > a > .caret {
//        border-top: 4px solid #aaa;
//        border-right: 4px solid transparent;
//        border-left: 4px solid transparent;
//        content: "";
//        display: inline-block;
//        height: 0;
//        width: 0;
//        vertical-align: middle;
//        -webkit-transition: color 0.1s linear;
//        -moz-transition: color 0.1s linear;
//        -o-transition: color 0.1s linear;
//        transition: color 0.1s linear; 
//      }
//
//      nav > ul > li > a {
//        color: #aaa;
//        display: block;
//        line-height: 56px;
//        padding: 0 24px;
//        text-decoration: none;
//      }
//
//      nav > ul > li:hover {
//        background-color: rgb( 40, 44, 47 );
//      }
//
//      nav > ul > li:hover > a {
//        color: rgb( 255, 255, 255 );
//      }
//
//      nav > ul > li:hover > a > .caret {
//        border-top-color: rgb( 255, 255, 255 );
//      }
//      
//      nav > ul > li > div {
//        background-color: rgb( 40, 44, 47 );
//        border-top: 0;
//        border-radius: 0 0 4px 4px;
//        box-shadow: 0 2px 2px -1px rgba(0, 0, 0, 0.055);
//        display: none;
//        margin: 0;
//        opacity: 0;
//        position: absolute;
//        width: 165px;
//        visibility: hidden;
//        z-index: 100;
//        -webkit-transiton: opacity 0.2s;
//        -moz-transition: opacity 0.2s;
//        -ms-transition: opacity 0.2s;
//        -o-transition: opacity 0.2s;
//        -transition: opacity 0.2s;
//      }
//
//      nav > ul > li:hover > div {
//        display: block;
//        opacity: 1;
//        visibility: visible;
//      }
//
//      nav > ul > li > div ul > li {
//        display: block;
//      }
//
//      nav > ul > li > div ul > li > a {
//        color: #fff;
//        display: block;
//        padding: 12px 24px;
//        text-decoration: none;
//      }
//
//      nav > ul > li > div ul > li:hover > a {
//        background-color: rgba( 255, 255, 255, 0.1);
//      }
//    
//    
//      ol.topic {
//        counter-reset: list;
//      }
//
//      ol.topic > li {
//        list-style: none;
//      }
//    
//      ol.topic > li:before {
//        content: "(" counter(list, lower-alpha) ") ";
//        counter-increment: list;
//      }"""

  val exhibitScript1 = """var rowStyler = function(item, database, tr) {
      var form = database.getObject(item, "form");
      var color = "white";
      switch (form) {
      case "circle":              color = "white"; break;
      case "couple":   color = "#FFDFAD"; break;
      case "line":              color = "#DEEFFF"; break;
      }
      tr.style.background = color;
      };"""
    
    val exhibitScript2 = """function toggle(obj) {
      var el = document.getElementById(obj);
      if ( el.style.display != 'none' ) {
      el.style.display = 'none';
      el.style.visibility = 'hidden';
      }
      else {
      el.style.display = '';
      el.style.visibility = 'visible';
      }
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

  val googleAnalyticsScript = """  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-32739031-1', 'dudajevagatve.lv');
  ga('send', 'pageview');"""

}