package lv.ddgatve.math

import org.fusesource.scalate.TemplateEngine
import java.io.File
import org.fusesource.scalate.support.FileTemplateSource
import java.nio.file.{ Path, Paths, Files }
import java.io.PrintWriter
import org.apache.commons.io.FileUtils
import scala.collection.mutable.MutableList
import scala.io.Source
import lv.ddgatve.scp.NewScpTo

object MakeLandingPages {

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

    val engine = new TemplateEngine
    engine.workingDirectory = new File("target")

    val bundleLines = Source.fromFile(new File("src/main/resources/bundle.txt")).getLines().toList
    val inFiles = bundleLines map (_.trim) filter (_.length() > 0)

    var problems = new MutableList[ProblemSlot]()
    for (inFile <- inFiles) {
      val outFile = ProblemIndex.getOutFile("src/main/resources/" + inFile)
      val plist = ProblemIndex.getIndex("src/main/resources/" + inFile)
      val templateName = "problemlist-lv.scaml"

      var indexTemplate: FileTemplateSource = new FileTemplateSource(
        new File("src/main/resources/" + templateName),
        "http://85.254.250.28/downloads1/" + templateName)
      val languageOpts = if (inFile.startsWith("openmo40")) {
        List(("Latvian(lv)", "amo40-list.html"),
          ("English(en)", "amo40-list-en.html"))
      } else {
        List()
      }
      val indexMap = Map("style1" -> HtmlConstants.style1,
        "googleAnalyticsScript" -> HtmlConstants.googleAnalyticsScript,
        "plist" -> plist,
        "olympiadTitle" -> ProblemIndex.getOlympiadTitle("src/main/resources/" + inFile),
        "lang" -> ProblemIndex.getLanguageSuffix(inFile),
        "localizationStrings" -> new LocalizationStrings,
        "indexMap" -> MathOntology.indexMap,
        "abbrevMap" -> MathOntology.abbrevMap,
        "languageOpts" -> languageOpts)
      writeToFile(engine.layout(indexTemplate, indexMap),
        new File("target/site/math/" + outFile))

      var fts: FileTemplateSource = new FileTemplateSource(
        new File("src/main/resources/youtube-topics.scaml"),
        "http://85.254.250.28/downloads1/youtube-topics.scaml")

      var fts2: FileTemplateSource = new FileTemplateSource(
        new File("src/main/resources/youtube-reference.scaml"),
        "http://85.254.250.28/downloads1/youtube-reference.scaml")

      val problemSublist = OutlineParser.parseXmlOutline("src/main/resources/" + inFile)
      problems = problems ++ problemSublist
      for (pv <- problemSublist) {
        if (pv.isInstanceOf[ProblemVideo]) {
          val pvv = pv.asInstanceOf[ProblemVideo]
          val m = Map("script1" -> HtmlConstants.script1,
            "script2" -> HtmlConstants.script2.replaceFirst("XXXXXXXXXXX", pvv.YouTubeId),
            "style1" -> HtmlConstants.style1,
            "googleAnalyticsScript" -> HtmlConstants.googleAnalyticsScript,
            "pv" -> pvv,
            "lang" -> ProblemIndex.getLanguageSuffix(inFile),
            "localizationStrings" -> new LocalizationStrings,
            "indexFile" -> outFile)
          writeToFile(engine.layout(fts, m),
            new File("target/site/math/" + pvv.id + ".html"))
        }

        if (pv.isInstanceOf[ProblemReference]) {
          val pvr = pv.asInstanceOf[ProblemReference]

          val m = Map("style1" -> HtmlConstants.style1,
            "googleAnalyticsScript" -> HtmlConstants.googleAnalyticsScript,
            "pv" -> pvr,
            "lang" -> ProblemIndex.getLanguageSuffix(inFile),
            "localizationStrings" -> new LocalizationStrings,
            "indexFile" -> outFile)
          writeToFile(engine.layout(fts2, m),
            new File("target/site/math/" + pvr.id + ".html"))

        }
      }
    }

    val jsonText = (for (pv <- problems) yield { pv.toString }).foldLeft("")(_ + "\n\n" + _)
    val jsonFullText = "{\n    items: [" + jsonText + "]\n}"
    writeToFile(jsonFullText, new File("target/site/math/ifd.js"))



    val llfile = listDirectoryByPattern("target/site/math", """.*\.(js|html|css|png)$""")
    //println("llfile = " + llfile)
    val lfile = llfile map (ff => "target/site/math/" + ff.getName())
    val rfile = llfile map (ff => "/home/lighttpd/dudajevagatve.lv/http/math/" + ff.getName())
    println("Copying " + lfile.size + " files to remote server")

    NewScpTo.copyToRemote(lfile, rfile)

  }
}
