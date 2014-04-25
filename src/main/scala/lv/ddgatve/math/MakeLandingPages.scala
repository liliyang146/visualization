package lv.ddgatve.math

import org.fusesource.scalate.TemplateEngine
import java.io.File
import org.fusesource.scalate.support.FileTemplateSource
import java.nio.file.{ Path, Paths, Files }
import java.io.PrintWriter
import org.apache.commons.io.FileUtils
import scala.collection.mutable.MutableList

object MakeLandingPages {

  def writeToFile(text: String, file: File): Unit = {
    val writer = new PrintWriter(file, "UTF-8")
    writer.write(text)
    writer.close()
  }

  def getLanguageSuffix(arg: String): String = {
    val langSuffix = arg.replaceFirst("""^.*-([a-z]+)\.[a-zA-Z]+$""", "$1")
    return langSuffix
  }

  def main(args: Array[String]): Unit = {
    // create destination directory, if it does not exist
    val folderPath: Path = Paths.get("target/site/math/")
    var tmpDir: Path = Files.createTempDirectory(folderPath, null)


    val engine = new TemplateEngine
    engine.workingDirectory = new File("src/main/resources")

    val inFiles = List("openmo40-outline-lv.xml",
      "openmo40-outline-en.xml")

    var problems = new MutableList[ProblemVideo]()
    for (inFile <- inFiles) {
      val outFile = ProblemIndex.getOutFile("src/main/resources/" + inFile)
      val plist = ProblemIndex.getIndex("src/main/resources/" + inFile)
      val templateName = "problemlist-" + getLanguageSuffix(inFile) + ".scaml"

      var indexTemplate: FileTemplateSource = new FileTemplateSource(
        new File("src/main/resources/" + templateName),
        "http://85.254.250.28/downloads1/" + templateName)
      val indexMap = Map("style1" -> HtmlConstants.style1,
        "googleAnalyticsScript" -> HtmlConstants.googleAnalyticsScript,
        "plist" -> plist)
      writeToFile(engine.layout(indexTemplate, indexMap),
        new File("target/site/math/" + outFile))

      var fts: FileTemplateSource = new FileTemplateSource(
        new File("src/main/resources/youtube-topics.scaml"),
        "http://85.254.250.28/downloads1/youtube-topics.scaml")

      val problemSublist = OutlineParser.parseXmlOutline("src/main/resources/" + inFile)
      problems = problems ++ problemSublist
      for (pv <- problemSublist) {
        val m = Map("script1" -> HtmlConstants.script1,
          "script2" -> HtmlConstants.script2.replaceFirst("XXXXXXXXXXX", pv.YouTubeId),
          "style1" -> HtmlConstants.style1,
          "googleAnalyticsScript" -> HtmlConstants.googleAnalyticsScript,
          "pv" -> pv,
          "lang" ->  getLanguageSuffix(inFile),
          "localizationStrings" -> new LocalizationStrings, 
          "indexFile" -> outFile)

        writeToFile(engine.layout(fts, m),
          new File("target/site/math/" + pv.id + "-" + getLanguageSuffix(inFile) + ".html"))
      }
    }

    val jsonText = (for (pv <- problems) yield { pv.toString }).foldLeft("")(_ + "\n\n" + _)
    val jsonFullText = "{\n    items: [" + jsonText + "]\n}"
    writeToFile(jsonFullText, new File("target/site/math/ifd.js"))
  }
}
