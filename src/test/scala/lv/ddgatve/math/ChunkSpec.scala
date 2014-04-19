package lv.ddgatve.math

import org.specs2.mutable._

class ChunkSpec extends Specification {

  "The 'Chunk' object" should {
    "allow constructor" in {
      val c = new Chunk("00:12", "bb")
      c must not beNull
    }
    "allow getting params set in constructor" in {
      val c = new Chunk("1:23", "bb")
      c.tstamp mustEqual "1:23"
      c.text mustEqual "bb"
    }
    "allow getting seconds" in {
      val c = new Chunk("0:12", "bb")
      c.getSeconds mustEqual 12
    }
  }
}