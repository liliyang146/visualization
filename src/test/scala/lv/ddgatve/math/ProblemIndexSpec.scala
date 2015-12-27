package lv.ddgatve.math

import org.specs2.mutable._

class ProblemIndexSpec extends Specification {

  "The 'ProblemIndex' object" should {
    "shorten descriptions" in {
      val desc = """Dots trijstūris ABC un punkts P tā iekšpusē. Pierādi, ka attālumu
summa no punkta P līdz dotā trijstūra virsotnēm ir lielāka nekā
puse no trijstūra perimetra."""
      val desc2 = ProblemIndex.shortenDescription(desc)
      desc2.length() mustEqual 100
    }

    "extract alt from images" in {
      val desc = """AAA <img src="BBB" alt="CCC"/> DDD"""
      val desc2 = ProblemIndex.shortenDescription(desc)
      desc2 mustEqual """AAA [CCC] DDD"""
    }

    "compute language suffix" in {
      val result = ProblemIndex.getLanguageSuffix("openmo40-outline-en.xml")
      result mustEqual "en"
    }
    
    "compute outfile for problem lists" in {
      val result = ProblemIndex.getOutFile("src/main/resources/amo38-list.xml")
      result mustEqual "amo38-list.html"
    }

  }
}