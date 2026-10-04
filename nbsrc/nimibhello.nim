import std / [strformat, strutils, sequtils]
import nimib, blognb

nbInit(theme = useBlog)
nb.title = "Hello nimib"
nb.date = "2026-10-04"
nb.draft = true

nbText: """
This post is not written in markdown: it is a Nim file that uses
[nimib](https://github.com/pietroppeter/nimib) 🐳.
Text blocks are markdown, code blocks are Nim code that gets executed
when the post is built, and its output is captured below the code.
"""

nbCode:
  proc fib(n: int): int =
    if n < 2: n
    else: fib(n - 1) + fib(n - 2)

  echo "first fibonacci numbers: ", (0 .. 15).mapIt(fib(it)).join(", ")

nbText: """
Since it is a recursive blog, here is a recursive drawing (a Sierpinski triangle in ascii):
"""

nbCode:
  proc sierpinski(n: int): seq[string] =
    if n == 0:
      return @["*"]
    let prev = sierpinski(n - 1)
    let pad = repeat(' ', 1 shl (n - 1))
    for line in prev:
      result.add pad & line & pad
    for line in prev:
      result.add line & " " & line

  for line in sierpinski(4):
    echo line

let n = 30
nbText: &"""
Variables computed in Nim can also end up in the text:
the {n}th fibonacci number is **{fib(n)}**.

Click on *Show Source* below to see the Nim source of this post.
"""

nbSave
