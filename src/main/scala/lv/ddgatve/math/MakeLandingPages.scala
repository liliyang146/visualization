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

  def main(args: Array[String]): Unit = {
    // create destination directory, if it does not exist
    val folderPath: Path = Paths.get("target/site/math/")
    var tmpDir: Path = Files.createTempDirectory(folderPath, null)

    val engine = new TemplateEngine
    engine.workingDirectory = new File("src/main/resources")

    val inFiles = List("openmo38-outline-lv.xml", "openmo39-outline-lv.xml", "openmo40-outline-lv.xml",
      "openmo40-outline-en.xml", "openmo41-outline-lv.xml")

    var problems = new MutableList[ProblemSlot]()
    for (inFile <- inFiles) {
      val outFile = ProblemIndex.getOutFile("src/main/resources/" + inFile)
      val plist = ProblemIndex.getIndex("src/main/resources/" + inFile)
      val templateName = "problemlist-" + ProblemIndex.getLanguageSuffix(inFile) + ".scaml"

      var indexTemplate: FileTemplateSource = new FileTemplateSource(
        new File("src/main/resources/" + templateName),
        "http://85.254.250.28/downloads1/" + templateName)
      val indexMap = Map("style1" -> HtmlConstants.style1,
        "googleAnalyticsScript" -> HtmlConstants.googleAnalyticsScript,
        "plist" -> plist,
        "olympiadTitle" -> ProblemIndex.getOlympiadTitle("src/main/resources/" + inFile),
        "lang" -> ProblemIndex.getLanguageSuffix(inFile),
        "localizationStrings" -> new LocalizationStrings,
        "indexMap" -> MathOntology.indexMap)
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
            new File("target/site/math/" + pvv.id + "-" + ProblemIndex.getLanguageSuffix(inFile) + ".html"))
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
            new File("target/site/math/" + pvr.id + "-" + ProblemIndex.getLanguageSuffix(inFile) + ".html"))

        }
      }
    }

    val jsonText = (for (pv <- problems) yield { pv.toString }).foldLeft("")(_ + "\n\n" + _)
    val jsonFullText = "{\n    items: [" + jsonText + "]\n}"
    writeToFile(jsonFullText, new File("target/site/math/ifd.js"))
  }
}
