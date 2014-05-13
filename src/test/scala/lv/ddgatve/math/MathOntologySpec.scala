package lv.ddgatve.math

import org.specs2.mutable._

class MathOntologySpec extends Specification {
  
  "The getYearMap function" should {
    "return 2011" in {
      val result = MathOntology.getYearMap("sol61-g12-p01");
      result mustEqual 2011
    }
  }

}

