# blog

A personal blog

built with [ark]

[ark]: https://www.dmulholl.com/docs/ark/master/

## build

```
uv run ark build
```

## posts with nimib

Posts can also be written in Nim with [nimib]: put a `.nim` file in `nbsrc/`
(see `nbsrc/nimibhello.nim`, which also has interactive parts compiled to js)
and use the `useBlog` theme from `nbsrc/blognb.nim`.
Running it generates `src/posts/<name>.html` (front matter + html body),
which ark renders as any other post.

```
nimble install -d   # nimib, karax
nimble posts        # or: nim r nbsrc/<name>.nim
uv run ark build
```

[nimib]: https://github.com/pietroppeter/nimib
