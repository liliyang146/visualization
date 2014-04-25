package lv.ddgatve.math

import org.specs2.mutable._

class MakeLandingPagesSpec extends Specification {
  "The 'MakeLandingPages' object" should {
    "compute language suffix" in {
      val result = MakeLandingPages.getLanguageSuffix("openmo40-outline-en.xml")
      result mustEqual "en"
    }
  }

}