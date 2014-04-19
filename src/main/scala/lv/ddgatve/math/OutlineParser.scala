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

  def parseXmlOutline(path: String): List[ProblemVideo] = {
    val rootElem = scala.xml.XML.loadFile(path)
    var result = new MutableList[ProblemVideo]
    for (elt <- rootElem \\ "problems" \\ "problem") {
      val pVideo = new ProblemVideo
      pVideo.id = elt.attribute("id").get(0).text
      pVideo.title = (elt \\ "title").head.text
      pVideo.YouTubeId = (elt \\ "youtube").head.text
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
    result.toList
  }

}