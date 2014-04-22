package lv.ddgatve.math

import scala.collection.mutable.MutableList

object ProblemIndex {

  def shortenDescription(desc: String): String = {
    val eltDescription = desc.trim //.replaceAllLiterally("\n"," ")
    val eltDescription1 = eltDescription.replaceAll("""(?m)\s+""", " ")
    val eltDescription15 = eltDescription1.replaceAll("""(?m)<img [^<>]+alt="([^<>"]+)"[^<>]+>""", "[$1]")
    val eltDescription2 = eltDescription15.replaceAll("""(?m)<[^<>]+>""", "")
    val reducedDescription = if (eltDescription2.length() > 100) {
      eltDescription2.substring(0, 97) + "..."
    } else {
      eltDescription2
    }
    reducedDescription
  }

  /*
   * Return a list of links (id attribute) and problem descriptions. 
   * Each pair of link+description is a tuple. 
   */
  def getIndex(path: String): List[(String, String, Int, Int)] = {

    val rootElem = scala.xml.XML.loadFile(path)
    val items = (rootElem \\ "problems" \\ "problem") map (
      elt => {
        val eltId = elt.attribute("id").get(0).text
        val gOpt = """^.*(-g([0-9]+)-).*$""".r.findFirstMatchIn(eltId).map(_ group 2)
        val g = gOpt.get.toInt

        val pOpt = """^.*(-p([0-9]+))$""".r.findFirstMatchIn(eltId).map(_ group 2)
        val p = pOpt.get.toInt
        val reducedDescription = shortenDescription((elt \\ "description").head.text)
       
        Tuple4(eltId, reducedDescription, g, p)
      })

    // indexlines sorted by grade (typically grade is from 5 to 12). 
    val aa = for (grade <- 1 to 20) yield {
      val gradeItems = items filter (item => item._3 == grade)
      if (gradeItems.size > 0) {
        List(Tuple4("", "", grade, 0)) ++ gradeItems
      } else {
        List[(String, String, Int, Int)]()
      }
    }
    val result = aa.foldLeft(List[(String, String, Int, Int)]())(_ ::: _)

    return result
  }

}