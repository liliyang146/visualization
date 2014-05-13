package lv.ddgatve.math

import org.specs2.mutable._
import java.util.Formatter
import java.util.Locale

class MakeLandingPagesSpec extends Specification {
  "The listFiles function" should {
    "return javascripts" in {
      val result = MakeLandingPages.listDirectoryByPattern("src/main/resources/web", """.*\.js$""")
      println("JS files are " + result)
      result.size mustEqual 4
    }
  }

}