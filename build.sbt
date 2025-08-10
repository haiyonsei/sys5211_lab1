//scalaVersion := "2.13.10"
scalaVersion := "2.12.10"

scalacOptions ++= Seq(
  "-deprecation:false",
  "-feature",
  "-unchecked",
  //"-Xfatal-warnings",
  "-language:reflectiveCalls",
)

val chiselVersion = "3.6.1"
addCompilerPlugin("edu.berkeley.cs" %% "chisel3-plugin" % chiselVersion cross CrossVersion.full)
libraryDependencies += "edu.berkeley.cs" %% "chisel3" % chiselVersion
libraryDependencies += "edu.berkeley.cs" %% "chiseltest" % "0.6.1"
