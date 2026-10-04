# Nim dependencies to write blog posts with nimib (see nbsrc/)

version       = "0.1.0"
author        = "Pietro Peterlongo"
description   = "A personal blog"
license       = "MIT"
bin           = @[]

requires "nim >= 2.0.0"
requires "nimib >= 0.4.1"
requires "karax >= 1.5.0"

task posts, "build all nimib posts (nbsrc/*.nim) into src/posts/":
  for file in listFiles("nbsrc"):
    if file.endsWith(".nim") and not file.endsWith("blognb.nim"):
      exec "nim r --hints:off " & file
