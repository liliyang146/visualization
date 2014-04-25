package lv.ddgatve.math

class ProblemVideo {
  var id = ""
  var languageCode = "lv"
  var title = ""
  var description = ""
  var YouTubeId = ""
  var chunkLists: List[List[Chunk]] = List()
  var chunkListTitles: List[String] = List()
  var notes: List[String] = List()
  var topic: String = ""

  override def toString(): String = {
    val countryCode = id.replaceFirst("""^([a-z]+)-.*""", "$1")
    //println("countryCode = " + countryCode)
    val eventCode = id.replaceFirst("""[a-z]+-([a-z0-9]+)-.*""", "$1")
    //println("eventCode = " + eventCode)
    val country = MathOntology.countryMap(countryCode)
    val year = MathOntology.yearMap(eventCode)
    val olympiadName = MathOntology.olympiadMap(eventCode)
    val languageName = MathOntology.languageMap(languageCode)
    val tShorter = title.replaceFirst("klases", "kl.")
    val tShortest = tShorter.replaceFirst("uzdevums", "uzd.")
    val (g, p) = ProblemIndex.getGradeAndProblem(id)
    val age = MathOntology.schoolAgeMap(countryCode + g)

    s"""{
            type: "Video",
            label: "$id",   
            form: "Grade$g-Age13",
            choreographer:  "kalvisapsitis1",
            year:  "$year",
            lesson: "$languageName",
            withChoreographer: "yes",
			camp: "$olympiadName",
            subjects: "$topic",
            YTurl: "https://www.youtube.com/watch?v=$YouTubeId",
			vurl: "$id.html", 
            quality: "high",
	        thumbnail:"http://img.youtube.com/vi/$YouTubeId/default.jpg",
            hasVenue: true,
            loc: "$country",
	        hebrewName: "$tShortest",
	        source: "submitted",
	        submitter:"KA",
	        submitterEmail: "datu.nesejs@gmail.com",
	        note: "...",
	        submitDate: "2014-04-04",
	        upDate: "2014-04-04"
  },"""
  }
}