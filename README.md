# blog

A personal blog: https://pietroppeter.github.io/blog/
(drafts: https://pietroppeter.github.io/blog/drafts.html)

built with [ark]

[ark]: https://www.dmulholl.com/docs/ark/master/

## build

```
uv run ark build
```

## drafts

A post with `draft: true` in its front matter (`nb.draft = true` for nimib posts)
is built but not listed in the index: it is listed in [drafts.html] instead.

[drafts.html]: https://pietroppeter.github.io/blog/drafts.html

## posts with nimib

Posts can also be written in Nim with [nimib]: put a `.nim` file in `nbsrc/`
(see `nbsrc/nimibhello.nim` and `nbsrc/nimibjs.nim` for an interactive one)
and use the `useBlog` theme from `nbsrc/blognb.nim`.
Running it generates `src/posts/<name>.html` (front matter + html body),
which ark renders as any other post.

```
nimble install -d   # nimib, karax
nimble posts        # or: nim r nbsrc/<name>.nim
uv run ark build
```

[nimib]: https://github.com/pietroppeter/nimib
