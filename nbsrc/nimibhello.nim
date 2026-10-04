import std / [strformat, strutils, sequtils]
import nimib, blognb

nbInit(theme = useBlog)
nb.title = "Hello nimib"
nb.date = "2026-10-04"

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

## Interactive parts

Nim compiles to C but also to JavaScript.
The same Nim file that produces this post can also contain code that is compiled
to JavaScript and runs in your browser.
The simplest way is to use `std/dom` (the code below is shown and also compiled to js):
"""

nbCodeDisplay(nbJsFromCode):
  import std / [dom, strutils]

  var clicks = 0
  let button = document.getElementById("recurse-button")
  let label = document.getElementById("recurse-label")
  button.addEventListener("click", proc (ev: Event) =
    inc clicks
    label.innerHtml = cstring("re-".repeat(clicks) & "cursing")
  )

nbRawHtml: """
<p><button id="recurse-button">recurse</button> <code id="recurse-label">cursing</code></p>
"""

nbText: """
### Karax

With [karax](https://github.com/karaxnim/karax) we can write small reactive widgets
in Nim. Here is the [Collatz sequence](https://en.wikipedia.org/wiki/Collatz_conjecture)
of any number you like:
"""

nbCodeDisplay(nbKaraxCode):
  import std / strutils

  proc collatz(n: int): seq[int] =
    result = @[n]
    var n = n
    while n > 1:
      n = if n mod 2 == 0: n div 2 else: 3 * n + 1
      result.add n

  var start = 27
  karaxHtml:
    label:
      text "start from "
    input(`type` = "number", min = "1", value = $start):
      proc oninput(ev: Event; n: VNode) =
        try:
          start = max(1, parseInt($n.value))
        except ValueError:
          discard
    let s = collatz(start)
    p:
      text $(s.len - 1) & " steps, max value " & $max(s)
    p:
      code:
        text s.join(" → ")

nbText: """
### A recursive tree

And since this blog is about recursing, a fractal tree drawn in svg.
Move the sliders to change depth and angle.
"""

nbCodeDisplay(nbKaraxCode):
  import std / [math, strutils]

  type Segment = tuple[x1, y1, x2, y2: float, depth: int]

  proc tree(x, y, angle, length: float, depth: int, spread: float): seq[Segment] =
    if depth == 0: return
    let
      x2 = x + length * cos(angle)
      y2 = y - length * sin(angle)
    result.add (x, y, x2, y2, depth)
    result.add tree(x2, y2, angle + spread, length * 0.72, depth - 1, spread)
    result.add tree(x2, y2, angle - spread, length * 0.72, depth - 1, spread)

  var
    depth = 8
    spread = 25

  karaxHtml:
    label:
      text "depth " & $depth
    input(`type` = "range", min = "1", max = "12", value = $depth):
      proc oninput(ev: Event; n: VNode) =
        depth = parseInt($n.value)
    label:
      text " angle " & $spread & "°"
    input(`type` = "range", min = "0", max = "90", value = $spread):
      proc oninput(ev: Event; n: VNode) =
        spread = parseInt($n.value)
    let segments = tree(200, 290, PI / 2, 80, depth, degToRad(spread.float))
    svg(viewBox = "0 0 400 300", width = "100%"):
      for s in segments:
        line(x1 = $s.x1, y1 = $s.y1, x2 = $s.x2, y2 = $s.y2,
             stroke = (if s.depth <= 2: "#4a8a3a" else: "#6b4f3a"),
             `stroke-width` = $(s.depth.float * 0.6))

nbText: """
All of the above is a single Nim file: click on *Show Source* to see it.
"""

nbSave
