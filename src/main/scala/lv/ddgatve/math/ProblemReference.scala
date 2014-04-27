package lv.ddgatve.math

class ProblemReference extends ProblemSlot {
  var id = ""
  var languageCode = "lv"
  var title = ""
  var description = ""
  var linkHref = ""
  var linkText = ""

  /**
   * JSON stuff is not needed
   */
  override def toString(): String = {
    return ""
  }
}