package lv.ddgatve.math

import org.specs2.mutable._

class ProblemVideoSpec extends Specification {
  "The 'ProblemVideo' object" should {
    "output correct label" in {
      val pv = new ProblemVideo
      pv.id = "lv-openmo40-g05-p01"
      val result = pv.toString
      println("result is " + result)
      result must contain(pv.id)
    }
  }
}