name := "hello"

version := "1.0"

scalaVersion := "2.10.4"

mainClass in (Compile, run) := Some("lv.ddgatve.math.MakeLandingPages")

libraryDependencies ++= Seq(
    "org.slf4j" % "slf4j-simple" % "1.7.6",
    "commons-io" % "commons-io" % "2.4",
    "com.jcraft" % "jsch" % "0.1.51"
)