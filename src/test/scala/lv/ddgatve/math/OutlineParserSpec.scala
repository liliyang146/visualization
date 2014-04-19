package lv.ddgatve.math

import org.specs2.mutable._

class OutlineParserSpec extends Specification {
  "The 'OutlineParser' object" should {
    "return nonempty list for parseXmlFile(...)" in {
      val result = OutlineParser.parseXmlOutline("src/main/resources/video-outlines.xml")
      result must not beNull
    }
    "return first problem id,title,youtubeid" in {
      val result = OutlineParser.parseXmlOutline("src/main/resources/video-outlines.xml")
      result(0).id mustEqual "lv-openmo40-g05-p01"
      result(0).title mustEqual "40. AMO, 5.klases 1. Uzdevums"
      result(0).YouTubeId mustEqual "UNyM7DyFDug"
    }
    "return normalized description" in {
      val result = OutlineParser.parseXmlOutline("src/main/resources/video-outlines.xml")
      result(0).description mustEqual "Cik reizes diennaktī sakrīt pulksteņa stundu un minūšu " +
        "rādītāji? (Plkst. 00:00 un 24:00 ieskaitīt vienu reizi.) <i>Atbildi pamatot!</i>"

    }
    "return multiple items" in {
      val result = OutlineParser.parseXmlOutline("src/main/resources/video-outlines.xml")
      result.size must be_>=(15)
    }
    "populate notes" in {
      val result = OutlineParser.parseXmlOutline("src/main/resources/video-outlines.xml")
      result(0).notes(1) mustEqual "Kas notiktu tad, ja stundu un minūšu rādītāji " +
        "virzītos viens otram pretī?"
    }

    "have part titles" in {
      val result = OutlineParser.parseXmlOutline("src/main/resources/video-outlines.xml")
      result(0).chunkListTitles mustEqual List("Uzdevuma saprašana", "Risināšanas plāns")
    }

    "have chunk lists" in {
      val result = OutlineParser.parseXmlOutline("src/main/resources/video-outlines.xml")
      val theLists: List[List[Chunk]] = result(0).chunkLists
      theLists(0) must not beNull

      theLists(0)(0) must not beNull
    }

    "have chunk list content" in {
      val result = OutlineParser.parseXmlOutline("src/main/resources/video-outlines.xml")
      val theLists: List[List[Chunk]] = result(0).chunkLists
      theLists(0)(0).text mustEqual "Ko uzdevumā prasīts noskaidrot."
      theLists(0)(0).tstamp mustEqual "0:17"
      theLists(0)(0).getSeconds mustEqual 17
    }
  }
}