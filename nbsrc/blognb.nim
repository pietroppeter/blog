## A nimib theme to write blog posts with nimib.
##
## A post written with nimib is a Nim file in this folder:
##
## ```nim
## import nimib, blognb
## nbInit(theme = useBlog)
## nb.title = "My post"
## nb.date = "2026-10-04"
## nb.draft = true # optional: listed in drafts/ instead of the index
## nbText: "hello"
## nbSave
## ```
##
## Running it (`nim r nbsrc/mypost.nim` or `nimble posts`) writes
## `src/posts/mypost.html`: a yaml front matter (title, date, is_post, draft)
## followed by the html body of the document (no <html>, <head>, ...).
## ark then picks it up as any other post and wraps it in the blog theme.
import std / [os, json]
import nimib
from nimib / themes import nbStyle, atomOneLight, showSourceButtonToHtml,
  sourceSectionToHtml, showSourceScriptToHtml

const
  blogRoot* = currentSourcePath().parentDir.parentDir
  postsDir* = blogRoot / "src" / "posts"

proc `date=`*(nb: var Nb, date: string) =
  ## date of the post, in YYYY-MM-DD format (as in markdown posts)
  nb.doc.context["date"] = %date

proc `draft=`*(nb: var Nb, draft: bool) =
  ## a draft post is not listed in the index, only in drafts/
  nb.doc.context["draft"] = %draft

func frontMatter(nb: Nb): string =
  # json strings are valid yaml strings
  withNewlines:
    "---"
    "title: " & $(%nb.doc.context{"title"}.getStr)
    "date: " & nb.doc.context{"date"}.getStr
    "is_post: true" & (if nb.doc.context{"draft"}.getBool: "\ndraft: true" else: "")
    "---"

func nbDocToBlogHtml*(blk: NbBlock, nb: Nb): string =
  let docJson = %[]
  withNewlines:
    nb.frontMatter
    "<!-- generated with nimib from nbsrc/" & nb.doc.context{"source_file"}.getStr & ", do not edit -->"
    atomOneLight
    nbStyle
    """<div class="nimib">"""
    nbContainerToHtml(blk, nb)
    """<div class="nb-source">""" & showSourceButtonToHtml(docJson, nb) & "</div>"
    sourceSectionToHtml(docJson, nb)
    showSourceScriptToHtml(docJson, nb)
    "</div>"

proc useBlog*(nb: var Nb) =
  ## nimib theme for posts of this blog
  var backend = NbRender(funcs: nbToHtml.funcs, partials: nbToHtml.partials)
  backend.funcs["NbDoc"] = nbDocToBlogHtml
  nb.backend = backend
  let sourceFile = nb.doc.thisFile.string.extractFilename
  nb.doc.context["source_file"] = %sourceFile
  nb.doc.context["title"] = %sourceFile.changeFileExt("")
  nb.doc.context["source_highlighted"] = %highlightNim(nb.doc.source)
  nb.doc.filename = postsDir / sourceFile.changeFileExt("html")
