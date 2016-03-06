<<<<<<< HEAD
body {
	font-size: 100%;
	margin: 1em 4em 2em 4em;
	font-family: Trebuchet MS, Helvetica, Arial, sans serif;
}

h1 {
	margin-top: 2px;
	font-weight: normal;
}

h4 {
	margin: 4px padding: 4px
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
	border: 0px solid red;
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
}

table.rightmenu {
	border: 1px solid red;
}

table.rightmenu th {
	font-size: 120%;
	padding-top: 10px;
	text-align: center;
	border-bottom: 1px solid #cccccc;
}

table.rightmenu th.noborder {
	font-size: 120%;
	padding-top: 10px;
	text-align: center;
	border-bottom: 0px solid #cccccc;
}

table.rightmenu td {
	border-bottom: 1px solid #cccccc;
	border-left: 1px solid #cccccc;
	border-right: 1px solid #cccccc;
	text-align: center;
	padding:  4px
}

table.rightmenu td.bottomline {
	border-bottom-style: double; 	
	border-bottom: 3px double #ff0000;
}

table.rightmenu td.noborder {
	border-bottom: 0px solid #cccccc;
	border-left: 0px solid #cccccc;
	border-right: 1px solid #cccccc;
	text-align: center;
}





nav {
  background-color: #fff;
  border: 1px solid #dedede;
  border-radius: 4px;
  box-shadow: 0 2px 2px -1px rgba(0, 0, 0, 0.055);
  color: #888;
  display: block;
  margin: 8px 22px 8px 22px;
  overflow: hidden;
  width: 90%; 
}

  nav ul {
    margin: 0;
    padding: 0;
  }

    nav ul li {
      display: inline-block;
      list-style-type: none;
      
      -webkit-transition: all 0.2s;
        -moz-transition: all 0.2s;
        -ms-transition: all 0.2s;
        -o-transition: all 0.2s;
        transition: all 0.2s; 
    }
      
      nav > ul > li > a > .caret,
	  nav > ul > li > div ul > li > a > .caret {
        border-top: 4px solid #aaa;
        border-right: 4px solid transparent;
        border-left: 4px solid transparent;
        content: "";
        display: inline-block;
        height: 0;
        width: 0;
        vertical-align: middle;
  
        -webkit-transition: color 0.1s linear;
     	  -moz-transition: color 0.1s linear;
       	-o-transition: color 0.1s linear;
          transition: color 0.1s linear; 
      }
	  
	  	nav > ul > li > div ul > li > a > .caret {
			border-bottom: 4px solid transparent;
			border-top: 4px solid transparent;
			border-right: 4px solid transparent;
			border-left: 4px solid #f2f2f2;
			margin: 0 0 0 8px;
		}

      nav > ul > li > a {
        color: #aaa;
        display: block;
        line-height: 56px;
        padding: 0 24px;
        text-decoration: none;
      }

        nav > ul > li:hover {
          background-color: rgb( 40, 44, 47 );
        }

        nav > ul > li:hover > a {
          color: rgb( 255, 255, 255 );
        }

        nav > ul > li:hover > a > .caret {
          border-top-color: rgb( 255, 255, 255 );
        }
		
		nav > ul > li > div ul > li:hover > a > .caret {
			border-left-color: rgb(255,255,255);
		}
      
      nav > ul > li > div,
	  nav > ul > li > div ul > li > div {
        background-color: rgb( 40, 44, 47 );
        border-top: 0;
        border-radius: 0 0 4px 4px;
        box-shadow: 0 2px 2px -1px rgba(0, 0, 0, 0.055);
        display: none;
        margin: 0;
        opacity: 0;
        position: absolute;
        width: 165px;
        visibility: hidden;
  
        -webkit-transiton: opacity 0.2s;
        -moz-transition: opacity 0.2s;
        -ms-transition: opacity 0.2s;
        -o-transition: opacity 0.2s;
        -transition: opacity 0.2s;
      }
	  
	  	nav > ul > li > div ul > li > div {
			background-color: rgb( 40, 44, 47 );
			border-radius: 0 4px 4px 4px;
			box-shadow: inset 2px 0 5px rgba(0,0,0,.15);
			margin-top: -42px;
			right: -165px;
		}

        nav > ul > li:hover > div,
		nav > ul > li > div ul > li:hover > div {
          display: block;
          opacity: 1;
          visibility: visible;
        }

          nav > ul > li > div ul > li,
		  nav > ul > li > div ul > li > div ul > li {
            display: block;
			position: relative;
          }

            nav > ul > li > div ul > li > a,
			nav > ul > li > div ul > li > div ul > li > a {
              color: #fff;
              display: block;
              padding: 12px 24px;
              text-decoration: none;
            }

              nav > ul > li > div ul > li:hover > a {
                background-color: rgba( 255, 255, 255, 0.1);
              }
	


/*
nav {
	background-color: #fff;
	border: 1px solid #dedede;
	border-radius: 4px;
	box-shadow: 0 2px 2px -1px rgba(0, 0, 0, 0.055);
	color: #888;
	display: block;
	margin: 0px 0px 0px 0px;
	overflow: hidden;
	width: 100%;
}

nav ul {
	margin: 0;
	padding: 0;
}

nav ul li {
	display: inline-block;
	list-style-type: none;
	-webkit-transition: all 0.2s;
	-moz-transition: all 0.2s;
	-ms-transition: all 0.2s;
	-o-transition: all 0.2s;
	transition: all 0.2s;
}

nav>ul>li>a>.caret {
	border-top: 4px solid #aaa;
	border-right: 4px solid transparent;
	border-left: 4px solid transparent;
	content: "";
	display: inline-block;
	height: 0;
	width: 0;
	vertical-align: middle;
	-webkit-transition: color 0.1s linear;
	-moz-transition: color 0.1s linear;
	-o-transition: color 0.1s linear;
	transition: color 0.1s linear;
}

nav>ul>li>a {
	color: #aaa;
	display: block;
	line-height: 56px;
	padding: 0 24px;
	text-decoration: none;
}

nav>ul>li:hover {
	background-color: rgb(40, 44, 47);
}

nav>ul>li:hover>a {
	color: rgb(255, 255, 255);
}

nav>ul>li:hover>a>.caret {
	border-top-color: rgb(255, 255, 255);
}

nav>ul>li>div {
	background-color: rgb(40, 44, 47);
	border-top: 0;
	border-radius: 0 0 4px 4px;
	box-shadow: 0 2px 2px -1px rgba(0, 0, 0, 0.055);
	display: none;
	margin: 0;
	opacity: 0;
	position: absolute;
	width: 165px;
	visibility: hidden;
	z-index: 100;
	-webkit-transiton: opacity 0.2s;
	-moz-transition: opacity 0.2s;
	-ms-transition: opacity 0.2s;
	-o-transition: opacity 0.2s;
	-transition: opacity 0.2s;
}

nav>ul>li:hover>div {
	display: block;
	opacity: 1;
	visibility: visible;
}

nav>ul>li>div ul>li {
	display: block;
}

nav>ul>li>div ul>li>a {
	color: #fff;
	display: block;
	padding: 12px 24px;
	text-decoration: none;
}

nav>ul>li>div ul>li:hover>a {
	background-color: rgba(255, 255, 255, 0.1);
}
*/



ol.topic {
	counter-reset: list;
}

ol.topic>li {
	list-style: none;
}

ol.topic>li:before {
	content: "(" counter(list, lower-alpha) ") ";
	counter-increment: list;
}

dt {
	font-weight: bold;
}

dl.topic ul {
	-webkit-margin-before: 0em;
}
=======
body {
	font-size: 100%;
	margin: 1em 4em 2em 4em;
	font-family: Trebuchet MS, Helvetica, Arial, sans serif;
}

h1 {
	margin-top: 2px;
	font-weight: normal;
}

h4 {
	margin: 4px padding: 4px
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
	border: 0px solid red;
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
}

table.rightmenu {
	border: 1px solid red;
}

table.rightmenu th {
	font-size: 120%;
	padding-top: 10px;
	text-align: center;
	border-bottom: 1px solid #cccccc;
}

table.rightmenu th.noborder {
	font-size: 120%;
	padding-top: 10px;
	text-align: center;
	border-bottom: 0px solid #cccccc;
}

table.rightmenu td {
	border-bottom: 1px solid #cccccc;
	border-left: 1px solid #cccccc;
	border-right: 1px solid #cccccc;
	text-align: center;
	padding:  4px
}

table.rightmenu td.bottomline {
	border-bottom-style: double; 	
	border-bottom: 3px double #ff0000;
}

table.rightmenu td.noborder {
	border-bottom: 0px solid #cccccc;
	border-left: 0px solid #cccccc;
	border-right: 1px solid #cccccc;
	text-align: center;
}





nav {
  background-color: #fff;
  border: 1px solid #dedede;
  border-radius: 4px;
  box-shadow: 0 2px 2px -1px rgba(0, 0, 0, 0.055);
  color: #888;
  display: block;
  margin: 8px 22px 8px 22px;
  overflow: hidden;
  width: 90%; 
}

  nav ul {
    margin: 0;
    padding: 0;
  }

    nav ul li {
      display: inline-block;
      list-style-type: none;
      
      -webkit-transition: all 0.2s;
        -moz-transition: all 0.2s;
        -ms-transition: all 0.2s;
        -o-transition: all 0.2s;
        transition: all 0.2s; 
    }
      
      nav > ul > li > a > .caret,
	  nav > ul > li > div ul > li > a > .caret {
        border-top: 4px solid #aaa;
        border-right: 4px solid transparent;
        border-left: 4px solid transparent;
        content: "";
        display: inline-block;
        height: 0;
        width: 0;
        vertical-align: middle;
  
        -webkit-transition: color 0.1s linear;
     	  -moz-transition: color 0.1s linear;
       	-o-transition: color 0.1s linear;
          transition: color 0.1s linear; 
      }
	  
	  	nav > ul > li > div ul > li > a > .caret {
			border-bottom: 4px solid transparent;
			border-top: 4px solid transparent;
			border-right: 4px solid transparent;
			border-left: 4px solid #f2f2f2;
			margin: 0 0 0 8px;
		}

      nav > ul > li > a {
        color: #aaa;
        display: block;
        line-height: 56px;
        padding: 0 24px;
        text-decoration: none;
      }

        nav > ul > li:hover {
          background-color: rgb( 40, 44, 47 );
        }

        nav > ul > li:hover > a {
          color: rgb( 255, 255, 255 );
        }

        nav > ul > li:hover > a > .caret {
          border-top-color: rgb( 255, 255, 255 );
        }
		
		nav > ul > li > div ul > li:hover > a > .caret {
			border-left-color: rgb(255,255,255);
		}
      
      nav > ul > li > div,
	  nav > ul > li > div ul > li > div {
        background-color: rgb( 40, 44, 47 );
        border-top: 0;
        border-radius: 0 0 4px 4px;
        box-shadow: 0 2px 2px -1px rgba(0, 0, 0, 0.055);
        display: none;
        margin: 0;
        opacity: 0;
        position: absolute;
        width: 165px;
        visibility: hidden;
  
        -webkit-transiton: opacity 0.2s;
        -moz-transition: opacity 0.2s;
        -ms-transition: opacity 0.2s;
        -o-transition: opacity 0.2s;
        -transition: opacity 0.2s;
      }
	  
	  	nav > ul > li > div ul > li > div {
			background-color: rgb( 40, 44, 47 );
			border-radius: 0 4px 4px 4px;
			box-shadow: inset 2px 0 5px rgba(0,0,0,.15);
			margin-top: -42px;
			right: -165px;
		}

        nav > ul > li:hover > div,
		nav > ul > li > div ul > li:hover > div {
          display: block;
          opacity: 1;
          visibility: visible;
        }

          nav > ul > li > div ul > li,
		  nav > ul > li > div ul > li > div ul > li {
            display: block;
			position: relative;
          }

            nav > ul > li > div ul > li > a,
			nav > ul > li > div ul > li > div ul > li > a {
              color: #fff;
              display: block;
              padding: 12px 24px;
              text-decoration: none;
            }

              nav > ul > li > div ul > li:hover > a {
                background-color: rgba( 255, 255, 255, 0.1);
              }
	


/*
nav {
	background-color: #fff;
	border: 1px solid #dedede;
	border-radius: 4px;
	box-shadow: 0 2px 2px -1px rgba(0, 0, 0, 0.055);
	color: #888;
	display: block;
	margin: 0px 0px 0px 0px;
	overflow: hidden;
	width: 100%;
}

nav ul {
	margin: 0;
	padding: 0;
}

nav ul li {
	display: inline-block;
	list-style-type: none;
	-webkit-transition: all 0.2s;
	-moz-transition: all 0.2s;
	-ms-transition: all 0.2s;
	-o-transition: all 0.2s;
	transition: all 0.2s;
}

nav>ul>li>a>.caret {
	border-top: 4px solid #aaa;
	border-right: 4px solid transparent;
	border-left: 4px solid transparent;
	content: "";
	display: inline-block;
	height: 0;
	width: 0;
	vertical-align: middle;
	-webkit-transition: color 0.1s linear;
	-moz-transition: color 0.1s linear;
	-o-transition: color 0.1s linear;
	transition: color 0.1s linear;
}

nav>ul>li>a {
	color: #aaa;
	display: block;
	line-height: 56px;
	padding: 0 24px;
	text-decoration: none;
}

nav>ul>li:hover {
	background-color: rgb(40, 44, 47);
}

nav>ul>li:hover>a {
	color: rgb(255, 255, 255);
}

nav>ul>li:hover>a>.caret {
	border-top-color: rgb(255, 255, 255);
}

nav>ul>li>div {
	background-color: rgb(40, 44, 47);
	border-top: 0;
	border-radius: 0 0 4px 4px;
	box-shadow: 0 2px 2px -1px rgba(0, 0, 0, 0.055);
	display: none;
	margin: 0;
	opacity: 0;
	position: absolute;
	width: 165px;
	visibility: hidden;
	z-index: 100;
	-webkit-transiton: opacity 0.2s;
	-moz-transition: opacity 0.2s;
	-ms-transition: opacity 0.2s;
	-o-transition: opacity 0.2s;
	-transition: opacity 0.2s;
}

nav>ul>li:hover>div {
	display: block;
	opacity: 1;
	visibility: visible;
}

nav>ul>li>div ul>li {
	display: block;
}

nav>ul>li>div ul>li>a {
	color: #fff;
	display: block;
	padding: 12px 24px;
	text-decoration: none;
}

nav>ul>li>div ul>li:hover>a {
	background-color: rgba(255, 255, 255, 0.1);
}
*/



ol.topic {
	counter-reset: list;
}

ol.topic>li {
	list-style: none;
}

ol.topic>li:before {
	content: "(" counter(list, lower-alpha) ") ";
	counter-increment: list;
}

dt {
	font-weight: bold;
}

dl.topic ul {
	-webkit-margin-before: 0em;
}
>>>>>>> 776dcba87548e5adb70f44f53f0bd1e662e35ffa
