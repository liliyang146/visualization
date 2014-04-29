package lv.ddgatve.math

import scala.collection.mutable.MutableList

object OutlineParser {

  // Parse the <part> element - return list of contained chunks
  def makePart(arg: scala.xml.Node): List[Chunk] = {
    val result = (arg \\ "item") map (
      itemNode => makeItem(itemNode))
    result.toList
  }

  // Parse the <item> element
  def makeItem(arg: scala.xml.Node): Chunk = {
    val itemTstamp = arg.attribute("tstamp").get(0).text
    val itemText = arg.head.text.trim.replaceAll("""(?m)\s+""", " ")
    new Chunk(itemTstamp, itemText)

  }

  def parseXmlOutline(path: String): List[ProblemSlot] = {
    val rootElem = scala.xml.XML.loadFile(path)
    val languageCode = (rootElem \\ "problems").head.attribute("lang").get(0).text
    var result = new MutableList[ProblemSlot]
    // ignore those, which are not deployed ("youtube" tag empty), 
    // except those that are references ("youtube" tag does not exist at all). 
    for (
      elt <- rootElem \\ "problems" \\ "problem" if ((elt \\ "youtube").size == 0 ||
        (elt \\ "youtube").head.text.length > 0)
    ) {
      if ((elt \\ "youtube").size > 0) {
        val pVideo = new ProblemVideo
        pVideo.id = elt.attribute("id").get(0).text
        println("Processing " + pVideo.id)
        pVideo.languageCode = languageCode
        pVideo.title = (elt \\ "title").head.text
        pVideo.YouTubeId = (elt \\ "youtube").head.text
        pVideo.topic = (elt \\ "topic").head.text
        pVideo.description = (elt \\ "description").head.text.trim.replaceAll("""(?m)\s+""", " ")
        // read part titles only
        val partTitleSeq = (elt \\ "part") map (
          partNode => partNode.attribute("name").get(0).text)
        pVideo.chunkListTitles = partTitleSeq.toList

        // read notes
        val noteSeq = (elt \\ "notes" \\ "item") map (
          noteNode => noteNode.head.text.trim().replaceAll("""(?m)\s+""", " "))
        pVideo.notes = noteSeq.toList

        // parse chunks in all parts

        val chunkListSeq = (elt \\ "part") map {
          partNode => makePart(partNode)
        }
        pVideo.chunkLists = chunkListSeq.toList
        result += pVideo
      }
      
      else {
        val pVideo = new ProblemReference
        pVideo.id = elt.attribute("id").get(0).text
        println("Processing " + pVideo.id)
        pVideo.languageCode = languageCode
        pVideo.title = (elt \\ "title").head.text
        pVideo.description = (elt \\ "description").head.text.trim.replaceAll("""(?m)\s+""", " ")
        pVideo.linkHref = (elt \\ "problemlink").head.attribute("href").get(0).text
        pVideo.linkText = (elt \\ "problemlink").head.text.trim()
        result += pVideo
      }
    }
    result.toList
  }

}