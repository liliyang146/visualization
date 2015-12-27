package lv.ddgatve.math

object MathOntology {

  val countryMap = Map("LV" -> "Latvia")

  /**
   * Find event year from the problem id
   */
  def getYearMap(id: String): Int = {
    val eventCode = id.replaceFirst("""([A-Z][A-Z]-)?([a-z0-9]+)-.*""", "$2")
    return yearMap(eventCode)
  }

  def getOlympiadName(id: String): String = {
    val eventCode = id.replaceFirst("""([A-Z][A-Z]-)?([a-z0-9]+)-.*""", "$2")
    return olympiadMap(eventCode)
  }

  val yearMap = Map(
    "amo38" -> 2011,
    "amo39" -> 2012,
    "amo40" -> 2013,
    "amo41" -> 2014,
    "sol61" -> 2011, 
    "cgmo12" -> 2013)

  val olympiadMap = Map(
    "amo38" -> "LV Open Math Olympiad",
    "amo39" -> "LV Open Math Olympiad",
    "amo40" -> "LV Open Math Olympiad",
    "amo41" -> "LV Open Math Olympiad",
    "sol61" -> "LV Prep Olympiad in Math",
    "cgmo12" -> "China Girls Mathematical Olympiad")

  val languageMap = Map("lv" -> "Latvian", "en" -> "English")

  val schoolAgeMap = Map("LV1" -> 8, "LV2" -> 9, "LV7" -> 10, "LV8" -> 11,
    "LV5" -> 12, "LV6" -> 13, "LV7" -> 14, "LV8" -> 15,
    "LV9" -> 16, "LV10" -> 17, "LV11" -> 18, "LV12" -> 19)

  val indexMap = Map(
    "en" -> List(("2013", "", "", "1 of 40", "amo40-list-en.html")),
    "lv" -> List(
      ("2011", "1 of 40", "sol61-list.html", "5 of 40", "amo38-list.html"),
      ("2012", "", "", "9 of 40", "amo39-list.html"),
      ("2013", "", "", "30 of 40", "amo40-list.html"),
      ("2014", "", "", "2 of 40", "amo41-list.html")))

  val abbrevMap = Map(
    "en" -> Map("SOL" -> "PrepO", "NOL" -> "RegO", "VOL" -> "StateO", "AMO" -> "OpenMO"),
    "lv" -> Map("SOL" -> "SOL", "NOL" -> "NOL", "VOL" -> "VOL", "AMO" -> "AMO"))

}


