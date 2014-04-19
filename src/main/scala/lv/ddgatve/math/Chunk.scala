package lv.ddgatve.math

class Chunk(val tstamp:String, val text:String) {
  val cc = tstamp.split(":")
  val seconds = 60*cc(0).toInt + cc(1).toInt
  def getSeconds(): Int = seconds 
}