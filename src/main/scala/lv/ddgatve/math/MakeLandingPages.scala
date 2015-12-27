package lv.ddgatve.math

//import org.fusesource.scalate.TemplateEngine
import org.fusesource.scalate._
import java.io.File
import org.fusesource.scalate.support.FileTemplateSource
import java.nio.file.{ Path, Paths, Files }
import java.io.PrintWriter
import org.apache.commons.io.FileUtils
import scala.collection.mutable.MutableList
import scala.io.Source
import lv.ddgatve.scp.NewScpTo
import scala.collection.immutable.TreeMap

object MakeLandingPages {

  //  val menuKeys = List("home.html",
  //    "contest-math-class.html",
  //    "about-lvamo.html",
  //    "about-lvsol.html",
  //    "other-videos.html")
  val topMenu = Map("home.html" -> "Sākums <span class='caret'></span>",
    "contest-math-class.html" -> "Materiāli <span class='caret'></span>",
    "about-lvamo.html" -> "LV AMO <span class='caret'></span>",
    "about-lvsol.html" -> "LV Sagat. <span class='caret'></span>",
    "other-videos.html" -> "Citi video <span class='caret'></span>")
  val lvamoMap = TreeMap("amo38-list.html" -> "2010./2011.m.g.",
    "amo39-list.html" -> "2011./2012.m.g.",
    "amo40-list.html" -> "2012./2013.m.g.",
    "amo41-list.html" -> "2013./2014.m.g.")
  val lvsolMap = TreeMap("sol61-list.html" -> "2010./2011.m.g.")
  val tempMap = TreeMap(
    "k" -> "index.html",
    "v" -> "Video šķirotājs",
    "http://www.delfi.lv" -> "Delfi",
    "http://www.apollo.lv" -> "Apollo")

  val navRoot = scala.xml.XML.loadFile("src/main/resources/nav.xml")
  val menuKeys = ((navRoot \ "item") map
    { x => x.head.attribute("id").get(0).text }).toList
  val theMenu = ((navRoot \ "item") map
    { x => x.head.attribute("id").get(0).text }).toList

  //println("menuKeys = " + menuKeys)

  def writeToFile(text: String, file: File): Unit = {
    val writer = new PrintWriter(file, "UTF-8")
    writer.write(text)
    writer.close()
  }

  def listDirectoryByPattern(path: String, regex: String): List[File] = {
    val dir = new File(path)
    val myBigFileArray = dir.listFiles()
    val result = myBigFileArray.filter(f => regex.r.findFirstIn(f.getName).isDefined)
    result.toList
  }

  def main(args: Array[String]): Unit = {
    // create empty destination directory, if it does not exist
    //FileUtils.deleteDirectory(new File("target/site/math/"))
    val folderPath: Path = Paths.get("target/site/math/")
    var tmpDir: Path = Files.createTempDirectory(folderPath, null)

    val pngFiles = listDirectoryByPattern("src/main/resources/png", """.*\.png$""")
    for (pngFile <- pngFiles) {
      FileUtils.copyFile(pngFile,
        new File("target/site/math/" + pngFile.getName()))
    }
    val webFiles = listDirectoryByPattern("src/main/resources/web", """.*\.(js|html|css)$""")
    for (webFile <- webFiles) {
      FileUtils.copyFile(webFile,
        new File("target/site/math/" + webFile.getName()))
    }

    val subDirs = List("pdf", "pptx")
    val filePatterns = List("""\.pdf$""", """\.pptx$""", """\.(js|json)$""", """\.css$""")
    //val pattern = """\.(pdf|pptx|js|json)$"""

    for (subDir <- subDirs) {
      val theFiles = listDirectoryByPattern("src/main/resources/" + subDir, filePatterns.mkString("|"))
      for (theFile <- theFiles) {
        FileUtils.copyFile(theFile,
          new File("target/site/math/" + theFile.getName()))
      }
    }

    val projectDirs = List("math/nim-game",
        "math/nim-game2",
        "math/ajax-ex", 
        "math/another-game", 
        "math/chapter01", 
        "math/sync-objs-arrays", 
        "math/simple-fb")
    val projectSubDirs = List(".", "js", "libs", 
        "domain", "property", "sync-array", "sync-object", "game")
    val projectFilePatterns = List("""\.html$""", """\.js$""", """\.json$""", """\.css$""")
    for (projectDir <- projectDirs) {
      for (projectSubDir <- projectSubDirs) {
        if ((new File("src/main/resources/" + projectDir + "/" + projectSubDir)).exists) {
          val theFiles = listDirectoryByPattern(
            "src/main/resources/" + projectDir + "/" + projectSubDir,
            projectFilePatterns.mkString("|"))
          for (theFile <- theFiles) {
            FileUtils.copyFile(theFile,
              new File("target/site/math/" + projectDir + "/" + projectSubDir + "/" + theFile.getName()))
          }
        }
      }
    }

    val engine = new TemplateEngine
    engine.workingDirectory = new File("target")
    //    engine.escapeMarkup = true

    val bundleLines = Source.fromFile(new File("src/main/resources/bundle.txt")).getLines().toList
    val inFiles = bundleLines map (_.trim) filter (_.length() > 0)

    var problems = new MutableList[ProblemSlot]()
    for (inFile <- inFiles) {
      val outFile = ProblemIndex.getOutFile("src/main/resources/" + inFile)
      val plist = ProblemIndex.getIndex("src/main/resources/" + inFile)
      val indexTemplate = "src/main/resources/problemlist-lv.scaml"
      val languageOpts = if (inFile.startsWith("openmo40")) {
        List(("Latvian(lv)", "amo40-list.html"),
          ("English(en)", "amo40-list-en.html"))
      } else {
        List()
      }
      val indexMap = Map(
        "googleAnalyticsScript" -> HtmlConstants.googleAnalyticsScript,
        "plist" -> plist,
        "olympiadTitle" -> ProblemIndex.getOlympiadTitle("src/main/resources/" + inFile),
        "lang" -> ProblemIndex.getLanguageSuffix(inFile),
        "localizationStrings" -> new LocalizationStrings,
        "indexMap" -> MathOntology.indexMap,
        "abbrevMap" -> MathOntology.abbrevMap,
        "languageOpts" -> languageOpts,
        "topMenu" -> topMenu,
        "menuKeys" -> menuKeys,
        "lvamoMap" -> lvamoMap,
        "lvsolMap" -> lvsolMap)
      writeToFile(engine.layout(indexTemplate, indexMap),
        new File("target/site/math/" + outFile))
      val defaultTemplate = "src/main/resources/default.scaml"
      val exhibitTemplate = "src/main/resources/exhibitTemplate.scaml"

      val staticFiles = List("about-lvamo.xml",
        "about-lvsol.xml",
        "all-topics.xml",
        "contest-math-class.xml",
        "home.xml",
        "home-ad.xml",
        "other-videos.xml",
        "other-videos-fr.xml",
        "topics-4-7.xml",
        "topics-8-12.xml")
      for (staticFile <- staticFiles) {
        val bodyText = scala.io.Source.fromFile("src/main/resources/web/" + staticFile).mkString
        val m = Map(
          "googleAnalyticsScript" -> HtmlConstants.googleAnalyticsScript,
          "bodyText" -> bodyText,
          "topMenu" -> topMenu,
          "menuKeys" -> menuKeys,
          "lvamoMap" -> lvamoMap,
          "lvsolMap" -> lvsolMap)
        val newName = staticFile.replaceFirst("xml$", "html")
        writeToFile(engine.layout(defaultTemplate, m),
          new File("target/site/math/" + newName))
      }

      val facetFiles = List("index.xml")
      for (facetFile <- facetFiles) {
        val bodyText = scala.io.Source.fromFile("src/main/resources/web/" + facetFile).mkString
        val m = Map(
          "googleAnalyticsScript" -> HtmlConstants.googleAnalyticsScript,
          "bodyText" -> bodyText,
          "exhibitScript1" -> HtmlConstants.exhibitScript1,
          "exhibitScript2" -> HtmlConstants.exhibitScript2,
          "topMenu" -> topMenu,
          "menuKeys" -> menuKeys,
          "lvamoMap" -> lvamoMap,
          "lvsolMap" -> lvsolMap)
        val newName = facetFile.replaceFirst("xml$", "html")
        writeToFile(engine.layout(exhibitTemplate, m),
          new File("target/site/math/" + newName))
      }

      val fts = "src/main/resources/youtube-topics.scaml"
      val fts2 = "src/main/resources/youtube-reference.scaml"

      val problemSublist = OutlineParser.parseXmlOutline("src/main/resources/" + inFile)
      problems = problems ++ problemSublist
      for (pv <- problemSublist) {
        if (pv.isInstanceOf[ProblemVideo]) {
          val pvv = pv.asInstanceOf[ProblemVideo]
          val m = Map("script1" -> HtmlConstants.script1,
            "script2" -> HtmlConstants.script2.replaceFirst("XXXXXXXXXXX", pvv.YouTubeId),
            "googleAnalyticsScript" -> HtmlConstants.googleAnalyticsScript,
            "pv" -> pvv,
            "lang" -> ProblemIndex.getLanguageSuffix(inFile),
            "localizationStrings" -> new LocalizationStrings,
            "indexFile" -> outFile,
            "topMenu" -> topMenu,
            "menuKeys" -> menuKeys,
            "lvamoMap" -> lvamoMap,
            "lvsolMap" -> lvsolMap)
          writeToFile(engine.layout(fts, m),
            new File("target/site/math/" + pvv.id + ".html"))
        }

        if (pv.isInstanceOf[ProblemReference]) {
          val pvr = pv.asInstanceOf[ProblemReference]

          val m = Map(
            "googleAnalyticsScript" -> HtmlConstants.googleAnalyticsScript,
            "pv" -> pvr,
            "lang" -> ProblemIndex.getLanguageSuffix(inFile),
            "localizationStrings" -> new LocalizationStrings,
            "indexFile" -> outFile,
            "topMenu" -> topMenu,
            "menuKeys" -> menuKeys,
            "lvamoMap" -> lvamoMap,
            "lvsolMap" -> lvsolMap)
          writeToFile(engine.layout(fts2, m),
            new File("target/site/math/" + pvr.id + ".html"))

        }
      }
    }

    val jsonText = (for (pv <- problems) yield { pv.toString }).foldLeft("")(_ + "\n\n" + _)
    val jsonFullText = "{\n    items: [" + jsonText + "]\n}"
    writeToFile(jsonFullText, new File("target/site/math/ifd.js"))

    if (args.length > 0 && args(0) == "-local") {
      println("Skip upload")
    } else {
      val llfile = listDirectoryByPattern("target/site/math", """.*\.(js|json|html|css|png|pdf|pptx)$""")
      val projLlFile = for (projectDir <- projectDirs) yield {
        for (projectSubDir <- projectSubDirs) yield {
          if ((new File("src/main/resources/" + projectDir + "/" + projectSubDir)).exists) {
            listDirectoryByPattern(
              "target/site/math/" + projectDir + "/" + projectSubDir,
              projectFilePatterns.mkString("|"))
          } else { List() }
        }
      }
      val projFlatLlFile = (projLlFile.flatten).flatten
      val commonList = llfile ++ projFlatLlFile

      val lfile = commonList map (ff => attachPrefix("target/site/math/", ff))
      val rfile = commonList map (ff => attachPrefix("/home/lighttpd/dudajevagatve.lv/http/math/", ff))
      println("Copying " + lfile.size + " files to remote server")

      //      for (commonFile <- rfile) {
      //        println("path = " + commonFile)
      //      }
      NewScpTo.copyToRemote(lfile, rfile)

    }

  }

  def attachPrefix(prefix: String, file: File): String = {
    val result = prefix +
      file.getPath.substring("target/site/math/".length())
    result.replaceAll("""\\""", """/""")
  }
}
